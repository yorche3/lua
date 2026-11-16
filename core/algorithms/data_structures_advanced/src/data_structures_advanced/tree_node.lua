local TreeNode = {}
TreeNode.__index = TreeNode

--- @param value integer
--- @return TreeNode
function TreeNode.new(value)
    return nil
end

--- @return integer
function TreeNode:get_value()
    return nil
end

--- @return TreeNode|nil
function TreeNode:get_left()
    return nil
end

--- @return TreeNode|nil
function TreeNode:get_right()
    return nil
end

--- @param node TreeNode|nil
--- @return TreeNode
function TreeNode:set_left(node)
    return nil
end

--- @param node TreeNode|nil
--- @return TreeNode
function TreeNode:set_right(node)
    return nil
end

return TreeNode
