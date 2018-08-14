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

-- Global var
win_cnt = 0
fail_cnt = 0

-- Global config
offer_arr = {0, 0, 0, 0, 0, 0}

-- 超鬼王
sg_en = 0
sg_force = 0
sg_mark = {0, 0}
sg_tired = {0, 0, 0, 0, 0, 0}

---- Portal
HUD = portal()
if HUD ~= -1 then
	if HUD == "show" then
		hud_scene = createHUD()
	end

	-- Main entrance
	mainmenu_UI()
end