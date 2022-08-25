PERK.PrintName = "Exoskeleton"
PERK.Description = "{1} increased max health and {2} increased movement speed. \n Regenerate {3} armor per second, up to {4}."
PERK.Icon = "materials/perks/unwavering_guard.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 0.15, percent = true},
	[3] = {value = 2},
	[4] = {value = 50},
}

PERK.Hooks = {}

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus)
    if not ply:Horde_GetPerk("totikfr_11") then return end
    bonus.walkspd = bonus.walkspd * 1.15
    bonus.sprintspd = bonus.sprintspd * 1.15
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_11" then
        ply:SetMaxHealth(110)
        ply:SetHealth(ply:GetMaxHealth())
		ply:Horde_SetArmorRegenEnabled(true)
		 ply:Horde_SetArmorRegenMax(50)
		 ply:Horde_SetArmorRegenAmount(2)
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

--hacky fix for armor regen sometimes breaking

PERK.Hooks.PlayerTick = function (ply, mv)
	if not ply:Horde_GetPerk("totikfr_11") then return end
    if ply:Horde_GetPerk("totikfr_11") then
      ply:Horde_SetArmorRegenMax(50)
		 ply:Horde_SetArmorRegenAmount(2)
	end
end

--PERK.Hooks.PlayerSwitchFlashlight = function (ply, switchOn)
  --  if not ply:Horde_GetPerk("totikfr_11") then return end
	
  --  if switchOn then
	  --hacky fix to prevent armor gen occasionally breaking
	--  ply:Horde_SetArmorRegenMax(100)
	--	 ply:Horde_SetArmorRegenAmount(2)
--else
--	ply:Horde_SetArmorRegenEnabled(true)
--	ply:Horde_SetArmorRegenMax(100)
--		 ply:Horde_SetArmorRegenAmount(2)
--	end
--end