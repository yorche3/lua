-- NaiveSort — ordenamientos elementales O(n²).
--
-- Especificación: 05_Naive_Sort
--
-- Contrato pendiente de implementación (de menor a mayor, in-place sobre el
-- array recibido):
--   selection_sort(arr)
--   bubble_sort(arr)
--   insertion_sort(arr)
--
-- Caso nulo: en Lua `nil` es un valor de primera clase, así que el indicador de
-- fallo del contrato se representa devolviendo `nil` cuando la entrada es nula,
-- sin lanzar errores.

local naive_sort = {}

function naive_sort.selection_sort(arr)
    if arr == nil then return nil end
    local n = #arr
    if n <= 1 then return arr end
    for i = 1, n - 1 do
        local min_index = i
        for j = i + 1, n do
            if arr[j] < arr[min_index] then
                min_index = j
            end
        end
        if min_index ~= i then
            arr[i], arr[min_index] = arr[min_index], arr[i]
        end
    end
    return arr
end

function naive_sort.bubble_sort(arr)
    if arr == nil then return nil end
    local n = #arr
    if n <= 1 then return arr end
    for i = 1, n - 1 do
        local swapped = false
        for j = 1, n - i do
            if arr[j] > arr[j + 1] then
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                swapped = true
            end
        end
        if not swapped then break end
    end
    return arr
end

function naive_sort.insertion_sort(arr)
    if arr == nil then return nil end
    local n = #arr
    if n <= 1 then return arr end
    for i = 2, n do
        local key = arr[i]
        local j = i - 1
        while j >= 1 and arr[j] > key do
            arr[j + 1] = arr[j]
            j = j - 1
        end
        arr[j + 1] = key
    end
    return arr
end
return naive_sort
