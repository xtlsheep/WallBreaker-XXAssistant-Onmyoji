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
ratio = 1136/height
s = (height*0.050)*(ratio) -- util.lua button
setScreenScale(640, 1136) -- iPhone 5s
print(string.format("width = %d, height = %d", width, height))
math.randomseed(os.time())
math.random(1,10000)

---- Portal
HUD = portal()
if HUD ~= -1 then
	if HUD == "show" then
		hud_scene = createHUD()
	end

	-- Main entrance
	mainmenu_UI()
end