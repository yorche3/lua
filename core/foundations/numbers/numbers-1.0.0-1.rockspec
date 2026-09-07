rockspec_format = "3.0"

package = "numbers"
version = "1.0.0-1"

source = {
    url = "https://github.com/yorche3/programming_languages/archive/refs/heads/main.tar.gz",
    dir = "programming_languages-main/lua/core/foundations/numbers",
}

description = {
    summary = "Numerical algorithms in three approaches (recursive, accumulator, iterative).",
    detailed = [[
        Numbers module with sum of first n, factorial, Fibonacci, greatest
        common divisor and least common multiple, implemented in three
        approaches: direct recursion, accumulator recursion, and iterative.
    ]],
    homepage = "https://github.com/yorche3/programming_languages",
    license = "MIT",
}

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
