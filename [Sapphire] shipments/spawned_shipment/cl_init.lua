include("shared.lua")

surface.CreateFont( "Robotoyo", {
    font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    size = 80,
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
    outline = true,
} )

surface.CreateFont( "Robotoyo2", {
    font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    size = 70,
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
    outline = true,
} )

local matBallGlow = Material("models/props_combine/tpballglow")
function ENT:Draw()
    self.height = self.height or 0
    self.colr = self.colr or 1
    self.colg = self.colg or 0
    self.StartTime = self.StartTime or CurTime()

    if GAMEMODE.Config.shipmentspawntime > 0 and self.height < self:OBBMaxs().z then
        self:drawSpawning()
    else
        self:DrawModel()
    end

    self:drawFloatingGun()
    self:drawInfo()
end

net.Receive("DarkRP_shipmentSpawn", function()
    local ent = net.ReadEntity()
    if not IsValid(ent) or not ent.IsSpawnedShipment then return end

    ent.height = 0
    ent.StartTime = CurTime()
end)

function ENT:drawSpawning()
    render.MaterialOverride(matBallGlow)

    render.SetColorModulation(self.colr, self.colg, 0)

    self:DrawModel()

    render.MaterialOverride()
    self.colr = 1 - ((CurTime() - self.StartTime) / GAMEMODE.Config.shipmentspawntime)
    self.colg = (CurTime() - self.StartTime) / GAMEMODE.Config.shipmentspawntime

    render.SetColorModulation(1, 1, 1)

    render.MaterialOverride()

    local normal = - self:GetAngles():Up()
    local pos = self:LocalToWorld(Vector(0, 0, self:OBBMins().z + self.height))
    local distance = normal:Dot(pos)
    self.height = self:OBBMaxs().z * ((CurTime() - self.StartTime) / GAMEMODE.Config.shipmentspawntime)
    render.EnableClipping(true)
    render.PushCustomClipPlane(normal, distance)

    self:DrawModel()

    render.PopCustomClipPlane()
end

function ENT:drawFloatingGun()
    local contents = CustomShipments[self:Getcontents() or ""]
    if not contents or not IsValid(self:GetgunModel()) then return end
    self:GetgunModel():SetNoDraw(true)

    local pos = self:GetPos() - Vector(5,0,15)
    local ang = self:GetAngles()

    -- Position the gun
    local gunPos = self:GetAngles():Up() * 40 + ang:Up() * (math.sin(CurTime() * 0.5) * 2)
    self:GetgunModel():SetPos(pos + gunPos)


    -- Draw the model
    if self:Getgunspawn() < CurTime() - 2 then
        self:GetgunModel():DrawModel()
        return
    elseif self:Getgunspawn() < CurTime() then -- Not when a gun just spawned
        return
    end

    -- Draw the spawning effect
    local delta = self:Getgunspawn() - CurTime()
    local min, max = self:GetgunModel():OBBMins(), self:GetgunModel():OBBMaxs()
    min, max = self:GetgunModel():LocalToWorld(min), self:GetgunModel():LocalToWorld(max)

    -- Draw the ghosted weapon
    render.MaterialOverride(matBallGlow)
    render.SetColorModulation(1 - delta, delta, 0) -- From red to green
    self:GetgunModel():DrawModel()
    render.MaterialOverride()
    render.SetColorModulation(1, 1, 1)

    -- Draw the cut-off weapon
    render.EnableClipping(true)
    -- The clipping plane only draws objects that face the plane
    local normal = -self:GetgunModel():GetAngles():Forward()
    local cutPosition = LerpVector(delta, max, min) -- Where it cuts
    local cutDistance = normal:Dot(cutPosition) -- Project the vector onto the normal to get the shortest distance between the plane and origin

    -- Activate the plane
    render.PushCustomClipPlane(normal, cutDistance);
    -- Draw the partial model
    self:GetgunModel():DrawModel()
    -- Remove the plane
    render.PopCustomClipPlane()

    render.EnableClipping(false)
end

function ENT:drawInfo()
    local Pos = self:GetPos()
    local Ang = self:GetAngles()

    local content = self:Getcontents() or ""
    local contents = CustomShipments[content]
    if not contents then return end
    contents = contents.name

    surface.SetFont("HUDNumber5")
    local text = DarkRP.getPhrase("contents")
    local TextWidth = surface.GetTextSize(text)
    local TextWidth2 = surface.GetTextSize(contents)

    cam.Start3D2D(Pos + Ang:Up() * 17, Ang, 0.05)
        draw.WordBox(2, -TextWidth * 1.2 + 5, -30, text, "Robotoyo", Color(128, 224, 227, 0), Color(255, 255, 255, 255))
        draw.WordBox(2, -TextWidth2 * 1.2 + 5, 60, contents, "Robotoyo", Color(128, 224, 227, 0), Color(255, 255, 255, 255))
    cam.End3D2D()

    Ang:RotateAroundAxis(Ang:Forward(), 90)

    text = DarkRP.getPhrase("amount")
    TextWidth = surface.GetTextSize(text)
    TextWidth2 = surface.GetTextSize(self:Getcount())

    cam.Start3D2D(Pos + Ang:Up() * 17, Ang, 0.05)
        draw.WordBox(2, -TextWidth * 0.5 + 5, -180, text, "Robotoyo", Color(128, 224, 227, 0), Color(255, 255, 255, 255))
        draw.WordBox(2, -TextWidth2 * 0.5 + 0, -110, self:Getcount(), "Robotoyo2", Color(128, 224, 227, 0), Color(255, 255, 255, 255))
    cam.End3D2D()
end

--[[---------------------------------------------------------------------------
Create a shipment from a spawned_weapon
---------------------------------------------------------------------------]]
properties.Add("splitShipment",
{
    MenuLabel   =   "Split this shipment",
    Order       =   2003,
    MenuIcon    =   "icon16/arrow_divide.png",

    Filter      =   function(self, ent, ply)
                        if not IsValid(ent) then return false end
                        return ent.IsSpawnedShipment
                    end,

    Action      =   function(self, ent)
                        if not IsValid(ent) then return end
                        RunConsoleCommand("darkrp", "splitshipment", ent:EntIndex())
                    end
})
