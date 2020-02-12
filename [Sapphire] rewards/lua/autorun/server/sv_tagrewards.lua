util.AddNetworkString("TagCaught")
util.AddNetworkString("ServerResponse")
util.AddNetworkString("OpenedURL")
util.AddNetworkString("SteamGroup")
util.AddNetworkString("InitialSpawn")
util.AddNetworkString("InitialSpawnClient")
util.AddNetworkString("DarkRPChatOpener")

-- Setup A Listen event when a player changes names
gameevent.Listen("player_changename")

--[[ 
Steam Name change listener:
	This is a Listen event for when
	a player changes their steam name,
	also has checks if the calling player
	is in the group.
]]--
hook.Add("player_changename","player_tag_finder",function(tbl)
	local ply = Player(tbl.userid)
	
	if string.find(string.lower(tbl.newname), string.lower("SapphireServers.net")) then -- Check for Sapphire, can't use brackets cause it's and invalid type. No known solution yet. :<
		if(ply:GetPData("HasHadTag")) then
			net.Start("ServerResponse")
				net.WriteString("You've already registered!")
			net.Send(ply)
		else
			net.Start("ServerResponse")
				net.WriteString("You've received $25,000!")
			net.Send(ply)
		
			ply:SetPData("HasHadTag", 1)
			ply:addMoney(25000) -- Amount to give player. addMoney is a DarkRP only function.
		end
	end	
end)

net.Receive("InitialSpawn", function(len, ply)
	if(ply:GetPData("SpawnOpen")) then
		return
	else
		net.Start("InitialSpawnClient")
		net.Send(ply)
		ply:SetPData("SpawnOpen", 1)
	end
end)

--[[ Steam Group Checks ]]--
net.Receive("SteamGroup", function(len, ply)
	timer.Create("TimedCheck", 75, 1, function() -- Checks in 75 seconds if you're in the group
	
		net.Start("ServerResponse")
			net.WriteString("Checking steam group status...")
		net.Send(ply)
	
		http.Fetch("http://steamcommunity.com/groups/sapphireserverrp/memberslistxml/?xml=1", function(body, len, headers, code) -- Fetch .xml file text
			if(string.find(body, ply:SteamID64())) then -- Find calling players ID64 within .xml file

				if(ply:GetPData("HasJoinedGroup")) then
					net.Start("ServerResponse")
						net.WriteString("You've already registered!")
					net.Send(ply)
				else
					net.Start("ServerResponse")
						net.WriteString("You've received $10,000 for joining our steam group!")
					net.Send(ply)
		
					ply:SetPData("HasJoinedGroup", 1)
					ply:addMoney(10000) -- Amount to give player. addMoney is a DarkRP only function.
				end
			end
		end)
	end)
end)

--[[ Youtube Reward checks ]]--

net.Receive("OpenedURL", function(len, ply)
	if(ply:GetPData("HasSeenURL")) then
		net.Start("ServerResponse")
			net.WriteString("You've already been rewarded!")
		net.Send(ply)
	else
		net.Start("ServerResponse")
			net.WriteString("You've received $10,000 for viewing!")
		net.Send(ply)
		
		ply:SetPData("HasSeenURL", 1)
		ply:addMoney(10000) -- Amount to give player. addMoney is a DarkRP only function.
	end
end)