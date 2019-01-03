require "util"
require "func"
require "yuhun"
require "jjtp"

-- 智能突破Global
auto_jjtp_en = 0
auto_jjtp_force = 0
auto_jjtp_interv = 0
auto_jjtp_mode = nil
auto_jjtp_whr_solo = {0, 0, 0, 0}
auto_jjtp_whr_pub = {0, 0, 0, 0}
auto_jjtp_round_time = 0
auto_jjtp_lock = 0
auto_jjtp_refresh = 0
auto_jjtp_solo_sel = nil
auto_jjtp_pub_sel = 0

-- Util func
function tingyuan_or_tansuo()
	local tingyuan_ = 0
	local tansuo_ = 0
	local x, y
	
	x, y = lct_tingyuan() if x > -1 then tingyuan_ = 1 end
	x, y = lct_tansuo() if x > -1 then tansuo_ = 1 end
	
	if tingyuan_ == 1 or tansuo_ == 1 then
		return RET_OK
	else
		return RET_ERR
	end
end

-- Main func
function yuhun_auto_jjtp(mode, role, group, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
	print("御魂 + 智能突破")
	local ret = 0
	
	while (1) do
		ret = yuhun(mode, role, group, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
		if ret == RET_OK then
			return RET_OK
		end
		mSleep(1000)
		ret = tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_ERR
		end
		ret = jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
		mSleep(1000)
		ret = tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_ERR
		end
	end
	return RET_ERR
end

function juexing_auto_jjtp(mode, role, group, element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
	print("觉醒 + 智能突破")
end

function tansuo_auto_jjtp(mode, sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, nor_attk, auto_change, page_jump, df_type, egg_color)
	print("探索 + 智能突破")
end

function yeyuanhuo_auto_jjtp(round_tan, round_chen, round_chi, lock)
	print("业原火 + 智能突破")
end