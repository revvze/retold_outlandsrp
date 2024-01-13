local PLUGIN = PLUGIN

local PANEL = {}

function PANEL:Init()
	self:SetAlpha(255)
	self:SetSize(ScrW(), ScrH())
	self:Center()
	self:MakePopup()

	self.killTime = CurTime() + PLUGIN.killTime

	self.mainCredits = markup.Parse(PLUGIN.credits)

	self.scrollY = ScrH()

	timer.Simple(0.1, function()
		if ( self.musicEnabled ) then
			if ( creditsMusic ) and ( creditsMusic:IsPlaying() ) then
				creditsMusic:Stop()
			end
	
			creditsMusic = CreateSound(LocalPlayer(), PLUGIN.musicTrack)
			creditsMusic:SetSoundLevel(0)
			creditsMusic:Play()
			creditsMusic:ChangeVolume(0.3)
		end
	end)
end

local gradient = surface.GetTextureID("vgui/gradient-u")
function PANEL:Paint(w, h)
	surface.SetDrawColor(Color(20, 20, 20, 255))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(0, 0, 0, 255))
	surface.SetTexture(gradient)
	surface.DrawTexturedRect(0, 0, w, h)

	surface.SetDrawColor(ColorAlpha(ix.config.Get("color"), 10))
	surface.SetTexture(gradient)
	surface.DrawTexturedRect(0, -h / 2, w, h)

	self.scrollY = self.scrollY - (FrameTime() * PLUGIN.speed)
	self.mainCredits:Draw(w / 2, self.scrollY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, nil, TEXT_ALIGN_CENTER)
end

function PANEL:OnRemove()
	if ( self.musicEnabled ) then
		if ( creditsMusic ) and ( creditsMusic:IsPlaying() ) then
			creditsMusic:FadeOut(2)
			timer.Simple(2, function()
				if ( creditsMusic:IsPlaying() ) then
					creditsMusic:Stop()
				end
			end)
		end
	end
end

function PANEL:Think()
	if ( CurTime() > self.killTime ) then
		self:AlphaTo(0, 2, 0, function()
			self:Remove()
		end)
	end
end

vgui.Register("ixNewCredits", PANEL, "DPanel")