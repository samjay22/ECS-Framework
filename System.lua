local System = {}
local SystemsList = {}
System.__index = System


for Index, Value in next, script:GetChildren() do
	if Value.Name == "BaseSystem" then 
		continue 
	end
	
	local Data = require(Value)
	SystemsList[Value.Name] = Data.new()
end

function System.new()
	return setmetatable({
		
		Systems = SystemsList;
		
	}, System)
end

function System.GetSystem(ComponentName : string)
	local SystemData = SystemsList[ComponentName]
	
	return SystemData
end

function System:OnComponentAdded(ComponentData)
	local ComponentName, ComponentID = ComponentData.Name, ComponentData.ID
	local SystemData =  System.GetSystem(ComponentName)
	
	SystemData:AddComponent(ComponentData)
end

function System:OnEntityRemoved(ComponentData)
	local ComponentName, ComponentID = ComponentData.Name, ComponentData.ID
	local SystemData =  System.GetSystem(ComponentName)
	
	SystemData:RemoveComponent(ComponentData)
end

function System:PurgeComponents(Entity)
	for SystemName, SystemMetatable in next, self.Systems do
		SystemMetatable:PurgeEntity(Entity)
	end 
end

function System:UpdateAllSystems()
	for SystemName, SystemMetatable in next, self.Systems do
		SystemMetatable:Update()
	end
end


local SystemsObject = System.new()

local function UpdateSystems()
	SystemsObject:UpdateAllSystems()
end

game["Run Service"].Heartbeat:Connect(UpdateSystems)

return SystemsObject.new()
