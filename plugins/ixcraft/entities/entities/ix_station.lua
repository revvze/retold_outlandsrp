
local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Station"
ENT.Category = "Helix"
ENT.Spawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "StationID")

	if (SERVER) then
		self:NetworkVarNotify("StationID", self.OnVarChanged)
	end
end

if (SERVER) then
	util.AddNetworkString("ixCraftingMenu")

	function ENT:Initialize()
		if (!self.uniqueID) then
			self:Remove()

			return
		end

		self:SetStationID(self.uniqueID)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end

	function ENT:OnVarChanged(name, oldID, newID)
		local stationTable = PLUGIN.craft.stations[newID]

		if (stationTable) then
			self:SetModel(stationTable:GetModel())
		end
	end

	function ENT:UpdateTransmitState()
		return TRANSMIT_PVS
	end

	function ENT:Use(activator)
		net.Start("ixCraftingMenu")
		net.Send(activator)

        if ( activator:IsCombine() or ( activator:IsConscript() and activator:GetCharacter():GetClass() == CLASS_CONSCRIPT_C ) ) then
            activator:Notify("You cannot use the crafting table.")
            return false
        end

		activator:EmitSound("physics/metal/metal_solid_impact_soft"..math.random(1,3)..".wav")
	end
else
	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(tooltip)
		local stationTable = self:GetStationTable()

		if (stationTable) then
			PLUGIN:PopulateStationTooltip(tooltip, stationTable)
		end
	end

	function ENT:Draw()
		self:DrawModel()
	end

	net.Receive("ixCraftingMenu", function()
		local frame = vgui.Create("DFrame")
		frame:SetSize(ScrW() / 1.4, ScrH() / 1.4)
		frame:SetTitle("crafting menu")
		frame:Center()
		frame:MakePopup()
		frame:SetBackgroundBlur(true)

		local craftingMenu = vgui.Create("ixCrafting", frame)
		craftingMenu:Dock(FILL)
	end)
end

function ENT:GetStationTable()
	return PLUGIN.craft.stations[self:GetStationID()]
end
