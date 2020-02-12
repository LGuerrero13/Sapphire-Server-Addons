AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Initialize
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function ENT:Initialize()

	self:SetModel(self.DirtyPrinterModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS);
	
	self:GetPhysicsObject():Wake()
	self:DrawShadow(true)
	self.nodupe = true
	self:Printing()
	self:Cooling()
	self:StartSound()
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Printer Functionality / Money Creation
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function ENT:Think()
	if self:GetPrintTime() >= self.PrinterTimer then
		self:SetPrintTime(0)
		self:CreateDirtyMoney()
	end
end

function ENT:Cooling()
	self:SetPrintCooling(100)
	
	timer.Create("coolingertimer", self.CoolantDegradeTime, 0, function()
		self:SetPrintCooling(self:GetPrintCooling() - self.CoolantDegradeAmount)
	end)
end

function ENT:Printing()

	timer.Create("globaltimer", 1, 0, function()

		if self:GetPrintCooling() > 0 then 
			self:StartSound()
			timer.UnPause("nettimer")
			timer.UnPause("coolingertimer")
		else
			timer.Pause("nettimer")
			timer.Pause("coolingertimer")

			if self.sound then
				self.sound:Stop()
			end	
		end

	end)

	timer.Create("nettimer", 1, 0, function()
		self:SetPrintTime(self:GetPrintTime() + 1)
	end)

end

function ENT:StartSound()
	self.sound = CreateSound(self, Sound(self.PrintSound))
	self.sound:SetSoundLevel(100)
	self.sound:PlayEx(1, 100)
	timer.Create("soundtimer", self.PrinterTimer, 0, function()
		self.sound = CreateSound(self, Sound(self.PrintSound))
		self.sound:SetSoundLevel(100)
		self.sound:PlayEx(1, 100)
	end)
end

function ENT:CreateDirtyMoney()
	local mon = ents.Create( "dirty_money" )
		if ( !IsValid( mon ) ) then return end
		mon:SetModel( "models/freeman/moneyprinters/printer_4.mdl" )
		mon:SetPos( self:GetPos() )
		mon:Spawn()
		mon:Setamount(self.PrinterCashAmount)

	if self.sound then
		self.sound:Stop()
	end		
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "dirty_printer_coolant" then
		ent:Remove()
		self:SetPrintCooling(self:GetPrintCooling() + ent:GetCoolingAmount())
	end
end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end	


	timer.Remove("nettimer", self:EntIndex())	
	timer.Remove("coolingertimer", self:EntIndex())
	timer.Remove("globaltimer", self:EntIndex())
end