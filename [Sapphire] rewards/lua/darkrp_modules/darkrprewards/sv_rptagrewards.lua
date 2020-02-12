local function obanrewards(ply, args)
	net.Start("DarkRPChatOpener")
	net.Send(ply)
end
DarkRP.defineChatCommand("rewards", obanrewards)