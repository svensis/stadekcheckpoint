include('shared.lua')

function ENT:Draw()

if self:GetNWString( "NoStealCode_PLS" ) == "Rebel" then

self.Color = Color(255, 99, 71, 255)

elseif self:GetNWString( "NoStealCode_PLS" ) == "Combine" then

self.Color = Color(0, 0, 255, 255)

else

self.Color = Color(0, 255, 0, 255)

end

    self:DrawModel()
    cam.Start3D2D(self:GetPos() + Vector(0, 0, 10), Angle(0, 0, 0), 1)
    surface.DrawCircle(0, 0, 150, self.Color)
    cam.End3D2D()
end




