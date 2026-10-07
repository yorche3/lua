-- data_structures_basics — barril del módulo: expone los cuatro tipos.
--
-- Especificación: 06_Data_Structures_Basics

local data_structures_basics = {}

data_structures_basics.Node       = require("data_structures_basics.node")
data_structures_basics.LinkedList = require("data_structures_basics.linked_list")
data_structures_basics.Stack      = require("data_structures_basics.stack")
data_structures_basics.Queue      = require("data_structures_basics.queue")

return data_structures_basics
