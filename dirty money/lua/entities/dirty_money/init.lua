AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/freeman/moneyprinters/printer_4.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS);
    self:SetUseType(SIMPLE_USE)
    
    self:GetPhysicsObject():Wake()
    self:DrawShadow(true)
    self.nodupe = true
end

function ENT:Use(activator, caller)
    if IsValid( caller ) and caller:IsPlayer() and caller:Team() == TEAM_LAUNDERER then
        self:Remove()
        DarkRP.notify(activator, 0, 4, DarkRP.getPhrase("found_money", DarkRP.formatMoney(500)))
        activator:addMoney(500 or 0)
        DarkRP.createMoneyBag(activator:GetPos() + Vector(20,0,30), self:Getamount())
    end
end

function ENT:OnTakeDamage(dmg)
    self:TakePhysicsDamage(dmg)

    local typ = dmg:GetDamageType()
    if bit.band(typ, DMG_BULLET) ~= DMG_BULLET then return end

    self.USED = true
    self.hasMerged = true
    self:Remove()
end

function ENT:StartTouch(ent)

end

