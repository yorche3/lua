-- node — celda enlazada compartida por LinkedList, Stack y Queue.
--
-- Especificación: 06_Data_Structures_Basics
--
-- Contrato del paso 4b: tipos nuevos y firmas; el algoritmo es del paso 5.
--
-- Indicadores: solo el enlace de un Node puede ser nil; el resto de las
-- operaciones devuelve -1 (números), false (banderas) o 0 (contadores).

local Node = {}
Node.__index = Node

--- Construye la celda con su valor y el enlace ausente (init).
-- @param value number
-- @return Node
function Node.new(value)
    local self = setmetatable({}, Node)
    self.value = value
    self.next = nil
    return self
end

--- Valor de la celda (get_value).
-- @return number
function Node:get_value()
    return self.value
end

--- Enlace de la celda, o nil cuando está ausente (get_next).
-- @return Node|nil
function Node:get_next()
    return self.next
end

--- Actualiza el enlace y devuelve la celda (set_next).
-- @param next_node Node|nil
-- @return Node
function Node:set_next(next_node)
    self.next = next_node
    return self
end

return Node
