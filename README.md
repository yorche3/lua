# Lua

Proyectos en **Lua (5.3+)**, con programas simples ejecutados con el intérprete `lua` y proyectos con pruebas unitarias gestionados con **LuaRocks** y el framework **Busted**.

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |

---

## ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
lua helloworld.lua

# Hello, User!
cd core/foundations/hellouser
lua hellouser.lua

# Calculator Tests
cd core/foundations/unit_test/calculator
export PATH="$HOME/.luarocks/bin:$PATH"
eval "$(luarocks path)"
busted

# Numbers Tests
cd core/foundations/numbers
export PATH="$HOME/.luarocks/bin:$PATH"
eval "$(luarocks path)"
busted
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
| ----------- | ----------- |
| [Lua 5.3+](https://www.lua.org/download.html) | `sudo apt install lua5.4` (Linux) / [Descargar](https://www.lua.org/ftp/) y `make all test && sudo make install` |
| [LuaRocks 3.x](https://luarocks.org/) | `sudo apt install luarocks` (Linux) / [Instalar](https://github.com/luarocks/luarocks/wiki/Download) |
| [Busted](https://lunarmodules.github.io/busted/) | `luarocks install --local busted` (árbol local, sin root) |

```bash
# Verificar instalación
lua -v
luarocks --version
busted --version
```

> **ES:** Si Busted se instala en el árbol local (`~/.luarocks`), configura el entorno antes de usarlo:
> **EN:** If Busted is installed in the local tree (`~/.luarocks`), configure the environment before using it:

```bash
export PATH="$HOME/.luarocks/bin:$PATH"
eval "$(luarocks path)"
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (interpretado con `lua`)

**ES:** Un único archivo fuente, sin dependencias externas, ejecutado directamente con el intérprete. Ideal para `helloworld` y `hellouser`. No requiere LuaRocks. Opcionalmente se puede precompilar a bytecode con `luac`.

**EN:** A single source file, no external dependencies, run directly with the interpreter. Ideal for `helloworld` and `hellouser`. No LuaRocks required. Optionally, it can be precompiled to bytecode with `luac`.

```bash
lua <File>.lua
```

### 2. Proyecto con pruebas unitarias (LuaRocks + Busted)

**ES:** Para proyectos que requieren pruebas unitarias, se usa **LuaRocks** (rockspec tipo `builtin`) como gestor de paquetes y **Busted** como framework de test. El código fuente se organiza en `src/` y las pruebas en `test/`, con descubrimiento automático mediante el archivo `.busted`.

**EN:** For projects that require unit tests, **LuaRocks** (a `builtin` rockspec) is used as the package manager and **Busted** as the test framework. Source code goes in `src/` and tests in `test/`, with automatic discovery via the `.busted` file.

```bash
busted                       # desde la raíz del proyecto (usa .busted)
luarocks test --local <rock>.rockspec   # alternativa con test_dependencies
luarocks make --local <rock>.rockspec   # instalar el módulo como rock local
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*