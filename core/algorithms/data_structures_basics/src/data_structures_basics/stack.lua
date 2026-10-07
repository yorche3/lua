-- stack — pila LIFO construida a mano sobre Node.
--
-- Especificación: 06_Data_Structures_Basics
--
-- Contrato del paso 4b: firmas con el cuerpo en su indicador natural; el
-- algoritmo es del paso 5 y la suite, del 4c.
--
-- Indicadores: pop y peek devuelven -1 si la pila está vacía, is_empty false y
-- size 0.

local Node = require("data_structures_basics.node")

local Stack = {}
Stack.__index = Stack

--- Pila vacía: tope ausente y contador a cero (init).
-- @return Stack
function Stack.new()
    local self = setmetatable({}, Stack)
    self.top = nil
    self.count = 0
    return self
end

--- Apila el valor sobre el tope (push).
-- @param value number
function Stack:push(value)
end

--- Extrae el tope, o -1 cuando la pila está vacía (pop).
-- @return number
function Stack:pop()
    return -1
end

--- Observa el tope sin extraerlo, o -1 cuando la pila está vacía (peek).
-- @return number
function Stack:peek()
    return -1
end

--- Informa si la pila no tiene nodos (is_empty).
-- @return boolean
function Stack:is_empty()
    return false
end

--- Número de nodos de la pila (size).
-- @return number
function Stack:size()
    return 0
end

return Stack
