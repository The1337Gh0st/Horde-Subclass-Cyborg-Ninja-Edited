PERK.PrintName = "Pain Inhibitors"
PERK.Description = "{1} global damage resistance in Blade Mode. \nGain immunity to poison damage and Break in Blade Mode. \nRegenerate {2} health per second."
PERK.Icon = "materials/perks/nanomachine.png"
PERK.Params = {
    [1] = {value = 0.35, percent = true},
	[2] = {value = 0.01, percent = true},
}

PERK.Hooks = {}


PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("totikfr_32")  then return end
	if not ply.Horde_In_Frenzy_Mode then return end
    bonus.resistance = bonus.resistance + 0.35
	if HORDE:IsPoisonDamage(dmginfo) then
       bonus.resistance = bonus.resistance + 1
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if not ply:Horde_GetPerk("totikfr_32")  then return end
	if not ply.Horde_In_Frenzy_Mode then return end
	if ply:Horde_GetPerk("totikfr_32") and debuff == HORDE.Status_Break then
        bonus.apply = 0
        return true
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_32" then
        ply:Horde_SetHealthRegenEnabled(true)
        ply:Horde_SetHealthRegenPercentage(0.01)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_32" then
        ply:Horde_SetHealthRegenEnabled(nil)
    end
end



