require "util"

-- Some func
function screen_direct_init()
	local ret = getScreenDirection()
	
	if ret == 0 then
		print("屏幕方向为竖屏, 默认Home键在右")
		init("0", 1)
		return
	elseif ret == 1 then
		if ver == "iOS" then
			print("屏幕方向为横屏，HOME键在右")
		elseif ver == "android" then
			print("屏幕方向为横屏")
		end
	elseif ret == 2 then
		print("屏幕方向为横屏，HOME键在左")
	else
		print("屏幕方向Unknow")
		lua_exit()
	end
	
	init("0", ret)
end

function onBeforeUserExit()
	stopAudio()
	
	if win_cnt.global > 0 or fail_cnt.global > 0 then
		settlement_UI()
	end
end

function show_win_fail(win_cnt, fail_cnt)
	HUD_show_or_hide(HUD,hud_info,string.format("战斗胜利 %d次 - 失败 %d次", win_cnt, fail_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
end

function print_global_config()
	print(string.format("悬赏封印：%d (勾玉：%d 体力：%d 金币：%d 猫粮：%d 狗粮：%d) 快速结算 %d, 断线/闪退 %d, 自动开启buff %d 停留过长关闭buff %d(%d sec), 体力用尽关闭buff %d)",
			offer_arr[1], offer_arr[2], offer_arr[3], offer_arr[4], offer_arr[5], offer_arr[6], turbo_settle_en, reconn, buff_start, buff_stop_idle, buff_stop_idle_time, buff_stop_useup))
	
	if auto_jjtp_en == 1 then
		print(string.format("智能突破 间隔 %d, 模式：%s，战斗时间：%d，刷新：%d，个人突破：%s，阴阳寮突破：%d, 锁定: %d",
				auto_jjtp_interv, auto_jjtp_mode, auto_jjtp_round_time, auto_jjtp_refresh, auto_jjtp_solo_sel, auto_jjtp_pub_sel, auto_jjtp_lock))
		print(string.format("五花肉 个人：(彼岸花 %d, 小僧 %d, 日和坊 %d, 御馔津 %d) 阴阳寮：(彼岸花 %d, 小僧 %d, 日和坊 %d, 御馔津 %d)",
				auto_jjtp_whr_solo[1], auto_jjtp_whr_solo[2], auto_jjtp_whr_solo[3], auto_jjtp_whr_solo[4],
				auto_jjtp_whr_pub[1], auto_jjtp_whr_pub[2], auto_jjtp_whr_pub[3], auto_jjtp_whr_pub[4]))
	end
	
	if sg_en == 1 then
		print(string.format("超鬼王: %d 鬼王选择 %s 强力追击 %d 标记 Boss %d 草人 %d 6星 %s 5星 %s 4星 %s 3星 %s 2星 %s 1星 %s",
				sg_en, sg_fight_sel, sg_force, sg_mark_sel[1], sg_mark_sel[2], sg_tired[6], sg_tired[5], sg_tired[4], sg_tired[3], sg_tired[2], sg_tired[1]))
		print(string.format("6星 high - %s low - %s 疲劳 - %s, 5星 high - %s low - %s 疲劳 - %s",
				sg_high[6], sg_low[6], sg_tired[6], sg_high[5], sg_low[5], sg_tired[5]))
		print(string.format("4星 high - %s low - %s 疲劳 - %s, 3星 high - %s low - %s 疲劳 - %s",
				sg_high[4], sg_low[4], sg_tired[4], sg_high[3], sg_low[3], sg_tired[3]))
		print(string.format("2星 high - %s low - %s 疲劳 - %s, 1星 high - %s low - %s 疲劳 - %s",
				sg_high[2], sg_low[2], sg_tired[2], sg_high[1], sg_low[1], sg_tired[1]))
	end
end

function receive_offer()
	local x, y, x_, y_
	x_, y_ = findColor({681, 167, 685, 171}, -- √ x 和 交接处
		"0|0|0xb39276,-1|29|0x9e7d62,71|209|0x50ad5b,74|295|0xd96c5a",
		90, 0, 0, 0)
	if (x_ > -1) then
		if (offer_arr[1] == 0) then
			HUD_show_or_hide(HUD,hud_info,"拒绝悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, 759, 460, 10, 10) -- 拒绝
		else
			if offer_arr[2] == 1 then
				x, y = findColor({614, 432, 616, 434},
					"0|0|0xed4a36,11|-21|0x67457c,-13|9|0xc7a98b,-30|17|0x8647c8",
					80, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_info,"接受勾玉悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			if offer_arr[3] == 1 then
				x, y = findColor({754, 376, 756, 378},
					"0|0|0x55b260,2|83|0xdd725f,-157|68|0x0d0f0b,-151|39|0xe97a2b",
					80, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_info,"接受体力悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			if offer_arr[4] == 1 then
				x, y = findColor({754, 376, 756, 378},
					"0|0|0x55b260,2|83|0xdd725f,-147|59|0x75671b,-166|48|0xddb64d",
					80, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_info,"接受金币悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			if offer_arr[5] == 1 then
				x, y = findColor({529, 451, 531, 453},
					"0|0|0x8b3028,-11|-8|0xf37b62,-10|-19|0xfdfeff,-9|-39|0x69467f",
					80, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_info,"接受猫粮悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			if offer_arr[6] == 1 then
				x, y = findColor({754, 376, 756, 378},
					"0|0|0x55b260,2|83|0xdd725f,-147|59|0x75671b,-243|44|0xfffbe9",
					80, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_info,"接受狗粮悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			random_touch(0, 759, 460, 10, 10) -- 拒绝
		end
	end
end

function disconn_dur_fight()
	local x, y = findColor({567, 376, 570, 379},
		"0|0|0xf1b15d,-180|-164|0xbba48a,172|-162|0xc3ac93,-5|50|0xb59f85",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"断线期间结束战斗",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, x, y, 20, 10)
	end
end

function game_disconn_reconn()
	if reconn == 0 then
		return RET_ERR
	end
	
	function game_disconn()
		local x, y = findColor({570, 360, 572, 362},
			"0|0|0xf3b25e,-55|-24|0x983c2e,-50|-19|0xf3b25e,-62|-32|0xcbb59c",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"重新连接",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, x, y, 20, 10) -- 重新连接
		end
		return x, y
	end
	
	function game_notice()
		local x, y = findColor({1080, 146, 1082, 148},
			"0|0|0xe8d4cf,2|-77|0x470c15,-7|-96|0x69504c,-1|-52|0x5a5756",
			90, 0, 0, 0)
		
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"关闭公告",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, x, y, 20, 10) -- 关闭
		end
		
		return x, y
	end
	
	function game_portal()
		local x, y = findColor({494, 124, 496, 126},
			"0|0|0xe0af86,119|-38|0xdc7746,140|151|0xf1d482,132|301|0xf9edac",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"进入服务器",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, 560, 550, 30, 10) -- 进入游戏
		end
		return x, y
	end
	
	function game_load()
		local x, y = findColor({857, 566, 859, 568},
			"0|0|0xe99e4f,-9|8|0xe4823f,-115|-49|0x690c2b,10|-164|0x76101b",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"进入游戏",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, 560, 550, 30, 10) -- 点击屏幕进入游戏
		end
		return x, y
	end
	
	local x, y
	local disconn = 0
	local notice = 0
	
	x, y = game_disconn() if x > -1 then disconn = 1 end
	x, y = game_notice() if x >-1 then notice = 1 end
	
	if (disconn == 0) and (notice == 0) then
		return RET_OK
	end
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 断开连接
			x, y = game_disconn() if x > -1 then break end
			-- 游戏入口
			x, y = game_portal() if x > -1 then break end
			-- 游戏载入
			x, y = game_load() if x > -1 then break end
			-- 游戏公告
			x, y = game_notice() if x > -1 then break end
			-- 庭院
			x, y = lct_tingyuan() if x > -1 then return RET_RECONN end
			break
		end
	end
	
	return RET_ERR
end

function loop_generic()
	local ret = 0
	-- 悬赏封印
	receive_offer()
	-- 断线结束战斗
	disconn_dur_fight()
	-- 断线重连
	ret = game_disconn_reconn()
	return ret
end

function real_baqidashe()
	local x, y = findColor({804, 182, 806, 184}, -- 大蛇图案
		"0|0|0x14fac5,-82|71|0x14fac5,-86|-69|0x14fac5,0|-16|0xffffff",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 973, 110, 5, 5) -- x
	end
	return x, y
end

function mysterious_vender()
	local x, y = findColor({989, 348, 991, 350}, -- 神秘商人
		"0|0|0xfdf6f5,-14|-23|0x6b4b4e,-20|92|0xe17871,52|79|0xfdfbfb",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 40, 45, 5, 5) -- <
	end
	return x, y
end

function close_channel()
	local x, y = findColor({570, 315, 580, 320},
		"0|0|0xc0ae8e,11|-32|0x513e2a,10|36|0x523e2a,-575|-294|0x76553e",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 5, 5)
	end
	return x, y
end

function out_of_sushi()
	local x, y, x_, y_
	x_, y_ = findColor({831, 171, 833, 173},
		"0|0|0xe8d4cf,-277|246|0xed4f3c,-313|138|0xeb7d30,-326|170|0x9446e7",
		95, 0, 0, 0)
	if x_ > -1 then
		random_touch(0, x_, y_, 5, 5)
		
		while (1) do
			while(1) do
				mSleep(500)
				-- 循环通用
				loop_generic()
				-- 八岐大蛇
				x, y = lct_8dashe() if x > -1 then random_touch(0, 930, 110, 5, 5) break end
				-- 创建队伍
				x, y = captain_room_create_window() if x > -1 then random_touch(0, 355, 525, 20, 10) break end
				-- 组队
				x, y = lct_zudui() if x > -1 then random_touch(0, 1060, 110, 5, 5) break end
				-- 探索场景
				x, y = lct_tansuo_scene() if x > -1 then random_touch(0, 45, 60, 5, 5) break end
				-- 退出场景
				x, y = scene_quit_confirm() if x > -1 then random_touch(0, x, y, 30, 5) break end
				-- 探索章节
				x, y = lct_tansuo_portal() if x > -1 then random_touch(0, 930, 135, 5, 5) break end
				-- 探索
				x, y = lct_tansuo()
				if x > -1 then
					stop_buff()
					lua_exit()
				end
				-- 庭院
				x, y = lct_tingyuan()
				if x > -1 then
					stop_buff()
					lua_exit()
				end
				break
			end
		end
	end
	return x_, y_
end

function right_lower_click()
	random_touch(0, 1040, 350, 50, 50)
	return
end

function disable_skill_feature()
	mSleep(1000)
	local x, y, x_, y_
	x, y = lct_tingyuan()
	if x > -1 then
		random_touch(0, 51, 62, 20, 20)
		random_sleep(1000)
		x_, y_ = findColor({790, 491, 793, 493},
			"0|0|0xffffff,-1|-12|0x4d5eea,216|-395|0xf2d3d1,190|26|0xe5cc9a",
			95, 0, 0, 0)
		if x_ > -1 then
			random_touch(0, x_, y_, 5, 5)
			random_sleep(1000)
		end
		random_touch(0, 1008, 97, 5, 5)
	end
end

function start_buff()
	function juexing_buff()
		local x, y = findColor({345, 120, 365, 400},
			"0|0|0x341e02,1|-8|0xf48204,17|11|0xe77600,0|15|0x321b01,334|4|0xb10b30",
			90, 0, 0, 0)
		return x, y
	end
	
	function yuhun_buff()
		local x, y = findColor({345, 120, 365, 400},
			"0|0|0x023131,-7|15|0x01d7e5,-2|-10|0x00d6e5,-8|5|0x023131,331|2|0xb10b30",
			90, 0, 0, 0)
		return x, y
	end
	
	function money_buff()
		local x, y = findColor({345, 120, 365, 400},
			"0|0|0xdeb74d,-14|5|0xcfc2b8,11|-8|0xebd7aa,5|8|0xf8e93b,330|1|0xb10b30",
			90, 0, 0, 0)
		return x, y
	end
	
	function exp_buff()
		local x, y = findColor({345, 120, 365, 400},
			"0|0|0xa3c0e4,-5|-14|0xbfdbf1,11|-18|0xbfdbf1,13|6|0xf7e733,338|-2|0xb10b30",
			90, 0, 0, 0)
		return x, y
	end
	
	local x_len = 380
	local x, y, x_, y_
	
	random_touch(0, 390, 50, 5, 5)
	mSleep(1000)
	
	x, y = findColor({295, 470, 297, 472},
		"0|0|0x7e7f6c,10|-21|0x838573,29|-37|0xb0a197,539|2|0x69705a",
		90, 0, 0, 0)
	if x > -1 then
		mSleep(1000)
		-- 觉醒
		if buff_sel[1] == 1 then
			x_, y_ = juexing_buff()
			if x_ > -1 then
				HUD_show_or_hide(HUD,hud_info,"开启觉醒Buff",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_touch(0, x_ + x_len, y_, 5, 20)
				mSleep(1000)
			end
		end
		-- 御魂
		if buff_sel[2] == 1 then
			x_, y_ = yuhun_buff()
			if x_ > -1 then
				HUD_show_or_hide(HUD,hud_info,"开启御魂Buff",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_touch(0, x_ + x_len, y_, 5, 20)
				mSleep(1000)
			end
		end
		-- 金币
		if buff_sel[3] == 1 then
			x_, y_ = money_buff()
			if x_ > -1 then
				HUD_show_or_hide(HUD,hud_info,"开启金币Buff",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_touch(0, x_ + x_len, y_, 5, 20)
				mSleep(1000)
			end
		end
		-- 经验
		if buff_sel[4] == 1 then
			-- 1st
			x_, y_ = exp_buff()
			if x_ > -1 then
				HUD_show_or_hide(HUD,hud_info,"开启经验Buff",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_touch(0, x_ + x_len, y_, 5, 20)
				mSleep(3000)
			end
			-- 2nd
			x_, y_ = exp_buff()
			if x_ > -1 then
				random_touch(0, x_ + x_len, y_, 5, 20)
			end
		end
		right_lower_click()
		mSleep(1000)
	end
end

function stop_buff()
	local buff_y = {136, 196, 256, 316, 376}
	local x, y, x_, y_
	
	random_touch(0, 390, 50, 5, 5)
	mSleep(1000)
	
	x, y = findColor({295, 470, 297, 472},
		"0|0|0x7e7f6c,10|-21|0x838573,29|-37|0xb0a197,539|2|0x69705a",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"关闭所有buff",20,"0xff000000","0xffffffff",0,100,0,300,32)
		mSleep(1000)
		for i = 1, 5 do
			x_, y_ = findColor({687, buff_y[i]-1, 689, buff_y[i]+1},
				"0|0|0xe08400,0|-7|0xe08400,0|8|0xe08400,-8|0|0xd9ccc2",
				90, 0, 0, 0)
			if x_ > -1 then
				random_touch(0, x_+50, y_, 10, 5)
				random_sleep(500)
			end
		end
		right_lower_click()
		mSleep(1000)
	end
end

function idle_at_tingyuan(idle_time_cnt)
	local time_cnt = 0
	local local_buff_stop_idle = 0
	local x, y
	
	-- Idle buff stop
	if buff_stop_idle == 1 then
		time_cnt = idle_time_cnt + 1
	end
	
	if time_cnt*500 > buff_stop_idle_time*1000 then
		stop_buff()
		buff_stop_idle = 0
	end
	
	return time_cnt
end

function idle_at_tansuo(idle_time_cnt)
	local time_cnt = 0
	local local_buff_stop_idle = 0
	local x, y
	
	-- Idle buff stop
	if buff_stop_idle == 1 then
		time_cnt = idle_time_cnt + 1
	end
	
	if time_cnt*500 > buff_stop_idle_time*1000 then
		stop_buff()
		buff_stop_idle = 0
	end
	
	return time_cnt
end

function stats_read()
	local stats_time = {first_date = "Unknown", total_dura = 0, last_date = "Unknown", last_dura = 0}
	local win_cnt_last = {yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0, yqfy = 0, battle = 0}
	local fail_cnt_last = {yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0, yqfy = 0, battle = 0}
	local win_cnt_total = {yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0, yqfy = 0, battle = 0}
	local fail_cnt_total = {yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0, yqfy = 0, battle = 0}
	
	stats_time.first_date = getStringConfig("script_first_start_date", "Unknown")
	stats_time.total_dura = getNumberConfig("script_total_run_duration", 0)
	stats_time.last_date = getStringConfig("script_last_start_date", "Unknown")
	stats_time.last_dura = getNumberConfig("script_last_run_duration", 0)
	
	win_cnt_last.yuhun = getNumberConfig("last_win_cnt_yuhun", 0)
	win_cnt_last.tansuo = getNumberConfig("last_win_cnt_tansuo", 0)
	win_cnt_last.jjtp = getNumberConfig("last_win_cnt_jjtp", 0)
	win_cnt_last.juexing = getNumberConfig("last_win_cnt_juexing", 0)
	win_cnt_last.yyh = getNumberConfig("last_win_cnt_yyh", 0)
	win_cnt_last.yuling = getNumberConfig("last_win_cnt_yuling", 0)
	win_cnt_last.yyh = getNumberConfig("last_win_cnt_yqfy", 0)
	win_cnt_last.yuling = getNumberConfig("last_win_cnt_battle", 0)
	fail_cnt_last.yuhun = getNumberConfig("last_fail_cnt_yuhun", 0)
	fail_cnt_last.tansuo = getNumberConfig("last_fail_cnt_tansuo", 0)
	fail_cnt_last.jjtp = getNumberConfig("last_fail_cnt_jjtp", 0)
	fail_cnt_last.juexing = getNumberConfig("last_fail_cnt_juexing", 0)
	fail_cnt_last.yyh = getNumberConfig("last_fail_cnt_yyh", 0)
	fail_cnt_last.yuling = getNumberConfig("last_fail_cnt_yuling", 0)
	fail_cnt_last.yyh = getNumberConfig("last_fail_cnt_yqfy", 0)
	fail_cnt_last.yuling = getNumberConfig("last_fail_cnt_battle", 0)
	win_cnt_total.yuhun = getNumberConfig("total_win_cnt_yuhun", 0)
	win_cnt_total.tansuo = getNumberConfig("total_win_cnt_tansuo", 0)
	win_cnt_total.jjtp = getNumberConfig("total_win_cnt_jjtp", 0)
	win_cnt_total.juexing = getNumberConfig("total_win_cnt_juexing", 0)
	win_cnt_total.yyh = getNumberConfig("total_win_cnt_yyh", 0)
	win_cnt_total.yuling = getNumberConfig("total_win_cnt_yuling", 0)
	win_cnt_total.yyh = getNumberConfig("total_win_cnt_yqfy", 0)
	win_cnt_total.yuling = getNumberConfig("total_win_cnt_battle", 0)
	fail_cnt_total.yuhun = getNumberConfig("total_fail_cnt_yuhun", 0)
	fail_cnt_total.tansuo = getNumberConfig("total_fail_cnt_tansuo", 0)
	fail_cnt_total.jjtp = getNumberConfig("total_fail_cnt_jjtp", 0)
	fail_cnt_total.juexing = getNumberConfig("total_fail_cnt_juexing", 0)
	fail_cnt_total.yyh = getNumberConfig("total_fail_cnt_yyh", 0)
	fail_cnt_total.yuling = getNumberConfig("total_fail_cnt_yuling", 0)
	fail_cnt_total.yyh = getNumberConfig("total_fail_cnt_yqfy", 0)
	fail_cnt_total.yuling = getNumberConfig("total_fail_cnt_battle", 0)
	
	return stats_time, win_cnt_last, fail_cnt_last, win_cnt_total, fail_cnt_total
end

function stats_write()
	local end_time
	local stats_time, win_cnt_last, fail_cnt_last, win_cnt_total, fail_cnt_total = stats_read()
	
	if win_cnt.global ~= 0 or fail_cnt.global ~= 0 then
		if stats_time.first_date == "Unknown" then
			setStringConfig("script_first_start_date", system_date)
		end
		end_time = mTime()
		setNumberConfig("script_total_run_duration", (stats_time.total_dura + end_time - start_time))
		setStringConfig("script_last_start_date", system_date)
		setNumberConfig("script_last_run_duration", (end_time - start_time))
		
		setNumberConfig("last_win_cnt_yuhun", win_cnt.yuhun)
		setNumberConfig("last_win_cnt_tansuo", win_cnt.tansuo)
		setNumberConfig("last_win_cnt_jjtp", win_cnt.jjtp)
		setNumberConfig("last_win_cnt_juexing", win_cnt.juexing)
		setNumberConfig("last_win_cnt_yyh", win_cnt.yyh)
		setNumberConfig("last_win_cnt_yuling", win_cnt.yuling)
		setNumberConfig("last_win_cnt_yqfy", win_cnt.yqfy)
		setNumberConfig("last_win_cnt_battle", win_cnt.battle)
		setNumberConfig("last_fail_cnt_yuhun", fail_cnt.yuhun)
		setNumberConfig("last_fail_cnt_tansuo", fail_cnt.tansuo)
		setNumberConfig("last_fail_cnt_jjtp", fail_cnt.jjtp)
		setNumberConfig("last_fail_cnt_juexing", fail_cnt.juexing)
		setNumberConfig("last_fail_cnt_yyh", fail_cnt.yyh)
		setNumberConfig("last_fail_cnt_yuling", fail_cnt.yuling)
		setNumberConfig("last_fail_cnt_yqfy", fail_cnt.yqfy)
		setNumberConfig("last_fail_cnt_battle", fail_cnt.battle)
		setNumberConfig("total_win_cnt_yuhun", (win_cnt_total.yuhun + win_cnt.yuhun))
		setNumberConfig("total_win_cnt_tansuo", (win_cnt_total.tansuo + win_cnt.tansuo))
		setNumberConfig("total_win_cnt_jjtp", (win_cnt_total.jjtp + win_cnt.jjtp))
		setNumberConfig("total_win_cnt_juexing", (win_cnt_total.juexing + win_cnt.juexing))
		setNumberConfig("total_win_cnt_yyh", (win_cnt_total.yyh + win_cnt.yyh))
		setNumberConfig("total_win_cnt_yuling", (win_cnt_total.yuling + win_cnt.yuling))
		setNumberConfig("total_win_cnt_yqfy", (win_cnt_total.yqfy + win_cnt.yqfy))
		setNumberConfig("total_win_cnt_battle", (win_cnt_total.battle + win_cnt.battle))
		setNumberConfig("total_fail_cnt_yuhun", (fail_cnt_total.yuhun + fail_cnt.yuhun))
		setNumberConfig("total_fail_cnt_tansuo", (fail_cnt_total.tansuo + fail_cnt.tansuo))
		setNumberConfig("total_fail_cnt_jjtp", (fail_cnt_total.jjtp + fail_cnt.jjtp))
		setNumberConfig("total_fail_cnt_juexing", (fail_cnt_total.juexing + fail_cnt.juexing))
		setNumberConfig("total_fail_cnt_yyh", (fail_cnt_total.yyh + fail_cnt.yyh))
		setNumberConfig("total_fail_cnt_yuling", (fail_cnt_total.yuling + fail_cnt.yuling))
		setNumberConfig("total_fail_cnt_yqfy", (fail_cnt_total.yqfy + fail_cnt.yqfy))
		setNumberConfig("total_fail_cnt_battle", (fail_cnt_total.battle + fail_cnt.battle))
	end
end

function alarm(op)
	local touchCount = 2
	local x_range, y_range
	
	x_range = width - math.floor(width/3)
	y_range = height - math.floor(height/3)
	
	for i = 1, 5 do
		playAudio("alarm.mp3")
		mSleep(500)
		stopAudio()
		mSleep(500)
	end
	if op == "pause" then
		while (1) do
			HUD_show_or_hide(HUD,hud_info,"暂停ing, 双击右上角继续",20,"0xff000000","0xffffffff",0,100,0,300,32)
			results = catchTouchPoint(touchCount)
			for i = 1, #results do
				sysLog("第"..i.."个坐标为:"..i..",x="..results[i].x..",y="..results[i].y)
			end
			if results[1].x > x_range and results[2].x > x_range and results[1].y > y_range and results[2].y > y_range then
				HUD_show_or_hide(HUD,hud_info,"继续运行",20,"0xff000000","0xffffffff",0,100,0,300,32)
				mSleep(1000)
				return RET_OK
			end
		end
	elseif op == "exit" then
		lua_exit()
	end
	
	return RET_ERR
end

function garbage_collect()
	local count
	
	collectgarbage("collect")
	count = collectgarbage("count")
	print(string.format("Execute collectgarbage, memory cost  - %d kb", count))
	setTimer(5*60*1000, garbage_collect)
end

function feed_paperman()
	local x, y = findColor({708, 422, 710, 424},
		"0|0|0xdabc69,-175|-14|0xfef3e6,-177|-19|0x93b464,-180|-29|0xfed5dc",
		95, 0, 0, 0)
	if x > -1 then
		right_lower_click()
	end
	return x, y
end

function get_bonus()
	local x, y = findColor({568, 380, 570, 382},
		"0|0|0xd73847,19|18|0xcab497,101|76|0xd19118,35|83|0xbb3a1a,483|-320|0x746b68,-423|102|0x53290e",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"领取奖励",20,"0xff000000","0xffffffff",0,100,0,300,32)
		jjtp_touch_blank()
		mSleep(1000)
	end
	return x, y
end

-- Locate & Enter func
function lct_tingyuan()
	local x, y, x_, y_
	x, y = findColor({1093, 35, 1095, 37},  -- 频道 邮件 加成
		"0|0|0xa29c7b,-77|-4|0xdfc7a1,-703|10|0xfddc8a,-710|35|0xf37f5b",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"庭院",20,"0xff000000","0xffffffff",0,100,0,300,32)
		-- 缩起的卷轴
		x_, y_ = findColor({1083, 545, 1085, 547},
			"0|0|0xe0d0cb,12|-15|0xecc891,-3|28|0x7e2513,-31|57|0xd4b17f",
			95, 0, 0, 0)
		if x_ > -1 then
			random_touch(0, x_, y_, 10, 10)
			mSleep(1000)
		end
	end
	return x, y
end

function lct_tansuo()
	local x, y = findColor({43, 50, 47, 54}, -- 探索返回
		"0|0|0xe0ecf9,-14|0|0xe6effa,4|-15|0xf0f5fb,34|-1|0x11215c",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"探索",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function lct_tingyuan_or_tansuo()
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

function lct_dingzhong()
	local x, y = findColor({770, 160, 820, 180}, -- 百鬼灯笼 庭院石碑 勾玉 勾玉加号
		"0|0|0xffffef,-49|-158|0xe87b2a,80|-144|0xd6c4a1,-84|-143|0xd6c4a1",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"町中",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y -- 百鬼灯笼
end

function lct_zudui()
	local x, y = findColor({851, 100, 853, 103},
		"0|0|0xe97c2c,-794|19|0xecd982,-774|91|0x8d7245,148|14|0xd6c4a1",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"组队",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function lct_channel()
	local x, y = findColorInRegionFuzzy(0xbfae8e, 95, 577, 316, 579, 318, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"世界频道",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function tingyuan_enter_tansuo()
	local x, y = findColor({230, 125, 1136, 175}, -- 探索灯笼
		"0|0|0xffffec,0|-2|0xffffec,0|2|0xffffd2,-2|0|0xffffe6,2|0|0xfffff1",
		95, 1, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 10, 10) -- 探索灯笼
	end
end

function tingyuan_enter_dingzhong()
	local x, y = findColor({450, 200, 1100, 400}, -- 町中石碑
		"0|0|0xc1b5a3,-22|-11|0xafaaaf,-21|23|0xa5a29e,23|23|0xa5a19c,23|-10|0xada7b2",
		90, 0, 1, 0)
	if x > -1 then
		random_touch(0, x, y, 10, 10) -- 町中石碑
	end
end

function tingyuan_enter_zudui()
	local x, y
	-- 打开的卷轴
	local x, y = findColor({1093, 35, 1095, 37},
		"0|0|0xa29c7b,-77|-4|0xdfc7a1,-703|10|0xfddc8a,-710|35|0xf37f5b",
		95, 0, 0, 0)
	if x > -1 then
		random_sleep(250)
		random_touch(0, 230, 560, 20, 20) -- 组队
	end
	return x, y
end

-- Fight func
function level_select(level, init, lock, spec)
	local function find_fifth_level()
		local x, y = findColor({340, 120, 360, 360},
			"0|0|0x312e2a,-11|-9|0x403c37,-14|-3|0x37332f,-17|0|0x534e49,-1|-7|0x49443f,2|5|0x4c4842,-9|7|0x4f4b45",
			85, 0, 1, 0)
		if x > -1 then
			random_touch(0, x, y, 50, 10)
		end
	end
	
	local function find_sixth_level()
		local x, y = findColor({340, 120, 360, 360},
			"0|0|0x4a4540,-6|-9|0x2f2b27,-17|-7|0x383530,-17|8|0x3f3b36,-10|7|0x423e39,-6|7|0x413d38,-1|8|0x4b4741,-1|4|0x2c2824",
			85, 0, 1, 0)
		if x > -1 then
			random_touch(0, x, y, 50, 10)
		end
	end
	
	local function find_seventh_level()
		local x, y = findColor({340, 120, 360, 360},
			"0|0|0x292622,8|-5|0x34302c,6|5|0x272420,7|-1|0x34312c,2|-11|0x58534d",
			85, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 50, 10)
		end
	end
	
	if (init == 1) then
		HUD_show_or_hide(HUD,hud_info,"层数 - 初始化",20,"0xff000000","0xffffffff",0,100,0,300,32)
		-- 选择层数
		if (level == 1) then
			random_move(0, 360, 150, 360, 500, 50, 10) -- 向下拉
			random_sleep(750)
			random_touch(0, 360, 150, 50, 10) -- 第一排
		elseif (level == 2) then
			random_move(0, 360, 150, 360, 500, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 215, 50, 10) -- 第二排
		elseif (level == 3) then
			random_move(0, 360, 150, 360, 500, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 280, 50, 10) -- 第三排
		elseif (level == 4) then
			random_move(0, 360, 150, 360, 500, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 350, 50, 10) -- 第四排
		elseif (level == 5) then
			random_move(0, 360, 150, 360, 500, 50, 10) -- 向下拉
			random_sleep(750)
			random_move(0, 360, 300, 360, 150, 50, 10) -- 向上拉
			random_sleep(750)
			find_fifth_level()
		elseif (level == 6) then
			random_move(0, 360, 150, 360, 500, 50, 10)
			random_sleep(750)
			random_move(0, 360, 300, 360, 150, 50, 10)
			random_sleep(750)
			find_sixth_level()
		elseif (level == 7) then
			if spec == "御魂" then
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_move(0, 360, 150, 360, 250, 50, 10)
				random_sleep(750)
				find_seventh_level()
			else
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_touch(0, 360, 150, 50, 10)
			end
		elseif (level == 8) then
			if spec == "御魂" then
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_touch(0, 360, 150, 50, 10)
			else
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_touch(0, 360, 215, 50, 10)
			end
		elseif (level == 9) then
			if spec == "御魂" then
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_touch(0, 360, 215, 50, 10)
			else
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_touch(0, 360, 280, 50, 10)
			end
		elseif (level == 10) then
			if spec == "御魂" then
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_touch(0, 360, 280, 50, 10)
			else
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_touch(0, 360, 350, 50, 10)
			end
		elseif (level == 11) then
			if spec == "御魂" then
				random_move(0, 360, 350, 360, 50, 50, 10)
				random_sleep(750)
				random_touch(0, 360, 350, 50, 10)
			end
		end
	end
	
	-- 锁定
	lock_or_unlock(lock, spec)
end

function lock_or_unlock(lock, spec)
	local x1, y1, x2, y2, x, y
	if spec == "御魂" then
		x1 = 638 y1 = 369 x2 = 640 y2 = 371
	elseif spec == "觉醒" then
		x1 = 638 y1 = 371 x2 = 640 y2 = 373
	elseif spec == "业原火" then
		x1 = 639 y1 = 368 x2 = 641 y2 = 369
	elseif spec == "御灵" then
		x1 = 639 y1 = 370 x2 = 641 y2 = 372
	elseif spec == "Solo结界突破" then
		x1 = 923 y1 = 548 x2 = 925 y2 = 550
	elseif spec == "Pub结界突破" then
		x1 = 190 y1 = 547 x2 = 192 y2 = 549
	elseif spec == "探索" then
		x1 = 750 y1 = 570 x2 = 760 y2 = 580
	end
	
	if (spec == "御魂" or spec == "觉醒" or spec == "业原火" or spec == "探索" or spec == "御灵") then
		if (lock == 1) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x735c41,11|1|0x2c2119,-11|0|0x2e231c,-1|5|0x291f19",
				90, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		else
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x725c40,0|-6|0x33271a,-13|1|0x9d93ce,13|1|0x9d95cd",
				90, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		end
		return x, y
	elseif (spec == "Solo结界突破") then
		if (lock == 1) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x806545,13|1|0x2f2318,-13|1|0x2f2318,-4|6|0x7c6242",
				95, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		else
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x866c49,0|7|0x1c150e,-16|0|0xb8acf1,16|0|0xb3aaec",
				95, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		end
		return x, y
	elseif (spec == "Pub结界突破") then
		if (lock == 1) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x806545,13|1|0x2f2318,-13|1|0x2f2318,-4|6|0x7c6242",
				95, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		else
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x846a48,16|1|0xb8aef2,-16|1|0xb7aff7,1|7|0x1f1610",
				95, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		end
		return x, y
	end
end

function solo_start()
	random_touch(0, 845, 440, 30, 10) -- 挑战
	mSleep(1000)
	local x, y = findColor({806, 441, 808, 443}, -- 挑战
		"0|0|0xf3b25e,75|0|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		return RET_ERR
	end
	return RET_OK
end

function group_start()
	random_touch(0, 575, 440, 30, 10)
end

function fight_ready()
	local x, y
	x, y = findColor({1036,486,1038,489},
		"0|0|0xd4ae7a,8|7|0xfff4d7,-50|78|0xdaae71,-51|60|0x731208",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"战斗准备",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, 1040, 493, 30, 30) -- 准备的鼓
		return x, y
	end
	return x, y
end

function fight_preset(index)
	local x, y = findColor({1035, 596, 1039, 599}, -- 准备的鼓的棒槌
		"0|0|0xe5c288,-62|17|0xebd19e,61|18|0xf0d8a9",
		95, 0, 0, 0)
	if (x > -1) then
		HUD_show_or_hide(HUD,hud_info,string.format("使用预设队伍%d", index),20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, 55, 610, 5, 5) -- 预设
		random_sleep(250)
		if index == 1 then
			random_touch(0, 230, 275, 50, 20) -- 队伍1
		elseif index == 2 then
			random_touch(0, 230, 380, 50, 20) -- 队伍2
		elseif index == 3 then
			random_touch(0, 230, 485, 50, 20) -- 队伍3
		end
		random_sleep(250)
		random_touch(0, 230, 610, 20, 10) -- 出战
		random_sleep(1000)
		random_touch(0, 1040, 493, 30, 30) -- 准备的鼓
	end
	return x, y
end

function round_one()
	local x, y = findColor({547, 313, 549, 315},
		"0|0|0x272420,-58|11|0x272420,-59|4|0xdcc096,5|27|0x272420",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"第一回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_two()
	local x, y = findColor({547, 313, 549, 315},
		"0|0|0x272420,-8|-1|0xdcba8b,-29|-5|0x272420,-17|20|0x272420",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"第二回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_three()
	local x, y = findColor({547, 313, 549, 315},
		"0|0|0x272420,-8|-1|0xdcba8b,-30|-7|0x272420,-17|27|0x272420",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"第三回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_fight()
	local x, y = findColor({574, 333, 576, 335},
		"0|0|0xe6c89b,-47|-82|0x030303,45|-75|0x030303,61|54|0x030303",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"战斗开始",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function manual_detect()
	local x, y = findColor({780, 632, 782, 634},
		"0|0|0xffffff,8|-4|0x05b4d4,3|-7|0x03b9e9,-3|-10|0x019dd2,-6|5|0x07b1b1",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"切换自动",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, 55, 590, 10, 10)
		mSleep(1000)
	end
	return x, y
end

function quit_confirm(sel)
	local x, y = findColor({658, 376, 660, 378},
		"0|0|0xf3b25e,-185|-3|0xdf6851,-65|-3|0xcbb59c,-119|-1|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		if sel == "确认" then
			random_touch(0, 660, 380, 20, 5)
		elseif sel == "取消" then
			random_touch(0, 475, 380, 20, 5)
		end
	end
	return x, y
end

function fight_ongoing()
	local function fight_6p()
		local x, y = findColor({27, 36, 29, 38},
			"0|0|0xd6c4a1,450|596|0xffffff,452|589|0x03b9ea,466|586|0x281918",
			95, 0, 0, 0)
		return x
	end
	
	local function fight_4p()
		local x, y = findColor({27, 36, 29, 38},
			"0|0|0xd6c4a1,652|596|0xffffff,655|589|0x03b8e9,669|586|0x281918",
			95, 0, 0, 0)
		return x
	end
	
	local function fight_3p()
		local x, y = findColor({27, 36, 29, 38},
			"0|0|0xd6c4a1,754|596|0xffffff,756|589|0x03b9e9,769|586|0x281918",
			95, 0, 0, 0)
		return x
	end
	
	local function fight_2p()
		local x, y = findColor({27, 36, 29, 38},
			"0|0|0xd6c4a1,855|596|0xffffff,857|589|0x03b9e9,870|586|0x281918",
			95, 0, 0, 0)
		return x
	end
	
	local p6 = fight_6p()
	local p4 = fight_4p()
	local p3 = fight_3p()
	local p2 = fight_2p()
	local flag = -1
	if p6 > -1 or p4 > -1 or p3 > -1 or p2 > -1 then
		flag = 0
	end
	
	if flag > -1 then
		if turbo_settle_en == 1 then
			turbo_settle = 1
		end
		local x, y = findColor({35, 514, 37, 516}, -- 指南针
			"0|0|0x29211b,-6|3|0xd3ad6a,-3|8|0x9c652b,6|-6|0xa97534,0|-6|0xd8b773",
			95, 0, 0, 0)
		if (x > -1) then
			random_touch(0, x, y, 10, 10) -- 指南针
		end
	end
	return flag, 0
end

function yuhun_overflow()
	local x, y = findColor({568, 376, 570, 378},
		"0|0|0xf3b25e,-54|-24|0x973b2e,52|20|0x963b2e,179|-163|0xc6b096,-182|42|0xcab49a",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 20, 5)
	end
	return x, y
end

function fight_success()
	function success_drum()
		local x, y = findColor({421, 75, 430, 145},
			"0|0|0x821c12,-24|43|0x9c1c12,27|40|0x9a1c12,297|26|0xd6be8d",
			95, 0, 0, 0)
		return x, y
	end
	
	function half_harma()
		local x, y = findColor({427, 541, 429, 543},
			"0|0|0x3a82c9,10|12|0x81aada,72|12|0x70290b,78|11|0x360204",
			90, 0, 0, 0)
		return x, y
	end
	
	function half_harma_loop()
		local x, y, x_, y_
		local cnt = math.random(8, 10)
		x, y = half_harma()
		if (x > -1) then
			HUD_show_or_hide(HUD,hud_info,"领取奖励",20,"0xff000000","0xffffffff",0,100,0,300,32)
			for i = 1, cnt do
				loop_generic()
				x_, y_ = half_harma()
				if x_ > -1 then
					right_lower_click()
				elseif x_ == -1 then
					return RET_OK
				end
				random_sleep(25)
			end
			return RET_OK
		end
		return RET_ERR
	end
	
	local x_s, y_s, x_h, y_h, ret
	local cnt = math.random(8, 10)
	
	x_s, y_s = success_drum()
	x_h, y_h = half_harma()
	
	if (x_s > -1 or x_h > -1) then
		HUD_show_or_hide(HUD,hud_info,"战斗胜利",20,"0xff000000","0xffffffff",0,100,0,300,32)
		for i = 1, cnt do
			loop_generic()
			ret = half_harma_loop()
			if ret == RET_OK then
				return RET_OK, RET_OK
			end
			yuhun_overflow()
			right_lower_click()
			random_sleep(25)
		end
		return RET_OK, RET_OK
	end
	return RET_ERR, RET_ERR
end

function fight_failed()
	function failed_drum()
		local x, y = findColor({410, 65, 415, 135},
			"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
			95, 0, 0, 0)
		return x, y
	end
	
	local x, y, x_f, y_f, ret
	local cnt = math.random(8, 10)
	
	x_f, y_f = failed_drum()
	
	if x_f > -1 then
		HUD_show_or_hide(HUD,hud_info,"战斗失败",20,"0xff000000","0xffffffff",0,100,0,300,32)
		for i = 1, cnt do
			loop_generic()
			x, y = failed_drum()
			if x > -1 then
				right_lower_click()
			elseif x == -1 then
				return RET_OK, RET_OK
			end
			random_sleep(25)
		end
		return RET_OK, RET_OK
	end
	return RET_ERR, RET_ERR
end

function fight_settle(mode)
	function fight_turbo(mode)
		local x, y
		local cnt
		
		if mode == "探索" then
			cnt = 8
		else
			cnt = 6
		end
		
		if turbo_settle_en == 1 then
			x, y = fight_ongoing()
			
			if x == -1 and turbo_settle == 1 then
				HUD_show_or_hide(HUD,hud_info,"战斗结束快速结算",20,"0xff000000","0xffffffff",0,100,0,300,32)
				turbo_settle = 0
				for i = 1, cnt do
					loop_generic()
					yuhun_overflow()
					right_lower_click()
					random_sleep(25)
				end
				return RET_OK
			end
		end
		return RET_ERR
	end
	
	local ret, x_s, y_s, x_f, y_f
	
	ret = fight_turbo(mode)
	mSleep(1000)
	x_s, y_s = fight_success()
	x_f, y_f = fight_failed()
	
	if ret == RET_OK then
		if x_s > -1 then
			return RET_OK, RET_OK, "Success"
		else
			return RET_OK, RET_OK, "Failed"
		end
	else
		if x_s > -1 then
			return RET_OK, RET_OK, "Success"
		elseif x_f > -1 then
			return RET_OK, RET_OK, "Failed"
		else
			return RET_ERR, RET_ERR, "Null"
		end
	end
end

function fight_stop_auto_group()
	local x, y = findColor({65, 120, 75, 310}, -- 有√的头像
		"0|0|0xedc790,-1|-13|0x372827,-11|9|0x3f3126,10|5|0xe9c38c",
		90, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 10, 10)
		random_sleep(250)
		random_touch(0, x + 150, y, 50, 10)
		random_sleep(250)
		random_touch(0, x + 150, y, 50, 10)
		random_sleep(250)
		random_touch(0, x, y, 10, 10)
	end
	return x, y
end

-- Member & Captain func
function member_user_profile()
	local x, y
	-- 探索队员
	x, y = findColor({110, 130, 115, 135},
		"0|0|0x7c5d4d,-7|-16|0x6d6e4c,3|-7|0x3d2621,12|3|0x5d463c,9|20|0xcfb9a4",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 1100, 400, 20, 20)
	end
	-- 房间第一位队员
	x, y = findColor({480, 130, 485, 135},
		"0|0|0x7c5d4d,-7|-16|0x6d6e4c,3|-7|0x3d2621,12|3|0x5d463c,9|20|0xcfb9a4",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 1100, 400, 20, 20)
	end
	-- 房间第二位队员
	x, y = findColor({675, 130, 680, 135},
		"0|0|0x7c5d4d,-7|-16|0x6d6e4c,3|-7|0x3d2621,12|3|0x5d463c,9|20|0xcfb9a4",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 1100, 400, 20, 20)
	end
	
	return x, y
end

function member_room_init()
	local x, y = findColor({75, 181, 80, 185}, -- 左边红穗
		"0|0|0x8d7245,1|23|0x8d7245,-5|45|0xa02527,1|45|0xead49c",
		95, 0, 0, 0)
	return x, y
end

function member_room_find()
	random_touch(0, 440, 559, 20, 10) -- 刷新
	random_sleep(300)
	
	local top = {195, 287, 376, 466}
	local bottom = {200, 292, 381, 471}
	local left = 935
	local right = 940
	local arr = {}
	local x, y
	local cnt = math.random(1, 3)
	
	arr = getRandomList(4)
	
	for i = 1, 4 do
		pos = arr[i]
		x, y = findColor({left, top[pos], right, bottom[pos]}, -- 加入
			"0|0|0xe2bc54,-20|-12|0xefda8a,40|-14|0x744827,-1|14|0x754b2b",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"寻找队伍",20,"0xff000000","0xffffffff",0,100,0,300,32)
			for i = 1, cnt do
				random_touch(0, x, y, 10, 5) -- 加入
				random_sleep(100)
			end
			return
		end
	end
end

function member_room_quit()
	local x, y = findColor({669, 379, 679, 388}, -- 确定取消
		"0|0|0xf3b25e,66|1|0xf3b25e,-146|1|0xdf6851,-278|0|0xdf6851",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"退出队伍",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, x, y, 20, 10) -- 确定
	end
	return x, y
end

function member_room_find_start()
	local x, y = findColor({925, 535, 927, 537},  -- 开始战斗
		"0|0|0xf3b25e,-60|-11|0xf3b25e,-63|13|0xf3b25e,65|2|0xf3b25e",
		95, 0, 0, 0)
	return x, y
end

function member_team_accept_invite(auto)
	local x, y
	local x_auto, y_auto
	
	if ver == "iOS" then
		x, y = findColor({120, 225, 122, 460},
			"0|0|0x56b361,19|9|0x866f5a,-93|-16|0xdd6c59,-102|-5|0x826952",
			95, 0, 0, 0)
		if x > -1 then
			random_sleep(150)
			if (auto == 1) then
				x_auto, y_auto = findColor({205, 225, 210, 460}, -- 自动准备的按钮
					"0|0|0xedc791,0|13|0x5ab565,8|19|0x51ad5b,17|9|0x5bb665",
					90, 0, 0, 0)
				if x_auto > -1 then
					HUD_show_or_hide(HUD,hud_info,"收到自动组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, x_auto, y_auto, 5, 5) -- 自动准备的按钮
					return x, y, RET_OK
				end
			end
			HUD_show_or_hide(HUD,hud_info,"收到组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, x, y, 5, 5) -- √
			return x, y, RET_ERR
		end
	elseif ver == "android" then
		x, y = findColor({120, 225, 122, 460},
			"0|0|0x58b360,17|10|0xb7a796,-83|-5|0xdd6e5d,-104|-3|0xb49f87",
			95, 0, 0, 0)
		if x > -1 then
			random_sleep(150)
			if (auto == 1) then
				x_auto, y_auto = findColor({205, 225, 210, 440},
					"0|0|0xefc594,0|13|0x5ab563,19|9|0x61bc6a,20|20|0xb7a896",
					90, 0, 0, 0)
				if x_auto > -1 then
					HUD_show_or_hide(HUD,hud_info,"收到自动组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, x_auto, y_auto, 5, 5) -- 自动准备的按钮
					return x, y, RET_OK
				end
			end
			HUD_show_or_hide(HUD,hud_info,"收到组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, x, y, 5, 5) -- √
		end
	end
	return x, y, RET_ERR
end

function member_team_refuse_invite()
	local x = -1
	local y = -1
	
	if ver == "iOS" then
		x, y = findColor({37, 200, 42, 450},
			"0|0|0xdc6d5a,2|-19|0x866c57,-21|2|0x846b55,21|1|0x856c56",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"拒绝组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, x, y, 5, 5)
		end
	elseif ver == "android" then
		x, y = findColor({37, 200, 42, 450},
			"0|0|0xd66b5a,1|-21|0xb6a18e,71|-3|0x5bb664,100|-10|0x62bd6b",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"拒绝组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
			random_touch(0, x, y, 5, 5)
		end
	end
	return x, y
end

function captain_room_create_init()
	local x, y = findColor({927, 557, 929, 559},
		"0|0|0xf3b25e,133|-447|0xe8d4cf,-866|-439|0xe0c167,-855|-328|0xa52729",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"创建队伍",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, x, y, 20, 10)
		mSleep(1000)
	end
	return x, y
end

function captain_room_create_window()
	local x, y = findColor({777, 524, 779, 526},
		"0|0|0xf3b25e,-421|0|0xdf6851,282|-413|0x605755,-580|-471|0xe4768d",
		90, 0, 0, 0)
	return x, y
end

function captain_room_create_public()
	local x, y = captain_room_create_window()
	if x > -1 then
		mSleep(500)
		local x_, y_ = findColor({288, 451, 290, 453},
			"0|0|0x402f0e",
			95, 0, 0, 0)
		if x_ > -1 then
			random_touch(0, x_, y_, 3, 3)
		end
		random_touch(0, x, y, 20, 10) -- 创建
	end
	return x, y
end

function captain_room_create_private()
	local x, y = captain_room_create_window()
	if x > -1 then
		mSleep(500)
		local x_, y_ = findColor({673, 457, 675, 459},
			"0|0|0x402f11",
			95, 0, 0, 0)
		if x_ > -1 then
			random_touch(0, x_, y_, 3, 3)
		end
		random_touch(0, x, y, 20, 10) -- 创建
	end
	return x, y
end

function captain_room_invite_init()
	local x, y = findColor({926, 533, 928, 535}, -- 灰色的开始战斗 离开队伍 队员1 2
		"0|0|0xb0a9a1,-724|4|0xdf6851,-364|-216|0xa29b93,-62|-212|0xa29b93",
		95, 0, 0, 0)
	return x, y
end

function captain_room_invite_first(invite_zone)
	local x, y, x_, y_, x__, y__
	local cnt = 0
	x, y = findColor({685, 508, 687, 510},
		"0|0|0xf3b25e,158|-451|0xf5e0d9,-409|-440|0xe77d93,-239|1|0xdf6851",
		95, 0, 0, 0)
	if x > -1 then
		if invite_zone == 1 then
			x_, y_ = findColor({275, 69, 277, 71},
				"0|0|0xe9849a,43|52|0xa26b4e,128|53|0xa26b4e,172|441|0xdf6851",
				95, 0, 0, 0)
			if x_ > -1 then
				random_touch(0, 360, 110, 30, 10)
				mSleep(1000)
			end
		elseif invite_zone == 2 then
			x_, y_ = findColor({275, 69, 277, 71},
				"0|0|0xe9849a,145|53|0xa26b4e,232|53|0xa26b4e,172|441|0xdf6851",
				95, 0, 0, 0)
			if x_ > -1 then
				random_touch(0, 460, 110, 30, 10)
				mSleep(1000)
			end
		elseif invite_zone == 3 then
			x_, y_ = findColor({275, 69, 277, 71},
				"0|0|0xe9849a,248|53|0xa26b4e,334|53|0xa26b4e,172|441|0xdf6851",
				95, 0, 0, 0)
			if x_ > -1 then
				random_touch(0, 560, 110, 30, 10)
				mSleep(1000)
			end
		end
		
		while (1) do
			-- 已选中
			if ver == "iOS" then
				x__, y__ = findColor({452, 201, 454, 204},
					"0|0|0xa3d0ce,234|310|0xf3b25e,-7|307|0xdf6851,-181|-132|0xe2758c",
					95, 0, 0, 0)
				if x__ > -1 then
					random_sleep(250)
					random_touch(0, x, y, 20, 10) -- 邀请
					return x__, y__
				end
			elseif ver == "android" then
				x__, y__ = findColor({452, 201, 454, 204},
					"0|0|0xcbcbb4,233|307|0xf4b25f,-5|309|0xdd6951,391|-144|0xf8e0d8",
					95, 0, 0, 0)
				if x__ > -1 then
					random_sleep(250)
					random_touch(0, x, y, 20, 10) -- 邀请
					return x__, y__
				end
			end
			-- 未选中
			x__, y__ = findColor({452, 201, 454, 204},
				"0|0|0xeac7a0,234|310|0xf3b25e,-7|307|0xdf6851,-181|-132|0xe2758c",
				95, 0, 0, 0)
			if x__ > -1 then
				random_touch(0, 440, 205, 40, 20) -- 第一位好友
				random_sleep(250)
				random_touch(0, x, y, 20, 10) -- 邀请
				return x__, y__
			end
			cnt = cnt + 1
			if cnt >= 10 then
				HUD_show_or_hide(HUD,hud_info,"没有找到在线好友",20,"0xff000000","0xffffffff",0,100,0,300,32)
				right_lower_click()
				return x__, y__
			end
			mSleep(1000)
		end
	end
	return x, y
end

function captain_room_start_with_1_members()
	local x, y = findColor({925, 535, 927, 537},  -- 开始战斗
		"0|0|0xf3b25e,-60|-11|0xf3b25e,-63|13|0xf3b25e,65|2|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		random_sleep(500)
		random_touch(0, x, y, 20, 10)
	end
	return x, y
end

function captain_room_start_with_2_members()
	local x, y = findColor({925, 532, 928, 535}, -- 开始战斗， 离开队伍
		"0|0|0xf3b25e,-723|2|0xdf6851,66|0|0xf3b25e,-657|1|0xdf6851",
		95, 0, 0, 0)
	if x > -1 then
		local x_, y_ = findColor({922, 440, 924, 442}, -- 右边邀请
			"0|0|0x31251a,24|-21|0x433527,34|-33|0xdbbf68,-8|-15|0xe1cd8d",
			95, 0, 0, 0)
		if x_ == -1 then
			random_sleep(500)
			random_touch(0, x, y, 20, 10) -- 开始战斗
		end
	end
	return x, y
end

function captain_team_lost_invite()
	local x, y = findColor({672, 380, 675, 382}, -- 确定取消失败的鼓失败
		"0|0|0xf3b25e,-212|-1|0xdf6851,-256|-303|0x242028,-24|-283|0x4f4c46",
		95, 0, 0, 0)
	return x, y
end

function captain_team_win_invite()
	local x, y = findColor({671, 383, 673, 385}, -- 确定取消左右上角
		"0|0|0xf3b25e,-212|-1|0xdf6851,-292|-161|0xcbb59c,77|-154|0xcbb59c",
		95, 0, 0, 0)
	return x, y
end

function captain_team_set_auto_invite()
	local x, y
	
	if ver == "iOS" then
		x, y = findColor({496, 317, 498, 319},
			"0|0|0x73604d,-85|65|0xdf6851,74|65|0xcbb59c,226|66|0xf3b25e",
			95, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 3, 3) -- 勾选
		end
	elseif ver == "android" then
		x, y = findColor({496, 317, 498, 319},
			"0|0|0x9d8771,-35|63|0xdd6951,177|64|0xf4b25f,75|62|0xccb49b",
			95, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 3, 3) -- 勾选
		end
	end
	return x, y
end