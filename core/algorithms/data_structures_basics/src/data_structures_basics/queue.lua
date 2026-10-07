-- queue — cola FIFO construida a mano sobre Node.
--
-- Especificación: 06_Data_Structures_Basics
--
-- Contrato del paso 4b: firmas con el cuerpo en su indicador natural; el
-- algoritmo es del paso 5 y la suite, del 4c.
--
-- Indicadores: dequeue y peek devuelven -1 si la cola está vacía, is_empty false
-- y size 0.

local Node = require("data_structures_basics.node")

local Queue = {}
Queue.__index = Queue

--- Cola vacía: frente y final ausentes y contador a cero (init).
-- @return Queue
function Queue.new()
    local self = setmetatable({}, Queue)
    self.front = nil
    self.rear = nil
    self.count = 0
    return self
end

--- Añade el valor por el final de la cola (enqueue).
-- @param value number
function Queue:enqueue(value)
end

--- Extrae el frente, o -1 cuando la cola está vacía (dequeue).
-- @return number
function Queue:dequeue()
    return -1
end

--- Observa el frente sin extraerlo, o -1 cuando la cola está vacía (peek).
-- @return number
function Queue:peek()
    return -1
end

--- Informa si la cola no tiene nodos (is_empty).
-- @return boolean
function Queue:is_empty()
    return false
end

--- Número de nodos de la cola (size).
-- @return number
function Queue:size()
    return 0
end

return Queue
