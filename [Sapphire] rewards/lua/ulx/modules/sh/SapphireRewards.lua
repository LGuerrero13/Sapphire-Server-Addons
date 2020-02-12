function ulx.rewarddata(calling_ply, target_plys)
local affected_plys = {}

	for _, v in pairs(target_plys) do
		net.Start("ServerResponse")
			net.WriteString(v:Nick()..", Was cleared from all PData!")
		net.Broadcast() -- Global Message
		
		util.RemovePData(v:SteamID(), "HasHadTag")
		util.RemovePData(v:SteamID(), "HasSeenURL")
		util.RemovePData(v:SteamID(), "HasJoinedGroup")
		util.RemovePData(v:SteamID(), "SpawnOpen")
	end
	ulx.fancyLogAdmin( calling_ply, "#A Cleared all PData from #T!", target_plys)
end


local SapphireRewards = ulx.command("Utility", "ulx removerewardpdata", ulx.rewarddata, "!removerewardpdata")
SapphireRewards:addParam{ type = ULib.cmds.PlayersArg }
SapphireRewards:defaultAccess( ULib.ACCESS_SUPERADMIN )
SapphireRewards:help( "Removes all of a players Reward PData." ) 
