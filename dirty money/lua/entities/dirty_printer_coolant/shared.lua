ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Dirty Printer Coolant"
ENT.Instructions = ""
ENT.Category = "Money Laundering"
ENT.Spawnable = true

ENT.Author = "posh"
ENT.Purpose = "SinfulRP money laundering"

function ENT:SetupDataTables()
    self:NetworkVar("Int",0,"CoolingAmount")
end