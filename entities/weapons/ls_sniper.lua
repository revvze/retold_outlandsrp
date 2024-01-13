AddCSLuaFile()

local function RPM(rpm)
    return 60 / rpm
end

SWEP.Base = "ls_base"

SWEP.PrintName = "Pulse-Sniper"
SWEP.Category = "HL2 RP"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/litenetwork/w_ospr.mdl")
SWEP.ViewModel = Model("models/litenetwork/c_ospr.mdl")
SWEP.ViewModelFOV = 60

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_AR2.Reload")
SWEP.EmptySound = Sound("Weapon_AR2.Empty")

SWEP.Primary.Sound = Sound("weapons/ospr/fire1.ogg")
SWEP.Primary.Recoil = 0.4 -- base recoil value, SWEP.Spread mods can change thisS
SWEP.Primary.Damage = 73 -- unused
SWEP.Primary.NumShots = 1 -- unused
SWEP.Primary.Cone = 0.01 -- unused
SWEP.Primary.Delay = RPM(40)
SWEP.Primary.Tracer = "AR2Tracer"

SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 10
SWEP.Spread.IronsightsMod = 0 -- multiply
SWEP.Spread.CrouchMod = 0.7 -- crouch effect (multiply)
SWEP.Spread.AirMod = 2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.03 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 100 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(0, 0, 0)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.2
SWEP.IronsightsSensitivity = 0.2
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2
SWEP.IronsightsMuzzleFlash = "AirboatMuzzleFlash"

SWEP.LoweredPos = Vector(5, -10, -15)
SWEP.LoweredAng = Angle(40, 60, 0)

SWEP.ScopePaint = function(wep)
    surface.SetDrawColor(color_white)
    surface.SetMaterial(ix.util.GetMaterial("ospr/scope_bg"))
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    surface.SetMaterial(ix.util.GetMaterial("ospr/scope_bg_overlay"))
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    surface.SetMaterial(ix.util.GetMaterial("vgui/hud/xbox_reticle"))
    surface.DrawTexturedRect(ScrW() / 2 - 100, ScrH() / 2 - 100, 200, 200)
    surface.SetMaterial(ix.util.GetMaterial("vgui/cursors/crosshair"))
    surface.DrawTexturedRect(ScrW() / 2 - 25, ScrH() / 2 - 25, 50, 50)
    
    local lp = LocalPlayer()
    local trace = {}
    trace.start = lp:EyePos()
    trace.endpos = trace.start + lp:GetAimVector() * 7000
    trace.filter = lp

    local traceData = util.TraceLine(trace)
    local dist = "UNKWN"

    if not traceData.Hit and traceData.HitPos then
        return
    end

    dist = traceData.HitPos:Distance(lp:GetPos()) / 39.3701
    dist = math.floor(dist)

    local ang = lp:EyeAngles()
    local bearing = ix.util.angleToBearing(ang)

    local w = (ScrW() * .5) + 200
    local h = (ScrH() * .5) - 150
    local c = Color(230, 0, 0)
    draw.SimpleText("RANGE: "..dist.."m", "DebugFixed", w, h, c)
    draw.SimpleText("BEARING: "..bearing.."º", "DebugFixed", w, h + 14, c)
end

SWEP.ScopeBehaviour = "sniper_sight"

function SWEP:PrimaryAttack()
	if not self:CanShoot() then return end

	local ply = self:GetOwner()

    --self:ShootBullet(self.Primary.Damage, self.Primary.NumShots, self:CalculateSpread())
    if ( SERVER ) then
        local ent = ents.Create("csniper_bullet")
        ent:SetPos(ply:GetShootPos())
        ent:SetAngles(self:GetAimDir())
        ent:SetOwner(ply)
        ent:Spawn()
        ent:Activate()
    end

    self:AddRecoil()
    self:ViewPunch()

    self:EmitSound(self.Primary.Sound)

	self:ShootEffects()

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetReloadTime(CurTime() + self.Primary.Delay)
end



function SWEP:CanShoot()
	return not (self.LoweredPos and self:IsSprinting()) and self:GetReloadTime() < CurTime()
end

function SWEP:GetAimDir()
	local ply = self:GetOwner()

	return ply:GetAimVector():Angle() + ply:GetViewPunchAngles()
end

function SWEP:ShouldDrawBeam()
    return CurTime() > self:GetNextPrimaryFire() and not self:GetReloading() and self:GetIronsights()
end

function SWEP:GetAimTrace()
	local ply = self:GetOwner()

	return util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + (self:GetAimDir():Forward() * 8192),
		filter = {ply, self},
		mask = MASK_SHOT
	})
end

if ( CLIENT ) then
	local beam = Material("effects/bluelaser1")
	local sprite = Material("effects/blueflare1")
    function SWEP:PreDrawViewModel(vm, wep, ply)
        if CLIENT and self.CustomMaterial and not self.CustomMatSetup then
            self.Owner:GetViewModel():SetMaterial(self.CustomMaterial)
            self.CustomMatSetup = true
        end
    
        self:OffsetThink()
    
        if self.scopedIn then
            return self.scopedIn
        end

        if self:ShouldDrawBeam() then
            cam.Start3D(nil, nil, ply:GetFOV())
                cam.IgnoreZ(true)

                local pos = vm:GetAttachment(1).Pos
                local tr = self:GetAimTrace()

                render.SetMaterial(beam)
                render.DrawBeam(pos, tr.HitPos, 1, 0, tr.Fraction * 10, Color(255, 0, 0))
                render.SetMaterial(sprite)
                render.DrawSprite(tr.HitPos, 2, 2, Color(50, 190, 255))
            cam.End3D()
        end

        cam.IgnoreZ(true)
    end

	function SWEP:PostDrawViewModel(vm, wep, ply)
		cam.IgnoreZ(false)
	end

	function SWEP:PostDrawTranslucentRenderables()
		local ply = self:GetOwner()

		if not IsValid(ply) then
			return
		end

		if ply == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and not hook.Run("ShouldDrawLocalPlayer", ply) then
			return
		end

		if ply:InVehicle() then return end
		if ply:GetNoDraw() then return end

		if self:ShouldDrawBeam() then
			local pos = self:GetAttachment(1).Pos
			local tr = self:GetAimTrace()

			render.SetMaterial(beam)
			render.DrawBeam(pos, tr.HitPos, 1, 0, tr.Fraction * 10, Color(255, 0, 0))
			render.SetMaterial(sprite)
			render.DrawSprite(tr.HitPos, 2, 2, Color(50, 190, 255))
		end
	end
end