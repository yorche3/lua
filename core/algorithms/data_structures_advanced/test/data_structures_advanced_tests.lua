-- Casos de prueba de la especificación 07_Data_Structures_Advanced.md
--
-- Cada caso es una fila de la especificación: una instancia recién creada
-- (`init` es `new` en Lua) y sus pasos en orden. Lua es mutable: los setters
-- mutan el nodo; la fila «Adaptación inmutable» no aplica y se omite.
--
-- Indicadores: la ausencia de enlace es `nil`; el fallo de `contains`/`has_edge`
-- y de las altas es `false`; el fallo de `get_neighbors` es `nil`, distinto de
-- la secuencia vacía `{}`. Los fallos son valores, nunca excepciones.
package.path = "./src/?.lua;./src/?/init.lua;" .. package.path

local data_structures_advanced = require("data_structures_advanced")

local TreeNode = data_structures_advanced.TreeNode
local BinaryTree = data_structures_advanced.BinaryTree
local Graph = data_structures_advanced.Graph

-- Fixtures: un nombre por cada entrada y cada salida esperada.
local parentValue = 10
local leftValue = 20
local rightValue = 30

local rootValue = 50
local lowerValue = 30
local higherValue = 70
local deepLowerValue = 20
local deepMiddleValue = 40
local missingTreeValue = 99
local emptyTreeSize = 0
local rootTreeSize = 1
local threeValuesSize = 3
local fiveValuesSize = 5

local vertexA = 10
local vertexB = 30
local vertexC = 50
local vertexD = 70
local missingVertex = 99
local otherMissingVertex = 98
local noCount = 0
local oneCount = 1
local twoCount = 2
local fourCount = 4
local emptyNeighbors = {}
local neighborsOfAAfterB = { 30 }
local neighborsOfAFull = { 30, 50, 70 }
local neighborsOfBFull = { 50 }
local neighborsOfLoop = { 10 }

-- Ejecutor compartido: inserta en orden y exige éxito en cada alta.
local function insertAll(tree, values, subject)
    for _, value in ipairs(values) do
        assert.is_true(tree:insert(value), subject .. " should succeed inserting " .. value)
    end
end

local function assertAllContained(tree, values, subject)
    for _, value in ipairs(values) do
        assert.is_true(tree:contains(value), subject .. " should contain " .. value)
    end
end

local function newGraph(labels)
    local graph = Graph.new()
    for _, label in ipairs(labels) do
        assert.is_true(graph:add_vertex(label), "Graph should register vertex " .. label)
    end
    return graph
end

local function assertCounts(graph, vertices, edges, subject)
    assert.are.equal(vertices, graph:vertex_count(), subject .. " should have " .. vertices .. " vertices")
    assert.are.equal(edges, graph:edge_count(), subject .. " should have " .. edges .. " edges")
end

describe("TreeNode", function()
    it("Crear un nodo de árbol", function()
        local node = TreeNode.new(parentValue)
        assert.are.equal(parentValue, node:get_value(), "TreeNode should keep the value on init")
    end)

    it("Enlaces iniciales ausentes", function()
        local node = TreeNode.new(parentValue)
        assert.is_nil(node:get_left(), "TreeNode should start with absent left link")
        assert.is_nil(node:get_right(), "TreeNode should start with absent right link")
    end)

    it("Enlazar dos hijos", function()
        local parent = TreeNode.new(parentValue)
        parent:set_left(TreeNode.new(leftValue))
        parent:set_right(TreeNode.new(rightValue))
        assert.are.equal(leftValue, parent:get_left():get_value(), "TreeNode should expose the left child value")
        assert.are.equal(rightValue, parent:get_right():get_value(), "TreeNode should expose the right child value")
    end)

    it("Recorrer cada enlace", function()
        local parent = TreeNode.new(parentValue)
        parent:set_left(TreeNode.new(leftValue))
        parent:set_right(TreeNode.new(rightValue))
        local left, right = parent:get_left(), parent:get_right()
        assert.are.equal(leftValue, left:get_value(), "TreeNode should reach the left child")
        assert.are.equal(rightValue, right:get_value(), "TreeNode should reach the right child")
        assert.is_nil(left:get_left(), "left child should have an absent left link")
        assert.is_nil(left:get_right(), "left child should have an absent right link")
        assert.is_nil(right:get_left(), "right child should have an absent left link")
        assert.is_nil(right:get_right(), "right child should have an absent right link")
    end)

    it("Desenlazar hijos", function()
        local parent = TreeNode.new(parentValue)
        parent:set_left(TreeNode.new(leftValue))
        parent:set_right(TreeNode.new(rightValue))

        parent:set_left(nil)
        assert.is_nil(parent:get_left(), "TreeNode should have an absent left link after clearing it")
        assert.are.equal(parentValue, parent:get_value(), "TreeNode should keep its value after clearing left")
        assert.are.equal(rightValue, parent:get_right():get_value(), "TreeNode should keep the right child after clearing left")

        parent:set_right(nil)
        assert.is_nil(parent:get_left(), "TreeNode should have an absent left link after clearing both")
        assert.is_nil(parent:get_right(), "TreeNode should have an absent right link after clearing both")
        assert.are.equal(parentValue, parent:get_value(), "TreeNode should keep its value after clearing both")
    end)
end)

describe("BinaryTree", function()
    it("Crear vacío", function()
        local tree = BinaryTree.new()
        assert.is_true(tree:is_empty(), "BinaryTree should be empty on init")
        assert.are.equal(emptyTreeSize, tree:size(), "BinaryTree should have size 0 on init")
        assert.is_false(tree:contains(rootValue), "BinaryTree should not contain 50 on init")
    end)

    it("Insertar la raíz", function()
        local tree = BinaryTree.new()
        assert.is_true(tree:insert(rootValue), "BinaryTree should succeed inserting the root")
        assert.are.equal(rootTreeSize, tree:size(), "BinaryTree should have size 1 after the root")
        assert.is_false(tree:is_empty(), "BinaryTree should not be empty after the root")
        assert.is_true(tree:contains(rootValue), "BinaryTree should contain the root")
    end)

    it("Insertar menor y mayor", function()
        local tree = BinaryTree.new()
        insertAll(tree, { rootValue, lowerValue, higherValue }, "BinaryTree")
        assert.are.equal(threeValuesSize, tree:size(), "BinaryTree should have size 3")
        assertAllContained(tree, { rootValue, lowerValue, higherValue }, "BinaryTree")
    end)

    it("Ramas de varios niveles", function()
        local values = { rootValue, lowerValue, higherValue, deepLowerValue, deepMiddleValue }
        local tree = BinaryTree.new()
        insertAll(tree, values, "BinaryTree")
        assertAllContained(tree, values, "BinaryTree")
        assert.are.equal(fiveValuesSize, tree:size(), "BinaryTree should have size 5")
    end)

    it("Valor ausente en árbol no vacío", function()
        local tree = BinaryTree.new()
        assert.is_true(tree:insert(rootValue), "BinaryTree should succeed inserting the root")
        assert.is_false(tree:contains(missingTreeValue), "BinaryTree should not contain 99")
        assert.are.equal(rootTreeSize, tree:size(), "BinaryTree should keep size 1 after a failed lookup")
        assert.is_true(tree:contains(rootValue), "BinaryTree should still contain 50")
    end)

    it("Duplicado idempotente", function()
        local tree = BinaryTree.new()
        insertAll(tree, { rootValue, lowerValue, higherValue, lowerValue }, "BinaryTree")
        assert.are.equal(threeValuesSize, tree:size(), "BinaryTree should ignore the duplicate in size")
        assertAllContained(tree, { rootValue, lowerValue, higherValue }, "BinaryTree")
    end)

    it("Inserciones ordenadas", function()
        local values = { deepLowerValue, lowerValue, deepMiddleValue, rootValue, higherValue }
        local tree = BinaryTree.new()
        insertAll(tree, values, "BinaryTree")
        assert.are.equal(fiveValuesSize, tree:size(), "BinaryTree should have size 5 after ordered insertions")
        assertAllContained(tree, values, "BinaryTree")
        assert.is_false(tree:contains(missingTreeValue), "BinaryTree should not contain 99")
    end)
end)

describe("Graph", function()
    it("Crear vacío", function()
        local graph = Graph.new()
        assert.is_true(graph:is_empty(), "Graph should be empty on init")
        assertCounts(graph, noCount, noCount, "Graph")
        assert.is_false(graph:has_edge(vertexA, vertexB), "Graph should not have edge 10-30 on init")
        assert.is_nil(graph:get_neighbors(vertexA), "Graph should fail get_neighbors(10) on init")
    end)

    it("Vértice aislado", function()
        local graph = Graph.new()
        assert.is_true(graph:add_vertex(vertexA), "Graph should succeed adding vertex 10")
        assert.is_false(graph:is_empty(), "Graph should not be empty with a vertex")
        assertCounts(graph, oneCount, noCount, "Graph")
        assert.are.same(emptyNeighbors, graph:get_neighbors(vertexA), "Graph should give empty neighbours for 10")
    end)

    it("Etiquetas no consecutivas y arista dirigida", function()
        local graph = newGraph({ vertexA, vertexD })
        assert.is_true(graph:add_edge(vertexA, vertexD), "Graph should succeed adding edge 10-70")
        assert.is_true(graph:has_edge(vertexA, vertexD), "Graph should have the forward edge")
        assert.is_false(graph:has_edge(vertexD, vertexA), "Graph should not have the reverse edge")
        assertCounts(graph, twoCount, oneCount, "Graph")
    end)

    it("Vértice duplicado conserva adyacencia", function()
        local graph = newGraph({ vertexA, vertexB })
        assert.is_true(graph:add_edge(vertexA, vertexB), "Graph should succeed adding edge 10-30")
        assert.is_true(graph:add_vertex(vertexA), "Graph should succeed re-adding vertex 10")
        assertCounts(graph, twoCount, oneCount, "Graph")
        assert.are.same(neighborsOfAAfterB, graph:get_neighbors(vertexA), "Graph should preserve neighbours of 10")
    end)

    it("Arista duplicada", function()
        local graph = newGraph({ vertexA, vertexB })
        assert.is_true(graph:add_edge(vertexA, vertexB), "Graph should succeed adding edge the first time")
        assert.is_true(graph:add_edge(vertexA, vertexB), "Graph should succeed adding edge the second time")
        assertCounts(graph, twoCount, oneCount, "Graph")
        assert.are.same(neighborsOfAAfterB, graph:get_neighbors(vertexA), "Graph should keep one neighbour of 10")
    end)

    it("Extremo inexistente sin mutación", function()
        local graph = newGraph({ vertexA, vertexB })
        assert.is_true(graph:add_edge(vertexA, vertexB), "Graph should succeed adding edge 10-30")
        assert.is_false(graph:add_edge(vertexA, missingVertex), "Graph should fail edge 10-99")
        assert.is_false(graph:add_edge(missingVertex, vertexA), "Graph should fail edge 99-10")
        assert.is_false(graph:add_edge(otherMissingVertex, missingVertex), "Graph should fail edge 98-99")
        assert.is_false(graph:add_edge(missingVertex, missingVertex), "Graph should fail edge 99-99")
        assertCounts(graph, twoCount, oneCount, "Graph")
        assert.are.same(neighborsOfAAfterB, graph:get_neighbors(vertexA), "Graph should preserve neighbours of 10")
        assert.are.same(emptyNeighbors, graph:get_neighbors(vertexB), "Graph should keep neighbours of 30 empty")
        assert.is_false(graph:has_edge(vertexA, missingVertex), "Graph should not have edge 10-99")
        assert.is_false(graph:has_edge(missingVertex, vertexA), "Graph should not have edge 99-10")
        assert.is_false(graph:has_edge(otherMissingVertex, missingVertex), "Graph should not have edge 98-99")
        assert.is_false(graph:has_edge(missingVertex, missingVertex), "Graph should not have edge 99-99")
        assert.is_nil(graph:get_neighbors(otherMissingVertex), "Graph should fail get_neighbors(98)")
        assert.is_nil(graph:get_neighbors(missingVertex), "Graph should fail get_neighbors(99)")
    end)

    it("Vecinos ordenados y contadores", function()
        local graph = newGraph({ vertexA, vertexB, vertexC, vertexD })
        assert.is_true(graph:add_edge(vertexA, vertexD), "Graph should succeed adding edge 10-70")
        assert.is_true(graph:add_edge(vertexA, vertexB), "Graph should succeed adding edge 10-30")
        assert.is_true(graph:add_edge(vertexA, vertexC), "Graph should succeed adding edge 10-50")
        assert.is_true(graph:add_edge(vertexB, vertexC), "Graph should succeed adding edge 30-50")
        assert.are.same(neighborsOfAFull, graph:get_neighbors(vertexA), "Graph should sort neighbours of 10")
        assert.are.same(neighborsOfBFull, graph:get_neighbors(vertexB), "Graph should give neighbours of 30")
        assert.are.same(emptyNeighbors, graph:get_neighbors(vertexC), "Graph should keep neighbours of 50 empty")
        assert.are.same(emptyNeighbors, graph:get_neighbors(vertexD), "Graph should keep neighbours of 70 empty")
        assertCounts(graph, fourCount, fourCount, "Graph")
    end)

    it("Consulta de arista ausente", function()
        local graph = newGraph({ vertexA, vertexB })
        assert.is_false(graph:has_edge(vertexA, vertexB), "Graph should not have edge 10-30")
        assertCounts(graph, twoCount, noCount, "Graph")
        assert.is_false(graph:is_empty(), "Graph should not be empty")
    end)

    it("Vecinos de vértice inexistente", function()
        local graph = Graph.new()
        assert.is_true(graph:add_vertex(vertexA), "Graph should succeed adding vertex 10")
        assert.is_nil(graph:get_neighbors(missingVertex), "Graph should fail get_neighbors(99)")
        assert.are.same(emptyNeighbors, graph:get_neighbors(vertexA), "Graph should distinguish empty neighbours of 10")
        assertCounts(graph, oneCount, noCount, "Graph")
    end)

    it("Bucle y duplicado", function()
        local graph = Graph.new()
        assert.is_true(graph:add_vertex(vertexA), "Graph should succeed adding vertex 10")
        assert.is_true(graph:add_edge(vertexA, vertexA), "Graph should succeed adding the loop")
        assert.is_true(graph:add_edge(vertexA, vertexA), "Graph should succeed adding the loop again")
        assert.is_true(graph:has_edge(vertexA, vertexA), "Graph should have the loop")
        assert.are.same(neighborsOfLoop, graph:get_neighbors(vertexA), "Graph should list the loop as neighbour")
        assertCounts(graph, oneCount, oneCount, "Graph")
    end)
end)
