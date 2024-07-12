---@meta

---@alias GroupIndex number
---@alias GroupIndexIdentificator string
---@alias GroupIndexes table<GroupIndexIdentificator, GroupIndex>

---@class Playable
---@field create fun(group: Group)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@class Group
---@field insert fun(self: Group, index: GroupIndex, item: any)
---@field remove fun(self: Group, index: GroupIndex)
