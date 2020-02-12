util.AddNetworkString("KillerResponse")

hook.Add("PlayerDeath", "KillReward", function(victim, weapon, killer)
	if(killer:IsWorld() or !killer:IsValid() or !killer:IsPlayer()) then return end
		if(killer:getDarkRPVar("job") == "Civil Protection Chief" or
			killer:getDarkRPVar("job") == "Civil Protection"
			and victim:isWanted()) then
	
			net.Start("KillerResponse")
			net.WriteString("You got $10,000 for killing "..victim:Nick().."!")
			net.Send(killer)
	
			killer:addMoney(10000)
			
		end
	
end)

hook.Add("playerArrested", "ArrestedReward", function(criminal, Time, arrestor)
	if(arrestor:getDarkRPVar("job") == "Civil Protection Chief" or
		arrestor:getDarkRPVar("job") == "Civil Protection"
		and criminal:isWanted()) then
	
		net.Start("KillerResponse")
		net.WriteString("You got $20,000 for arresting "..criminal:Nick().."!")
		net.Send(arrestor)
	
		arrestor:addMoney(20000)
	end
end)