local GraphNode = {}
GraphNode.__index = GraphNode

--- @param label integer
--- @return GraphNode
function GraphNode.new(label)
    return nil
end

local Graph = {}
Graph.__index = Graph

--- @return Graph
function Graph.new()
    return nil
end

--- @param label integer
--- @return boolean
function Graph:add_vertex(label)
    return nil
end

--- @param u integer
--- @param v integer
--- @return boolean
function Graph:add_edge(u, v)
    return nil
end

--- @param u integer
--- @param v integer
--- @return boolean
function Graph:has_edge(u, v)
    return nil
end

--- @param u integer
--- @return integer[]|nil
function Graph:get_neighbors(u)
    return nil
end

--- @return boolean
function Graph:is_empty()
    return nil
end

--- @return integer
function Graph:vertex_count()
    return nil
end

--- @return integer
function Graph:edge_count()
    return nil
end

return Graph
