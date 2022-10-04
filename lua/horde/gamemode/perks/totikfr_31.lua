PERK.PrintName = "Sharper Blade"
PERK.Description = "+{1} Blade Mode damage increase. \nLeech a flat {4} armor on hit. \nLeeches up to {3} health on hit."
PERK.Icon = "materials/perks/samurai/demon_strike.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
	[2] = {value = 1, percent = true},
	[3] = {value = 5},
	[4] = {value = 1},
}

PERK.Hooks = {}


PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("totikfr_31") and (HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo)) then
        local leech = math.min(5, dmginfo:GetDamage() * 0.10)
        HORDE:SelfHeal(ply, leech)
    end
	if ply.Horde_In_Frenzy_Mode then return end
	if ply.Horde_Ripper_Mode then return end
    if ply:Horde_GetPerk("totikfr_31") and (HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo)) then
		ply:SetArmor(math.min(100,ply:Armor()+1))
    end
end
