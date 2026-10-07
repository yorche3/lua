# Data Structures Basics — Lua

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Lua**, usando **LuaRocks** como gestor de paquetes y **Busted** como framework de pruebas unitarias.

Cuatro estructuras de datos construidas a mano sobre un único tipo `Node`: **lista enlazada** (`LinkedList`), **pila** (`Stack`) y **cola** (`Queue`). Cada ADT gestiona sus propios punteros y contador de forma independiente, sin delegar operaciones entre sí ni usar colecciones de la biblioteca estándar.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`data_structures_basics-1.0.0-1.rockspec`](data_structures_basics-1.0.0-1.rockspec) | Rock de LuaRocks — declara el módulo `data_structures_basics` y sus submódulos. |
| [`.busted`](.busted) | Configuración de Busted — usa `test/` como directorio y acepta el patrón `_test`. |
| [`src/data_structures_basics/init.lua`](src/data_structures_basics/init.lua) | Barril del módulo — expone `Node`, `LinkedList`, `Stack` y `Queue`. |
| [`src/data_structures_basics/node.lua`](src/data_structures_basics/node.lua) | Celda enlazada compartida por las tres estructuras. |
| [`src/data_structures_basics/linked_list.lua`](src/data_structures_basics/linked_list.lua) | Lista enlazada con inserción por ambos extremos y eliminación de primera aparición. |
| [`src/data_structures_basics/stack.lua`](src/data_structures_basics/stack.lua) | Pila LIFO sobre `Node`. |
| [`src/data_structures_basics/queue.lua`](src/data_structures_basics/queue.lua) | Cola FIFO sobre `Node`. |
| [`test/data_structures_basics_tests.lua`](test/data_structures_basics_tests.lua) | Suite de pruebas: 4 tests (uno por estructura). |

**Estructura de directorios esperada:**

```text
data_structures_basics/
├── data_structures_basics-1.0.0-1.rockspec
├── .busted
├── src/
│   └── data_structures_basics/
│       ├── init.lua              # Barril del módulo
│       ├── node.lua              # Celda enlazada compartida
│       ├── linked_list.lua       # Lista enlazada
│       ├── stack.lua             # Pila LIFO
│       └── queue.lua             # Cola FIFO
└── test/
    └── data_structures_basics_tests.lua  # 4 tests
```

**ES:** La especificación espera `src/data_structures_basics.ext` como archivo único, pero Lua usa subdirectorios con `init.lua` para módulos con múltiples archivos. Esta adaptación es idiomática y conserva el contrato: el barril `init.lua` expone los cuatro tipos.

**EN:** The specification expects `src/data_structures_basics.ext` as a single file, but Lua uses subdirectories with `init.lua` for modules with multiple files. This adaptation is idiomatic and preserves the contract: the `init.lua` barrel exposes all four types.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Sigue el mismo patrón que [`numbers`](../../foundations/numbers/): módulo Lua con rock de LuaRocks y pruebas con Busted. Las cuatro estructuras se organizan en archivos separados dentro de `src/data_structures_basics/`, compartiendo el tipo `Node`.

**EN:** Follows the same pattern as [`numbers`](../../foundations/numbers/): a Lua module with a LuaRocks rock and Busted tests. The four structures are organized in separate files under `src/data_structures_basics/`, sharing the `Node` type.

**ES:** Cada ADT usa metatablas de Lua para implementar métodos con sintaxis de dos puntos (`:`). El constructor `new()` inicializa los punteros a `nil` y el contador a `0`, equivalente al `init()` del pseudocódigo.

**EN:** Each ADT uses Lua metatables to implement methods with colon syntax (`:`). The `new()` constructor initializes pointers to `nil` and the counter to `0`, equivalent to the pseudocode's `init()`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `data_structures_basics-1.0.0-1.rockspec` — Rock de LuaRocks

**ES:** Declara el paquete `data_structures_basics` versión `1.0.0-1` con formato 3.0, los cinco submódulos mapeados a sus archivos en `src/data_structures_basics/` y la dependencia de test `busted`.

**EN:** Declares the `data_structures_basics` package version `1.0.0-1` with format 3.0, the five submodules mapped to their files in `src/data_structures_basics/`, and the `busted` test dependency.

```lua
package = "data_structures_basics"
version = "1.0.0-1"

build = {
   type = "builtin",
   modules = {
      data_structures_basics = "src/data_structures_basics/init.lua",
      ["data_structures_basics.node"] = "src/data_structures_basics/node.lua",
      ["data_structures_basics.linked_list"] = "src/data_structures_basics/linked_list.lua",
      ["data_structures_basics.stack"] = "src/data_structures_basics/stack.lua",
      ["data_structures_basics.queue"] = "src/data_structures_basics/queue.lua",
   }
}
```

### `src/data_structures_basics/node.lua` — Celda enlazada

**ES:** `Node` es el tipo compartido por las tres estructuras. Usa metatablas para implementar métodos. El constructor `new(value)` asigna el valor y deja `next` como `nil` (ausencia nativa de Lua).

**EN:** `Node` is the type shared by all three structures. It uses metatables to implement methods. The `new(value)` constructor assigns the value and leaves `next` as `nil` (Lua's native absence).

```lua
local Node = {}
Node.__index = Node

function Node.new(value)
    local self = setmetatable({}, Node)
    self.value = value
    self.next = nil
    return self
end

function Node:get_value()
    return self.value
end

function Node:get_next()
    return self.next
end

function Node:set_next(next_node)
    self.next = next_node
    return self
end

return Node
```

### `src/data_structures_basics/linked_list.lua` — Lista enlazada

**ES:** Mantiene punteros `head` y `tail`, y un contador `count`. Las operaciones `insert_head` e `insert_tail` actualizan ambos punteros en `O(1)`. `delete` recorre la lista en `O(n)` y devuelve `true` en éxito, `false` si el valor no está.

**EN:** Maintains `head` and `tail` pointers, and a `count` counter. The `insert_head` and `insert_tail` operations update both pointers in `O(1)`. `delete` traverses the list in `O(n)` and returns `true` on success, `false` if the value is absent.

```lua
function LinkedList:delete(value)
    local current = self.head
    local previous = nil
    while current do
        if current.value == value then
            if previous then
                previous.next = current.next
            else
                self.head = current.next
            end
            if current == self.tail then
                self.tail = previous
            end
            self.count = self.count - 1
            return true
        end
        previous = current
        current = current.next
    end
    return false
end
```

### Suites de pruebas — Busted

**ES:** Una suite con cuatro tests, uno por estructura. Cada test ejecuta pasos sucesivos sobre la misma instancia, sin reiniciar el escenario entre aserciones. Los valores son enteros positivos para no colisionar con el indicador de fallo `-1`.

**EN:** One suite with four tests, one per structure. Each test executes successive steps on the same instance, without resetting the scenario between assertions. Values are positive integers to avoid colliding with the failure indicator `-1`.

```lua
it("LinkedList", function()
    local list = LinkedList.new()

    assertSteps({
        { description = "be empty after init",
          run = function() return list:is_empty() end,
          expected = true },
        { description = "report size 0 after init",
          run = function() return list:size() end,
          expected = emptySize },
        -- ... más pasos / more steps
    }, "LinkedList")
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
cd lua/core/algorithms/data_structures_basics
busted
```

### Alternativa con LuaRocks / LuaRocks alternative

```bash
cd lua/core/algorithms/data_structures_basics
luarocks test --local data_structures_basics-1.0.0-1.rockspec
```

### Instalar el módulo como rock / Install the module as a rock

```bash
cd lua/core/algorithms/data_structures_basics
luarocks make --local data_structures_basics-1.0.0-1.rockspec
```

### Salida real / Actual output

```text
++++
4 successes / 0 failures / 0 errors / 0 pending : 0.001081 seconds
```

> **ES:** 4 tests en total (uno por estructura), todos pasando.
> **EN:** 4 tests in total (one per structure), all passing.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

### `Node`

| Operación | Entrada → salida | Complejidad | Notas |
|-----------|------------------|-------------|-------|
| `Node.new(value)` | `number → Node` | `O(1)` | Constructor: asigna `value` y deja `next` como `nil`. |
| `get_value()` | `→ number` | `O(1)` | Devuelve el valor de la celda. |
| `get_next()` | `→ Node\|nil` | `O(1)` | Devuelve el enlace, o `nil` si está ausente. |
| `set_next(next_node)` | `Node\|nil → Node` | `O(1)` | Actualiza el enlace y devuelve la celda. |

### `LinkedList`

| Operación | Entrada → salida | Complejidad | Notas |
|-----------|------------------|-------------|-------|
| `LinkedList.new()` | `→ LinkedList` | `O(1)` | Constructor: `head`, `tail` a `nil`, `count` a `0`. |
| `is_empty()` | `→ boolean` | `O(1)` | `true` si `count == 0`. |
| `size()` | `→ number` | `O(1)` | Devuelve `count`. |
| `get_head()` | `→ number` | `O(1)` | Valor de la cabeza, o `-1` si está vacía. |
| `insert_head(value)` | `number →` | `O(1)` | Inserta al principio; actualiza `head` y `tail` si es el primer nodo. |
| `insert_tail(value)` | `number →` | `O(1)` | Inserta al final; actualiza `tail` y `head` si es el primer nodo. |
| `delete(value)` | `number → boolean` | `O(n)` | Elimina la primera aparición; devuelve `true` en éxito, `false` si no está. |

### `Stack`

| Operación | Entrada → salida | Complejidad | Notas |
|-----------|------------------|-------------|-------|
| `Stack.new()` | `→ Stack` | `O(1)` | Constructor: `top` a `nil`, `count` a `0`. |
| `is_empty()` | `→ boolean` | `O(1)` | `true` si `count == 0`. |
| `size()` | `→ number` | `O(1)` | Devuelve `count`. |
| `push(value)` | `number →` | `O(1)` | Apila sobre `top`. |
| `peek()` | `→ number` | `O(1)` | Observa el tope sin extraerlo, o `-1` si está vacía. |
| `pop()` | `→ number` | `O(1)` | Extrae el tope, o `-1` si está vacía. |

### `Queue`

| Operación | Entrada → salida | Complejidad | Notas |
|-----------|------------------|-------------|-------|
| `Queue.new()` | `→ Queue` | `O(1)` | Constructor: `front`, `rear` a `nil`, `count` a `0`. |
| `is_empty()` | `→ boolean` | `O(1)` | `true` si `count == 0`. |
| `size()` | `→ number` | `O(1)` | Devuelve `count`. |
| `enqueue(value)` | `number →` | `O(1)` | Añade tras `rear`. |
| `peek()` | `→ number` | `O(1)` | Observa el frente sin extraerlo, o `-1` si está vacía. |
| `dequeue()` | `→ number` | `O(1)` | Extrae el frente, o `-1` si está vacía. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión | Alternativa considerada | Razón |
|----------|-------------------------|-------|
| **ES:** Subdirectorio `src/data_structures_basics/` con múltiples archivos | Archivo único `src/data_structures_basics.lua` | **ES:** Lua usa subdirectorios con `init.lua` para módulos con múltiples archivos; es idiomático y conserva el contrato. |
| **ES:** Métodos con metatablas y sintaxis `:` | Funciones sueltas con la estructura como primer parámetro | **ES:** Las metatablas permiten sintaxis de dos puntos (`stack:push(10)`), más legible y cercana al pseudocódigo. |
| **ES:** Contador `count` explícito en cada estructura | Recorrer la estructura para calcular el tamaño | **ES:** `O(1)` para `size()` en lugar de `O(n)`; el pseudocódigo lo exige. |
| **ES:** `nil` como ausencia nativa | Centinela numérico o tipo opcional | **ES:** Lua no tiene `null`; `nil` es la representación nativa de ausencia. La fase prohíbe `Option`/`Maybe`. |

**EN:**

| Decision | Alternative considered | Reason |
|----------|------------------------|--------|
| Subdirectory `src/data_structures_basics/` with multiple files | Single file `src/data_structures_basics.lua` | Lua uses subdirectories with `init.lua` for modules with multiple files; it is idiomatic and preserves the contract. |
| Methods with metatables and `:` syntax | Free functions with the structure as the first parameter | Metatables allow colon syntax (`stack:push(10)`), more readable and closer to the pseudocode. |
| Explicit `count` counter in each structure | Traverse the structure to compute the size | `O(1)` for `size()` instead of `O(n)`; the pseudocode requires it. |
| `nil` as native absence | Numeric sentinel or optional type | Lua has no `null`; `nil` is the native representation of absence. The phase forbids `Option`/`Maybe`. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación | Adaptación | Justificación |
|----------------|------------|---------------|
| **ES:** `src/data_structures_basics.ext` como archivo único | Subdirectorio `src/data_structures_basics/` con `init.lua` y archivos separados para cada estructura | **ES:** Lua usa subdirectorios con `init.lua` para módulos con múltiples archivos; es la convención idiomática y conserva el contrato. |
| **ES:** `init()` como nombre del constructor | `new()` como constructor | **ES:** Lua usa `new()` por convención para constructores con metatablas; es idiomático y conserva la semántica de `init()`. |
| **ES:** `null` o ausencia nativa como enlace | `nil` como ausencia nativa | **ES:** Lua no tiene `null`; `nil` es la representación nativa de ausencia. El pseudocódigo dice "absent"; Lua lo adapta a `nil`. |
| **ES:** Indicador de fallo para `get_head`, `pop`, `peek`, `dequeue` | `-1` como indicador de fallo | **ES:** Lua no tiene excepciones ni tipos opcionales en esta fase; `-1` es el indicador natural para operaciones que devuelven números. |
| **ES:** `delete` devuelve éxito o fallo | `true`/`false` como indicador | **ES:** Lua tiene booleanos nativos; `delete` devuelve `true` en éxito, `false` si el valor no está. |

**EN:**

| Specification | Adaptation | Justification |
|---------------|------------|---------------|
| `src/data_structures_basics.ext` as a single file | Subdirectory `src/data_structures_basics/` with `init.lua` and separate files for each structure | Lua uses subdirectories with `init.lua` for modules with multiple files; it is the idiomatic convention and preserves the contract. |
| `init()` as the constructor name | `new()` as the constructor | Lua uses `new()` by convention for constructors with metatables; it is idiomatic and preserves the `init()` semantics. |
| `null` or native absence as the link | `nil` as native absence | Lua has no `null`; `nil` is the native representation of absence. The pseudocode says "absent"; Lua adapts it to `nil`. |
| Failure indicator for `get_head`, `pop`, `peek`, `dequeue` | `-1` as the failure indicator | Lua has no exceptions or optional types in this phase; `-1` is the natural indicator for operations that return numbers. |
| `delete` returns success or failure | `true`/`false` as the indicator | Lua has native booleans; `delete` returns `true` on success, `false` if the value is absent. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación | Situación de fallo | Indicador | Ejemplo |
|-----------|-------------------|-----------|---------|
| `Node.get_next()` | Enlace ausente | `nil` | `node:get_next()` devuelve `nil` si no hay siguiente. |
| `LinkedList.get_head()` | Lista vacía | `-1` | `list:get_head()` devuelve `-1` si `is_empty()` es `true`. |
| `LinkedList.delete(value)` | Valor no está en la lista | `false` | `list:delete(99)` devuelve `false` si `99` no está. |
| `Stack.pop()` | Pila vacía | `-1` | `stack:pop()` devuelve `-1` si `is_empty()` es `true`. |
| `Stack.peek()` | Pila vacía | `-1` | `stack:peek()` devuelve `-1` si `is_empty()` es `true`. |
| `Queue.dequeue()` | Cola vacía | `-1` | `queue:dequeue()` devuelve `-1` si `is_empty()` es `true`. |
| `Queue.peek()` | Cola vacía | `-1` | `queue:peek()` devuelve `-1` si `is_empty()` es `true`. |

**EN:**

| Operation | Failure situation | Indicator | Example |
|-----------|-------------------|-----------|---------|
| `Node.get_next()` | Absent link | `nil` | `node:get_next()` returns `nil` if there is no next node. |
| `LinkedList.get_head()` | Empty list | `-1` | `list:get_head()` returns `-1` if `is_empty()` is `true`. |
| `LinkedList.delete(value)` | Value not in the list | `false` | `list:delete(99)` returns `false` if `99` is absent. |
| `Stack.pop()` | Empty stack | `-1` | `stack:pop()` returns `-1` if `is_empty()` is `true`. |
| `Stack.peek()` | Empty stack | `-1` | `stack:peek()` returns `-1` if `is_empty()` is `true`. |
| `Queue.dequeue()` | Empty queue | `-1` | `queue:dequeue()` returns `-1` if `is_empty()` is `true`. |
| `Queue.peek()` | Empty queue | `-1` | `queue:peek()` returns `-1` if `is_empty()` is `true`. |

---

## ✅ Cobertura de pruebas / Test coverage

### `Node`

| Caso de la especificación | Cubierto | Prueba | Notas |
|---------------------------|----------|--------|-------|
| Inicializar y observar valor/enlace | Sí | `test/data_structures_basics_tests.lua:48-62` | `Node.new(10)`, `get_value()`, `get_next()`. |
| Inicializar otro nodo, enlazar y recorrer | Sí | `test/data_structures_basics_tests.lua:64-78` | `Node.new(20)`, `set_next()`, recorrido. |

### `LinkedList`

| Caso de la especificación | Cubierto | Prueba | Notas |
|---------------------------|----------|--------|-------|
| Estado vacío | Sí | `test/data_structures_basics_tests.lua:83-95` | `is_empty()`, `size()`, `get_head()`. |
| Insertar por ambos extremos | Sí | `test/data_structures_basics_tests.lua:97-108` | `insert_tail(10)`, `insert_tail(20)`, `insert_head(5)`, `insert_tail(10)`. |
| Eliminar primera aparición | Sí | `test/data_structures_basics_tests.lua:110-120` | `delete(10)`, recorrido, `size()`. |
| Valor ausente | Sí | `test/data_structures_basics_tests.lua:122-130` | `delete(99)` devuelve `false`. |
| Vaciar la lista | Sí | `test/data_structures_basics_tests.lua:132-148` | Tres `delete()`, `is_empty()`, `size()`, `get_head()`. |

### `Stack`

| Caso de la especificación | Cubierto | Prueba | Notas |
|---------------------------|----------|--------|-------|
| Estado vacío y extracción fallida | Sí | `test/data_structures_basics_tests.lua:153-170` | `is_empty()`, `size()`, `peek()`, `pop()`. |
| LIFO y `peek` no mutante | Sí | `test/data_structures_basics_tests.lua:172-182` | `push(10)`, `push(20)`, `push(30)`, `peek()`. |
| Extracción y reutilización | Sí | `test/data_structures_basics_tests.lua:184-198` | `pop()`, `push(40)`, tres `pop()`. |
| Vacío tras extracción | Sí | `test/data_structures_basics_tests.lua:200-208` | `pop()` devuelve `-1`, `is_empty()` sigue `true`. |

### `Queue`

| Caso de la especificación | Cubierto | Prueba | Notas |
|---------------------------|----------|--------|-------|
| Estado vacío y extracción fallida | Sí | `test/data_structures_basics_tests.lua:213-230` | `is_empty()`, `size()`, `peek()`, `dequeue()`. |
| FIFO y `peek` no mutante | Sí | `test/data_structures_basics_tests.lua:232-242` | `enqueue(10)`, `enqueue(20)`, `enqueue(30)`, `peek()`. |
| Extracción y reutilización | Sí | `test/data_structures_basics_tests.lua:244-258` | `dequeue()`, `enqueue(40)`, tres `dequeue()`. |
| Vacío tras extracción | Sí | `test/data_structures_basics_tests.lua:260-268` | `dequeue()` devuelve `-1`, `is_empty()` sigue `true`. |

**EN:**

| Specification case | Covered | Test | Notes |
|--------------------|---------|------|-------|
| Initialize and observe value/link | Yes | `test/data_structures_basics_tests.lua:48-62` | `Node.new(10)`, `get_value()`, `get_next()`. |
| Initialize another node, link and traverse | Yes | `test/data_structures_basics_tests.lua:64-78` | `Node.new(20)`, `set_next()`, traversal. |
| Empty state | Yes | `test/data_structures_basics_tests.lua:83-95` | `is_empty()`, `size()`, `get_head()`. |
| Insert at both ends | Yes | `test/data_structures_basics_tests.lua:97-108` | `insert_tail(10)`, `insert_tail(20)`, `insert_head(5)`, `insert_tail(10)`. |
| Delete first occurrence | Yes | `test/data_structures_basics_tests.lua:110-120` | `delete(10)`, traversal, `size()`. |
| Absent value | Yes | `test/data_structures_basics_tests.lua:122-130` | `delete(99)` returns `false`. |
| Empty the list | Yes | `test/data_structures_basics_tests.lua:132-148` | Three `delete()`, `is_empty()`, `size()`, `get_head()`. |
| Empty state and failed removal | Yes | `test/data_structures_basics_tests.lua:153-170` | `is_empty()`, `size()`, `peek()`, `pop()`. |
| LIFO and non-mutating `peek` | Yes | `test/data_structures_basics_tests.lua:172-182` | `push(10)`, `push(20)`, `push(30)`, `peek()`. |
| Removal and reuse | Yes | `test/data_structures_basics_tests.lua:184-198` | `pop()`, `push(40)`, three `pop()`. |
| Empty after removal | Yes | `test/data_structures_basics_tests.lua:200-208` | `pop()` returns `-1`, `is_empty()` stays `true`. |
| FIFO and non-mutating `peek` | Yes | `test/data_structures_basics_tests.lua:232-242` | `enqueue(10)`, `enqueue(20)`, `enqueue(30)`, `peek()`. |
| Removal and reuse | Yes | `test/data_structures_basics_tests.lua:244-258` | `dequeue()`, `enqueue(40)`, three `dequeue()`. |
| Empty after removal | Yes | `test/data_structures_basics_tests.lua:260-268` | `dequeue()` returns `-1`, `is_empty()` stays `true`. |

---

## ⚠️ Limitaciones conocidas / Known limitations

**ES:** Ninguna. El módulo implementa todos los contratos de la especificación con las complejidades prometidas. Lua no garantiza Tail Call Optimization (TCO), pero este módulo no usa recursión profunda; todas las operaciones son iterativas o de profundidad constante.

**EN:** None. The module implements all specification contracts with the promised complexities. Lua does not guarantee Tail Call Optimization (TCO), but this module does not use deep recursion; all operations are iterative or constant-depth.

---

## 📝 Notas de implementación / Implementation Notes

**ES:**

- **ES:** El proyecto no usa un `main()`: el "punto de entrada" es el propio runner de Busted, que descubre y ejecuta las suites automáticamente.
- **ES:** Cada estructura usa metatablas de Lua para implementar métodos con sintaxis de dos puntos (`:`). El constructor `new()` inicializa los punteros a `nil` y el contador a `0`.
- **ES:** `Node` es compartido por las tres estructuras, pero cada ADT gestiona sus propios punteros (`head`/`tail` para `LinkedList`, `top` para `Stack`, `front`/`rear` para `Queue`) y su propio contador `count`.
- **ES:** Los tests recorren varias operaciones sobre la misma instancia de cada ADT, sin reiniciar el escenario entre aserciones. Lua es mutable, así que los cambios persisten.
- **ES:** El indicador de fallo `-1` es válido porque los tests usan solo enteros positivos (`10`, `20`, `30`, `40`, `5`, `99`).
- **ES:** `delete` devuelve `true`/`false` (booleanos nativos de Lua) en lugar de un indicador numérico, porque la operación no devuelve un valor sino un estado de éxito.

**EN:**

- The project has no `main()`: the "entry point" is Busted's runner itself, which discovers and executes the suites automatically.
- Each structure uses Lua metatables to implement methods with colon syntax (`:`). The `new()` constructor initializes pointers to `nil` and the counter to `0`.
- `Node` is shared by all three structures, but each ADT manages its own pointers (`head`/`tail` for `LinkedList`, `top` for `Stack`, `front`/`rear` for `Queue`) and its own `count` counter.
- Tests traverse multiple operations on the same instance of each ADT, without resetting the scenario between assertions. Lua is mutable, so changes persist.
- The failure indicator `-1` is valid because tests use only positive integers (`10`, `20`, `30`, `40`, `5`, `99`).
- `delete` returns `true`/`false` (Lua's native booleans) instead of a numeric indicator, because the operation does not return a value but a success state.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo | Referencia |
|------|------------|
| Especificación | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) |
| Módulo homologado del lenguaje | [`lua/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/AGENT_Template/) |
| Validación de la documentación | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/WORKFLOW/) |
| Documentación oficial del lenguaje | [Lua 5.5 Reference Manual](https://www.lua.org/manual/5.5/) |

---

## 🌐 Otras implementaciones / Other implementations

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

**EN:** This project is also implemented in other languages. Explore the [main repository](https://github.com/yorche3/programming_languages) to see the other versions.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
