# 🚀 Fundamentos / Foundations — Lua

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **Lua (5.3+)**.

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con **Lua**. Cubre desde los programas más básicos (`Hello, World!` y `Hello, User!`) hasta la implementación de una calculadora con pruebas unitarias y algoritmos numéricos en tres enfoques progresivos (recursivo directo, recursivo con acumulador e iterativo).

**EN:** This section brings together the essential concepts to start working with **Lua**. It covers everything from the most basic programs (`Hello, World!` and `Hello, User!`) to the implementation of a calculator with unit tests and numerical algorithms in three progressive approaches (direct recursion, accumulator recursion, and iterative).

---

## 📁 Estructura / Structure

```text
lua/
└── core/
    └── foundations/
        ├── README.md              # Este archivo / This file
        ├── helloworld/            # 01_Hello_World — Primer programa
        │   ├── helloworld.lua
        │   └── README.md
        ├── hellouser/             # 02_Hello_User — Entrada y salida
        │   ├── hellouser.lua
        │   └── README.md
        ├── unit_test/
        │   └── calculator/        # 03_Unit_Test_Calculator — Pruebas unitarias
        │       ├── calculator-1.0.0-1.rockspec
        │       ├── .busted
        │       ├── src/
        │       │   └── calculator.lua
        │       ├── test/
        │       │   └── calculator_test.lua
        │       └── README.md
        └── numbers/               # 04_Numbers — Algoritmos numéricos
            ├── numbers-1.0.0-1.rockspec
            ├── .busted
            ├── src/
            │   └── numbers.lua
            ├── test/
            │   ├── recursive_tests.lua
            │   └── iterative_tests.lua
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias externas |
| -------------- | -------- | --------- | :---: | :-------------------: |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | `print`, ejecución interpretada, `luac` | — | ❌ Solo stdlib |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `io.write`, `io.read`, `local`, concatenación `..` | — | ❌ Solo stdlib |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | LuaRocks, Busted, `describe`/`it`, `assert.are.equal` | 5 | ✅ Busted (solo test) |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | Recursión, iteración, acumuladores, helpers locales, TCO | 10 | ✅ Busted (solo test) |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos en esta sección siguen un patrón progresivo:

1. **Hello World** y **Hello User**: Programas de un solo archivo, ejecutados directamente con el intérprete `lua` (o precompilados con `luac`), sin LuaRocks. Usan exclusivamente la biblioteca estándar.
2. **Calculator**: Primer proyecto con dependencia externa (**Busted**). Introduce **LuaRocks** (rockspec tipo `builtin`), la separación `src/` + `test/` y el runner de Busted (configurado con `.busted`).
3. **Numbers**: Expande el patrón de Calculator a dos suites de prueba (una por enfoque probado). Lua **no garantiza TCO** (la VM no optimiza llamadas de cola), por lo que `_acc` se conserva como puente didáctico sin pruebas propias: `_rec` + `_ite` = 10 tests (22 casos).

**EN:** The projects in this section follow a progressive pattern:

1. **Hello World** and **Hello User**: Single-file programs, run directly with the `lua` interpreter (or precompiled with `luac`), without LuaRocks. Use only the standard library.
2. **Calculator**: First project with an external dependency (**Busted**). Introduces **LuaRocks** (a `builtin` rockspec), the `src/` + `test/` separation, and Busted's runner (configured with `.busted`).
3. **Numbers**: Expands the Calculator pattern to two test suites (one per tested approach). Lua **does not guarantee TCO** (the VM does not optimize tail calls), so `_acc` is kept as an educational bridge without dedicated tests: `_rec` + `_ite` = 10 tests (22 cases).

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd lua/core/foundations/helloworld
lua helloworld.lua
```

### Hello User

```bash
cd lua/core/foundations/hellouser
lua hellouser.lua
```

### Calculator (pruebas)

```bash
cd lua/core/foundations/unit_test/calculator
export PATH="$HOME/.luarocks/bin:$PATH"
eval "$(luarocks path)"
busted
```

### Numbers (pruebas)

```bash
cd lua/core/foundations/numbers
export PATH="$HOME/.luarocks/bin:$PATH"
eval "$(luarocks path)"
busted
```

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
