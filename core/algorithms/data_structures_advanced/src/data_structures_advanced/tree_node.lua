local TreeNode = {}
TreeNode.__index = TreeNode

--- @param value integer
--- @return TreeNode
function TreeNode.new(value)
    return setmetatable({ value = value, left = nil, right = nil }, TreeNode)
end

--- @return integer
function TreeNode:get_value()
    return self.value
end

--- @return TreeNode|nil
function TreeNode:get_left()
    return self.left
end

--- @return TreeNode|nil
function TreeNode:get_right()
    return self.right
end

--- @param node TreeNode|nil
--- @return TreeNode
function TreeNode:set_left(node)
    self.left = node
    return self
end

--- @param node TreeNode|nil
--- @return TreeNode
function TreeNode:set_right(node)
    self.right = node
    return self
end

return TreeNode
