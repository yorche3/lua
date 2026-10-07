-- Casos de prueba de la especificación 06_Data_Structures_Basics.md
--
-- Los casos de cada estructura son pasos sucesivos sobre la misma instancia:
-- Lua es mutable, así que `init` se invoca una sola vez y las filas siguientes
-- continúan sobre la estructura ya creada, sin reiniciar el escenario.
--
-- Indicadores: solo el enlace de un `Node` es `nil`; el resto de los fallos son
-- valores devueltos (`-1`, `false`, `0`), nunca excepciones. Las aserciones usan
-- las operaciones del contrato; el recorrido de la lista parte del campo `head`
-- porque `get_head` devuelve el valor de la cabeza y Lua no tiene visibilidad
-- privada.
package.path = "./src/?.lua;./src/?/init.lua;" .. package.path

local data_structures_basics = require("data_structures_basics")

local Node = data_structures_basics.Node
local LinkedList = data_structures_basics.LinkedList
local Stack = data_structures_basics.Stack
local Queue = data_structures_basics.Queue

-- Fixtures: un nombre por cada entrada y cada salida esperada.
local nodeAValue = 10
local nodeBValue = 20

local listFirstValue = 10
local listSecondValue = 20
local listHeadValue = 5
local listAbsentValue = 99
local listInsertedSize = 4
local listDeletedSize = 3
local listInsertedTraversal = { 5, 10, 20, 10 }
local listDeletedTraversal = { 5, 20, 10 }

local stackFirstValue = 10
local stackSecondValue = 20
local stackThirdValue = 30
local stackReuseValue = 40
local stackAfterPushSize = 3

local queueFirstValue = 10
local queueSecondValue = 20
local queueThirdValue = 30
local queueReuseValue = 40
local queueAfterEnqueueSize = 3

local emptySize = 0
local failureValue = -1

-- Recorrido compartido sobre los enlaces: solo `get_value` y `get_next`, para
-- observar el orden de la lista y no sus campos internos.
local function traverseFrom(head)
    local values = {}
    local current = head
    while current ~= nil do
        values[#values + 1] = current:get_value()
        current = current:get_next()
    end
    return values
end

-- Ejecutor compartido: recorre los pasos en orden, sobre la misma instancia, y
-- compara lo observado con lo esperado nombrando el caso que falla.
local function assertSteps(steps, subject)
    for _, step in ipairs(steps) do
        local observed = step.run()
        assert.same(step.expected, observed, subject .. " should " .. step.description)
    end
end

describe("data_structures_basics", function()
    it("Node", function()
        local a, b

        assertSteps({
            -- Caso: inicializar y observar valor/enlace.
            { description = "assign the value on init",
              run = function()
                  a = Node.new(nodeAValue)
                  return a:get_value()
              end,
              expected = nodeAValue },
            { description = "leave the next link absent on init",
              run = function() return a:get_next() end,
              expected = nil },

            -- Caso: inicializar otro nodo, enlazar y recorrer.
            { description = "assign the value of the second node on init",
              run = function()
                  b = Node.new(nodeBValue)
                  return b:get_value()
              end,
              expected = nodeBValue },
            { description = "link the next node with set_next",
              run = function()
                  a:set_next(b)
                  return a:get_next():get_value()
              end,
              expected = nodeBValue },
            { description = "keep the next link absent on a linked node",
              run = function() return b:get_next() end,
              expected = nil },
        }, "Node")
    end)

    it("LinkedList", function()
        local list = LinkedList.new()

        assertSteps({
            -- Paso: estado vacío.
            { description = "be empty after init",
              run = function() return list:is_empty() end,
              expected = true },
            { description = "report size 0 after init",
              run = function() return list:size() end,
              expected = emptySize },
            { description = "return the failure indicator from get_head on an empty list",
              run = function() return list:get_head() end,
              expected = failureValue },

            -- Paso: insertar por ambos extremos.
            { description = "count one element per insertion",
              run = function()
                  list:insert_tail(listFirstValue)
                  list:insert_tail(listSecondValue)
                  list:insert_head(listHeadValue)
                  list:insert_tail(listFirstValue)
                  return list:size()
              end,
              expected = listInsertedSize },
            { description = "traverse 5, 10, 20, 10 from the head",
              run = function() return traverseFrom(list.head) end,
              expected = listInsertedTraversal },

            -- Paso: eliminar la primera aparición.
            { description = "succeed on the first occurrence with delete",
              run = function() return list:delete(listFirstValue) end,
              expected = true },
            { description = "remove only the first occurrence",
              run = function() return traverseFrom(list.head) end,
              expected = listDeletedTraversal },
            { description = "decrement the size on a successful delete",
              run = function() return list:size() end,
              expected = listDeletedSize },

            -- Paso: valor ausente.
            { description = "fail with delete on an absent value",
              run = function() return list:delete(listAbsentValue) end,
              expected = false },
            { description = "keep the elements after a failed delete",
              run = function() return traverseFrom(list.head) end,
              expected = listDeletedTraversal },
            { description = "keep the size after a failed delete",
              run = function() return list:size() end,
              expected = listDeletedSize },

            -- Paso: vaciar la lista.
            { description = "remove the remaining head with delete",
              run = function() return list:delete(listHeadValue) end,
              expected = true },
            { description = "remove the remaining second value with delete",
              run = function() return list:delete(listSecondValue) end,
              expected = true },
            { description = "remove the remaining first value with delete",
              run = function() return list:delete(listFirstValue) end,
              expected = true },
            { description = "be empty after removing every element",
              run = function() return list:is_empty() end,
              expected = true },
            { description = "report size 0 after removing every element",
              run = function() return list:size() end,
              expected = emptySize },
            { description = "return the failure indicator from get_head after emptying the list",
              run = function() return list:get_head() end,
              expected = failureValue },
        }, "LinkedList")
    end)

    it("Stack", function()
        local stack = Stack.new()

        assertSteps({
            -- Paso: estado vacío y extracción fallida.
            { description = "be empty after init",
              run = function() return stack:is_empty() end,
              expected = true },
            { description = "report size 0 after init",
              run = function() return stack:size() end,
              expected = emptySize },
            { description = "return the failure indicator from peek on an empty stack",
              run = function() return stack:peek() end,
              expected = failureValue },
            { description = "return the failure indicator from pop on an empty stack and stay empty",
              run = function()
                  local popped = stack:pop()
                  return { popped, stack:is_empty() }
              end,
              expected = { failureValue, true } },

            -- Paso: LIFO y `peek` no mutante.
            { description = "observe the top with peek without removing it",
              run = function()
                  stack:push(stackFirstValue)
                  stack:push(stackSecondValue)
                  stack:push(stackThirdValue)
                  local peeked = stack:peek()
                  return { peeked, stack:size() }
              end,
              expected = { stackThirdValue, stackAfterPushSize } },

            -- Paso: extracción y reutilización.
            { description = "extract the top with pop and reuse the stack with push",
              run = function()
                  local results = { stack:pop() }
                  stack:push(stackReuseValue)
                  results[#results + 1] = stack:pop()
                  results[#results + 1] = stack:pop()
                  results[#results + 1] = stack:pop()
                  return results
              end,
              expected = { stackThirdValue, stackReuseValue, stackSecondValue,
                  stackFirstValue } },
            { description = "be empty and report size 0 after extracting every value",
              run = function() return { stack:is_empty(), stack:size() } end,
              expected = { true, emptySize } },

            -- Paso: vacío tras extracción.
            { description = "return the failure indicator from pop after emptying and stay empty",
              run = function()
                  local popped = stack:pop()
                  return { popped, stack:is_empty() }
              end,
              expected = { failureValue, true } },
        }, "Stack")
    end)

    it("Queue", function()
        local queue = Queue.new()

        assertSteps({
            -- Paso: estado vacío y extracción fallida.
            { description = "be empty after init",
              run = function() return queue:is_empty() end,
              expected = true },
            { description = "report size 0 after init",
              run = function() return queue:size() end,
              expected = emptySize },
            { description = "return the failure indicator from peek on an empty queue",
              run = function() return queue:peek() end,
              expected = failureValue },
            { description = "return the failure indicator from dequeue on an empty queue and stay empty",
              run = function()
                  local dequeued = queue:dequeue()
                  return { dequeued, queue:is_empty() }
              end,
              expected = { failureValue, true } },

            -- Paso: FIFO y `peek` no mutante.
            { description = "observe the front with peek without removing it",
              run = function()
                  queue:enqueue(queueFirstValue)
                  queue:enqueue(queueSecondValue)
                  queue:enqueue(queueThirdValue)
                  local peeked = queue:peek()
                  return { peeked, queue:size() }
              end,
              expected = { queueFirstValue, queueAfterEnqueueSize } },

            -- Paso: extracción y reutilización.
            { description = "extract the front with dequeue and reuse the queue with enqueue",
              run = function()
                  local results = { queue:dequeue() }
                  queue:enqueue(queueReuseValue)
                  results[#results + 1] = queue:dequeue()
                  results[#results + 1] = queue:dequeue()
                  results[#results + 1] = queue:dequeue()
                  return results
              end,
              expected = { queueFirstValue, queueSecondValue, queueThirdValue,
                  queueReuseValue } },
            { description = "be empty and report size 0 after extracting every value",
              run = function() return { queue:is_empty(), queue:size() } end,
              expected = { true, emptySize } },

            -- Paso: vacío tras extracción.
            { description = "return the failure indicator from dequeue after emptying and stay empty",
              run = function()
                  local dequeued = queue:dequeue()
                  return { dequeued, queue:is_empty() }
              end,
              expected = { failureValue, true } },
        }, "Queue")
    end)
end)
