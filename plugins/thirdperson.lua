
local PLUGIN = PLUGIN

PLUGIN.name = "Third Person"
PLUGIN.author = "Black Tea"
PLUGIN.description = "Enables third person camera usage."

if ( SERVER ) then
    ix.plugin.SetUnloaded("thirdperson", false)
elseif ( CLIENT ) then
    if ( IsValid(ix.gui.pluginManager) ) then
        ix.gui.pluginManager:UpdatePlugin("thirdperson", true)
    end
end

ix.config.Add("thirdperson", false, "Allow Thirdperson in the server.", nil, {
	category = "server"
})

if (CLIENT) then
	local function isHidden()
		return !ix.config.Get("thirdperson")
	end

	ix.option.Add("thirdpersonEnabled", ix.type.bool, false, {
		category = "thirdperson",
		hidden = isHidden,
		OnChanged = function(oldValue, value)
			hook.Run("ThirdPersonToggled", oldValue, value)
		end
	})

	ix.option.Add("thirdpersonClassic", ix.type.bool, false, {
		category = "thirdperson",
		hidden = isHidden
	})

	ix.option.Add("thirdpersonVertical", ix.type.number, 10, {
		category = "thirdperson", min = 0, max = 30,
		hidden = isHidden
	})

	ix.option.Add("thirdpersonHorizontal", ix.type.number, 0, {
		category = "thirdperson", min = -30, max = 30,
		hidden = isHidden
	})

	ix.option.Add("thirdpersonDistance", ix.type.number, 50, {
		category = "thirdperson", min = 0, max = 100,
		hidden = isHidden
	})


	concommand.Add("ix_togglethirdperson", function()
		local bEnabled = !ix.option.Get("thirdpersonEnabled", false)

		ix.option.Set("thirdpersonEnabled", bEnabled)
	end)

	local function isAllowed()
		return ix.config.Get("thirdperson")
	end

	local playerMeta = FindMetaTable("Player")
	local traceMin = Vector(-10, -10, -10)
	local traceMax = Vector(10, 10, 10)

	function playerMeta:CanOverrideView()
		local entity = Entity(self:GetLocalVar("ragdoll", 0))

		if (IsValid(ix.gui.characterMenu) and !ix.gui.characterMenu:IsClosing() and ix.gui.characterMenu:IsVisible()) then
			return false
		end

		if (IsValid(ix.gui.menu) and ix.gui.menu:GetCharacterOverview()) then
			return false
		end

		if (ix.option.Get("thirdpersonEnabled", false) and
			!IsValid(self:GetVehicle()) and
			isAllowed() and
			IsValid(self) and
			self:GetCharacter() and
			!self:GetNetVar("actEnterAngle") and
			!IsValid(entity) and
			LocalPlayer():Alive()
			) then
			return true
		end
	end

	local view, traceData, crouchFactor, ft, curAng
	local clmp = math.Clamp
	crouchFactor = 0

	local originLerp
	local angleLerp
	function PLUGIN:CalcView(client, origin, angles, fov)
		ft = FrameTime()

		if not ( originLerp ) then
			originLerp = origin
		end	

		if not ( angleLerp ) then
			angleLerp = angles
		end	

		if (client:CanOverrideView() and LocalPlayer():GetViewEntity() == LocalPlayer()) then
			local bNoclip = LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP

			if ((client:OnGround() and client:KeyDown(IN_DUCK)) or client:Crouching()) then
				crouchFactor = Lerp(ft*5, crouchFactor, 1)
			else
				crouchFactor = Lerp(ft*5, crouchFactor, 0)
			end

			curAng = client:EyeAngles()
			view = {}
			traceData = {}
				traceData.start = 	client:GetPos() + client:GetViewOffset() +
									curAng:Up() * ix.option.Get("thirdpersonVertical", 10) +
									curAng:Right() * ix.option.Get("thirdpersonHorizontal", 0) -
									client:GetViewOffsetDucked() * .5 * crouchFactor
				traceData.endpos = traceData.start - curAng:Forward() * ix.option.Get("thirdpersonDistance", 50)
				traceData.filter = client
				traceData.ignoreworld = bNoclip
				traceData.mins = traceMin
				traceData.maxs = traceMax

			originLerp = LerpVector(ft*5, originLerp, util.TraceHull(traceData).HitPos)
			view.origin = originLerp
			angleLerp = LerpAngle(ft*5, angleLerp, curAng)
			view.angles = angleLerp

			return view
		else
			originLerp = origin
			angleLerp = angles
		end
	end

	function PLUGIN:CreateMove(cmd)
	end

	function PLUGIN:InputMouseApply(cmd, x, y, ang)
	end

	function PLUGIN:ShouldDrawLocalPlayer()
		if (LocalPlayer():GetViewEntity() == LocalPlayer() and !IsValid(LocalPlayer():GetVehicle())) then
			return LocalPlayer():CanOverrideView()
		end
	end
end
