ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Dirty Printer Base"
ENT.Category = "Money Laundering"
ENT.Instructions = ""
ENT.Spawnable = false

ENT.Author = "posh"
ENT.Purpose = "SinfulRP money laundering"

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Int", 1, "Amount")
	self:NetworkVar("Int", 2, "PrintTime")
	self:NetworkVar("Int", 3, "PrintCooling")
end