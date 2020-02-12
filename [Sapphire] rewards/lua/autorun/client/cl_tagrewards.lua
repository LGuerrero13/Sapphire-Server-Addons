--[[
*******************************************************
* Copyright (C) 2018 posh http://steamcommunity.com/id/jcool129/
* 
* This file is part of [Sapphire] rewards.
* 
* [Sapphire] rewards can not be copied and/or distributed without the express
* permission of posh
*******************************************************
 ]]--

surface.CreateFont( "RobotoC", {
	font = "Roboto",
	extended = false,
	size = 24,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function OpenRewards()

	local main = vgui.Create("DFrame")
		main:SetTitle("")
		main:SetDraggable(false)
		main:ShowCloseButton(false)
		main:SetSize(500, 550)
		main:MakePopup()
		main:SetPos(ScrW() / 2 - (main:GetWide() / 2), ScrH() / 2 - (main:GetWide() / 2))
		main.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, main:GetWide(), main:GetTall())
			draw.RoundedBox(1, 1, 1, main:GetWide() - 2, main:GetTall() - 2, Color(0, 0, 0, 200))
		end
			
	local Header = vgui.Create("DFrame", main)
		Header:SetTitle("")
		Header:SetDraggable(false)
		Header:ShowCloseButton(false)
		Header:SetSize(main:GetWide(), 75)
		Header:SetPos(0,0)
		Header.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, Header:GetWide(), Header:GetTall())
			draw.RoundedBox(1, 1, 1, Header:GetWide() - 2, Header:GetTall() - 2, Color(0, 0, 0, 200))
		end
			
	local HeaderTitle = vgui.Create("DLabel", Header)
		HeaderTitle:SetPos(20, Header:GetTall() / 2 - (HeaderTitle:GetTall() / 2))
		HeaderTitle:SetFont("HUDNumber5")
		HeaderTitle:SetSize(200,20)
		HeaderTitle:SetText("Rewards Menu")
		
	local SteamGroup = vgui.Create("DFrame", main)
		SteamGroup:SetTitle("")
		SteamGroup:SetDraggable(false)
		SteamGroup:ShowCloseButton(false)
		SteamGroup:SetSize(main:GetWide(), 75)
		SteamGroup:SetPos(0,75)
		SteamGroup.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, SteamGroup:GetWide(), SteamGroup:GetTall())
			draw.RoundedBox(1, 1, 1, SteamGroup:GetWide() - 2, SteamGroup:GetTall() - 2, Color(0, 0, 0, 230))
		end
			
	local SteamGroupTitle = vgui.Create("DLabel", SteamGroup)
		SteamGroupTitle:SetPos(20, SteamGroup:GetTall() / 2 - (SteamGroupTitle:GetTall() / 2))
		SteamGroupTitle:SetFont("RobotoC")
		SteamGroupTitle:SetSize(300,20)
		SteamGroupTitle:SetText("Join the steam group - $10k")
		
	local SteamButton = vgui.Create("DButton", SteamGroup)
		SteamButton:SetSize(125,  40)
		SteamButton:SetPos(SteamGroup:GetWide() - SteamButton:GetWide() - 10, SteamGroup:GetTall() / 2 - (SteamButton:GetTall() / 2) )
		SteamButton:SetFont("RobotoC")
		SteamButton:SetText("Go")
		SteamButton:SetTextColor(Color(255,255,255))
		SteamButton.DoClick = function()
			surface.PlaySound( "ambient/levels/labs/coinslot1.wav" )
			gui.OpenURL("https://steamcommunity.com/groups/sapphireserverrp") -- Add your steam group link here.
			chat.AddText(Color(79,188,191), "[SapphireTags]: ", Color(255,255,255), "Please wait 1 minute and 15 seconds for your reward.")
			net.Start("SteamGroup")
			net.SendToServer()
		end
		SteamButton.OnCursorEntered = function()
				surface.PlaySound( "items/flashlight1.wav" )
		end
		SteamButton.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, SteamButton:GetWide(), SteamButton:GetTall())
			draw.RoundedBox(1, 1, 1, SteamButton:GetWide() - 2, SteamButton:GetTall() - 2, Color(80, 80, 80))
		end
		
	local TagGroup = vgui.Create("DFrame", main)
		TagGroup:SetTitle("")
		TagGroup:SetDraggable(false)
		TagGroup:ShowCloseButton(false)
		TagGroup:SetSize(main:GetWide(), 75)
		TagGroup:SetPos(0,150)
		TagGroup.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, TagGroup:GetWide(), TagGroup:GetTall())
			draw.RoundedBox(1, 1, 1, TagGroup:GetWide() - 2, TagGroup:GetTall() - 2, Color(0, 0, 0, 230))
		end
			
	local TagGroupTitle = vgui.Create("DLabel", TagGroup)
		TagGroupTitle:SetPos(20, TagGroup:GetTall() / 2 - (TagGroupTitle:GetTall() / 2))
		TagGroupTitle:SetFont("RobotoC")
		TagGroupTitle:SetSize(300,20)
		TagGroupTitle:SetText("Put [Sapphire] in your name - $25k")
		
	local TagButton = vgui.Create("DButton", TagGroup)
		TagButton:SetSize(125,  40)
		TagButton:SetPos(SteamGroup:GetWide() - TagButton:GetWide() - 10, SteamGroup:GetTall() / 2 - (TagButton:GetTall() / 2) )
		TagButton:SetFont("RobotoC")
		TagButton:SetText("Go")
		TagButton:SetTextColor(Color(255,255,255))
		TagButton.DoClick = function()
			gui.OpenURL("https://steamcommunity.com/profiles/"..LocalPlayer():SteamID64().."/edit")
		end
		TagButton.OnCursorEntered = function()
			surface.PlaySound( "items/flashlight1.wav" )
		end
		TagButton.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, TagButton:GetWide(), TagButton:GetTall())
			draw.RoundedBox(1, 1, 1, TagButton:GetWide() - 2, TagButton:GetTall() - 2, Color(80, 80, 80))
		end	
		
	local YoutubeGroup = vgui.Create("DFrame", main)
		YoutubeGroup:SetTitle("")
		YoutubeGroup:SetDraggable(false)
		YoutubeGroup:ShowCloseButton(false)
		YoutubeGroup:SetSize(main:GetWide(), 75)
		YoutubeGroup:SetPos(0,225)
		YoutubeGroup.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, YoutubeGroup:GetWide(), YoutubeGroup:GetTall())
			draw.RoundedBox(1, 1, 1, YoutubeGroup:GetWide() - 2, YoutubeGroup:GetTall() - 2, Color(0, 0, 0, 230))
		end
			
	local YoutubeTitle = vgui.Create("DLabel", YoutubeGroup)
		YoutubeTitle:SetPos(20, YoutubeGroup:GetTall() / 2 - (YoutubeTitle:GetTall() / 2))
		YoutubeTitle:SetFont("RobotoC")
		YoutubeTitle:SetSize(300,20)
		YoutubeTitle:SetText("View the Youtube - $10k")
		
	local YoutubeButton = vgui.Create("DButton", YoutubeGroup)
		YoutubeButton:SetSize(125,  40)
		YoutubeButton:SetPos(SteamGroup:GetWide() - YoutubeButton:GetWide() - 10, YoutubeGroup:GetTall() / 2 - (YoutubeButton:GetTall() / 2) )
		YoutubeButton:SetFont("RobotoC")
		YoutubeButton:SetText("Go")
		YoutubeButton:SetTextColor(Color(255,255,255))
		YoutubeButton.DoClick = function()
			surface.PlaySound( "ambient/levels/labs/coinslot1.wav" )
			gui.OpenURL("https://www.youtube.com/channel/UCApnMUi-Kz1Wa1-0fiS7QQg") -- Add your custom URL here.
			net.Start("OpenedURL")
			net.SendToServer()
		end
		YoutubeButton.OnCursorEntered = function()
			surface.PlaySound( "items/flashlight1.wav" )
		end
		YoutubeButton.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, TagButton:GetWide(), TagButton:GetTall())
			draw.RoundedBox(1, 1, 1, TagButton:GetWide() - 2, TagButton:GetTall() - 2, Color(80, 80, 80))
		end
			
	local CloseButton = vgui.Create("DButton", main)
		CloseButton:SetSize(main:GetWide(),  50)
		CloseButton:SetPos(0, main:GetTall() - CloseButton:GetTall())
		CloseButton:SetFont("RobotoC")
		CloseButton:SetText("Close")
		CloseButton:SetTextColor(Color(255,255,255))
		CloseButton.DoClick = function()
			main:Close()
		end
		CloseButton.Paint = function()
			surface.SetDrawColor(Color(255 ,255 ,255 ,255))
			surface.DrawOutlinedRect(0, 0, CloseButton:GetWide(), CloseButton:GetTall())
			draw.RoundedBox(1, 1, 1, CloseButton:GetWide() - 2, CloseButton:GetTall() - 2, Color(0, 0, 0, 230))
		end
end

--[[
	Check when a player starts moving
	to send a net message to server.
]]--
hook.Add("KeyPress", "dude", function(ply, key)
	if(key == IN_FORWARD) then
		net.Start("InitialSpawn")
		net.SendToServer()	
	end
end)

--[[
	Receive net message from server to
	open the chat when a command is typed.
]]--
net.Receive("DarkRPChatOpener", function(len, ply)
	OpenRewards()
end)

--[[ 
OnPlayerChat Hook:
	This is a Player chat hook that
	reads from the ingame chat and 
	checks if the player saying the command
	is the LocalPlayer if so, then execute a 
	Derma panel.
]]--


--[[ 
Global chat ServerResponse:
	This is a global response catcher that
	grabs strings from net messages and
	displays it in chat accordingly.
]]--
net.Receive("ServerResponse", function(len)
	local msg = net.ReadString()
	chat.AddText(Color(79,188,191), "[SapphireTags]: ", Color(255,255,255), msg)
end)