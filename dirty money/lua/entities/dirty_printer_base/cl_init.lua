include("shared.lua")

GRADIENT_HORIZONTAL = 0;
GRADIENT_VERTICAL = 1;
function draw.LinearGradient(x,y,w,h,from,to,dir,res)

	dir = dir or GRADIENT_HORIZONTAL;

	if dir == GRADIENT_HORIZONTAL then
		res = (res and res <= w) and res or w;

	elseif dir == GRADIENT_VERTICAL then
		res = (res and res <= h) and res or h;
	end

	  for i=1,res do
		surface.SetDrawColor(
			Lerp(i/res,from.r,to.r),
			Lerp(i/res,from.g,to.g),
			Lerp(i/res,from.b,to.b),
			Lerp(i/res,from.a,to.a)
		);

		if dir == GRADIENT_HORIZONTAL then
			surface.DrawRect(x + w * (i/res), y, w/res, h );
		elseif dir == GRADIENT_VERTICAL then
			surface.DrawRect(x, y + h * (i/res), w, h/res ); 
		end
	end
end

local start_time = CurTime()
local end_time = CurTime() + 20
local fration = math.Clamp((CurTime() - start_time) / (end_time - start_time), 0, 1)

function ENT:Draw()

	self:DrawModel()

	local Pos = self:GetPos()
    local Ang = self:GetAngles()

    surface.SetFont("ChatFont")

    Ang:RotateAroundAxis(self:GetAngles():Up(), 180)

    cam.Start3D2D(Pos + Ang:Up() * 3.5, Ang, 0.1)

		surface.SetDrawColor(255,255,255)
    	surface.DrawOutlinedRect(-55, -80, 122, 160 )
    	 
    cam.End3D2D()

    Ang:RotateAroundAxis(self:GetAngles():Up(), 270)

    cam.Start3D2D(Pos + Ang:Up() * 3.5, Ang, 0.1)
    	draw.DrawText(self.PrinterTextName, "ChatFont", 1, -60, Color( 155, 155, 155, 255 ), TEXT_ALIGN_CENTER )


    	--[[ Printing Bar ]]--
    	surface.SetDrawColor(255,255,255)
    	surface.DrawOutlinedRect(-50, 0, 100, 10 )
    	draw.LinearGradient(-49, 0, self:GetPrintTime() * 4.9, 8, Color(15,32,39), Color(44,83,100), GRADIENT_VERTICAL)
    	draw.DrawText("Time Left: "..self.PrinterTimer - self:GetPrintTime(), "ChatFont", 1, -15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )

    	--[[ Coolant Bar ]]--
    	surface.SetDrawColor(255,255,255)
    	surface.DrawOutlinedRect(-50, 25, 100, 10 )
    	draw.LinearGradient(-49, 25, self:GetPrintCooling() / 0.98, 8, Color(15,32,39), Color(185,29,115), GRADIENT_VERTICAL)
    	draw.DrawText("cooling amount: "..self:GetPrintCooling(), "ChatFont", 1, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )

    cam.End3D2D()

      

end