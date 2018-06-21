require "util"
require "UI"

-- iPhone 5s: 640 x 1136
-- Def
RET_OK = 0
RET_ERR = -1
RET_ONE = 1
dev_width = 640
jsm_ana_x = {392, 698, 1002}
jsm_ana_y = {164, 284, 403}
jsm_ana_metal_x_diff = {169, 134, 99, 64, 28}
jsm_center_x = {300, 600, 900, 300, 600, 900, 300, 600, 900}
jsm_center_y = {135, 135, 135, 255, 255, 255, 375, 375, 375}
jsm_whr_x1 = {121, 426, 732, 121, 426, 732, 121, 426, 732}
jsm_whr_y1 = {205, 205, 205, 323, 323, 323, 445, 445, 445}
jsm_whr_x2 = {405, 711, 1017, 405, 711, 1017, 405, 711, 1017}
jsm_whr_y2 = {254, 254, 254, 376, 376, 376, 495, 495, 495}
jsm_fight_x = {333, 639, 942, 333, 639, 942, 333, 639, 942}
jsm_fight_y = {300, 300, 300, 420, 420, 420, 540, 540, 540}

-- Init
print(os.date())
init(0, 1)
width,height = getScreenSize()
s = height * 0.050
setScreenScale(640, 1136)
print(string.format("width = %d, height = %d", width, height))
math.randomseed(os.time())
math.random(1,10000)

-- Portal
ios_ver = ios_ver()
if ios_ver ~= -1 then
	if ios_ver == "ios_other" then
		hud_scene = createHUD()
	end

	-- Main entrance
	portal_UI()
end