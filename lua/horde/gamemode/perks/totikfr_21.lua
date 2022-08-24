PERK.PrintName = "Counter-Attack"
PERK.Description = "When hit, your attacker recieves sextuples the damage you recieved. \nGain {1} global damage resist, and +{2} damage block while in Blade Mode."
PERK.Icon = "materials/perks/graceful_guard.png"
PERK.Params = {
    [1] = {value = 0.35, percent = true},
	[2] = {value = 5},
}

PERK.Hooks = {}

PERK.Hooks.PlayerHurt = function(victim, attacker, healthRemaining, damageTaken)
    if not victim:Horde_GetPerk("totikfr_21")  then return end
    if ( attacker:IsNPC() ) then
		attacker:TakeDamage(damageTaken*6, victim)
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("totikfr_21")  then return end
	bonus.resistance = bonus.resistance + 0.35
	if not ply.Horde_In_Frenzy_Mode then return end    
	bonus.block = bonus.block + 5
end