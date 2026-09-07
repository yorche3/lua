rockspec_format = "3.0"

package = "calculator"
version = "1.0.0-1"

source = {
    url = "https://github.com/yorche3/programming_languages/archive/refs/heads/main.tar.gz",
    dir = "programming_languages-main/lua/core/foundations/unit_test/calculator",
}

description = {
    summary = "Calculator with educational arithmetic implementations.",
    detailed = [[
        Calculator module with addition, subtraction, multiplication, division
        and modulus, implemented with educational strategies (repeated
        addition and subtraction) for the programming_languages project.
    ]],
    homepage = "https://github.com/yorche3/programming_languages",
    license = "MIT",
}

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
