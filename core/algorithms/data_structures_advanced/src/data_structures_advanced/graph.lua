local GraphNode = {}
GraphNode.__index = GraphNode

--- @param label integer
--- @return GraphNode
function GraphNode.new(label)
    local node = { value = label, neighbors = {}, next_vertex = nil }
    return setmetatable(node, GraphNode)
end

local Graph = {}
Graph.__index = Graph

--- @return Graph
function Graph.new()
    local graph = { vertices = nil, vertex_total = 0, edge_total = 0 }
    return setmetatable(graph, Graph)
end

local function find_vertex(graph, label)
    local current = graph.vertices
    while current do
        if current.value == label then
            return current
        end
        current = current.next_vertex
    end
    return nil
end

local function has_neighbor(vertex, label)
    for _, neighbor in ipairs(vertex.neighbors) do
        if neighbor == label then
            return true
        end
    end
    return false
end

local function insert_neighbor(vertex, label)
    local neighbors = vertex.neighbors
    local position = 1
    while position <= #neighbors and neighbors[position] < label do
        position = position + 1
    end
    table.insert(neighbors, position, label)
end

--- @param label integer
--- @return boolean
function Graph:add_vertex(label)
    if find_vertex(self, label) ~= nil then
        return true
    end
    local vertex = GraphNode.new(label)
    vertex.next_vertex = self.vertices
    self.vertices = vertex
    self.vertex_total = self.vertex_total + 1
    return true
end

--- @param u integer
--- @param v integer
--- @return boolean
function Graph:add_edge(u, v)
    local u_vertex = find_vertex(self, u)
    if u_vertex == nil or find_vertex(self, v) == nil then
        return false
    end
    if has_neighbor(u_vertex, v) then
        return true
    end
    insert_neighbor(u_vertex, v)
    self.edge_total = self.edge_total + 1
    return true
end

--- @param u integer
--- @param v integer
--- @return boolean
function Graph:has_edge(u, v)
    local u_vertex = find_vertex(self, u)
    if u_vertex == nil then
        return false
    end
    return has_neighbor(u_vertex, v)
end

--- @param u integer
--- @return integer[]|nil
function Graph:get_neighbors(u)
    local u_vertex = find_vertex(self, u)
    if u_vertex == nil then
        return nil
    end
    local neighbors = {}
    for index, label in ipairs(u_vertex.neighbors) do
        neighbors[index] = label
    end
    return neighbors
end

--- @return boolean
function Graph:is_empty()
    return self.vertex_total == 0
end

--- @return integer
function Graph:vertex_count()
    return self.vertex_total
end

--- @return integer
function Graph:edge_count()
    return self.edge_total
end

return Graph
