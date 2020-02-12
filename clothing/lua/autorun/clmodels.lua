if SERVER then
 	
	AddCSLuaFile()
	
	util.AddNetworkString("ClientSideModels")
	util.AddNetworkString("RemoveData")
	
	function GAMEMODE:PlayerDeath( victim, inflictor, attacker)

		net.Start("RemoveData")
		net.Send(victim)
	
	end

	local function LoadCoordinates()
		local XYZFILE = file.Read("clothing_data.txt", "DATA")
		if not data then file.CreateDir( "clothing_data" ) end

		data = string.Split(data, "\n")
		for _, line in ipairs(data) do
			local args = string.Split(line, " ; ") -- Used for readability
			local x = args[1]

			if not x then return end -- ERROR!

			_clothing[0].x = args
		end
	end
	
end

if CLIENT then
	local meta = FindMetaTable( "Player" )
	meta.Data = {}
	
	
	net.Receive("ClientSideModels", function( len, ply) 
	
		local data = net.ReadTable()
		table.insert(data, ClientsideModel(data[1]))
		data[10]:SetNoDraw( true )
		
		table.insert(meta.Data, data)
		
		
	end)

	hook.Add( "OnPlayerChat", "purgemodelshook", function( ply, text, bTeam, bDead )
		if ( ply != LocalPlayer() ) then return end

		if ( string.lower(text) == "!purgemodels" ) then

			for m, l in pairs(meta.Data) do
				l[10]:Remove()
			end

			meta.Data = {}

			return true
		end
	end )

	function PositionEditor()
		local Form = vgui.Create("DFrame")
			Form:SetSize(400, 200)
			Form:Center()
			Form:MakePopup()
			Form:SetTitle("")
			Form:ShowCloseButton(false)
			Form.Paint = function(self, w, h)
				surface.SetDrawColor( Color( 0, 0, 0 ) )
				surface.DrawOutlinedRect( 0, 0, w, h )

				surface.SetDrawColor( Color( 255, 255, 255 ) )
				surface.DrawOutlinedRect( 1, 1, w - 2, h - 2 )


				draw.RoundedBox(0, 2, 2, w - 4, h - 4,Color(9,28,40))
			end

		local Header = vgui.Create("DPanel", Form)
			Header:SetPos(2,2)
			Header:SetSize(Form:GetWide() - 4, 15)
			Header.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(18,18,10))
			end

		local ExitButton = vgui.Create("DButton", Header)
			ExitButton:SetText("X")
			ExitButton:SetPos(Header:GetWide() - 15, 0)
			ExitButton:SetSize(15,15)
			ExitButton:SetColor(Color(255,255,255))
			ExitButton.DoClick = function()
				Form:Close()
			end
			ExitButton.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(200,15,62))
			end

		local Title = vgui.Create("DLabel", Header)
			Title:SetSize(75, 15)
			Title:SetFont("HudSelectionText")
			Title:SetColor(Color(218,200,160))
			Title:SetPos(2, 0)
			Title:SetText("Clothing Editor")

		local xtext = vgui.Create("DTextEntry", Form)
			xtext:SetPos(25, 50)
			xtext:SetSize(40, 20)
			xtext:SetText("X")
			xtext.OnEnter = function(self)
				for k, v in pairs(meta.Data) do
					v[4] = self:GetValue()
					LocalPlayer():SetPData("xvalue", self:GetValue())
				end
			end

		local ytext = vgui.Create("DTextEntry", Form)
			ytext:SetPos(25, 80)
			ytext:SetSize(40, 20)
			ytext:SetText("Y")
			ytext.OnEnter = function(self)
				for k, v in pairs(meta.Data) do
					v[5] = self:GetValue()
					LocalPlayer():SetPData("yvalue", self:GetValue())
				end
			end

		local ztext = vgui.Create("DTextEntry", Form)
			ztext:SetPos(25, 110)
			ztext:SetSize(40, 20)
			ztext:SetText("Z")
			ztext.OnEnter = function(self)
				for k, v in pairs(meta.Data) do
					v[6] = self:GetValue()
					LocalPlayer():SetPData("zvalue", self:GetValue())
				end
			end

		--[[Rotation]]--
		local rotx = vgui.Create("DTextEntry", Form)
			rotx:SetPos(85, 50)
			rotx:SetSize(40, 20)
			rotx:SetText("Rot X")
			rotx.OnEnter = function(self)
				for k, v in pairs(meta.Data) do
					v[7] = self:GetValue()
					LocalPlayer():SetPData("rotx", self:GetValue())
				end
			end

		local roty = vgui.Create("DTextEntry", Form)
			roty:SetPos(85, 80)
			roty:SetSize(40, 20)
			roty:SetText("Rot Y")
			roty.OnEnter = function(self)
				for k, v in pairs(meta.Data) do
					v[8] = self:GetValue()
					LocalPlayer():SetPData("roty", self:GetValue())
				end
			end

		local rotz = vgui.Create("DTextEntry", Form)
			rotz:SetPos(85, 110)
			rotz:SetSize(40, 20)
			rotz:SetText("Rot Z")
			rotz.OnEnter = function(self)
				for k, v in pairs(meta.Data) do
					v[9] = self:GetValue()
					LocalPlayer():SetPData("rotz", self:GetValue())
				end
			end
	end

	concommand.Add("clothes_editor",PositionEditor)
	
	hook.Add( 'PostPlayerDraw', "CustomClothing", function(ply) 
		
		if not IsValid(ply) or not ply:Alive() then print("Dead")return end
		for k, v in pairs(meta.Data) do

			local bone_id = ply:LookupBone( v[2] )
			if not bone_id then return end
			
			local pos, ang = ply:GetBonePosition(bone_id)
			
			v[10]:SetModelScale(v[3], 0)
			pos = pos + (ang:Right() * ply:GetPData("xvalue", v[4])) + (ang:Up() * ply:GetPData("yvalue", v[5])) + (ang:Forward() * ply:GetPData("zvalue", v[6]))
			
			ang:RotateAroundAxis( ang:Forward(), tonumber( ply:GetPData("rotx", v[7]) ) )
			ang:RotateAroundAxis( ang:Up(), tonumber( ply:GetPData("roty", v[8]) ) )
			ang:RotateAroundAxis( ang:Right(), tonumber( ply:GetPData("rotz", v[9]) ) )
			
			v[10]:SetAngles(ang)
			v[10]:SetPos(pos)

			v[10]:SetRenderOrigin( pos )
			v[10]:SetRenderAngles( ang )
			v[10]:DrawModel()
			v[10]:SetupBones()
			v[10]:SetRenderOrigin( )
			v[10]:SetRenderAngles()
			
			
		end
		
	end)
end