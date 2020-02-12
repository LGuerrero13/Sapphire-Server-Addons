AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/freeman/moneyprinters/coolers/cooler_5.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS);
    self:SetUseType(SIMPLE_USE)
    
    self:GetPhysicsObject():Wake()
    self:DrawShadow(true)
    self.nodupe = true
    self:SetCoolingAmount(20)
end

function ENT:Use(activator, caller)
   
end

function ENT:OnTakeDamage(dmg)
    
end

function ENT:StartTouch(ent)

end

