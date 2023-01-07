local HTTP = game:GetService("HttpService")

local Systems = require(script.System)
local Components = require(script.Component)
local Entites = require(script.Entity)

local ECS = {}
ECS.__index = ECS

function ECS.new()
	return setmetatable({
		
		Entities = {};
		
	}, ECS)
end

function ECS:NewEntity(Entity)
	local EntityID = HTTP:GenerateGUID(true)
	local newEntity = Entites.new(Entity, self)
	self.Entities[EntityID] = newEntity
	return EntityID
end

function ECS:AddComponentToEntity(EntityID, ComponentName)
	local EntityData = self.Entities[EntityID]
	assert(EntityData, "No entity!")

	local ComponentID : string = HTTP:GenerateGUID(true)
	local ComponentData = Components.new(EntityData, ComponentName, ComponentID)
	EntityData:AddComponent(ComponentData)
	Systems:OnComponentAdded(ComponentData)
end


function ECS:RemoveEntity(EntityID)
	self.Systems:PurgeComponents(self.Entities[EntityID])
	self.Entities[EntityID] = nil
end

function ECS:RemoveComponentFromEntity(Entity, ComponentName)
	
end

return ECS
