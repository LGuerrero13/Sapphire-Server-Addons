net.Receive("KillerResponse", function(len)
	local msg = net.ReadString()
	chat.AddText(Color(79,188,191), "[Sapphire]: ", Color(255,255,255), msg)
end)