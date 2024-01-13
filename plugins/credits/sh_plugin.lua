local PLUGIN = PLUGIN

PLUGIN.name = "Credits"
PLUGIN.description = "Adds a command to roll the credits for all players."
PLUGIN.author = "Riggs.mackay"

PLUGIN.speed = 48 -- How fast the credits roll. (default: 48)
PLUGIN.killTime = 80 -- Time in seconds to wait before killing the credits.
PLUGIN.musicTrack = "music/vlvx_song3.mp3" -- MUST BE A VALID SOUND FILE
PLUGIN.credits = [[
<font=Font-Elements80>
<color=127,0,0>Division II</color>
<font=Font-Elements64>
Owner
</font><font=Font-Elements48>
<color=255,30,70>Aches</color>
</font>

<font=Font-Elements32>
Framework Used
</font><font=Font-Elements24>
<color=115,53,142>helixβ</color>
</font>

<font=Font-Elements32>
<color=50,100,200>Developers</color>
</font><font=Font-Elements24>
Riggs.mackay™ - Lead Developer
Aches - Side Developer
Apsy (Skay) - Side Developer
</font>

<font=Font-Elements32>
<color=250,200,0>Staff Team</color>
</font><font=Font-Elements24>
Jack - Headstaff
Average Mini-14 Enjoyer - Staff
Swell Hell - Staff
Bor3d - Trial Staff
puppy - Trial Staff
</font>

<font=Font-Elements32>
<color=0,50,200>Event Team</color>
</font><font=Font-Elements24>
InterestingDuck
Lee West
Astroking
anti
</font>

<font=Font-Elements32>
<color=0,100,0>Beta Testers</color>
</font><font=Font-Elements24>
Jack
Average Mini-14 Enjoyer
Swell Hell
Egocentrism
Nebo Strelok ☢
InterestingDuck
Ducker
</font>

<font=Font-Elements32>
<color=0,80,0>Alpha Testers</color>
</font><font=Font-Elements24>
Average Mini-14 Enjoyer
Swell Hell
InterestingDuck
Intelligent Idiot
Jack
</font>

<font=Font-Elements32>
<color=0,150,0>Contributors</color>
</font><font=Font-Elements24>
Charity
Nebo Strelok ☢
Average Axe Enjoyer
</font>

<font=Font-Elements64>
Partnered Servers
</font><font=Font-Elements48>
<color=50,150,250>Lite Network Community</color>
<color=180,180,180>NPC Servers</color>
</font>

<font=Font-Elements64>
Thank You For Playing
</font>
]]

if ( CLIENT ) then
    concommand.Add("ix_credits", function()
        vgui.Create("ixNewCredits")
    end)

    concommand.Add("ix_credits_music", function()
        local credits = vgui.Create("ixNewCredits")
        credits.musicEnabled = true
    end)
end

ix.command.Add("credits", {
    description = "Roll the credits for all players.",
    superAdminOnly = true,
    arguments = {
        bit.bor(ix.type.bool, ix.type.optional),
    },
    OnRun = function(self, ply, bMusic)
        for k, v in pairs(player.GetAll()) do
            if ( bMusic ) then
                v:ConCommand("ix_credits_music")
            else
                v:ConCommand("ix_credits")
            end
        end
    end
})
