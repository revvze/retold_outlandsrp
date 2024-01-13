
local PLUGIN = PLUGIN
local _tonumber = tonumber
local _math_ceil = math.ceil
local _SoundDuration = SoundDuration
local _Ambients_Cooldown = 10

PLUGIN.name = "Ambient Music"
PLUGIN.description = "Adds background music (ply-side)"
PLUGIN.author = "Bilwin"
PLUGIN.schema = "Any"
PLUGIN.songs = {
	{path = "music/passive/passivemusic_01.ogg", duration = 95},
	{path = "music/passive/passivemusic_02.ogg", duration = 136},
	{path = "music/passive/passivemusic_03.ogg", duration = 111},
	{path = "music/passive/passivemusic_04.ogg", duration = 122},
	{path = "music/passive/passivemusic_05.ogg", duration = 233},
	{path = "music/passive/passivemusic_06.ogg", duration = 222},
	{path = "music/passive/passivemusic_07.ogg", duration = 243},
	{path = "music/passive/passivemusic_08.ogg", duration = 286},
	{path = "music/passive/passivemusic_09.ogg", duration = 162},
	{path = "music/passive/passivemusic_10.ogg", duration = 268},
	{path = "music/passive/passivemusic_11.ogg", duration = 349},
	{path = "music/passive/passivemusic_12.ogg", duration = 264},
	{path = "music/passive/passivemusic_13.ogg", duration = 445},
	{path = "music/passive/passivemusic_14.ogg", duration = 127},
	{path = "music/passive/passivemusic_15.ogg", duration = 128},
	{path = "music/passive/passivemusic_16.ogg", duration = 247},
	{path = "music/passive/passivemusic_17.ogg", duration = 286},
	{path = "music/passive/passivemusic_18.ogg", duration = 328},
	{path = "music/passive/passivemusic_19.ogg", duration = 118},
	{path = "music/passive/passivemusic_20.ogg", duration = 221},
}

ix.lang.AddTable("english", {
	optEnableAmbient = "Enable ambient",
    optAmbientVolume = "Ambient volume"
})

if (CLIENT) then
    m_flAmbientCooldown = m_flAmbientCooldown or 0
    bAmbientPreSaver = bAmbientPreSaver or false

    ix.option.Add("enableAmbient", ix.type.bool, true, {
		category = PLUGIN.name,
        OnChanged = function(oldValue, value)
            if (value) then
                if IsValid(PLUGIN.ambient) then
                    local volume = ix.option.Get("ambientVolume", 1)
                    PLUGIN.ambient:SetVolume(volume)
                end
            else
                if IsValid(PLUGIN.ambient) then
                    PLUGIN.ambient:SetVolume(0)
                end
            end
        end
	})

	ix.option.Add("ambientVolume", ix.type.number, 0.5, {
		category = PLUGIN.name,
        min = 0.1,
        max = 2,
        decimals = 1,
        OnChanged = function(oldValue, value)
            if IsValid(PLUGIN.ambient) and ix.option.Get("enableAmbient", true) then
                PLUGIN.ambient:SetVolume(value)
            end
        end
	})

    do
        if !table.IsEmpty(PLUGIN.songs) then
            for _, data in ipairs(PLUGIN.songs) do
                util.PrecacheSound(data.path)
            end
        end
    end

    function PLUGIN:CreateAmbient()
        local bEnabled = ix.option.Get('enableAmbient', true)

        if (bEnabled and !bAmbientPreSaver) then
            local flVolume = _tonumber(ix.option.Get('ambientVolume', 1))
            local mSongTable = self.songs[math.random(1, #self.songs)]
            local mSongPath = mSongTable.path
            local mSongDuration = mSongTable.duration or _SoundDuration(mSongPath)

            sound.PlayFile('sound/' .. mSongTable.path, 'noblock', function(radio)
                if IsValid(radio) then
                    if IsValid(self.ambient) then self.ambient:Stop() end

                    radio:SetVolume(flVolume)
                    radio:Play()
                    self.ambient = radio

                    m_flAmbientCooldown = os.time() + _tonumber(mSongDuration) + _Ambients_Cooldown
                end
            end)
        end
    end

    net.Receive('ixPlayAmbient', function()
        if !timer.Exists('mAmbientMusicChecker') then
            timer.Create('mAmbientMusicChecker', 5, 0, function()
                if (m_flAmbientCooldown or 0) > os.time() then return end
                PLUGIN:CreateAmbient()
            end)
        end

        if !timer.Exists('mAmbientChecker') then
            timer.Create('mAmbientChecker', 0.5, 0, function()
                if IsValid(ix.gui.characterMenu) and ix.config.Get("music") ~= "" then
                    if IsValid(PLUGIN.ambient) then
                        PLUGIN.ambient:SetVolume(0)
                    end
                else
                    if ix.option.Get('enableAmbient', true) then
                        if IsValid(PLUGIN.ambient) then
                            local volume = ix.option.Get("ambientVolume", 1)
                            PLUGIN.ambient:SetVolume(volume)
                        end
                    end
                end
            end)
        end
    end)
end

if (SERVER) then
    util.AddNetworkString('ixPlayAmbient')
    function PLUGIN:PlayerLoadedCharacter(ply, character, currentChar)
        net.Start('ixPlayAmbient')
        net.Send(ply)
    end
end
