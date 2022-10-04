PERK.PrintName = "Exoskeleton"
PERK.Description = "{1} increased max health. \n Regenerate {3} armor per second, up to {4}."
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
        ply:SetHealth(ply:GetMaxHealth())
		ply:Horde_SetArmorRegenEnabled(true)
		 ply:Horde_SetArmorRegenMax(25)
		 ply:Horde_SetArmorRegenAmount(1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_11" then
        ply:SetHealth(ply:GetMaxHealth())
		ply:Horde_SetArmorRegenEnabled(nil)
		ply:Horde_SetArmorRegenMax(0)
		ply:Horde_SetArmorRegenAmount(0)
    end
end

PERK.Hooks.Horde_OnSetMaxHealth = function(ply, bonus)
    if SERVER and ply:Horde_GetPerk("totikfr_11") then
        bonus.increase = bonus.increase + 0.1
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
