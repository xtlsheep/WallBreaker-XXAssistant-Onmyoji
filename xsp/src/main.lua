require "util"
require "UI"

-- Def
RET_OK = 0
RET_ERR = -1
RET_VALID = 1
ENABLE = 1
DISABLE = 0

-- Init
width_dev = 640
height_dev = 1136
print(os.date())
script_init()
width, height = getScreenSize()
dpi = getScreenDPI()
ratio = height_dev/height
s = (height*0.050)*(ratio) -- util.lua button
setScreenScale(width_dev, height_dev) -- iPhone 5s
print(string.format("width = %d, height = %d, dpi = %d", width, height, dpi))
math.randomseed(os.time())
math.random(1,10000)

-- Global
linkage = 0
HUD = nil
hud_scene = nil
dis_skl_fea = 1
win_cnt = 0
fail_cnt = 0
offer_arr = {0, 0, 0, 0, 0, 0}
buff_idle_stop = 0
buff_idle_stop_time = 0
buff_usup_stop = 0

-- 超鬼王
--sg_en = 0
--sg_force = 0
--sg_mark = {0, 0}
--sg_tired = {0, 0, 0, 0, 0, 0}

-- Portal
portal_UI()