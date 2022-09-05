PERK.PrintName = "Cybernetic Arm"
PERK.Description = "{1} increased melee damage. \nKills leech {2} armor while not in Blade Mode or Ripper Mode."
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
