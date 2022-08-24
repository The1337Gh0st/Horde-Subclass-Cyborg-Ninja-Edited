PERK.PrintName = "Cyborg Ninja Base"
PERK.Description = [[
COMPLEXITY: HIGH

{1} increased Slashing and Blunt damage in Blade Mode. ({11} base, {2} per level, up to {3})
{4} increased Global damage resistance. ({11} base, {5} per level, up to {6})
{10} speed in Blade Mode. ({12} base, {5} per level, up to {13})

Press F to enter Blade Mode, replacing your flashlight.
Blade Mode uses Suit Power when active and requires 10 to activate.
{7} increased melee damage in Blade Mode.

Enemies killed in Blade Mode performs Zandatsu, giving you a {9} chance to drop a Suit Battery.
Gain immunity to Bleeding.
Normal attacks recharge your Suit Power.]]
PERK.Icon = "materials/subclasses/cyborg_ninja.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "Cyborg Ninja"},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
    [4] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "Cyborg Ninja"},
    [5] = {value = 0.01, percent = true},
    [6] = {value = 0.25, percent = true},
    [7] = {value = 0.50, percent = true},
	[8] = {value = 0.6, percent = true},
	[9] = {value = 0.50, percent = true},
	[10] = {percent = true, base = 0.5, level = 0.01, max = 0.75, classname = "Cyborg Ninja"},
	[11] = {value = 0, percent = true},
	[12] = {value = 0.5, percent = true},
	[13] = {value = 0.75, percent = true},
}
PERK.Hooks = {}

--leftover code that had to be merged due to it not working properly

--thanks my dude

--PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
 --   if ply:Horde_GetPerk("totikfr_base") and ply.Horde_In_Frenzy_Mode  then
  --  if HORDE:IsMeleeDamage(dmginfo) then
  --      bonus.increase = bonus.increase + 0.5
	--	if ply:Horde_GetPerk("totikfr_31") then
	--	bonus.increase = bonus.increase + 0.35
	--	end
  --  end
--end
--end

-- some rly weird stuff here
PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("totikfr_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Cyborg Ninja")))
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus, switchOn)
    if not ply:Horde_GetPerk("totikfr_base")  then return end
	
    bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("totikfr_base")
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("totikfr_base") then return end
	if not ply.Horde_In_Frenzy_Mode then return end
	

    if HORDE:IsMeleeDamage(dmginfo) then
		bonus.increase = bonus.increase + 0.5
	if ply:Horde_GetPerk("totikfr_31") then
		bonus.increase = bonus.increase + 0.25
		end
		
		
			
	bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("totikfr_base")
		
end
end

PERK.Hooks.PlayerTick = function (ply, mv)
	if not ply:Horde_GetPerk("totikfr_base") then return end
    if ply.Horde_In_Frenzy_Mode and CurTime() >= ply.Horde_HealthDegenCurTime then
        ply:SetArmor(math.max(0, ply:Armor() - 1))
        ply.Horde_HealthDegenCurTime = CurTime() + 0.25
    end
		if ply:Armor()<1 then
        -- Disable Frenzy mode
--[[        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Frenzy_Mode, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)--]]
        ply.Horde_In_Frenzy_Mode = nil 
        ply:ScreenFade(SCREENFADE.PURGE, Color(60, 60, 200, 0), 0.1, 0.1)
	end
end

PERK.Hooks.PlayerSwitchFlashlight = function (ply, switchOn)
    if not ply:Horde_GetPerk("totikfr_base") then return end
    if switchOn and ply:Armor()>=10 then
        -- Enable Frenzy mode
		ply:SetArmor(math.max(0, ply:Armor() - 10))
		sound.Play("weapons/physcannon/superphys_launch4.wav", ply:GetPos()) 
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Frenzy_Mode, 8)
            net.WriteUInt(1, 8)
        net.Send(ply)
        ply.Horde_In_Frenzy_Mode = true
        ply.Horde_HealthDegenCurTime = CurTime()
        ply:ScreenFade(SCREENFADE.STAYOUT, Color(60, 60, 200, 50), 0.2, 5)
	else
        -- Disable Frenzy mode
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Frenzy_Mode, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        ply.Horde_In_Frenzy_Mode = nil 
        ply:ScreenFade(SCREENFADE.PURGE, Color(60, 60, 200, 0), 0.1, 0.1)
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus)
    if ply.Horde_In_Frenzy_Mode and ply:Horde_GetPerk("totikfr_base") then
    bonus.walkspd = bonus.walkspd * (0.5 + ply:Horde_GetPerkLevelBonus("totikfr_base"))
    bonus.sprintspd = bonus.sprintspd * (0.5 + ply:Horde_GetPerkLevelBonus("totikfr_base"))
    end
end

--Zandatsu
PERK.Hooks.Horde_OnNPCKilled = function(victim, killer, inflictor)
	if not killer:Horde_GetPerk("totikfr_base") then return end
	if killer:Horde_GetPerk("totikfr_31") then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
	if not killer.Horde_In_Frenzy_Mode then return end
    local p = math.random()
	local c = 0.5
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
	--[[if killer:Horde_GetPerk("totikfr_32") and p <= 0.25 then
		local ent2 = ents.Create("item_healthkit")
		ent2:SetPos(victim:GetPos())
		ent2:SetOwner(killer)
		ent2.Owner = killer
		ent2.Inflictor = victim
		ent2:Spawn()
		ent2:Activate()
		timer.Simple(15, function() if ent2:IsValid() then ent2:Remove() end end)
	end]]--
end

--Passive FC regen
PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
	if ply.Horde_In_Frenzy_Mode then return end
    if ply:Horde_GetPerk("totikfr_base") and (HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo)) then
        local leech = math.min(4, dmginfo:GetDamage() * 0.05)
		ply:SetArmor(math.min(100,ply:Armor()+leech))
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Horde_GetPerk("totikfr_base") and debuff == HORDE.Status_Bleeding then
        bonus.apply = 0
        return true
    end
end

--