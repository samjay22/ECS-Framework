local ComponentList = {}
local Component = {}
Component.__index = Component

for Index, Value in next, script:GetChildren() do
	local Data = require(Value)
	ComponentList[Value.Name] = Data
end

function Component.new(Entity, ComponentName, ComponentID)
	local ComponentData = ComponentList[ComponentName]
	assert(ComponentData, "No ComponentData")
	local Data = ComponentData.new(Entity, ComponentID)
	local self = setmetatable(Data, Component)
	return self
end

function Component:GetParent()
	return self.Parent
end

function Component:RemoveComponentFromEntity()
	self.Parent = nil
end

return Component
