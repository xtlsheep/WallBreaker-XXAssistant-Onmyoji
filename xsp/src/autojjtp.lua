require "util"
require "func"
require "yuhun"
require "jjtp"

-- 智能突破Global
auto_jjtp_en = 0
auto_jjtp_interv = 0
auto_jjtp_mode = nil
auto_jjtp_whr_solo = {0, 0, 0, 0}
auto_jjtp_whr_pub = {0, 0, 0, 0}
auto_jjtp_round_time = 0
auto_jjtp_lock = 0
auto_jjtp_refresh = 0
auto_jjtp_solo_sel = nil
auto_jjtp_pub_sel = 0
auto_jjtp_time_stamp = 0

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

function auto_jjtp_time_check()
	if auto_jjtp_en == 0 then
		return
	end
	
	local curr_time_stamp = mTime()
	local dura_time = curr_time_stamp - auto_jjtp_time_stamp
	local dura_time_min = dura_time/(1000*60)
	
	if dura_time_min > auto_jjtp_interv then
		return RET_VALID
	end
	return RET_OK
end

-- Main func
function yuhun_auto_jjtp(mode, role, group, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
	local ret = 0
	
	while (1) do
		auto_jjtp_time_stamp = mTime()
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
		jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
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
	local ret = 0
	
	while (1) do
		auto_jjtp_time_stamp = mTime()
		ret = juexing(mode, role, group, element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
		if ret == RET_OK then
			return RET_OK
		end
		mSleep(1000)
		ret = tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_ERR
		end
		jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
		mSleep(1000)
		ret = tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_ERR
		end
	end
	return RET_ERR
end

function tansuo_auto_jjtp(mode, sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type, egg_color)
	local ret = 0
	
	while (1) do
		auto_jjtp_time_stamp = mTime()
		ret = tansuo(mode, sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type, egg_color)
		if ret == RET_OK then
			return RET_OK
		end
		mSleep(1000)
		ret = tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_ERR
		end
		jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
		mSleep(1000)
		ret = tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_ERR
		end
	end
	return RET_ERR
end

function yeyuanhuo_auto_jjtp(round_tan, round_chen, round_chi, lock)
	local ret = 0
	
	while (1) do
		auto_jjtp_time_stamp = mTime()
		ret = yeyuanhuo(round_tan, round_chen, round_chi, lock)
		if ret == RET_OK then
			return RET_OK
		end
		mSleep(1000)
		ret = tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_ERR
		end
		jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
		mSleep(1000)
		ret = tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_ERR
		end
	end
	return RET_ERR
end