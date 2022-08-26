PERK.PrintName = "Counter-Attack"
PERK.Description = "When hit, your attacker recieves quintuple the damage you recieved, \nand is inflicted with Stun."
PERK.Icon = "materials/perks/graceful_guard.png"
PERK.Params = {
    [1] = {value = 0.35, percent = true},
	[2] = {value = 5},
}

PERK.Hooks = {}

PERK.Hooks.PlayerHurt = function(victim, attacker, healthRemaining, damageTaken)
    if not victim:Horde_GetPerk("totikfr_21")  then return end
    if ( attacker:IsNPC() ) then
		attacker:TakeDamage(damageTaken*5, victim)
		attacker:Horde_AddStun(damageTaken*5)
    end
end
