# Numbers — Lua

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Lua**, usando **LuaRocks** como gestor de paquetes y **Busted** como framework de pruebas unitarias.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`_rec`), **recursivo con acumulador** (`_acc`) e **iterativo** (`_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`numbers-1.0.0-1.rockspec`](numbers-1.0.0-1.rockspec) | Rock de LuaRocks — declara el módulo `numbers` y la dependencia de test `busted`. |
| [`.busted`](.busted) | Configuración de Busted — usa `test/` como directorio y acepta el patrón `_test`. |
| [`src/numbers.lua`](src/numbers.lua) | Módulo `numbers` — 15 funciones (3 enfoques × 5 algoritmos) + 4 helpers locales. |
| [`test/recursive_tests.lua`](test/recursive_tests.lua) | Suite recursiva: 5 tests (11 casos). |
| [`test/iterative_tests.lua`](test/iterative_tests.lua) | Suite iterativa: 5 tests (11 casos). |

**Estructura de directorios esperada:**

```text
numbers/
├── numbers-1.0.0-1.rockspec      # Rock de LuaRocks
├── .busted                       # Configuración de Busted
├── src/
│   └── numbers.lua               # 15 funciones + 4 helpers locales
└── test/
    ├── recursive_tests.lua       # Tests recursivos (5 tests, 11 casos)
    └── iterative_tests.lua       # Tests iterativos (5 tests, 11 casos)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Sigue el mismo patrón que [`calculator`](../unit_test/calculator/): módulo Lua con rock de LuaRocks y pruebas con Busted. Las 15 funciones se organizan en 3 grupos por enfoque:

| Enfoque | Sufijo | Ejemplo | ¿Tiene tests directos? |
| ------- | ------ | ------- | :---------------------: |
| Recursivo directo | `_rec` | `fibonacci_rec(n)` | ✅ Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc(n)` | ❌ No (ver nota TCO) |
| Iterativo | `_ite` | `fibonacci_ite(n)` | ✅ Sí |

**EN:** Follows the same pattern as [`calculator`](../unit_test/calculator/): a Lua module with a LuaRocks rock and Busted tests. The 15 functions are organized into 3 groups by approach:

| Approach | Suffix | Example | Direct tests? |
| -------- | ------ | ------- | :-----------: |
| Direct recursion | `_rec` | `fibonacci_rec(n)` | ✅ Yes |
| Accumulator recursion | `_acc` | `fibonacci_acc(n)` | ❌ No (see TCO note) |
| Iterative | `_ite` | `fibonacci_ite(n)` | ✅ Yes |

**Combinación aplicada:** TCO ❌ + iteración ✅ → `_rec` + `_ite` = **2 suites × 5 tests = 10 tests (22 casos)**.

**Applied combination:** No TCO + iteration ✅ → `_rec` + `_ite` = **2 suites × 5 tests = 10 tests (22 cases)**.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `numbers-1.0.0-1.rockspec` — Rock de LuaRocks

**ES:** Declara el paquete `numbers` versión `1.0.0-1` con formato 3.0, la dependencia `lua >= 5.3` (por el operador `//` de división entera), la dependencia de test `busted` y el módulo `numbers` mapeado a `src/numbers.lua`.

**EN:** Declares the `numbers` package version `1.0.0-1` with format 3.0, the `lua >= 5.3` dependency (for the `//` integer division operator), the `busted` test dependency, and the `numbers` module mapped to `src/numbers.lua`.

```lua
rockspec_format = "3.0"

package = "numbers"
version = "1.0.0-1"

dependencies = {
    "lua >= 5.3",
}

test_dependencies = {
    "busted",
}

build = {
    type = "builtin",
    modules = {
        numbers = "src/numbers.lua",
    },
}
```

### `src/numbers.lua` — Implementación

**ES:** Cada algoritmo tiene 3 implementaciones en un único archivo. Los helpers del enfoque con acumulador son `local` (privados del módulo). Por ejemplo, `fibonacci`:

**EN:** Each algorithm has 3 implementations in a single file. The accumulator helpers are `local` (private to the module). For example, `fibonacci`:

```lua
-- Enfoque recursivo directo / Direct recursion
function numbers.fibonacci_rec(n)
    if n <= 1 then
        return n
    end
    return numbers.fibonacci_rec(n - 1) + numbers.fibonacci_rec(n - 2)
end

-- Enfoque con acumulador / Accumulator recursion
local function fibonacci_acc_help(n, acc2, acc1)
    if n <= 0 then
        return acc2
    end
    if n <= 2 then
        return acc1 + acc2
    end
    return fibonacci_acc_help(n - 1, acc1, acc1 + acc2)
end

function numbers.fibonacci_acc(n)
    return fibonacci_acc_help(n, 0, 1)
end

-- Enfoque iterativo / Iterative
function numbers.fibonacci_ite(n)
    if n <= 1 then
        return n
    end
    local acc2 = 0
    local acc1 = 1
    for i = 2, n do
        local temp = acc1 + acc2
        acc2 = acc1
        acc1 = temp
    end
    return acc1
end
```

| Algoritmo | `_rec` | `_acc` | `_ite` |
| --------- | ------ | ------ | ------ |
| `sum_of_first_n` | `n + sum_rec(n-1)` | helper con `acc + n` | bucle `1..n` |
| `factorial` | `n * fact_rec(n-1)` | helper con `acc * n` | bucle `2..n` |
| `fibonacci` | `fib_rec(n-1) + fib_rec(n-2)` | helper con `acc2, acc1` | bucle de intercambio |
| `greatest_common_divisor` | Euclides recursivo | helper (Euclides) | Euclides con `while y ~= 0` |
| `least_common_multiple` | `(a*b) // gcd_rec` | `(a*b) // gcd_acc` | `(a*b) // gcd_ite` |

### Suites de pruebas — Busted

**ES:** Dos suites, una por enfoque probado. Cada suite agrupa un `it` por función (5 por suite); los 11 casos del pseudocódigo viven como aserciones dentro de ellos (22 casos en total).

**EN:** Two suites, one per tested approach. Each suite groups one `it` per function (5 per suite); the specification pseudocode's 11 cases live as assertions within them (22 cases in total).

```lua
it("fibonacci_rec", function()
    assert.are.equal(0, numbers.fibonacci_rec(0))
    assert.are.equal(1, numbers.fibonacci_rec(1))
    assert.are.equal(8, numbers.fibonacci_rec(6))
end)

it("fibonacci_ite", function()
    assert.are.equal(0, numbers.fibonacci_ite(0))
    assert.are.equal(1, numbers.fibonacci_ite(1))
    assert.are.equal(8, numbers.fibonacci_ite(6))
end)
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Lua 5.3+** (`lua`).
- **LuaRocks 3.x** (`luarocks`).
- **Busted** (`busted`).

```bash
lua -v
luarocks --version

# Instalar busted (árbol local del usuario, sin root)
luarocks install --local busted

# Configurar el entorno para usar el árbol local
export PATH="$HOME/.luarocks/bin:$PATH"
eval "$(luarocks path)"
```

### Ejecutar las pruebas unitarias / Run tests

```bash
cd lua/core/foundations/numbers
busted
```

### Alternativa con LuaRocks / LuaRocks alternative

```bash
cd lua/core/foundations/numbers
luarocks test --local numbers-1.0.0-1.rockspec
```

### Instalar el módulo como rock / Install the module as a rock

```bash
cd lua/core/foundations/numbers
luarocks make --local numbers-1.0.0-1.rockspec
```

### Salida esperada / Expected output

```text
++++++++++
10 successes / 0 failures / 0 errors / 0 pending : 0.001783 seconds
```

> **ES:** 10 tests en total (5 por suite); los 22 casos viven como aserciones dentro de ellos, todos pasando.
> **EN:** 10 tests in total (5 per suite); the 22 cases live as assertions within them, all passing.

---

## 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones. La recursión con acumulador consigue esto pasando el estado previo como parámetro, sin dejar trabajo pendiente en la pila.

En Lua, **no se garantiza TCO**: la máquina virtual no optimiza las llamadas de cola, por lo que una recursión suficientemente profunda termina en un error de desbordamiento de pila. La versión con acumulador se conserva únicamente con fines educativos, como puente conceptual entre la recursión directa (`_rec`) y la versión iterativa (`_ite`). Como no hay un beneficio práctico de rendimiento, **no se desarrollan pruebas unitarias específicas para las funciones `_acc`**. Su comportamiento queda validado a través de las suites recursiva e iterativa, que ejercitan los mismos resultados.

**EN:**
Tail recursion occurs when the recursive call is the last action executed by a function; after the call there are no more instructions. Accumulator recursion achieves this by passing the previous state as a parameter, leaving no pending work on the stack.

In Lua, **TCO is not guaranteed**: the virtual machine does not optimize tail calls, so sufficiently deep recursion ends in a stack overflow error. The accumulator version is kept purely for educational purposes, as a conceptual bridge between direct recursion (`_rec`) and the iterative version (`_ite`). Since there is no practical performance benefit, **no dedicated unit tests are written for the `_acc` functions**. Their behavior is validated through the recursive and iterative suites, which exercise the same results.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El proyecto no usa un `main()`: el "punto de entrada" es el propio runner de Busted, que descubre y ejecuta las suites automáticamente.
- **EN:** The project has no `main()`: the "entry point" is Busted's runner itself, which discovers and executes the suites automatically.
- **ES:** Los helpers `_help` son funciones `local` del archivo, ocultas fuera del módulo (equivalente a los helpers privados del pseudocódigo).
- **EN:** The `_help` helpers are `local` functions of the file, hidden outside the module (equivalent to the pseudocode's private helpers).
- **ES:** En Lua el operador `/` es división de punto flotante; por eso `lcm` usa `//` (división entera, Lua 5.3+) para devolver un entero exacto.
- **EN:** In Lua the `/` operator is floating-point division; that's why `lcm` uses `//` (integer division, Lua 5.3+) to return an exact integer.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
