AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Initialize
---------------------------------------------------------------------------------------------------------------------------------------------
*/
function ENT:Initialize()
	self:SetModel(self.Model);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	local phys = self:GetPhysicsObject();
	phys:Wake();
	
	local ply = self:Getowning_ent();
	if IsValid(ply) and ply:IsPlayer() then
		self.Owner = ply;
		self:CPPISetOwner(ply);
	end
	
	self.SetAngle = Angle( self.pitch, self.yaw, self.roll)
	
	self.Data = {
			
		self.Model,
		self.Bone,

		self.Scale,

		self.X,
		self.Y,
		self.Z,

		self.pitch,
		self.yaw,
		self.roll,
		
	}
	
	
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				StartTouch / Check Weapon or Shipment
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function ENT:StartTouch(ent)
	
	if ent:IsPlayer() then
	
		self:SetSolid(SOLID_NONE)
		
		net.Start("ClientSideModels")
		net.WriteTable(self.Data)
		net.Send(ent)
		
		self:Remove()
		
	end
	
end
