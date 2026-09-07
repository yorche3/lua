# Calculator — Lua

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Lua**, usando **LuaRocks** como gestor de paquetes y **Busted** como framework de pruebas unitarias.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`calculator-1.0.0-1.rockspec`](calculator-1.0.0-1.rockspec) | Rock de LuaRocks — declara el módulo `calculator` y la dependencia de test `busted`. |
| [`.busted`](.busted) | Configuración de Busted — usa `test/` como directorio y acepta el patrón `_test`. |
| [`src/calculator.lua`](src/calculator.lua) | Módulo `calculator` con las 5 operaciones aritméticas. |
| [`test/calculator_test.lua`](test/calculator_test.lua) | 5 pruebas unitarias con `describe`/`it` y `assert.are.equal`. |

**Estructura de directorios esperada:**

```text
calculator/
├── calculator-1.0.0-1.rockspec   # Rock de LuaRocks
├── .busted                       # Configuración de Busted
├── src/
│   └── calculator.lua            # 5 operaciones aritméticas
└── test/
    └── calculator_test.lua       # 5 tests con Busted
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **LuaRocks** (rockspec tipo `builtin`) para empaquetar el módulo y **Busted** para las pruebas:

1. `calculator` es un módulo Lua que retorna una tabla con las 5 funciones.
2. Cada prueba usa `describe`/`it` y verifica con `assert.are.equal`.
3. El descubrimiento de pruebas es automático: `.busted` apunta al directorio `test/` con el patrón `_test`.
4. `multiplication`, `division` y `modulus` se implementan con las estrategias educativas de la especificación (sin usar los operadores `*`, `/` ni `%` respectivamente).

**EN:** This project uses **LuaRocks** (a `builtin` rockspec) to package the module and **Busted** for tests:

1. `calculator` is a Lua module returning a table with the 5 functions.
2. Each test uses `describe`/`it` and verifies with `assert.are.equal`.
3. Test discovery is automatic: `.busted` points to the `test/` directory with the `_test` pattern.
4. `multiplication`, `division` and `modulus` are implemented with the educational strategies from the specification (without using the `*`, `/` or `%` operators respectively).

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `calculator-1.0.0-1.rockspec` — Rock de LuaRocks

**ES:** Declara el paquete `calculator` versión `1.0.0-1` con formato 3.0, la dependencia `lua >= 5.1`, la dependencia de test `busted` y el módulo `calculator` mapeado a `src/calculator.lua`.

**EN:** Declares the `calculator` package version `1.0.0-1` with format 3.0, the `lua >= 5.1` dependency, the `busted` test dependency, and the `calculator` module mapped to `src/calculator.lua`.

```lua
rockspec_format = "3.0"

package = "calculator"
version = "1.0.0-1"

dependencies = {
    "lua >= 5.1",
}

test_dependencies = {
    "busted",
}

build = {
    type = "builtin",
    modules = {
        calculator = "src/calculator.lua",
    },
}
```

### `src/calculator.lua` — Módulo principal

| Operación | Implementación educativa |
| --------- | ------------------------ |
| `addition(a, b)` | Suma directa (`a + b`). |
| `subtraction(a, b)` | Resta directa (`a - b`). |
| `multiplication(a, b)` | Suma repetitiva: acumula `a`, `b` veces (no usa `*`). |
| `division(a, b)` | Resta repetitiva: resta `b` de `a` mientras `a >= b` (no usa `/`). |
| `modulus(a, b)` | Construida sobre `division` y `multiplication` (no usa `%`). |

```lua
local calculator = {}

function calculator.addition(a, b)
    return a + b
end

function calculator.subtraction(a, b)
    return a - b
end

function calculator.multiplication(a, b)
    local result = 0
    for _ = 1, b do
        result = calculator.addition(result, a)
    end
    return result
end

function calculator.division(a, b)
    local quotient = 0
    while a >= b do
        a = calculator.subtraction(a, b)
        quotient = calculator.addition(quotient, 1)
    end
    return quotient
end

function calculator.modulus(a, b)
    local q = calculator.division(a, b)
    local p = calculator.multiplication(q, b)
    return calculator.subtraction(a, p)
end

return calculator
```

### `test/calculator_test.lua` — Pruebas unitarias (Busted)

**ES:** Un `it` por operación, con los mismos casos del pseudocódigo de la especificación. La primera línea agrega `src/` al `package.path` para resolver `require("calculator")` sin instalar el rock.

**EN:** One `it` per operation, with the same cases as the specification pseudocode. The first line adds `src/` to `package.path` to resolve `require("calculator")` without installing the rock.

```lua
package.path = "./src/?.lua;" .. package.path

local calculator = require("calculator")

describe("calculator", function()
    it("addition(2, 3) returns 5", function()
        assert.are.equal(5, calculator.addition(2, 3))
    end)

    it("subtraction(5, 2) returns 3", function()
        assert.are.equal(3, calculator.subtraction(5, 2))
    end)

    it("multiplication(3, 4) returns 12", function()
        assert.are.equal(12, calculator.multiplication(3, 4))
    end)

    it("division(10, 3) returns 3", function()
        assert.are.equal(3, calculator.division(10, 3))
    end)

    it("modulus(10, 3) returns 1", function()
        assert.are.equal(1, calculator.modulus(10, 3))
    end)
end)
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Lua 5.1+** (`lua`).
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
cd lua/core/foundations/unit_test/calculator
busted
```

### Alternativa con LuaRocks / LuaRocks alternative

**ES:** `luarocks test` instala las dependencias de prueba en un árbol temporal y ejecuta la suite automáticamente.

**EN:** `luarocks test` installs the test dependencies in a temporary tree and runs the suite automatically.

```bash
cd lua/core/foundations/unit_test/calculator
luarocks test --local calculator-1.0.0-1.rockspec
```

### Instalar el módulo como rock / Install the module as a rock

```bash
cd lua/core/foundations/unit_test/calculator
luarocks make --local calculator-1.0.0-1.rockspec
```

```bash
lua -e 'local c = require("calculator"); print(c.addition(2, 3))'
```

### Salida esperada / Expected output

```text
●●●●●
5 successes / 0 failures / 0 errors / 0 pending : 0.000935 seconds
```

---

## 📝 Notas de implementación / Implementation Notes

**ES:** El proyecto no usa un `main()`: el "punto de entrada" es el propio runner de Busted (invocado directamente o vía `luarocks test`), que descubre y ejecuta la suite automáticamente. Por eso no se necesita el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye).

**EN:** The project has no `main()`: the "entry point" is Busted's runner itself (invoked directly or via `luarocks test`), which discovers and executes the suite automatically. That's why the pseudocode's `run_tests` is not needed (the specification asks for it only if the framework doesn't include one).

**ES:** `division` no valida `b == 0` (fuera del alcance de este ejemplo, como indica la especificación). En Lua el operador `/` es división de punto flotante, pero aquí no se usa: `division` cuenta restas repetidas.

**EN:** `division` does not validate `b == 0` (out of scope for this example, as the specification states). In Lua the `/` operator is floating-point division, but it's not used here: `division` counts repeated subtractions.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
