PERK.PrintName = "Cybernetic Arm"
PERK.Description = "{1} increased melee damage. \nMelee damage leeches a flat +{2} armor."
PERK.Icon = "materials/perks/berserk.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
	[2] = {value = 4},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("totikfr_12")  then return end
    if HORDE:IsMeleeDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.20
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("totikfr_12") and (HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo)) then
		ply:SetArmor(math.min(100,ply:Armor()+4))
    end
end