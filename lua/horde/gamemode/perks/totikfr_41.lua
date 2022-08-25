PERK.PrintName = "Rifle Mechanism"
PERK.Description =
[[Unlocks a Special Attack (Shift + E).
Perform an attack that deals 1000 damage and inflicts Stun.
Leeches 25 armor. 15 second cooldown.]]
PERK.Icon = "materials/perks/samurai/focus_slash.png"

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_41" then
        ply:Horde_SetPerkCooldown(15)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Quickstep, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_41" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Quickstep, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end


PERK.Hooks.Horde_UseActivePerk = function (ply, dmginfo)
    if not ply:Horde_GetPerk("totikfr_41") then return end	
	
    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity
	local startpos = util.TraceLine(util.GetPlayerTrace(ply)).StartPos
	local hitpos = util.TraceLine(util.GetPlayerTrace(ply)).HitPos

    if ent:IsValid() and ent:IsNPC() and (not ent:GetNWEntity("HordeOwner"):IsValid()) then --no way this thing works
	local distance = math.sqrt((hitpos.x - startpos.x)^2 + (hitpos.y - startpos.y)^2 + (hitpos.z - startpos.z)^2)
		if distance <= 196 then
		sound.Play("horde/weapons/katana/melee_katana_02.ogg", ply:GetPos())
		
		local fx = EffectData()
		fx:SetOrigin(hitpos)
		util.Effect("BloodImpact", fx)
		
		ent:TakeDamage(1000, ply)
		ent:Horde_AddStun(1000)
		ply:SetArmor(math.min(100,ply:Armor()+25))
		return false
		end
	end
return true
end