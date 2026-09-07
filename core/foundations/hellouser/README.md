# Hello, User! — Lua

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Lua**, con un enfoque manual y minimalista.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hellouser.lua`](hellouser.lua) | Código fuente: solicita un nombre al usuario y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hellouser.lua   # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **Escritura sin salto de línea** — `io.write` imprime el prompt dejando el cursor en la misma línea.
2. **Entrada de usuario** — `io.read("*l")` lee una línea desde la entrada estándar.
3. **Variables locales y concatenación** — `local name` declara una variable de ámbito local, y `..` concatena cadenas.

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Writing without newline** — `io.write` prints the prompt leaving the cursor on the same line.
2. **User input** — `io.read("*l")` reads a line from standard input.
3. **Local variables and concatenation** — `local name` declares a locally scoped variable, and `..` concatenates strings.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p lua/core/foundations/hellouser
   ```

2. Escribir el archivo `hellouser.lua` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `lua`.

**ES:** El flujo del programa es:

1. Imprimir `"Enter your name: "` con `io.write` (sin salto de línea).
2. Leer una línea desde `stdin` con `io.read("*l")`.
3. Imprimir `"Hello, <nombre>!"` concatenando con `..`.

**EN:** Program flow:

1. Print `"Enter your name: "` with `io.write` (no newline).
2. Read a line from `stdin` with `io.read("*l")`.
3. Print `"Hello, <name>!"` concatenating with `..`.

```lua
io.write("Enter your name: ")
local name = io.read("*l")
print("Hello, " .. name .. "!")
```

| Elemento | Propósito |
|----------|-----------|
| `io.write(...)` | Imprime en la salida estándar **sin** salto de línea al final (el cursor permanece junto al prompt). |
| `io.read("*l")` | Lee una línea desde la entrada estándar (sin el salto de línea final). `"*l"` es el formato por defecto de `io.read`. |
| `local name` | Variable local; `local` limita su ámbito al bloque actual (buena práctica frente a los globales). |
| `..` | Operador de concatenación de cadenas. |
| `print(...)` | Imprime con salto de línea al final. |

> **ES:** `io.read` admite varios formatos: `"*l"` (línea), `"*n"` (número), `"*a"` (todo el archivo) o un número (cantidad de caracteres). Sin argumentos equivale a `"*l"`.
> **EN:** `io.read` accepts several formats: `"*l"` (line), `"*n"` (number), `"*a"` (whole file), or a number (character count). With no arguments it defaults to `"*l"`.

> **ES:** En Lua, concatenar con `..` no convierte números automáticamente en versiones antiguas; para concatenar un número hay que usar `tostring(n)`. Con cadenas no hay problema.
> **EN:** In Lua, concatenating with `..` does not automatically convert numbers in old versions; to concatenate a number you must use `tostring(n)`. With strings there is no problem.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Lua instalado

```bash
# Verificar instalación
lua -v
```

### Ejecutar / Run

```bash
cd lua/core/foundations/hellouser
lua hellouser.lua
```

### Salida esperada / Expected output

```text
Enter your name: Ada
Hello, Ada!
```

> **ES:** El programa espera a que el usuario escriba su nombre y presione Enter antes de mostrar el saludo.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Lua no requiere una función `main`: el script se ejecuta de arriba a abajo.
- **EN:** Lua does not require a `main` function: the script executes top to bottom.
- **ES:** `local` restringe la variable al ámbito del script (chunk); por defecto las variables serían globales.
- **EN:** `local` restricts the variable to the script (chunk) scope; by default variables would be global.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
