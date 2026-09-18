# Algorithms Pure — Lua

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Lua**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre tablas Lua, que **son mutables**, **se indexan desde 1** y usan `nil` como indicador de fallo.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `busted` + LuaRocks | 3 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                          # 05_Naive_Sort
    ├── naive_sort-1.0.0-1.rockspec      # Rock de LuaRocks
    ├── .busted                          # ROOT = {"test"}, pattern = {"_test","_spec"}
    ├── .gitignore                       # Artefactos de proyecto de LuaRocks
    ├── src/
    │   └── naive_sort.lua               # selection_sort, bubble_sort, insertion_sort
    ├── test/
    │   └── naive_sort_tests.lua         # 3 tests × 9 casos
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | Lua 5.3+ (intérprete, sin paso de compilación) |
| **CLI** | `busted` |
| **Manifiesto** | `{modulo}-1.0.0-1.rockspec` — `rockspec_format = "3.0"`, `build.type = "builtin"` y `test_dependencies = { "busted" }` |
| **Configuración de test** | `.busted` con `ROOT = { "test" }` y `pattern = { "_test", "_spec" }` |
| **Framework de tests** | Busted 2.x, instalado en el árbol local (`~/.luarocks`); el árbol del sistema es de root |
| **Entorno de test** | `export PATH="$HOME/.luarocks/bin:$PATH"` + `eval "$(luarocks path)"` |
| **Separación** | `src/{modulo}.lua` (módulo) ↔ `test/` (suites `*_tests.lua`) |
| **Entry point** | El runner de Busted descubre las suites; no hay `run_tests` propio ni `main()` |
| **Acceso al módulo** | `package.path = "./src/?.lua;" .. package.path` al inicio de cada suite, para no instalar el rock |
| **Iteración** | Bucles `for`/`while` nativos sobre tablas |
| **Indexación** | **1-based**: las cotas del pseudocódigo se desplazan una posición |
| **Naming** | `snake_case` para funciones (`selection_sort`), igual que la especificación; módulo como tabla local |
| **Indicador de fallo** | `nil` — se devuelve tal cual, sin lanzar errores |
| **Comparación de tablas** | `assert.same` (comparación profunda); `==` compara referencias |
| **Verificación estática** | `luac -p`, el modo «solo analizar» del compilador estándar |
| **Artefactos** | `*.src.rock`, `luac.out` — cubiertos por el `.gitignore` de la raíz de `lua/` |

---

## 🚀 Compilación rápida / Quick Build

```bash
export PATH="$HOME/.luarocks/bin:$PATH"
eval "$(luarocks path)"

# Naive Sort Tests
cd naive_sort
busted
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
