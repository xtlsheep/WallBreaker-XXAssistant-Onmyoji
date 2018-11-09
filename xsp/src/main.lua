require "util"
require "UI"

-- Def
RET_OK = 0
RET_ERR = -1
RET_VALID = 1
ENABLE = 1
DISABLE = 0

-- Init
system_date = os.date()
start_time = mTime()
ver = getOSType()
width, height = getScreenSize()
dpi = getScreenDPI()
direction_init()
print(system_date)
print(string.format("OS = %s, width = %d, height = %d, dpi = %d", ver, width, height, dpi))

width_dev = 640
height_dev = 1136
setScreenScale(width_dev, height_dev) -- iPhone 5s
ratio = height_dev/height
s = (height*0.050)*(ratio)
math.randomseed(os.time())
math.random(1,10000)

-- Global
HUD = nil
hud_dscrpt = nil
linkage = 0
show_settlement = 0
offer_arr = {0, 0, 0, 0, 0, 0}

win_cnt = {global = 0, yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0, yqfy = 0}
fail_cnt = {global = 0, yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0, yqfy = 0}
buff_usup_stop = 0
buff_idle_stop = 0
buff_idle_stop_time = 0

intel_jjtp_solo = 0
intel_jjtp_pub = 0

-- 超鬼王
--sg_en = 0
--sg_force = 0
--sg_mark = {0, 0}
--sg_tired = {0, 0, 0, 0, 0, 0}

-- Portal
portal_UI()