local BlankTable = {}

local ECS = {}
local Entity = require(script.Entity)
local Component = require(script.Component)
local Systems = {}

function ECS.AddEntity(Object)
	return Entity.new(Object)
end

function ECS.RemoveEntity(ID)
	Entity.Remove(ID)

	for Index, Value in next, Component.GetComponents() do
		Component.RemoveComponent(Entity, Index)
	end

end

function ECS.AddComponent(EntityID : string, ComponentName, Decorators)
	local EntityExists = Entity.Exists(EntityID)
	if EntityExists then
		Component.new(ComponentName, EntityID, Decorators or BlankTable)
	end
end

function ECS.RemoveComponent(EntityID, ComponentName)
	assert(Entity.Exists(EntityID), "No entity exists under given name!")
	assert(Component.Exists(ComponentName), "No component exists under given name!")
	
	Component.RemoveComponent(Entity, ComponentName)
end

function ECS.AddSystem(SystemName, SystemProcess)
	assert(Component.Exists(SystemName), "No system exists under given name!")
	
	Systems[SystemName] = SystemProcess
end

function ECS.RemoveSystem(SystemName)
	Systems[SystemName] = nil
end

function ECS.Update(dt)
	for Index, Value in next, Systems do
		Value(Entity, Component, dt)
	end
end

return ECS
