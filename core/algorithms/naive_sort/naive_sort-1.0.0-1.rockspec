rockspec_format = "3.0"

package = "naive_sort"
version = "1.0.0-1"

source = {
    url = "https://github.com/yorche3/programming_languages/archive/refs/heads/main.tar.gz",
    dir = "programming_languages-main/lua/core/algorithms/naive_sort",
}

description = {
    summary = "Elementary sorting algorithms (selection, bubble and insertion sort).",
    detailed = [[
        Naive Sort module with the three elementary O(n^2) sorting algorithms,
        implemented directly over arrays with step-by-step comparisons and
        swaps, without system sorting libraries or auxiliary structures.
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
        naive_sort = "src/naive_sort.lua",
    },
}
