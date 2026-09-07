# Hello, World! — Lua

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Lua**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`helloworld.lua`](helloworld.lua) | Código fuente: imprime `"Hello, World! from Lua!"` en la salida estándar. |

**Estructura de directorios esperada:**

```text
helloworld/
├── helloworld.lua   # Código fuente
└── README.md        # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. Un único archivo `.lua` es suficiente: Lua es un lenguaje interpretado, por lo que no requiere compilación previa para ejecutarse. Opcionalmente se puede precompilar a bytecode con `luac`.

**EN:** The project was created manually, without scaffolding tools. A single `.lua` file is enough: Lua is an interpreted language, so no prior compilation is required to run it. Optionally, it can be precompiled to bytecode with `luac`.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p lua/core/foundations/helloworld
   ```

2. Escribir el archivo `helloworld.lua` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `lua`.

```lua
print("Hello, World! from Lua!")
```

| Elemento | Propósito |
|----------|-----------|
| `print(...)` | Función global que imprime sus argumentos en la salida estándar, separados por tabulaciones y seguidos de un salto de línea (`\n`). |
| `"Hello, World! from Lua!"` | Argumento: la cadena a imprimir. |

> **ES:** `print` acepta cualquier número de argumentos y usa el metamétodo `__tostring` de cada uno para convertirlos a cadena.
> **EN:** `print` accepts any number of arguments and uses each one's `__tostring` metamethod to convert them to strings.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Lua instalado

```bash
# Verificar instalación
lua -v
```

### Ejecutar directamente / Run directly

```bash
cd lua/core/foundations/helloworld
lua helloworld.lua
```

### Precompilar con `luac` (opcional) / Precompile with `luac` (optional)

**ES:** `luac` traduce el código fuente a bytecode precompilado, que el intérprete carga más rápido y es portátil entre plataformas con el mismo número de versión.

**EN:** `luac` translates source code to precompiled bytecode, which the interpreter loads faster and is portable across platforms with the same version number.

```bash
cd lua/core/foundations/helloworld
luac -o helloworld.luac helloworld.lua
lua helloworld.luac
```

> **ES:** Si se ejecuta `luac helloworld.lua` sin `-o`, el bytecode se guarda como `luac.out` (ya ignorado en el `.gitignore`).
> **EN:** If `luac helloworld.lua` is run without `-o`, the bytecode is saved as `luac.out` (already ignored in `.gitignore`).

### Salida esperada / Expected output

```text
Hello, World! from Lua!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Lua no requiere una función `main`: el script se ejecuta de arriba a abajo como en lenguajes de scripting.
- **EN:** Lua does not require a `main` function: the script executes top to bottom like in scripting languages.
- **ES:** `print` escribe en `stdout` y añade automáticamente un salto de línea.
- **EN:** `print` writes to `stdout` and automatically appends a newline.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
