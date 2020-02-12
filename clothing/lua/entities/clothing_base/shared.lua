ENT.Type = "anim";
ENT.Base = "base_anim";
ENT.PrintName = "Clothing";
ENT.Author = "[TNet] Chadness Everdeen";
ENT.Spawnable = false;
ENT.Category = "Clothing";
ENT.AutomaticFrameAdvance = true;
ENT.RenderGroup 		= RENDERGROUP_BOTH;
ENT.lastMove = 0;

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Downloading content from workshop
---------------------------------------------------------------------------------------------------------------------------------------------
*/	

if SERVER then
	
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Some another shared functions
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 1,"owning_ent");
end


