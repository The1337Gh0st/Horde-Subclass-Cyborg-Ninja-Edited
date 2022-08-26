PERK.PrintName = "Cybernetic Arm"
PERK.Description = "{1} increased melee damage. \nWhile not in Blade Mode or Ripper Mode: \nKills leech {2} armor. Leech a flat {3} armor on hit if your target is an Elite."
PERK.Icon = "materials/perks/berserk.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
	[2] = {value = 2},
	[3] = {value = 1},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("totikfr_12")  then return end
    if HORDE:IsMeleeDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.20
    end
end


PERK.Hooks.Horde_OnNPCKilled = function(victim, killer, inflictor)
	if not killer:Horde_GetPerk("totikfr_12") then return end
	if killer.Horde_In_Frenzy_Mode then return end
	if killer.Horde_Ripper_Mode then return end
	killer:SetArmor(math.min(100,killer:Armor()+2))
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
	if ply.Horde_In_Frenzy_Mode then return end
	if ply.Horde_Ripper_Mode then return end
	if not npc:GetVar("is_elite") then return end
    if ply:Horde_GetPerk("totikfr_12") and (HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo)) then
		ply:SetArmor(math.min(100,ply:Armor()+1))
    end
end
