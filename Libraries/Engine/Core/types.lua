---@meta

---@alias GroupItem any
---@alias GroupItemIdentificator string
---@alias GroupItemIndex integer
---@alias GroupItemIndexes table<GroupItemIdentificator, GroupItemIndex>

---@class Playable
---@field create fun(group: Group)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@class Group
---@field insert fun(self: Group, index: GroupItemIndex, item: GroupItem)
---@field remove fun(self: Group, index: GroupItemIndex)

---@alias Miliseconds integer
---@alias Path string
---@alias Rotation integer
---@alias Transparency integer
