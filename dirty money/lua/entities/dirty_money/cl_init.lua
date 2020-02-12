include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    -- Do not draw labels when a different model is used.
    -- If you want a different model with labels, make your own money entity and use GM.Config.MoneyClass.
    if self:GetModel() ~= "models/freeman/moneyprinters/printer_4.mdl" then return end

    local Pos = self:GetPos()
    local Ang = self:GetAngles()

    surface.SetFont("ChatFont")
    local text = DarkRP.formatMoney(self:Getamount())
    local TextWidth = surface.GetTextSize(text)

    cam.Start3D2D(Pos + Ang:Up() * 4, Ang, 0.1)
        surface.SetDrawColor(255,255,255)
        surface.DrawOutlinedRect(-70, -103, 139, 207 )
        draw.WordBox(2, -TextWidth * 0.5, -10, text, "ChatFont", Color(0, 0, 0, 255), Color(255, 255, 255, 255))
    cam.End3D2D()
end

function ENT:Think()
end
