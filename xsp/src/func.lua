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
	print(string.format("悬赏封印：%d (勾玉：%d 体力：%d 金币：%d 猫粮：%d 狗粮：%d; 断线/闪退 %d, 停留过长关闭buff %d(%d sec), 体力用尽关闭buff %d)",
			offer_arr[1], offer_arr[2], offer_arr[3], offer_arr[4], offer_arr[5], offer_arr[6], reconn, buff_stop_idle, buff_stop_idle_time, buff_stop_useup))
	
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
		return
	end
	
	function game_disconn()
		local x, y = findColor({570, 360, 572, 362},
			"0|0|0xf3b25e,445|-329|0x5c5242,-180|-338|0x675531,31|-332|0x60160c",
			95, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 20, 10) -- 重新连接
		end
		return x, y
	end
	
	function game_notice()
		local x, y = findColor({1018, 69, 1020, 72},
			"0|0|0xe8d4cf,-424|-11|0xf7e9c3,-352|4|0x655447,-11|-41|0x7e6874",
			90, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 20, 10) -- 关闭
		end
		return x, y
	end
	
	function game_portal()
		local x, y = findColor({534, 562, 536, 564},
			"0|0|0x94adbc,-59|-459|0xffd8a6,-58|-480|0x8a272f,-369|-217|0xd17c5a,-346|-138|0xe7b674",
			90, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 30, 10) -- 进入游戏
		end
		return x, y
	end
	
	function game_load()
		local x, y = findColor({568, 550, 570, 552},
			"0|0|0x313b46,-144|-219|0xcac2dd,191|-455|0xd1c085,-143|-218|0xcac2dd",
			90, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 30, 10) -- 点击屏幕进入游戏
		end
		return x, y
	end
	
	local x, y
	local disconn = 0
	local notice = 0
	
	x, y = game_disconn() if x > -1 then disconn = 1 end
	x, y = game_notice() if x >-1 then notice = 1 end
	
	if (disconn == 0) and (notice == 0) then
		return
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
			x, y = lct_tingyuan() if x > -1 then return end
			break
		end
	end
	
	return
end

function loop_generic()
	-- 悬赏封印
	receive_offer()
	-- 断线结束战斗
	disconn_dur_fight()
	-- 断线重连
	game_disconn_reconn()
	return
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
					random_touch(0, 390, 50, 5, 5)
					mSleep(1500)
					stop_buff()
					lua_exit()
				end
				-- 庭院
				x, y = lct_tingyuan()
				if x > -1 then
					random_touch(0, 380, 60, 5, 5)
					mSleep(1500)
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
		random_sleep(750)
		x_, y_ = findColor({791, 491, 793, 493},
			"0|0|0xffffff,-1|-14|0x4b5ee9,9|-1|0x3b4bb9,215|-395|0xe8d4cf",
			95, 0, 0, 0)
		if x_ > -1 then
			random_touch(0, x_, y_, 5, 5)
			random_sleep(750)
		end
		random_touch(0, 1008, 97, 5, 5)
	end
end

function stop_buff()
	local x, y, x_, y_
	x, y = findColor({816, 469, 818, 471},
		"0|0|0x46533c,26|-8|0xac7b42,12|11|0xc1ab93,-19|12|0x2b3516",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"关闭buff",20,"0xff000000","0xffffffff",0,100,0,300,32)
		for i = 1, 5 do
			x_, y_ = findColor({794, 135, 796, 360},
				"0|0|0x412e2b,5|-7|0xe4c197,-5|8|0xd8b389,0|-15|0x382826,-1|22|0xcbb59c",
				90, 0, 0, 0)
			if x_ > -1 then
				random_touch(0, x_, y_, 5, 5)
				random_sleep(500)
			end
			random_sleep(250)
		end
	end
	right_lower_click()
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
		random_touch(0, 390, 50, 10, 10) -- 加成
		mSleep(1500)
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
		random_touch(0, 390, 60, 10, 5) -- 加成
		mSleep(1500)
		stop_buff()
		buff_stop_idle = 0
	end
	return time_cnt
end

function stats_read()
	local stats_time = {first_date = "Unknown", total_dura = 0, last_date = "Unknown", last_dura = 0}
	local win_cnt_last = {yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0}
	local fail_cnt_last = {yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0}
	local win_cnt_total = {yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0}
	local fail_cnt_total = {yuhun = 0, tansuo = 0, jjtp = 0, juexing = 0, yyh = 0, yuling = 0}
	
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
	fail_cnt_last.yuhun = getNumberConfig("last_fail_cnt_yuhun", 0)
	fail_cnt_last.tansuo = getNumberConfig("last_fail_cnt_tansuo", 0)
	fail_cnt_last.jjtp = getNumberConfig("last_fail_cnt_jjtp", 0)
	fail_cnt_last.juexing = getNumberConfig("last_fail_cnt_juexing", 0)
	fail_cnt_last.yyh = getNumberConfig("last_fail_cnt_yyh", 0)
	fail_cnt_last.yuling = getNumberConfig("last_fail_cnt_yuling", 0)
	win_cnt_total.yuhun = getNumberConfig("total_win_cnt_yuhun", 0)
	win_cnt_total.tansuo = getNumberConfig("total_win_cnt_tansuo", 0)
	win_cnt_total.jjtp = getNumberConfig("total_win_cnt_jjtp", 0)
	win_cnt_total.juexing = getNumberConfig("total_win_cnt_juexing", 0)
	win_cnt_total.yyh = getNumberConfig("total_win_cnt_yyh", 0)
	win_cnt_total.yuling = getNumberConfig("total_win_cnt_yuling", 0)
	fail_cnt_total.yuhun = getNumberConfig("total_fail_cnt_yuhun", 0)
	fail_cnt_total.tansuo = getNumberConfig("total_fail_cnt_tansuo", 0)
	fail_cnt_total.jjtp = getNumberConfig("total_fail_cnt_jjtp", 0)
	fail_cnt_total.juexing = getNumberConfig("total_fail_cnt_juexing", 0)
	fail_cnt_total.yyh = getNumberConfig("total_fail_cnt_yyh", 0)
	fail_cnt_total.yuling = getNumberConfig("total_fail_cnt_yuling", 0)
	
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
		setNumberConfig("last_fail_cnt_yuhun", fail_cnt.yuhun)
		setNumberConfig("last_fail_cnt_tansuo", fail_cnt.tansuo)
		setNumberConfig("last_fail_cnt_jjtp", fail_cnt.jjtp)
		setNumberConfig("last_fail_cnt_juexing", fail_cnt.juexing)
		setNumberConfig("last_fail_cnt_yyh", fail_cnt.yyh)
		setNumberConfig("last_fail_cnt_yuling", fail_cnt.yuling)
		setNumberConfig("total_win_cnt_yuhun", (win_cnt_total.yuhun + win_cnt.yuhun))
		setNumberConfig("total_win_cnt_tansuo", (win_cnt_total.tansuo + win_cnt.tansuo))
		setNumberConfig("total_win_cnt_jjtp", (win_cnt_total.jjtp + win_cnt.jjtp))
		setNumberConfig("total_win_cnt_juexing", (win_cnt_total.juexing + win_cnt.juexing))
		setNumberConfig("total_win_cnt_yyh", (win_cnt_total.yyh + win_cnt.yyh))
		setNumberConfig("total_win_cnt_yuling", (win_cnt_total.yuling + win_cnt.yuling))
		setNumberConfig("total_fail_cnt_yuhun", (fail_cnt_total.yuhun + fail_cnt.yuhun))
		setNumberConfig("total_fail_cnt_tansuo", (fail_cnt_total.tansuo + fail_cnt.tansuo))
		setNumberConfig("total_fail_cnt_jjtp", (fail_cnt_total.jjtp + fail_cnt.jjtp))
		setNumberConfig("total_fail_cnt_juexing", (fail_cnt_total.juexing + fail_cnt.juexing))
		setNumberConfig("total_fail_cnt_yyh", (fail_cnt_total.yyh + fail_cnt.yyh))
		setNumberConfig("total_fail_cnt_yuling", (fail_cnt_total.yuling + fail_cnt.yuling))
	end
end

function alarm(op)
	local touchCount = 2
	
	for i = 1, 5 do
		playAudio("alarm.mp3")
		mSleep(500)
		stopAudio()
		mSleep(500)
	end
	if op == "pause" then
		HUD_show_or_hide(HUD,hud_info,"暂停ing, 双击屏幕任意位置继续",20,"0xff000000","0xffffffff",0,100,0,300,32)
		results = catchTouchPoint(touchCount)
		return
	elseif op == "exit" then
		lua_exit()
	end
end

-- Locate & Enter func
function lct_tingyuan()
	local x, y = findColor({1093, 35, 1095, 37},  -- 频道 邮件 加成
		"0|0|0xa29c7b,-77|-4|0xdfc7a1,-703|10|0xfddc8a,-710|35|0xf37f5b",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"庭院",20,"0xff000000","0xffffffff",0,100,0,300,32)
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

function lct_dingzhong()
	local x, y = findColor({770, 160, 820, 180}, -- 百鬼灯笼 庭院石碑 勾玉 勾玉加号
		"0|0|0xfffff2,-199|-142|0xe9371f,122|45|0xb5afb9,80|-143|0xd6c4a1",
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
	-- 缩起的卷轴
	x, y = findColor({1083, 545, 1085, 547},
		"0|0|0xe0d0cb,12|-15|0xecc891,-3|28|0x7e2513,-31|57|0xd4b17f",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 10, 10)
	end
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
			80, 0, 1, 0)
		if x > -1 then
			random_touch(0, x, y, 50, 10)
		end
	end
	
	local function find_sixth_level()
		local x, y = findColor({340, 120, 360, 360},
			"0|0|0x4a4540,-6|-9|0x2f2b27,-17|-7|0x383530,-17|8|0x3f3b36,-10|7|0x423e39,-6|7|0x413d38,-1|8|0x4b4741,-1|4|0x2c2824",
			80, 0, 1, 0)
		if x > -1 then
			random_touch(0, x, y, 50, 10)
		end
	end
	
	if (init == 1) then
		HUD_show_or_hide(HUD,hud_info,"层数 - 初始化",20,"0xff000000","0xffffffff",0,100,0,300,32)
		-- 选择层数
		if (level == 1) then
			random_move(0, 360, 150, 360, 400, 50, 10) -- 向下拉
			random_sleep(750)
			random_touch(0, 360, 150, 50, 10) -- 第一排
		elseif (level == 2) then
			random_move(0, 360, 150, 360, 400, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 215, 50, 10) -- 第二排
		elseif (level == 3) then
			random_move(0, 360, 150, 360, 400, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 280, 50, 10) -- 第三排
		elseif (level == 4) then
			random_move(0, 360, 150, 360, 400, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 350, 50, 10) -- 第四排
		elseif (level == 5) then
			random_move(0, 360, 150, 360, 400, 50, 10) -- 向下拉
			random_sleep(750)
			random_move(0, 360, 300, 360, 150, 50, 10) -- 向上拉
			random_sleep(750)
			find_fifth_level()
		elseif (level == 6) then
			random_move(0, 360, 150, 360, 400, 50, 10) -- 向下拉
			random_sleep(750)
			random_move(0, 360, 300, 360, 150, 50, 10) -- 向上拉
			random_sleep(750)
			find_sixth_level()
		elseif (level == 7) then
			random_move(0, 360, 350, 360, 100, 50, 10) -- 向上拉
			random_sleep(750)
			random_touch(0, 360, 150, 50, 10)
		elseif (level == 8) then
			random_move(0, 360, 350, 360, 100, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 215, 50, 10)
		elseif (level == 9) then
			random_move(0, 360, 350, 360, 100, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 280, 50, 10)
		elseif (level == 10) then
			random_move(0, 360, 350, 360, 100, 50, 10)
			random_sleep(750)
			random_touch(0, 360, 350, 50, 10)
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
		x1 = 639 y1 = 369 x2 = 641 y2 = 371
	elseif spec == "御灵" then
		x1 = 552 y1 = 378 x2 = 554 y2 = 380
	elseif spec == "Solo结界突破" then
		x1 = 917 y1 = 551 x2 = 919 y2 = 553
	elseif spec == "Pub结界突破" then
		x1 = 190 y1 = 547 x2 = 192 y2 = 549
	elseif spec == "探索" then
		x1 = 750 y1 = 570 x2 = 760 y2 = 580
	end
	
	if (spec == "御魂" or spec == "觉醒" or spec == "业原火" or spec == "探索") then
		if (lock == 1) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x735c41,11|1|0x2c2119,-11|0|0x2e231c,-1|5|0x291f19",
				95, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		else
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x725c40,0|-6|0x33271a,-13|1|0x9d93ce,13|1|0x9d95cd",
				95, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		end
		return x, y
	elseif (spec == "御灵") then
		if (lock == 1) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x886d49,0|5|0x241911,-13|0|0x2f2318,15|0|0x2f2318",
				95, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		else
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x886e4a,0|7|0x1d150f,-17|0|0xb9adf4,17|0|0xb8aef2",
				95, 0, 0, 0)
			if x > -1 then
				random_touch(0, x, y, 3, 3)
			end
		end
		return x, y
	elseif (spec == "Solo结界突破") then
		if (lock == 1) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x826745,0|5|0x1f150e,-13|0|0x2f2318,13|1|0x2f2318",
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
	local x, y = findColor({1035, 596, 1039, 599}, -- 准备的鼓的棒槌
		"0|0|0xe5c288,-62|17|0xebd19e,61|18|0xf0d8a9",
		95, 0, 0, 0)
	if (x > -1) then
		HUD_show_or_hide(HUD,hud_info,"战斗开始",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, 1040, 493, 30, 30) -- 准备的鼓
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
	local x, y = findColor({519, 320, 526, 325}, -- 字 一
		"0|0|0x272420,0|-14|0xd9ba91,0|17|0xead0a3,126|10|0xdeaa70",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"第一回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_two()
	local x, y = findColor({519, 320, 526, 325}, -- 字 二
		"0|0|0xdcc096,-1|-11|0x272420,1|7|0x272420,124|11|0xdea86c",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"第二回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_three()
	local x, y = findColor({519, 320, 526, 325}, -- 字 三
		"0|0|0x272420,0|-13|0x272420,1|11|0x272420,126|14|0xdda669",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"第三回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_fight()
	local x, y = findColor({534, 288, 536, 290},
		"0|0|0x030303,44|-23|0x020202,84|81|0x020202,80|150|0x881509,-524|272|0x5d5575",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"战斗开始",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function fight_ongoing()
	local x, y = findColor({26, 36, 28, 38}, -- 云彩&返回
		"0|0|0xd6c4a1,-7|523|0x625a7c,-13|525|0x5b5374,-16|598|0x2f4633",
		80, 0, 0, 0)
	if (x > -1) then
		local x_1, y_1 = findColor({33, 513, 38, 517}, -- 指南针
			"0|0|0x1c1816,2|-6|0xe6cc8f,6|-12|0xe5d497,-7|10|0xdfbc85",
			95, 0, 0, 0)
		if (x_1 > -1) then
			random_touch(0, 36, 514, 10, 10) -- 指南针
		end
	end
	return x, y
end

function fight_success(mode)
	local cnt, x, y
	cnt = 3
	if mode == "组队" then
		x, y = findColor({417, 86, 426, 95}, -- 组队胜利的鼓
			"0|0|0x821c12,-24|43|0x9c1c12,27|40|0x9a1c12,297|26|0xd6be8d",
			95, 0, 0, 0)
		if (x > -1) then
			HUD_show_or_hide(HUD,hud_info,"战斗胜利",20,"0xff000000","0xffffffff",0,100,0,300,32)
			for i = 1, cnt do
				right_lower_click()
				random_sleep(150)
			end
		end
		return x, y
	elseif mode == "单人" then
		x, y = findColor({421, 136, 430, 145}, -- 单人胜利的鼓
			"0|0|0x821c12,-24|43|0x9c1c12,27|40|0x9a1c12,297|26|0xd6be8d",
			95, 0, 0, 0)
		if (x > -1) then
			HUD_show_or_hide(HUD,hud_info,"战斗胜利",20,"0xff000000","0xffffffff",0,100,0,300,32)
			for i = 1, cnt do
				right_lower_click()
				random_sleep(150)
			end
		end
		return x, y
	end
	return x, y
end

function whole_damo()
	local x, y = findColor({560, 369, 571, 376}, -- 达摩底部
		"0|0|0xaa7b2a,-52|61|0x340204,1|61|0x3b0305,76|55|0x370204",
		95, 0, 0, 0)
	if (x > -1) then
		HUD_show_or_hide(HUD,hud_info,"领取奖励",20,"0xff000000","0xffffffff",0,100,0,300,32)
		right_lower_click()
	end
	return x, y
end

function half_damo()
	local x, y = findColor({498, 529, 501, 532}, -- 达摩底部
		"0|0|0x670a0b,20|22|0x320204,127|0|0x7e0e0e,159|7|0x6f290b",
		95, 0, 0, 0)
	if (x > -1) then
		HUD_show_or_hide(HUD,hud_info,"退出战斗",20,"0xff000000","0xffffffff",0,100,0,300,32)
		right_lower_click()
	end
	return x, y
end

function keep_half_damo()
	local x, y
	while (1) do
		loop_generic()
		x, y = findColor({498, 529, 501, 532}, -- 达摩底部
			"0|0|0x670a0b,20|22|0x320204,127|0|0x7e0e0e,159|7|0x6f290b",
			95, 0, 0, 0)
		if x > -1 then
			right_lower_click()
		elseif x == -1 then
			return
		end
		random_sleep(100)
	end
end

function fight_failed(mode)
	local x, y
	if (mode == "单人") then
		x, y = findColor({410, 130, 415, 135}, -- 失败的鼓
			"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"战斗失败",20,"0xff000000","0xffffffff",0,100,0,300,32)
			right_lower_click()
		end
	elseif (mode == "组队") then
		x, y = findColor({410, 80, 415, 85}, -- 失败的鼓
			"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"战斗失败",20,"0xff000000","0xffffffff",0,100,0,300,32)
			right_lower_click()
		end
	end
	return x, y
end

function keep_fight_failed(mode)
	local x, y
	if (mode == "单人") then
		while (1) do
			loop_generic()
			x, y = findColor({410, 130, 415, 135}, -- 失败的鼓
				"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
				95, 0, 0, 0)
			if x > -1 then
				right_lower_click()
			elseif x == -1 then
				return
			end
			random_sleep(100)
		end
	elseif (mode == "组队") then
		while (1) do
			loop_generic()
			x, y = findColor({410, 80, 415, 85}, -- 失败的鼓
				"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
				95, 0, 0, 0)
			if x > -1 then
				right_lower_click()
			elseif x == -1 then
				return
			end
			random_sleep(100)
		end
	end
end

function yuhun_overflow()
	local x, y = findColor({568, 376, 570, 378},
		"0|0|0xf3b25e,-54|-24|0x973b2e,52|20|0x963b2e,179|-163|0xc6b096,-182|42|0xcab49a",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 20, 5)
		random_sleep(1000)
		right_lower_click()
	end
	return x, y
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

function member_room_user_profile()
	local x, y
	x, y = findColor({144, 532, 146, 534},
		"0|0|0x9d4939,352|-374|0xd2bda7,353|-40|0xcdb8a3,380|-213|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 360, 530, 20, 20)
	end
	x, y = findColor({144, 532, 146, 534},
		"0|0|0x9d4939,545|-378|0xd2bca6,546|-39|0xcab39e,577|-213|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 360, 530, 20, 20)
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
		local x_, y_ = findColor({273, 457, 275, 459}, -- 所有人选项
			"0|0|0x402f11",
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
		local x_, y_ = findColor({673, 457, 675, 459}, -- 不公开
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
	x, y = findColor({685, 508, 687, 510},
		"0|0|0xf3b25e,158|-451|0xf5e0d9,-409|-440|0xe77d93,-239|1|0xdf6851",
		95, 0, 0, 0)
	if x > -1 then
		mSleep(500)
		if invite_zone == 1 then
			x_, y_ = findColor({364, 94, 366, 96},
				"0|0|0x8a553f,-46|-13|0xa36b4e,36|-13|0xa26b4e,-93|-22|0xe2758c,479|-33|0xf4e0da",
				95, 0, 0, 0)
			if x_ > -1 then
				random_touch(0, x_, y_, 20, 5)
				mSleep(1000)
			end
		elseif invite_zone == 2 then
			x_, y_ = findColor({464, 94, 466, 96},
				"0|0|0x8b5640,-44|-15|0xa1694e,39|-16|0xa26b4e,-192|-25|0xe77c94,378|-37|0xf5e0d9",
				95, 0, 0, 0)
			if x_ > -1 then
				random_touch(0, x_, y_, 20, 5)
				mSleep(1000)
			end
		elseif invite_zone == 3 then
			x_, y_ = findColor({564, 94, 566, 96},
				"0|0|0x8a563e,-41|-16|0xa36b4e,43|-17|0xa26b4e,-293|-25|0xe2758c,279|-36|0xf4e0da",
				95, 0, 0, 0)
			if x_ > -1 then
				random_touch(0, x_, y_, 20, 5)
				mSleep(1000)
			end
		end
		
		for i = 1, 5 do
			-- 已选中
			if ver == "iOS" then
				x__, y__ = findColor({452, 201, 454, 204},
					"0|0|0xa3d0ce,234|310|0xf3b25e,-7|307|0xdf6851,-181|-132|0xe2758c",
					95, 0, 0, 0)
				if x__ > -1 then
					random_sleep(250)
					random_touch(0, x, y, 20, 10) -- 邀请
					return x, y
				end
			elseif ver == "android" then
				x__, y__ = findColor({452, 201, 454, 204},
					"0|0|0xcbcbb4,233|307|0xf4b25f,-5|309|0xdd6951,391|-144|0xf8e0d8",
					95, 0, 0, 0)
				if x__ > -1 then
					random_sleep(250)
					random_touch(0, x, y, 20, 10) -- 邀请
					return x, y
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
				return x, y
			end
			mSleep(1000)
		end
		HUD_show_or_hide(HUD,hud_info,"没有找到在线好友",20,"0xff000000","0xffffffff",0,100,0,300,32)
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
		x, y = findColor({927, 557, 929, 559},
			"0|0|0xf3b25e,133|-447|0xe8d4cf,-866|-439|0xe0c167,-855|-328|0xa52729",
			95, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 3, 3) -- 勾选
		end
	end
	return x, y
end