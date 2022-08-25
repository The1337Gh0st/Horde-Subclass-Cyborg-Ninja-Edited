PERK.PrintName = "Rules of Nature"
PERK.Description = "Blade Mode causes melee damage to leech up to {1} health. \nGain a stack of Adrenaline on kill, up to {2}. Adrenaline lasts {4} longer than usual. \nAdrenaline increases your speed and damage by {3}."
PERK.Icon = "materials/perks/psycho/bestial_wrath.png"
PERK.Params = {
    [1] = {value = 10},
	[2] = {value = 5},
	[3] = {value = 0.06, percent = true},
	[4] = {value = 0.50, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_32" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 5)
        ply:Horde_SetAdrenalineStackDuration(ply:Horde_GetAdrenalineStackDuration() * 1.5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_32" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 5)
        ply:Horde_SetAdrenalineStackDuration(ply:Horde_GetAdrenalineStackDuration() / 1.5)
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("totikfr_32") and (HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo)) and ply.Horde_In_Frenzy_Mode then
        local leech = math.min(10, dmginfo:GetDamage() * 0.10)
        HORDE:SelfHeal(ply, leech)
    end
end

