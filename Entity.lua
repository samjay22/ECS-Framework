local Entity = {}
Entity.__index = Entity

local function GetComponent(self, ComponentName)
	local ComponentList = self.Components[ComponentName]

	if not ComponentList then
		local NewList = {}

		self.Components[ComponentName] = NewList
		ComponentList = NewList
	end
	
	return ComponentList
end

local function GetNumberOfComponents(ListOfGivenComponent) : number
	local Size = 0

	for Index, Value in next, ListOfGivenComponent do
		Size += 1
	end

	return Size
end

function Entity.new(EntityObject, ECS)
	local self = setmetatable({
		
		EntityObject = EntityObject;
		Components = {};
		ECS = ECS;
		
	}, Entity)
	
	
	function self:AddComponent(ComponentData)
		local ComponentName = ComponentData.Name
		local ComponentID = ComponentData.ID
		local AllowedAmount = ComponentData.AllowedAmount
		
		local ListOfGivenComponent = GetComponent(self, ComponentName)
		local CurrentComponentNumber = GetNumberOfComponents(ListOfGivenComponent)


		if AllowedAmount > CurrentComponentNumber then
			ListOfGivenComponent[ComponentID] = ComponentData
		end

		print(ListOfGivenComponent[ComponentID], self)
	end

	function self:GetComponent(ComponentName)
		return GetComponent(self, ComponentName)
	end

	
	return self
end

return Entity
