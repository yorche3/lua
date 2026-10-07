-- linked_list — lista enlazada construida a mano sobre Node.
--
-- Especificación: 06_Data_Structures_Basics
--
-- Contrato del paso 4b: firmas con el cuerpo en su indicador natural; el
-- algoritmo es del paso 5 y la suite, del 4c.
--
-- Indicadores: get_head devuelve -1 si la lista está vacía, delete false cuando
-- el valor no está, is_empty false y size 0.

local Node = require("data_structures_basics.node")

local LinkedList = {}
LinkedList.__index = LinkedList

--- Lista vacía: cabeza y cola ausentes y contador a cero (init).
-- @return LinkedList
function LinkedList.new()
    local self = setmetatable({}, LinkedList)
    self.head = nil
    self.tail = nil
    self.count = 0
    return self
end

--- Valor de la cabeza, o -1 cuando la lista está vacía (get_head).
-- @return number
function LinkedList:get_head()
    return -1
end

--- Inserta el valor al principio de la lista (insert_head).
-- @param value number
function LinkedList:insert_head(value)
end

--- Inserta el valor al final de la lista (insert_tail).
-- @param value number
function LinkedList:insert_tail(value)
end

--- Elimina la primera aparición del valor (delete): false cuando no está.
-- @param value number
-- @return boolean
function LinkedList:delete(value)
    return false
end

--- Informa si la lista no tiene nodos (is_empty).
-- @return boolean
function LinkedList:is_empty()
    return false
end

--- Número de nodos de la lista (size).
-- @return number
function LinkedList:size()
    return 0
end

return LinkedList
