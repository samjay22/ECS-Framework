local HTTP = game:GetService("HttpService")
local Entity = {}
local Entities = {}

function Entity.new(Object) : string
	local ID = HTTP:GenerateGUID(true)
	Entities[ID] = 	Object
	return ID
end

function Entity.Remove(ID)
	Entities[ID] = nil
end

function Entity.GetPrefab(ID)
	return Entities[ID]
end

function Entity.Exists(ID)
	return Entities[ID] ~= nil
end

return Entity
