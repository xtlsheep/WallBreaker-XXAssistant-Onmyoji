require "util"
require "UI"

-- Def
RET_OK = 0
RET_ERR = -1
RET_VALID = 1
ENABLE = 1
DISABLE = 0

-- Init
start_date = os.date()
start_time = mTime()
print(start_date)
width_dev = 640
height_dev = 1136
width, height = getScreenSize()
ver = getOSType()
dpi = getScreenDPI()
script_init()
setScreenScale(width_dev, height_dev) -- iPhone 5s
ratio = height_dev/height
s = (height*0.050)*(ratio)
print(string.format("OS = %s, width = %d, height = %d, dpi = %d", ver, width, height, dpi))
math.randomseed(os.time())
math.random(1,10000)

-- Global
linkage = 0
HUD = nil
hud_scene = nil
dis_skl_fea = 1
offer_arr = {0, 0, 0, 0, 0, 0}

win_cnt = 0
fail_cnt = 0
yuhun_win_cnt = 0
yuhun_fail_cnt = 0
tansuo_win_cnt = 0
tansuo_fail_cnt = 0
jjtp_win_cnt = 0
jjtp_fail_cnt = 0
juexing_win_cnt = 0
juexing_fail_cnt = 0
yyh_win_cnt = 0
yyh_fail_cnt = 0
yuling_win_cnt = 0
yuling_fail_cnt = 0
yqfy_win_cnt = 0
yqfy_fail_cnt = 0

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
settlement_UI()