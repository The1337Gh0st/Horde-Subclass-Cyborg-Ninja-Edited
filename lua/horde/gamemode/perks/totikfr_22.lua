PERK.PrintName = "Parry"
PERK.Description = "Activating Blade Mode will give you {1} evasion for {2} seconds."
PERK.Icon = "materials/perks/samurai/blade_dance.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
	[2] = {value = 2},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_22" then
	ply.Horde_CheckCyborgDodge = true
     ply.Horde_DoCyborgDodge = nil
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_22" then
        ply.Horde_CheckCyborgDodge = nil
     ply.Horde_DoCyborgDodge = nil
	 timer.Stop( "CyborgNinja_EndDodge" )
    end
end

PERK.Hooks.PlayerSwitchFlashlight = function (ply, switchOn)
    if not ply:Horde_GetPerk("totikfr_22") then return end
	
	local id = ply:SteamID()
	
    if switchOn and ply.Horde_In_Frenzy_Mode then
        ply.Horde_DoCyborgDodge = true
		timer.Create("CyborgNinja_EndDodge" .. id, 2, 1, function ()
		ply.Horde_DoCyborgDodge = nil
            end)
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("totikfr_22")  then return end
	
	
	
	
	if ply:Horde_GetPerk("totikfr_22") and ply.Horde_In_Frenzy_Mode and ply.Horde_CheckCyborgDodge and ply.Horde_DoCyborgDodge then
	
			bonus.evasion = bonus.evasion + 1
		
			end
end

