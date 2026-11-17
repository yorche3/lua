local TreeNode = require("data_structures_advanced.tree_node")

local BinaryTree = {}
BinaryTree.__index = BinaryTree

--- @return BinaryTree
function BinaryTree.new()
    return setmetatable({ root = nil, count = 0 }, BinaryTree)
end

--- @param value integer
--- @return boolean
function BinaryTree:insert(value)
    if self.root == nil then
        self.root = TreeNode.new(value)
        self.count = self.count + 1
        return true
    end
    local current = self.root
    while true do
        local v = current:get_value()
        if value == v then
            return true
        elseif value < v then
            local child = current:get_left()
            if child == nil then
                current:set_left(TreeNode.new(value))
                self.count = self.count + 1
                return true
            end
            current = child
        else
            local child = current:get_right()
            if child == nil then
                current:set_right(TreeNode.new(value))
                self.count = self.count + 1
                return true
            end
            current = child
        end
    end
end

--- @param value integer
--- @return boolean
function BinaryTree:contains(value)
    local current = self.root
    while current do
        local v = current:get_value()
        if value == v then
            return true
        elseif value < v then
            current = current:get_left()
        else
            current = current:get_right()
        end
    end
    return false
end

--- @return boolean
function BinaryTree:is_empty()
    return self.count == 0
end

--- @return integer
function BinaryTree:size()
    return self.count
end

return BinaryTree
