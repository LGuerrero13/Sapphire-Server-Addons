ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Dirty Money"
ENT.Instructions = ""
ENT.Spawnable = true

ENT.Author = "posh"
ENT.Purpose = "SinfulRP money laundering"

function ENT:SetupDataTables()
    self:NetworkVar("Int",0,"amount")
end