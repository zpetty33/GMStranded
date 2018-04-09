SGS.SkillUnlocks = {}
function Unlock_RegisterSkillUnlock( unlock )
	if not SGS.SkillUnlocks[unlock.skill] then SGS.SkillUnlocks[unlock.skill] = {} end
	SGS.SkillUnlocks[unlock.skill][unlock.level] = unlock
end

--[[
Woodcutting Unlocks
]]

Unlock_RegisterSkillUnlock( {
	skill	= "woodcutting",
	level	= 15,
	text	= "You can now chop Oak Trees",
	text2	= "You can now use Steel Hatchets"
} )

Unlock_RegisterSkillUnlock( {
	skill	= "woodcutting",
	level	= 25,
	text	= "You can now use Silver Hatchets"
} )

Unlock_RegisterSkillUnlock( {
	skill	= "woodcutting",
	level	= 30,
	text	= "You can now chop Maple Trees"
} )

Unlock_RegisterSkillUnlock( {
	skill	= "woodcutting",
	level	= 35,
	text	= "You can now use Trinium Hatchets"
} )

Unlock_RegisterSkillUnlock( {
	skill	= "woodcutting",
	level	= 45,
	text	= "You can now chop Pine Trees",
	text2	= "You can now use Naquadah Hatchets"
} )

Unlock_RegisterSkillUnlock( {
	skill	= "woodcutting",
	level	= 55,
	text	= "You can now chop Yew Trees",
	text2	= "You can now use Mithril Hatchets"
} )

Unlock_RegisterSkillUnlock( {
	skill	= "woodcutting",
	level	= 65,
	text	= "You can now chop Buckeye Trees",
	text2	= "You can now use Platinum Hatchets"
} )

Unlock_RegisterSkillUnlock( {
	skill	= "woodcutting",
	level	= 72,
	text	= "You can now chop Palm Trees"
} )

--[[
Mining Unlocks
]]

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 15,
	text	= "You can now mine Iron Deposits",
	text2	= "You can now use Steel Pickaxes",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 25,
	text	= "You can now mine Coal Deposits",
	text2	= "You can now use Silver Pickaxes",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 35,
	text	= "You can now mine Silver Deposits",
	text2	= "You can now use Trinium Pickaxes",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 45,
	text	= "You can now use Naquadah Pickaxes",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 50,
	text	= "You can now mine Trinium Deposits",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 55,
	text	= "You can now mine Naquadah Deposits",
	text2	= "You can now use Mithril Pickaxes",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 62,
	text	= "You can now mine Gold Deposits",
	text2	= "You can now mine Mithril Deposits",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 65,
	text	= "You can now use Platinum Pickaxes",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "mining",
	level	= 72,
	text	= "You can now mine Platinum Deposits",
} )

--[[
Farming Unlocks
]]

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 7,
	text	= "You can now plant Guacca Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 8,
	text	= "You can now plant Wheat Seeds",
	text2	= "You can now plant Liferoot Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 15,
	text	= "You can now use the Steel Hoe",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 18,
	text	= "You can now plant Arctus Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 21,
	text	= "You can now plant Liechi Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 25,
	text	= "You can now use the Silver Hoe",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 28,
	text	= "You can now plant Lum Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 32,
	text	= "You can now plant Tree Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 35,
	text	= "You can now use the Trinium Hoe",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 38,
	text	= "You can now plant Oak Tree Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 45,
	text	= "You can now plant Maple Tree Seeds",
	text2	= "You can now use the Naquadah Hoe",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 50,
	text	= "You can now plant Perriot Seeds",
	text2	= "You can now plant Pine Tree Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 55,
	text	= "You can now plant Pallie/Yew Tree Seeds",
	text2	= "You can now use the Mithril Hoe",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 65,
	text	= "You can now plant Moly/Buckeye Tree Seeds",
	text2	= "You can now use the Platinum Hoe",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 72,
	text	= "You can now plant Karopa Seeds",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "farming",
	level	= 74,
	text	= "You can now plant Palm Tree Seeds",
} )

--[[
Fishing Unlocks
]]

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 10,
	text	= "You can now catch Cod",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 15,
	text	= "You can now catch Salmon",
	text2	= "You can now use the Steel Fishing Rod",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 20,
	text	= "You can now catch Tuna",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 25,
	text	= "You can now use the Silver Fishing Rod",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 30,
	text	= "You can now catch Lobster",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 35,
	text	= "You can now use the Trinium Fishing Rod",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 40,
	text	= "You can now catch Bass",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 45,
	text	= "You can now use the Naquadah Fishing Rod",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 50,
	text	= "You can now catch Swordfish",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 55,
	text	= "You can now use the Mithril Fishing Rod",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 60,
	text	= "You can now catch Shark",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 65,
	text	= "You can now use the Platinum Fishing Rod",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "fishing",
	level	= 71,
	text	= "You can now catch Eel",
} )

--[[
Arcane Unlocks
]]

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 5,
	text	= "You have unlocked the Water Bolt Spell",
	text2	= "You have unlocked the Self Heal Spell",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 10,
	text	= "You have unlocked the Earth Bolt Spell",
	text2	= "You have unlocked the Personal Light Spell",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 15,
	text	= "You have unlocked the Fire Bolt Spell",
	text2	= "You have unlocked the Gather Resources Spells",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 20,
	text	= "You have unlocked the Wind Blast Spell",
	text2	= "You have unlocked the Teleport to Cursor Spell",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 26,
	text	= "You have unlocked the Water Blast Spell",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 30,
	text	= "You have unlocked the Consume Tree Spell",
	text2	= "You have unlocked the Resurrect Spell",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 33,
	text	= "You have unlocked the Earth Blast Spell",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 35,
	text	= "You have unlocked the Grow Seeds Spell",
	text2	= "You have unlocked the Heal Other Spell",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 40,
	text	= "You have unlocked the Fire Blast Spell",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 45,
	text	= "You have unlocked the Wind Wave Spell",
	text2	= "You have unlocked Set Time: Noon",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 50,
	text	= "You have unlocked the Water Wave Spell",
	text2	= "You have unlocked Set Time: Dawn",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 55,
	text	= "You have unlocked the Earth Wave Spell",
	text2	= "You have unlocked Set Time: Midnight",
} )

Unlock_RegisterSkillUnlock( {
	skill	= "arcane",
	level	= 60,
	text	= "You have unlocked the Fire Wave Spell",
	text2	= "You have unlocked Set Time: Dusk",
} )