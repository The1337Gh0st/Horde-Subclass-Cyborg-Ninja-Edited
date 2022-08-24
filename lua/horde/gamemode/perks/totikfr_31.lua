PERK.PrintName = "Sharper Blade"
PERK.Description = "+{1} Blade Mode damage increase. \n Blade Mode has a {2} chance to drop a battery on kill. \nBlade Mode makes headshot melee damage inflict Bleed."
PERK.Icon = "materials/perks/samurai/demon_strike.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
	[2] = {value = 1, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnNPCKilled = function(victim, killer, inflictor)
	if not killer:Horde_GetPerk("totikfr_31") then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
	if not killer.Horde_In_Frenzy_Mode then return end
    local p = math.random()
	local c = 1
	--if killer:Horde_GetPerk("totikfr_31") then c = 1 end
    if p <= c then
        local ent = ents.Create("item_battery")
        ent:SetPos(killer:GetPos())
        ent:SetOwner(killer)
        ent.Owner = killer
        ent.Inflictor = victim
        ent:Spawn()
        ent:Activate()
        timer.Simple(15, function() if ent:IsValid() then ent:Remove() end end)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("totikfr_31")  then return end
    if HORDE:IsMeleeDamage(dmginfo) and ply.Horde_In_Frenzy_Mode and hitgroup == HITGROUP_HEAD then
		npc:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, dmginfo:GetDamage() * 0.5, ply, dmginfo:GetDamagePosition())
    end
end
