--[[
	© Copyright github.com/Heldex
	Contact (svensis@protonmail.com)
	
	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--]]

AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/props_combine/combine_interface001.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )        
	self:SetCollisionGroup( COLLISION_GROUP_NONE )
	self.CapturePoint = 0
	self.CombineClaimed = false
	self.RebelClaimed = false
	self.EntityID = "Checkpoint-"..self:EntIndex()
	self:SetNWString("NoStealCode_PLS", "None") -- uses this name as it can be seen on clientside code, lol.
	self.Combine = false
	self.Rebel = false
	
	
if (not timer.Exists(self.EntityID)) then
    print("Checkpoint-" .. self:EntIndex())

    timer.Create(self.EntityID, 2, 1, function()
        timer.Adjust(self.EntityID, 1, 1) -- errors the timer and turns it off, as it cannot be done after entity is removed cause the variable doesnt exist. or im just crazy

        local nig = ents.FindInSphere(self:GetPos() + Vector(0, 0, 10), 150)

        for k, v in pairs(nig) do
            if v:IsPlayer() then
                if v:GetFaction() == FACTION_MPF and self.Rebel == false then
                    if self.CapturePoint == 0 then
                        self:SetColor(Color(255, 255, 255))
                        self:SetNWString("NoStealCode_PLS", "None")
                    end

                    if self.CapturePoint == 10 and self.CombineClaimed == false then
                        self.RebelClaimed = false
                        self.CombineClaimed = true

                        if self.CombineClaimed == true then
                            self.CapturePoint = 11
                            Clockwork.player:Notify(v, "You captured the point!")
                            self:SetColor(Color(0, 0, 255))
                            self:EmitSound("buttons/combine_button3.wav")

                            if math.random(1, 2) == 2 then
                                self:EmitSound("npc/metropolice/vo/protectioncomplete.wav") -- makes terminal emit it instead of player (incase multiple combine capturing point)
                            end

                            self:SetNWString("NoStealCode_PLS", "Combine")
                        end
                    elseif self.CombineClaimed ~= true then
                        self.CapturePoint = self.CapturePoint + 1

                        if self.CapturePoint == 1 then
                            Clockwork.player:Notify(v, "Point secured, now capturing.")
                        end

                        if self.CapturePoint == -9 then
                            Clockwork.player:Notify(v, "Checkpoint secured, now taking over.")
                        end
                    end
                end

                if v:GetFaction() == FACTION_REBEL and self.Combine == false then
                    if self.CapturePoint == 0 then
                        self:SetColor(Color(255, 255, 255))
                        self:SetNWString("NoStealCode_PLS", "None")
                    end

                    if self.CapturePoint == -10 and self.RebelClaimed == false then
                        self.CombineClaimed = false
                        self.RebelClaimed = true

                        if self.RebelClaimed == true then
                            self.CapturePoint = -11
                            Clockwork.player:Notify(v, "You captured the point!")
                            self:SetColor(Color(255, 99, 71))
                            self:EmitSound("buttons/combine_button3.wav")
                            self:SetNWString("NoStealCode_PLS", "Rebel")
                        end
                    elseif self.RebelClaimed ~= true then
                        self.CapturePoint = self.CapturePoint - 1

                        if self.CapturePoint == -1 then
                            Clockwork.player:Notify(v, "Point secured, now capturing.")
                        end

                        if self.CapturePoint == 9 then
                            Clockwork.player:Notify(v, "Checkpoint secured, now taking over.")
                        end
                    end
                end
            end
        end
    end)
end
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableMotion()
	end
end
 

--[[
 function ENT:Use( activator, caller )
 end
function ENT:Think()

		 local nig = ents.FindInSphere( self:GetPos() + Vector(0, 0, 10), 150 )
		
		 for k,v in pairs(nig) do
				 if v:GetFaction() == FACTION_REBEL then
					 self.Rebel = true
				 else
					 self.Rebel = false
				 end
		
				 if v:GetFaction() == FACTION_MPF then
					 self.Combine = true
				 else
					 self.Combine = false
				 end
				 Clockwork.player:Notify(v, "Combine"..tostring(self.Combine))
				 Clockwork.player:Notify(v, "Rebel"..tostring(self.Rebel))
		 end
 end
 --]]
 
 