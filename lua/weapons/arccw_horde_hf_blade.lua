if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_katana")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_hf_blade", "vgui/hud/arccw_horde_katana", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "HF Blade"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Ancient Japanese Sword, converted to high-frequency blade. It carried over the already excellent properties of the original sword, making it extremely powerful."
SWEP.Trivia_Manufacturer = "Unknown."
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Slashing Weapon"
SWEP.Trivia_Country = "Japan"
SWEP.Trivia_Year = 2013

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_katana.mdl"
SWEP.WorldModel = "models/horde/weapons/w_katana.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 100
SWEP.Melee2Damage = 40

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 60
SWEP.MeleeAttackTime = 0.2
SWEP.MeleeTime = 0.65
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 50
SWEP.Melee2AttackTime = 0
SWEP.Melee2Time = 0.3
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = {
    "horde/weapons/katana/katana_swing_miss1.ogg",
    "horde/weapons/katana/katana_swing_miss2.ogg"
}
SWEP.MeleeMissSound = {
    "horde/weapons/katana/katana_swing_miss1.ogg",
    "horde/weapons/katana/katana_swing_miss2.ogg"
}
SWEP.MeleeHitSound = {
    "horde/weapons/katana/katana_impact_world1.ogg",
    "horde/weapons/katana/katana_impact_world2.ogg"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/katana/melee_katana_01.ogg",
    "horde/weapons/katana/melee_katana_02.ogg",
    "horde/weapons/katana/melee_katana_03.ogg"
}

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "melee2"

SWEP.Primary.ClipSize = -1

SWEP.AttachmentElements = {
}

SWEP.Attachments = {
}

SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"swing_l", "swing_r2"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = {"swing_l", "swing_r2"},
        Time = 0.4,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(-0, -1, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)