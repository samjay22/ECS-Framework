local Component = {}
local ActiveComponents = {}
local ComponentList = {}

for Index, Value in next, script:GetChildren() do
	ComponentList[Value.Name] = require(Value)
end

function Component.new(ComponentName, EntityID, Decorators)
	local DefaultData = ComponentList[ComponentName]
	local Output = {}

	
	for Index, Value in next, DefaultData or Decorators do
		if Decorators[Index] then
			Output[Index] = Decorators[Index]
		else
			Output[Index] = Value
		end
	end
	
	if not ActiveComponents[EntityID] then
		ActiveComponents[EntityID] = {}
	end
	
	ActiveComponents[EntityID][ComponentName] = Output
end

function Component.GetData(Entity, Name)
	return ActiveComponents[Entity][Name]
end

function Component.RemoveComponent(Entity, Name)
	ActiveComponents[Entity][Name] = nil
end

function Component.Exists(Name)
	return ComponentList[Name]
end

function Component.GetComponents()
	return ComponentList
end

return Component
