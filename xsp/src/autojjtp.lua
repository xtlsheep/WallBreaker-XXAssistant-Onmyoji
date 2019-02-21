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
function yuhun_auto_jjtp(mode, role, group, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate, limitation)
	local ret = 0
	
	while (1) do
		auto_jjtp_time_stamp = mTime()
		
		yuhun(mode, role, group, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate, limitation)
		mSleep(1000)
		ret = lct_tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			lua_exit()
		end
		
		jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
		mSleep(1000)
		ret = lct_tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			lua_exit()
		end
	end
	return RET_ERR
end

function juexing_auto_jjtp(mode, role, group, element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
	local ret = 0
	
	while (1) do
		auto_jjtp_time_stamp = mTime()
		
		juexing(mode, role, group, element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
		mSleep(1000)
		ret = lct_tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			lua_exit()
		end
		
		jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
		mSleep(1000)
		ret = lct_tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			lua_exit()
		end
	end
	return RET_ERR
end

function tansuo_auto_jjtp(mode, sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type, egg_color)
	local ret = 0
	
	while (1) do
		auto_jjtp_time_stamp = mTime()
		
		tansuo(mode, sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type, egg_color)
		mSleep(1000)
		ret = lct_tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			lua_exit()
		end
		
		
		jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
		mSleep(1000)
		ret = lct_tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			lua_exit()
		end
	end
	return RET_ERR
end

function yeyuanhuo_auto_jjtp(round_tan, round_chen, round_chi, lock)
	local ret = 0
	
	while (1) do
		auto_jjtp_time_stamp = mTime()
		
		yeyuanhuo(round_tan, round_chen, round_chi, lock)
		mSleep(1000)
		ret = lct_tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			lua_exit()
		end
		
		jjtp(auto_jjtp_mode, auto_jjtp_whr_solo, auto_jjtp_whr_pub, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock)
		mSleep(1000)
		ret = lct_tingyuan_or_tansuo()
		if ret == RET_ERR then
			HUD_show_or_hide(HUD,hud_info,"场景识别错误, 结束脚本",20,"0xff000000","0xffffffff",0,100,0,300,32)
			lua_exit()
		end
	end
	return RET_ERR
end