-- Casos de prueba de la especificación 05_Naive_Sort.md
--
-- Caso nulo incluido: en Lua `nil` es un valor de primera clase, así que el
-- indicador de fallo del contrato es representable y se comprueba aparte del
-- caso vacío. No se espera ninguna excepción.
package.path = "./src/?.lua;" .. package.path

local naive_sort = require("naive_sort")

local standardInput = { 5, 2, 9, 1, 5, 6 }
local standardOutput = { 1, 2, 5, 5, 6, 9 }

local sortedInput = { 1, 2, 3, 4, 5 }
local sortedOutput = { 1, 2, 3, 4, 5 }

local reverseInput = { 5, 4, 3, 2, 1 }
local reverseOutput = { 1, 2, 3, 4, 5 }

local identicalInput = { 7, 7, 7, 7 }
local identicalOutput = { 7, 7, 7, 7 }

local negativeInput = { 3, -1, 4, -5, 0 }
local negativeOutput = { -5, -1, 0, 3, 4 }

local singleInput = { 42 }
local singleOutput = { 42 }

local emptyInput = {}
local emptyOutput = {}

local cases = {
    { description = "an unsorted array", input = standardInput, expected = standardOutput },
    { description = "an already sorted array", input = sortedInput, expected = sortedOutput },
    { description = "a reverse ordered array", input = reverseInput, expected = reverseOutput },
    { description = "an array of identical elements", input = identicalInput, expected = identicalOutput },
    { description = "an array with negative numbers", input = negativeInput, expected = negativeOutput },
    { description = "a single element array", input = singleInput, expected = singleOutput },
    { description = "an empty array", input = emptyInput, expected = emptyOutput },
    -- En una tabla Lua, una clave ausente y una clave con valor `nil` son
    -- equivalentes: `case.input` y `case.expected` valen `nil`.
    { description = "a null input", input = nil, expected = nil },
}

-- Copia suficiente: los casos contienen solo escalares.
local function copyArray(arr)
    if arr == nil then
        return nil
    end
    local result = {}
    for i = 1, #arr do
        result[i] = arr[i]
    end
    return result
end

-- Helper compartido: recibe la función a probar y el nombre del algoritmo, y
-- ejecuta todos los casos con un mensaje descriptivo cada uno.
--
-- La comparación usa `assert.same` porque en Lua `==` sobre tablas compara
-- referencias, no contenidos. Cada caso ordena una copia del fixture, ya que
-- los tres algoritmos pueden ordenar in-place sobre el array recibido.
local function assertSortsAllCases(sort, algorithm)
    for _, case in ipairs(cases) do
        local actual = sort(copyArray(case.input))
        assert.same(case.expected, actual, algorithm .. " should sort " .. case.description)
    end
end

describe("naive_sort", function()
    it("selection_sort", function()
        assertSortsAllCases(naive_sort.selection_sort, "selection_sort")
    end)

    it("bubble_sort", function()
        assertSortsAllCases(naive_sort.bubble_sort, "bubble_sort")
    end)

    it("insertion_sort", function()
        assertSortsAllCases(naive_sort.insertion_sort, "insertion_sort")
    end)
end)
