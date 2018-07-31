require "util"
require "UI"

-- Def
RET_OK = 0
RET_ERR = -1
RET_VALID = 1
ENABLE = 1
DISABLE = 0

-- Init
print(os.date())
init(0, 1)
width,height = getScreenSize()
s = height * 0.050 -- util.lua
setScreenScale(640, 1136) -- iPhone 5s
print(string.format("width = %d, height = %d", width, height))
math.randomseed(os.time())
math.random(1,10000)

---- Portal
ios_ver = ios_ver()
if ios_ver ~= -1 then
	if ios_ver == "ios_other" then
		hud_scene = createHUD()
	end

	-- Main entrance
	portal_UI()
end