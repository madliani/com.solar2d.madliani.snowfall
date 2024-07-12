---@meta

---@alias GroupIndex number
---@alias GroupIndexIdentificator string
---@alias GroupIndexes table<GroupIndexIdentificator, GroupIndex>

---@class Group
---@field insert fun(self: Group, index: GroupIndex, item: any)
---@field remove fun(self: Group, item: GroupIndex)
