# Data Structures Advanced — Lua

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **Lua**, usando **LuaRocks** como gestor de paquetes y **Busted** como framework de pruebas unitarias.

**ES:** Este módulo implementa un árbol binario de búsqueda (`BinaryTree`) sobre nodos enlazados (`TreeNode`) y un grafo dirigido (`Graph`) con registro canónico enlazado y listas de adyacencia ordenadas manualmente (`GraphNode`). La base `Node` se reutiliza mediante valor embebido (`value`) en cada nodo hijo, sin colecciones auxiliares de biblioteca para los registros principales.

**EN:** This module implements a binary search tree (`BinaryTree`) on linked nodes (`TreeNode`) and a directed graph (`Graph`) with a canonical linked vertex registry and manually sorted adjacency sequences (`GraphNode`). The `Node` base is reused via an embedded value (`value`) in each child node, without auxiliary library collections for the primary registries.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`data_structures_advanced-1.0.0-1.rockspec`](data_structures_advanced-1.0.0-1.rockspec) | Rock de LuaRocks — especificación del paquete y dependencias / LuaRocks rockspec — package specification and dependencies |
| [`.busted`](.busted) | Configuración de Busted — define directorio `test/` y patrones de prueba / Busted configuration — defines `test/` directory and test patterns |
| [`src/data_structures_advanced/init.lua`](src/data_structures_advanced/init.lua) | Barril del módulo — expone `TreeNode`, `BinaryTree` y `Graph` / Module barrel — exports `TreeNode`, `BinaryTree`, and `Graph` |
| [`src/data_structures_advanced/tree_node.lua`](src/data_structures_advanced/tree_node.lua) | Nodo de árbol con valor y enlaces `left`/`right` / Tree node with value and `left`/`right` links |
| [`src/data_structures_advanced/binary_tree.lua`](src/data_structures_advanced/binary_tree.lua) | Árbol binario de búsqueda (ABB) con inserción y búsqueda / Binary search tree (BST) with insertion and lookup |
| [`src/data_structures_advanced/graph.lua`](src/data_structures_advanced/graph.lua) | Grafo dirigido con registro enlazado canónico y adyacencia ordenada / Directed graph with canonical linked registry and sorted adjacency |
| [`test/data_structures_advanced_tests.lua`](test/data_structures_advanced_tests.lua) | Suite de pruebas Busted: 23 casos (TreeNode, BinaryTree, Graph) / Busted test suite: 23 cases (TreeNode, BinaryTree, Graph) |
| `.gitignore` | Archivos generados excluidos del control de versiones / Generated files ignored by version control |

**Estructura del módulo / Module structure:**

```text
data_structures_advanced/
├── data_structures_advanced-1.0.0-1.rockspec
├── .busted
├── .gitignore
├── src/
│   └── data_structures_advanced/
│       ├── init.lua
│       ├── tree_node.lua
│       ├── binary_tree.lua
│       └── graph.lua
└── test/
    └── data_structures_advanced_tests.lua
```

**Nota de desviación de ubicación / Location deviation note:**
- **ES:** La especificación propone un único archivo `src/data_structures_advanced.ext` y `test/data_structures_advanced_test.ext`. Siguiendo el patrón de la base `data_structures_basics`, Lua organiza módulos multiclase en un subdirectorio `src/data_structures_advanced/` con un barril `init.lua`, y Busted ejecuta la suite desde `test/data_structures_advanced_tests.lua`.
- **EN:** The specification suggests a single file `src/data_structures_advanced.ext` and `test/data_structures_advanced_test.ext`. Following the `data_structures_basics` baseline pattern, Lua structures multi-component modules in a `src/data_structures_advanced/` subdirectory with an `init.lua` barrel, and Busted runs the suite from `test/data_structures_advanced_tests.lua`.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Proyecto creado manualmente con la estructura canónica de LuaRocks y Busted, consistente con la primera base `data_structures_basics` y la segunda base `numbers`. Las estructuras se construyen mediante tablas y metatablas con sintaxis de dos puntos (`:`). La reutilización de la base `Node(value)` se realiza mediante valor embebido (`self.value = value/label`), sin instanciación independiente de `Node`. El registro de vértices del grafo es una lista enlazada manual (`next_vertex`), y la adyacencia se almacena en tablas nativas indexadas insertadas en orden creciente mediante un algoritmo de inserción lineal `O(d(u))`, sin delegar en tablas hash ni bibliotecas de ordenación.

**EN:** Manually created project following the canonical LuaRocks and Busted layout, consistent with the first reference `data_structures_basics` and the second reference `numbers`. Structures are implemented using tables and metatables with colon syntax (`:`). Base `Node(value)` reuse is achieved through embedded values (`self.value = value/label`), without independent instantiation of `Node`. The graph vertex registry is a manual linked list (`next_vertex`), and adjacency is stored in native table sequences kept in ascending order via linear insertion `O(d(u))`, without delegating to hash tables or library sorting.

---

## 📄 Configuración clave / Key Configuration

- **`data_structures_advanced-1.0.0-1.rockspec`**: Define el paquete `data_structures_advanced` versión `1.0.0-1` con tipo de construcción `builtin` de LuaRocks.
- **`.busted`**: Configura Busted para reconocer `test` como directorio raíz de pruebas (`ROOT = { "test" }`) y filtrar archivos que coincidan con los patrones `_test` o `_spec`.

---

## 🚀 Compilación y ejecución / Build & Run

```bash
# Ejecución de la suite nativa con Busted
cd lua/core/algorithms/data_structures_advanced
busted
```

**Salida real / Actual output:**

```text
+++++++++++++++++++++++
23 successes / 0 failures / 0 errors / 0 pending : 0.005101 seconds
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

### `Node` (Base conceptual embebida / Embedded conceptual base)

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node(value)` | `integer → Node` | `O(1)` | Base conceptual con el valor; no se instancia directamente, se embebe en `TreeNode` y `GraphNode`. / Conceptual base carrying the value; not directly instantiated, embedded in `TreeNode` and `GraphNode`. |
| `get_value()` | `→ integer` | `O(1)` | Accesor del valor almacenado. / Accessor for the stored value. |

### `TreeNode`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `TreeNode.new(value)` | `integer → TreeNode` | `O(1)` | Constructor: valor embebido, `left = nil`, `right = nil`. / Constructor: embedded value, `left = nil`, `right = nil`. |
| `get_value()` | `→ integer` | `O(1)` | Devuelve el valor del nodo. / Returns the node value. |
| `get_left()` | `→ TreeNode\|nil` | `O(1)` | Devuelve el hijo izquierdo o `nil` si está ausente. / Returns left child or `nil` if absent. |
| `get_right()` | `→ TreeNode\|nil` | `O(1)` | Devuelve el hijo derecho o `nil` si está ausente. / Returns right child or `nil` if absent. |
| `set_left(node)` | `TreeNode\|nil → TreeNode` | `O(1)` | Muta el enlace izquierdo; devuelve `self`. / Mutates left link; returns `self`. |
| `set_right(node)` | `TreeNode\|nil → TreeNode` | `O(1)` | Muta el enlace derecho; devuelve `self`. / Mutates right link; returns `self`. |

### `BinaryTree`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `BinaryTree.new()` | `→ BinaryTree` | `O(1)` | Constructor: `root = nil`, `count = 0`. / Constructor: `root = nil`, `count = 0`. |
| `insert(value)` | `integer → boolean` | `O(h)` | Inserción en ABB; duplicados no alteran el tamaño ni fallan. / BST insertion; duplicates do not change size or fail. |
| `contains(value)` | `integer → boolean` | `O(h)` | Búsqueda siguiendo invariante del ABB; `false` si no está. / Lookup following BST invariant; `false` if absent. |
| `is_empty()` | `→ boolean` | `O(1)` | `true` si `count == 0`. / `true` if `count == 0`. |
| `size()` | `→ integer` | `O(1)` | Devuelve el número de nodos almacenados. / Returns the count of stored nodes. |

### `GraphNode` (Interno a `Graph` / Internal to `Graph`)

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `GraphNode.new(label)` | `integer → GraphNode` | `O(1)` | Constructor interno: `value = label`, `neighbors = {}`, `next_vertex = nil`. / Internal constructor: `value = label`, `neighbors = {}`, `next_vertex = nil`. |

### `Graph`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Graph.new()` | `→ Graph` | `O(1)` | Constructor: `vertices = nil`, `vertex_total = 0`, `edge_total = 0`. / Constructor: `vertices = nil`, `vertex_total = 0`, `edge_total = 0`. |
| `is_empty()` | `→ boolean` | `O(1)` | `true` si `vertex_total == 0`. / `true` if `vertex_total == 0`. |
| `vertex_count()` | `→ integer` | `O(1)` | Devuelve el número de vértices registrados. / Returns vertex count. |
| `edge_count()` | `→ integer` | `O(1)` | Devuelve el número de aristas dirigidas. / Returns edge count. |
| `add_vertex(label)` | `integer → boolean` | `O(V)` | Registra vértice; duplicado es idempotente (`true`). / Registers vertex; duplicate is idempotent (`true`). |
| `add_edge(u, v)` | `integer, integer → boolean` | `O(V + d(u))` | Inserta arista dirigida; `false` si falta un extremo; inserción ordenada manual en adyacencia. / Inserts directed edge; `false` if endpoint missing; manual sorted insertion in adjacency. |
| `has_edge(u, v)` | `integer, integer → boolean` | `O(V + d(u))` | Comprueba arista dirigida; `false` si no existe o falta extremo. / Checks directed edge; `false` if missing or endpoint missing. |
| `get_neighbors(u)` | `integer → integer[]\|nil` | `O(V + d(u))` | Devuelve copia aislada de vecinos en orden creciente; `nil` si falta `u`. / Returns isolated copy of neighbours in ascending order; `nil` if `u` missing. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Valor embebido en `TreeNode` y `GraphNode` / Embedded value in `TreeNode` and `GraphNode` | Clase base `Node` con metatabla y herencia por prototipo / Base class `Node` with metatable and prototype inheritance | Lua favorece la composición directa sobre tablas planas; la especificación autoriza expresamente el valor embebido para evitar capas superfluas de indirección metatabular. / Lua favors direct composition on flat tables; the specification explicitly authorizes embedded values to avoid superfluous metatable indirection. |
| Inserción ordenada manual con tabla secuencial / Manual sorted insertion with sequential table | Ordenar con `table.sort` al insertar o consultar / Sorting with `table.sort` on insert or query | Garantiza la complejidad contractual `O(d(u))` por arista y mantiene la invariante de orden sin sobrecostes `O(d(u) log d(u))` ni delegación en utilidades de biblioteca. / Guarantees contractual `O(d(u))` complexity per edge and maintains the ordering invariant without `O(d(u) log d(u))` overhead or delegation to library utilities. |
| Copia superficial independiente en `get_neighbors` / Independent shallow copy in `get_neighbors` | Devolver la referencia interna a `neighbors` / Returning internal reference to `neighbors` | Protege el estado interno del grafo contra mutaciones externas y desacopla consultas futuras de modificaciones concurrentes de aristas. / Protects the graph's internal state against external mutations and decouples future queries from concurrent edge modifications. |
| Registro canónico con lista enlazada simple (`next_vertex`) / Canonical registry with singly-linked list (`next_vertex`) | Tabla asociativa `graph.vertices[label]` / Associative table `graph.vertices[label]` | Cumple el criterio de aceptación de implementación manual estricta `O(V)`, sin delegar el registro en tablas hash de la biblioteca estándar de Lua. / Meets strict manual implementation acceptance criterion `O(V)`, without delegating the registry to Lua standard library hash tables. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Archivo único `src/data_structures_advanced.ext` / Single file `src/data_structures_advanced.ext` | Subdirectorio `src/data_structures_advanced/` con `init.lua`, `tree_node.lua`, `binary_tree.lua` y `graph.lua` / Subdirectory layout with `init.lua` and separate component files | Convención canónica en Lua para separar responsabilidades y permitir `require("data_structures_advanced")` a través del barril. / Canonical convention in Lua to separate concerns and enable `require("data_structures_advanced")` through the barrel. |
| `init()` como constructor / `init()` as constructor | `new()` como función constructora asociada a la metatabla / `new()` as constructor function paired with metatable | Convención idiomática universal en Lua para constructores orientados a objetos con metatablas. / Universal idiomatic convention in Lua for object-oriented constructors with metatables. |
| Ausencia nativa (`absent`) / Native absence (`absent`) | `nil` nativo de Lua / Native Lua `nil` | Lua carece de `null` o centinelas opcionales en el lenguaje base; `nil` representa la ausencia canónica de punteros y claves. / Lua lacks `null` or language-level optional sentinels; `nil` represents canonical absence of pointers and keys. |
| Enlaces inmutables (`set_left` devolviendo nuevo nodo) / Immutable links (`set_left` returning new node) | Mutación en sitio devolviendo `self` / In-place mutation returning `self` | Lua es un lenguaje imperativo con tablas mutables por referencia; la mutación en sitio es idiomática y preserva identidad. / Lua is an imperative language with reference-mutable tables; in-place mutation is idiomatic and preserves identity. |
| Almacenamiento de vecinos en `LinkedList<T>` / Neighbour storage in `LinkedList<T>` | Secuencia nativa indexada de Lua con inserción ordenada manual / Native indexed Lua sequence with manual sorted insertion | Lua no incluye listas enlazadas en su biblioteca estándar; la tabla secuencial con inserción `O(d(u))` cumple las restricciones manuales. / Lua does not include linked lists in its standard library; sequential tables with `O(d(u))` insertion satisfy manual constraints. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `TreeNode.get_left()` | Enlace izquierdo ausente / Absent left link | `nil` | `node:get_left()` devuelve `nil` en un nodo recién creado. / `node:get_left()` returns `nil` on a newly created node. |
| `TreeNode.get_right()` | Enlace derecho ausente / Absent right link | `nil` | `node:get_right()` devuelve `nil` en un nodo recién creado. / `node:get_right()` returns `nil` on a newly created node. |
| `BinaryTree.contains(value)` | Valor ausente en el árbol / Missing value in tree | `false` | `tree:contains(99)` devuelve `false`. / `tree:contains(99)` returns `false`. |
| `Graph.add_edge(u, v)` | Vértice `u` o `v` inexistente / Endpoint `u` or `v` does not exist | `false` | `graph:add_edge(10, 99)` devuelve `false` sin mutar el grafo. / `graph:add_edge(10, 99)` returns `false` without mutating graph. |
| `Graph.has_edge(u, v)` | Arista ausente o extremo inexistente / Missing edge or endpoint | `false` | `graph:has_edge(10, 99)` devuelve `false`. / `graph:has_edge(10, 99)` returns `false`. |
| `Graph.get_neighbors(u)` | Vértice `u` inexistente en el grafo / Vertex `u` does not exist | `nil` | `graph:get_neighbors(99)` devuelve `nil` (distinto de `{}` para vértice aislado). / `graph:get_neighbors(99)` returns `nil` (distinct from `{}` for isolated vertex). |

---

## ✅ Cobertura de pruebas / Test coverage

**ES:** Mapeo de casos: `unidad/variante → casos aplicables → grupo lógico → archivo/suite → runner`.
- `TreeNode` (variante mutable única): 5 casos aplicables evaluados en el grupo lógico `describe("TreeNode")` dentro de `test/data_structures_advanced_tests.lua` ejecutado por Busted. El caso inmutable se declara omitido por diseño de lenguaje.
- `BinaryTree` (ABB sobre `TreeNode`): 7 casos aplicables evaluados en `describe("BinaryTree")`.
- `Graph` (Grafo dirigido con registro canónico): 11 casos aplicables evaluados en `describe("Graph")`.
Total: 23 casos ejecutados y verificados.

**EN:** Case mapping: `unit/variant → applicable cases → logical group → file/suite → runner`.
- `TreeNode` (single mutable variant): 5 applicable cases evaluated in logical group `describe("TreeNode")` inside `test/data_structures_advanced_tests.lua` run by Busted. The immutable case is declared omitted due to language design.
- `BinaryTree` (BST on `TreeNode`): 7 applicable cases evaluated in `describe("BinaryTree")`.
- `Graph` (Directed graph with canonical registry): 11 applicable cases evaluated in `describe("Graph")`.
Total: 23 executed and verified cases.

### `TreeNode`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear un nodo de árbol / Create a tree node | Sí / Yes | `test/data_structures_advanced_tests.lua:67-70` | Verifica `get_value() == 10`. / Verifies `get_value() == 10`. |
| Enlaces iniciales ausentes / Absent initial links | Sí / Yes | `test/data_structures_advanced_tests.lua:72-76` | Verifica `get_left()` y `get_right()` como `nil`. / Verifies `get_left()` and `get_right()` as `nil`. |
| Enlazar dos hijos / Link two children | Sí / Yes | `test/data_structures_advanced_tests.lua:78-84` | Verifica enlace y lectura de valores 20 y 30. / Verifies linking and reading values 20 and 30. |
| Recorrer cada enlace / Traverse each link | Sí / Yes | `test/data_structures_advanced_tests.lua:86-97` | Sigue enlaces y verifica hojas ausentes. / Follows links and verifies absent leaves. |
| Desenlazar hijos / Unlink children | Sí / Yes | `test/data_structures_advanced_tests.lua:99-112` | Desenlaza izquierdo y derecho con `nil` conservando datos. / Clears left and right with `nil` preserving data. |
| Adaptación inmutable (si aplica) / Immutable adaptation (if applicable) | Omitido / Omitted | N/A | Lua es un lenguaje mutable por referencia; no aplica variante inmutable. / Lua is a reference-mutable language; immutable variant does not apply. |

### `BinaryTree`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear vacío / Create empty | Sí / Yes | `test/data_structures_advanced_tests.lua:115-120` | `is_empty() == true`, `size() == 0`, `contains(50) == false`. |
| Insertar la raíz / Insert the root | Sí / Yes | `test/data_structures_advanced_tests.lua:122-128` | Inserta 50; `size() == 1`, `contains(50) == true`. |
| Insertar menor y mayor / Insert lower and higher | Sí / Yes | `test/data_structures_advanced_tests.lua:130-135` | Inserta 50, 30, 70; `size() == 3` y los 3 presentes. / Inserts 50, 30, 70; `size() == 3` and all 3 present. |
| Ramas de varios niveles / Multilevel branches | Sí / Yes | `test/data_structures_advanced_tests.lua:137-143` | Inserta 50, 30, 70, 20, 40; `size() == 5`. |
| Valor ausente en árbol no vacío / Missing value in nonempty tree | Sí / Yes | `test/data_structures_advanced_tests.lua:145-151` | `contains(99) == false`, `size() == 1`. |
| Duplicado idempotente / Idempotent duplicate | Sí / Yes | `test/data_structures_advanced_tests.lua:153-158` | Inserta 50, 30, 70, 30; `size() == 3`. |
| Inserciones ordenadas / Ordered insertions | Sí / Yes | `test/data_structures_advanced_tests.lua:160-166` | Inserta 20, 30, 40, 50, 70; `size() == 5`. |

### `Graph`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear vacío / Create empty | Sí / Yes | `test/data_structures_advanced_tests.lua:170-176` | `is_empty() == true`, 0 vértices, 0 aristas, `has_edge` falso y vecinos `nil`. |
| Vértice aislado / Isolated vertex | Sí / Yes | `test/data_structures_advanced_tests.lua:178-184` | 1 vértice, 0 aristas, vecinos `{}` vacíos. / 1 vertex, 0 edges, empty `{}` neighbours. |
| Etiquetas no consecutivas y arista dirigida / Nonconsecutive labels and directed edge | Sí / Yes | `test/data_structures_advanced_tests.lua:186-192` | Vértices 10 y 70, arista `(10, 70)` dirigida; inversa no existe. / Vertices 10 and 70, directed edge `(10, 70)`; reverse absent. |
| Vértice duplicado conserva adyacencia / Duplicate vertex preserves adjacency | Sí / Yes | `test/data_structures_advanced_tests.lua:194-200` | Reinsertar 10 preserva arista previa `(10, 30)`. / Re-adding 10 preserves previous `(10, 30)` edge. |
| Arista duplicada / Duplicate edge | Sí / Yes | `test/data_structures_advanced_tests.lua:202-208` | Duplicar `(10, 30)` mantiene `edge_count == 1`. / Duplicate `(10, 30)` keeps `edge_count == 1`. |
| Extremo inexistente sin mutación / Missing endpoint without mutation | Sí / Yes | `test/data_structures_advanced_tests.lua:210-227` | Falla con extremos inexistentes sin alterar contadores ni adyacencias previas. / Fails with missing endpoints without altering counts or prior adjacency. |
| Vecinos ordenados y contadores / Sorted neighbours and counts | Sí / Yes | `test/data_structures_advanced_tests.lua:229-240` | Aristas insertadas desordenadas resultan en `[30, 50, 70]`. / Out-of-order edges result in `[30, 50, 70]`. |
| Consulta de arista ausente / Missing-edge query | Sí / Yes | `test/data_structures_advanced_tests.lua:242-247` | `has_edge(10, 30) == false` con vértices registrados pero sin arista. / `has_edge(10, 30) == false` with registered vertices but no edge. |
| Vecinos de vértice inexistente / Neighbours of missing vertex | Sí / Yes | `test/data_structures_advanced_tests.lua:249-255` | `get_neighbors(99) == nil`, distinguishable de `{}` para vértice aislado. / `get_neighbors(99) == nil`, distinguishable from `{}` for isolated vertex. |
| Aislamiento del resultado de vecinos / Neighbour-result isolation | Sí / Yes | `test/data_structures_advanced_tests.lua:257-271` | Modificar la copia devuelta no muta el grafo; nuevas aristas no alteran copias previas. / Modifying returned copy does not mutate graph; new edges do not alter prior copies. |
| Bucle y duplicado / Self-loop and duplicate | Sí / Yes | `test/data_structures_advanced_tests.lua:273-281` | Arista `(10, 10)` añadida dos veces produce 1 arista y vecino `[10]`. / Self-loop `(10, 10)` added twice yields 1 edge and neighbour `[10]`. |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Ninguna / None | No aplica / Not applicable | Todas las operaciones satisfacen el contrato y las complejidades requeridas sin limitaciones observadas. / All operations satisfy the contract and required complexities with no observed limitations. |

---

## 📝 Notas de implementación / Implementation Notes

**ES:**
- **Modelo de objetos:** Se emplean tablas estándar con metatablas y campo `__index`. Los métodos se invocan con la sintaxis `:` pasando `self` implícitamente.
- **Base `Node`:** Conforme a la especificación, la base almacena únicamente el valor sin enlaces ni validaciones. Se reutiliza mediante valor embebido (`self.value`) en `TreeNode` y `GraphNode`, prescindiendo de una metatabla padre intermedia.
- **Ausencia y nulos:** Lua utiliza `nil` como representación universal de ausencia. Se devuelve `nil` en enlaces no asignados (`get_left`, `get_right`) y como indicador de fallo para vértices inexistentes en `get_neighbors(u)`, diferenciándose claramente de una tabla vacía `{}` que denota un vértice existente sin vecinos.
- **Registro canónico de vértices:** El grafo no emplea tablas hash ni índices asociativos para almacenar los vértices. Mantiene una lista enlazada simple a través del puntero `next_vertex`, asegurando una búsqueda manual en tiempo `O(V)`.
- **Adyacencia ordenada:** Para evitar ordenamientos posteriores con coste `O(d log d)`, cada arista se inserta en su posición ordenada mediante búsqueda lineal e inserción in-place en `O(d(u))`.

**EN:**
- **Object model:** Standard tables with metatables and `__index` are used. Methods are called using `:` syntax passing `self` implicitly.
- **Base `Node`:** As per specification, the base holds only the value with no links or validations. It is reused through embedded values (`self.value`) in `TreeNode` and `GraphNode`, avoiding intermediate parent metatables.
- **Absence and nulls:** Lua uses `nil` as the universal representation of absence. `nil` is returned for unassigned links (`get_left`, `get_right`) and as failure indicator for nonexistent vertices in `get_neighbors(u)`, cleanly distinguishing from an empty table `{}` that denotes an existing vertex with no neighbours.
- **Canonical vertex registry:** The graph does not use hash tables or associative indices to store vertices. It maintains a singly linked list via the `next_vertex` pointer, ensuring manual lookup in `O(V)` time.
- **Sorted adjacency:** To avoid post-query sorting with `O(d log d)` overhead, each edge is inserted in its sorted position via linear search and in-place insertion in `O(d(u))`.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

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

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`../data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`../../foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/AGENT_Template/) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/WORKFLOW/) |
| Documentación oficial del lenguaje / Language official docs | [Lua 5.5 Reference Manual](https://www.lua.org/manual/5.5/) |
