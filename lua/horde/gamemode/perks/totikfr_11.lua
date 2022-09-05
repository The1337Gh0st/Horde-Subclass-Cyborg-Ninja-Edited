PERK.PrintName = "Exoskeleton"
PERK.Description = "{1} increased max health. \n Regenerate {3} armor per second, up to {4}. \nKills have a {5} chance to drop a Health Kit."
PERK.Icon = "materials/perks/unwavering_guard.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 0.15, percent = true},
	[3] = {value = 1},
	[4] = {value = 25},
	[5] = {value = 0.25, percent = true},
}

PERK.Hooks = {}


PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_11" then
        ply:SetMaxHealth(110)
        ply:SetHealth(ply:GetMaxHealth())
		ply:Horde_SetArmorRegenEnabled(true)
		 ply:Horde_SetArmorRegenMax(25)
		 ply:Horde_SetArmorRegenAmount(1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_11" then
        ply:SetMaxHealth(100)
        ply:SetHealth(ply:GetMaxHealth())
		ply:Horde_SetArmorRegenEnabled(nil)
		ply:Horde_SetArmorRegenMax(0)
		ply:Horde_SetArmorRegenAmount(0)
    end
end


PERK.Hooks.PlayerTick = function (ply, mv)
	if not ply:Horde_GetPerk("totikfr_11") then return end
	
	if ply.Horde_Ripper_Mode then
	ply:Horde_SetArmorRegenMax(0)
		 ply:Horde_SetArmorRegenAmount(0)
	end
	
	if ply.Horde_Ripper_Mode then return end
	
	if ply.Horde_In_Frenzy_Mode then
	ply:Horde_SetArmorRegenMax(0)
		 ply:Horde_SetArmorRegenAmount(0)
	end
	
	if ply.Horde_In_Frenzy_Mode then return end
	
    if ply:Horde_GetPerk("totikfr_11") then
      ply:Horde_SetArmorRegenMax(25)
		 ply:Horde_SetArmorRegenAmount(1)
	end
end

PERK.Hooks.Horde_OnNPCKilled = function(victim, killer, inflictor)
	if not killer:Horde_GetPerk("totikfr_11") then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
    local p = math.random()
	local c = 0.25
	if killer:Horde_GetPerk("totikfr_11") and p <= 0.25 then
		local ent2 = ents.Create("item_healthkit")
		ent2:SetPos(victim:GetPos())
		ent2:SetOwner(killer)
		ent2.Owner = killer
		ent2.Inflictor = victim
		ent2:Spawn()
		ent2:Activate()
		timer.Simple(30, function() if ent2:IsValid() then ent2:Remove() end end)
	end
end