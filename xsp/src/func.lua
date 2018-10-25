require "util"

-- Some func
function script_init()
	local ret = getScreenDirection()
	
	if ret == 0 then
		print("屏幕方向为竖屏, 默认Home键在右")
		init("0", 1)
		return
	elseif ret == 1 then
		ver = getOSType()
		if ver == "iOS" then
			print("屏幕方向为横屏，HOME键在右")
		elseif ver == "android" then
			print("屏幕方向为横屏")
		end
	elseif ret == 2 then
		print("屏幕方向为横屏，HOME键在左")
	else
		print("屏幕方向Unknow")
		UI:show(direct_err_ui)
		lua_exit()
	end
	
	init("0", ret)
end

function show_win_fail(win_cnt, fail_cnt)
	HUD_show_or_hide(HUD,hud_scene,string.format("战斗胜利 %d次 - 失败 %d次", win_cnt, fail_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
end

function print_global_vars()
	print(string.format("悬赏封印：%d (勾玉：%d 体力：%d 金币：%d 猫粮：%d 狗粮：%d)",
			offer_arr[1], offer_arr[2], offer_arr[3], offer_arr[4], offer_arr[5], offer_arr[6]))
	print(string.format("停留过长关闭buff %d(%d sec), 体力用尽关闭buff %d",
			buff_idle_stop, buff_idle_stop_time, buff_usup_stop))
end

function find_offer()
	local x, y, x_, y_
	x_, y_ = findColor({681, 167, 685, 171}, -- √ x 和 交接处
		"0|0|0xb39276,-1|29|0x9e7d62,71|209|0x50ad5b,74|295|0xd96c5a",
		95, 0, 0, 0)
	if (x_ > -1) then
		if (offer_arr[1] == 0) then
			HUD_show_or_hide(HUD,hud_scene,"拒绝悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
			ran_touch(0, 759, 460, 10, 10) -- 拒绝
		else
			if offer_arr[2] == 1 then
				x, y = findColor({614, 432, 616, 434},
					"0|0|0xed4a36,11|-21|0x67457c,-13|9|0xc7a98b,-30|17|0x8647c8",
					90, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_scene,"接受勾玉悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			if offer_arr[3] == 1 then
				x, y = findColor({754, 376, 756, 378},
					"0|0|0x55b260,2|83|0xdd725f,-157|68|0x0d0f0b,-151|39|0xe97a2b",
					90, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_scene,"接受体力悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			if offer_arr[4] == 1 then
				x, y = findColor({754, 376, 756, 378},
					"0|0|0x55b260,2|83|0xdd725f,-147|59|0x75671b,-166|48|0xddb64d",
					90, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_scene,"接受金币悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			if offer_arr[5] == 1 then
				x, y = findColor({529, 451, 531, 453},
					"0|0|0x8b3028,-11|-8|0xf37b62,-10|-19|0xfdfeff,-9|-39|0x69467f",
					90, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_scene,"接受猫粮悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			if offer_arr[6] == 1 then
				x, y = findColor({754, 376, 756, 378},
					"0|0|0x55b260,2|83|0xdd725f,-147|59|0x75671b,-243|44|0xfffbe9",
					90, 0, 0, 0)
				if x > -1 then
					HUD_show_or_hide(HUD,hud_scene,"接受狗粮悬赏",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 759, 373, 10, 10) -- 接受
					return x_, y_
				end
			end
			ran_touch(0, 759, 460, 10, 10) -- 拒绝
		end
	end
	return x_, y_
end

function handle_error(disconn_fin, real_8dashe, secret_vender)
	local x, y
	if (disconn_fin == ENABLE) then
		x, y = findColor({567, 376, 570, 379},
			"0|0|0xf1b15d,-180|-164|0xbba48a,172|-162|0xc3ac93,-5|50|0xb59f85",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_scene,"断线期间结束战斗",20,"0xff000000","0xffffffff",0,100,0,300,32)
			ran_touch(0, x, y, 20, 10)
		end
	end
	if (real_8dashe == ENABLE) then
		x, y = findColor({804, 182, 806, 184}, -- 大蛇图案
			"0|0|0x14fac5,-82|71|0x14fac5,-86|-69|0x14fac5,0|-16|0xffffff",
			95, 0, 0, 0)
		if x > -1 then
			ran_touch(0, 973, 110, 5, 5) -- x
		end
	end
	if (secret_vender == ENABLE) then
		x, y = findColor({989, 348, 991, 350}, -- 神秘商人
			"0|0|0xfdf6f5,-14|-23|0x6b4b4e,-20|92|0xe17871,52|79|0xfdfbfb",
			95, 0, 0, 0)
		if x > -1 then
			ran_touch(0, 40, 45, 5, 5) -- <
		end
	end
	return x, y
end

function level_select(level, init, lock, spec)
	mSleep(1000)
	if (init == ENABLE) then
		HUD_show_or_hide(HUD,hud_scene,"层数 - 初始化",20,"0xff000000","0xffffffff",0,100,0,300,32)
		-- 选择层数
		if (level == 1) then
			ran_move(0, 360, 150, 0, 200, 20) -- 向下拉
			ran_sleep(500)
			ran_touch(0, 360, 150, 120, 3) -- 第一排
		elseif (level == 2) then
			ran_move(0, 360, 150, 0, 200, 20)
			ran_sleep(500)
			ran_touch(0, 360, 215, 120, 3) -- 第二排
		elseif (level == 3) then
			ran_move(0, 360, 150, 0, 200, 20)
			ran_sleep(500)
			ran_touch(0, 360, 280, 120, 3) -- 第三排
		elseif (level == 4) then
			ran_move(0, 360, 150, 0, 200, 20)
			ran_sleep(500)
			ran_touch(0, 360, 350, 120, 3) -- 第四排
		elseif (level == 5) then
			ran_move(0, 360, 150, 0, 200, 20) -- 向下拉
			ran_sleep(1000)
			ran_move(0, 360, 280, 0, -100, 10) -- 向上拉
			ran_sleep(500)
			ran_touch(0, 360, 150, 120, 3)
		elseif (level == 6) then
			ran_move(0, 360, 150, 0, 200, 20)
			ran_sleep(1000)
			ran_move(0, 360, 280, 0, -100, 10)
			ran_sleep(500)
			ran_touch(0, 360, 215, 120, 3)
		elseif (level == 7) then
			ran_move(0, 360, 350, 0, -200, 20)
			ran_sleep(500)
			ran_touch(0, 360, 150, 120, 3)
		elseif (level == 8) then
			ran_move(0, 360, 350, 0, -200, 20)
			ran_sleep(500)
			ran_touch(0, 360, 215, 120, 3)
		elseif (level == 9) then
			ran_move(0, 360, 350, 0, -200, 20)
			ran_sleep(500)
			ran_touch(0, 360, 280, 120, 3)
		elseif (level == 10) then
			ran_move(0, 360, 350, 0, -200, 20)
			ran_sleep(500)
			ran_touch(0, 360, 350, 120, 3)
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
		x1 = 780 y1 = 376 x2 = 782 y2 = 378
	elseif spec == "御灵" then
		x1 = 552 y1 = 378 x2 = 554 y2 = 380
	elseif spec == "结界突破" then
		x1 = 917 y1 = 551 x2 = 919 y2 = 553
	elseif spec == "探索" then
		x1 = 750 y1 = 570 x2 = 760 y2 = 580
	end
	
	if (spec == "御魂" or spec == "觉醒" or spec == "业原火" or spec == "探索") then
		if (lock == ENABLE) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x735c41,11|1|0x2c2119,-11|0|0x2e231c,-1|5|0x291f19",
				95, 0, 0, 0)
			if x > -1 then
				ran_touch(0, x, y, 3, 3)
			end
		else
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x725c40,0|-6|0x33271a,-13|1|0x9d93ce,13|1|0x9d95cd",
				95, 0, 0, 0)
			if x > -1 then
				ran_touch(0, x, y, 3, 3)
			end
		end
		return x, y
	end
	
	if (spec == "御灵") then
		if (lock == ENABLE) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x886d49,0|5|0x241911,-13|0|0x2f2318,15|0|0x2f2318",
				95, 0, 0, 0)
			if x > -1 then
				ran_touch(0, x, y, 3, 3)
			end
		else
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x886e4a,0|7|0x1d150f,-17|0|0xb9adf4,17|0|0xb8aef2",
				95, 0, 0, 0)
			if x > -1 then
				ran_touch(0, x, y, 3, 3)
			end
		end
		return x, y
	end
	
	if (spec == "结界突破") then
		if (lock == ENABLE) then
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x826745,0|5|0x1f150e,-13|0|0x2f2318,13|1|0x2f2318",
				95, 0, 0, 0)
			if x > -1 then
				ran_touch(0, x, y, 3, 3)
			end
		else
			x, y = findColor({x1, y1, x2, y2},
				"0|0|0x866c49,0|7|0x1c150e,-16|0|0xb8acf1,16|0|0xb3aaec",
				95, 0, 0, 0)
			if x > -1 then
				ran_touch(0, x, y, 3, 3)
			end
		end
		return x, y
	end
end

function solo_start()
	ran_touch(0, 845, 440, 30, 10) -- 挑战
	mSleep(1000)
	local x, y = findColor({806, 441, 808, 443}, -- 挑战
		"0|0|0xf3b25e,75|0|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		return RET_ERR
	end
	return RET_OK
end

function disable_skill_feature()
	mSleep(1000)
	local x, y, x_, y_
	x, y = lct_tingyuan()
	if x > -1 then
		if dis_skl_fea == 1 then
			ran_touch(0, 51, 62, 20, 20)
			ran_sleep(750)
			x_, y_ = findColor({790, 492, 792, 493},
				"0|0|0x4b5ee9,214|-395|0xe8d4cf,221|39|0xe3af75",
				95, 0, 0, 0)
			if x_ > -1 then
				ran_touch(0, x_, y_, 5, 5)
				ran_sleep(750)
			end
			ran_touch(0, 1008, 97, 5, 5)
			dis_skl_fea = 0
		end
	end
end

-- Locate & enter func
function lct_tingyuan()
	local x, y = findColor({1093, 35, 1095, 37},  -- 频道 邮件 加成
		"0|0|0xa29c7b,-77|-4|0xdfc7a1,-703|10|0xfddc8a,-710|35|0xf37f5b",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"庭院",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function lct_tansuo()
	local x, y = findColor({43, 50, 47, 54}, -- 探索返回
		"0|0|0xe0ecf9,-14|0|0xe6effa,4|-15|0xf0f5fb,34|-1|0x11215c",
		95, 0, 0, 0)
	return x, y
end

function lct_zudui()
	local x, y = findColor({854, 100, 856, 102},
		"0|0|0xea7d2b,205|12|0xe8d4cf,-797|19|0xecd982,202|87|0x8d7245",
		90, 0, 0, 0)
	return x, y
end

function tingyuan_enter_tansuo()
	local x, y = findColor({230, 125, 1136, 175}, -- 庭院探索灯笼
		"0|0|0xffffec,0|-2|0xffffec,0|2|0xffffd2,-2|0|0xffffe6,2|0|0xfffff1",
		95, 1, 0, 0)
	if x > -1 then
		ran_touch(0, x, y, 10, 10) -- 探索灯笼
	end
end

function tingyuan_enter_zudui()
	local x, y = findColor({1093, 35, 1095, 37},
		"0|0|0xa29c7b,-77|-4|0xdfc7a1,-703|10|0xfddc8a,-710|35|0xf37f5b",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, 230, 560, 20, 20) -- 组队
	end
	return x, y
end

-- Fight func
function fight_ready()
	local x, y = findColor({1035, 596, 1039, 599}, -- 准备的鼓的棒槌
		"0|0|0xe5c288,-62|17|0xebd19e,61|18|0xf0d8a9",
		95, 0, 0, 0)
	if (x > -1) then
		-- HUD_show_or_hide(HUD,hud_scene,"战斗准备",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, 1040, 493, 30, 30) -- 准备的鼓
	end
	return x, y
end

function round_one()
	local x, y = findColor({519, 320, 526, 325}, -- 字 一
		"0|0|0x272420,0|-14|0xd9ba91,0|17|0xead0a3,126|10|0xdeaa70",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"第一回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_two()
	local x, y = findColor({519, 320, 526, 325}, -- 字 二
		"0|0|0xdcc096,-1|-11|0x272420,1|7|0x272420,124|11|0xdea86c",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"第二回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_three()
	local x, y = findColor({519, 320, 526, 325}, -- 字 三
		"0|0|0x272420,0|-13|0x272420,1|11|0x272420,126|14|0xdda669",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"第三回合",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function round_fight()
	local x, y = findColor({534, 288, 536, 290},
		"0|0|0x030303,44|-23|0x020202,84|81|0x020202,80|150|0x881509,-524|272|0x5d5575",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"战斗开始",20,"0xff000000","0xffffffff",0,100,0,300,32)
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
			ran_touch(0, 36, 514, 10, 10) -- 指南针
		end
	end
	return x, y
end

function right_bottom_click()
	ran_touch(0, 1040, 350, 50, 50) -- 右下空白
	return
end

function fight_success(mode)
	local cnt, x, y
	cnt = 3
	if mode == "组队" then
		x, y = findColor({417, 86, 426, 95}, -- 组队胜利的鼓
			"0|0|0x821c12,-24|43|0x9c1c12,27|40|0x9a1c12,297|26|0xd6be8d",
			95, 0, 0, 0)
		if (x > -1) then
			HUD_show_or_hide(HUD,hud_scene,"战斗胜利",20,"0xff000000","0xffffffff",0,100,0,300,32)
			for i = 1, cnt do
				right_bottom_click() -- 右下空白
				ran_interv()
			end
		end
		return x, y
	elseif mode == "单人" then
		x, y = findColor({421, 136, 430, 145}, -- 单人胜利的鼓
			"0|0|0x821c12,-24|43|0x9c1c12,27|40|0x9a1c12,297|26|0xd6be8d",
			95, 0, 0, 0)
		if (x > -1) then
			HUD_show_or_hide(HUD,hud_scene,"战斗胜利",20,"0xff000000","0xffffffff",0,100,0,300,32)
			for i = 1, cnt do
				right_bottom_click() -- 右下空白
				ran_interv()
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
		HUD_show_or_hide(HUD,hud_scene,"领取奖励",20,"0xff000000","0xffffffff",0,100,0,300,32)
		right_bottom_click() -- 右下空白
	end
	return x, y
end

function half_damo()
	local x, y = findColor({498, 529, 501, 532}, -- 达摩底部
		"0|0|0x670a0b,20|22|0x320204,127|0|0x7e0e0e,159|7|0x6f290b",
		95, 0, 0, 0)
	if (x > -1) then
		HUD_show_or_hide(HUD,hud_scene,"退出战斗",20,"0xff000000","0xffffffff",0,100,0,300,32)
		right_bottom_click() -- 右下空白
	end
	return x, y
end

function keep_half_damo()
	local x, y
	while (1) do
		find_offer()
		--captain_team_set_auto_invite(captain_auto_invite)
		x, y = findColor({498, 529, 501, 532}, -- 达摩底部
			"0|0|0x670a0b,20|22|0x320204,127|0|0x7e0e0e,159|7|0x6f290b",
			95, 0, 0, 0)
		if x > -1 then
			right_bottom_click() -- 右下空白
		elseif x == -1 then
			return
		end
		mSleep(500)
	end
end

function fight_failed(mode)
	local x, y
	if (mode == "单人") then
		x, y = findColor({410, 130, 415, 135}, -- 失败的鼓
			"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_scene,"战斗失败",20,"0xff000000","0xffffffff",0,100,0,300,32)
			right_bottom_click() -- 右下空白
		end
	elseif (mode == "组队") then
		x, y = findColor({410, 80, 415, 85}, -- 失败的鼓
			"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_scene,"战斗失败",20,"0xff000000","0xffffffff",0,100,0,300,32)
			right_bottom_click() -- 右下空白
		end
	end
	return x, y
end

function keep_fight_failed(mode)
	local x, y
	if (mode == "单人") then
		while (1) do
			find_offer()
			x, y = findColor({410, 130, 415, 135}, -- 失败的鼓
				"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
				95, 0, 0, 0)
			if x > -1 then
				right_bottom_click() -- 右下空白
			elseif x == -1 then
				return
			end
			mSleep(500)
		end
	elseif (mode == "组队") then
		while (1) do
			find_offer()
			x, y = findColor({410, 80, 415, 85}, -- 失败的鼓
				"0|0|0x524c5e,-19|37|0x5e5468,31|38|0x5b5265,234|24|0xbab2a4",
				95, 0, 0, 0)
			if x > -1 then
				right_bottom_click() -- 右下空白
			elseif x == -1 then
				return
			end
			mSleep(500)
		end
	end
end

function auto_check()
	local x, y = findColor({781, 631, 783, 633},
		"0|0|0xffffff,15|-9|0x281918,29|-26|0x281a19,3|-6|0x03b9e9",
		80, 0, 0, 0)
	if x > -1 then
		ran_touch(0, 55, 590, 20, 20)
	end
	return x, y
end

function yuhun_overflow()
	local x, y = findColor({568, 376, 570, 378},
		"0|0|0xf3b25e,-54|-24|0x973b2e,52|20|0x963b2e,179|-163|0xc6b096,-182|42|0xcab49a",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, x, y, 20, 5)
		mSleep(250)
		ran_interv()
		right_bottom_click()
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
	ran_touch(0, 440, 559, 20, 10) -- 刷新
	mSleep(250)
	ran_interv()
	
	local top = {195, 287, 376, 466}
	local bottom = {200, 292, 381, 471}
	local left = 935
	local right = 940
	local arr = {}
	local x, y
	
	arr = getRandomList(4)
	
	for i = 1, 4 do
		pos = arr[i]
		x, y = findColor({left, top[pos], right, bottom[pos]}, -- 加入
			"0|0|0xe2bc54,-20|-12|0xefda8a,40|-14|0x744827,-1|14|0x754b2b",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_scene,"寻找队伍",20,"0xff000000","0xffffffff",0,100,0,300,32)
			ran_touch(0, x, y, 10, 5) -- 加入
			return
		end
	end
end

function member_room_quit()
	local x, y = findColor({669, 379, 679, 388}, -- 确定取消
		"0|0|0xf3b25e,66|1|0xf3b25e,-146|1|0xdf6851,-278|0|0xdf6851",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"退出队伍",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 20, 10) -- 确定
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
	x, y = findColor({146, 338, 418, 537},
		"0|0|0x9d4939,720|-1|0xac7e42,381|-153|0xf3b25e,546|-152|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, 1100, 500, 20, 20) -- 右下空白
	end
	x, y = findColor({146, 338, 418, 537},
		"0|0|0x9d4939,720|-1|0xac7e42,578|-151|0xf3b25e,742|-151|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, 1100, 500, 20, 20) -- 右下空白
	end
	return x, y
end

function captain_room_init()
	local x, y = findColor({925, 555, 937, 567}, -- 创建队伍 and 右边红穗
		"0|0|0xf3b25e,133|-325|0xa52729,128|-362|0x8d7245,127|-327|0xead49c",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"创建队伍",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 20, 10)
	end
	return x, y
end

function captain_room_create_public()
	local x, y = findColor({775, 522, 780, 527}, -- 创建取消
		"0|0|0xf3b25e,-421|-1|0xdf6851,-64|0|0xcbb59c,-356|0|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		mSleep(500)
		local x_, y_ = findColor({273, 457, 275, 459}, -- 所有人选项
			"0|0|0x402f11",
			95, 0, 0, 0)
		if x_ > -1 then
			ran_touch(0, x_, y_, 3, 3)
		end
		ran_touch(0, x, y, 20, 10) -- 创建
	end
	return x, y
end

function captain_room_create_private()
	local x, y = findColor({775, 522, 780, 527}, -- 创建取消
		"0|0|0xf3b25e,-421|-1|0xdf6851,-64|0|0xcbb59c,-356|0|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		mSleep(500)
		local x_, y_ = findColor({673, 457, 675, 459}, -- 不公开
			"0|0|0x402f11",
			95, 0, 0, 0)
		if x_ > -1 then
			ran_touch(0, x_, y_, 3, 3)
		end
		ran_touch(0, x, y, 20, 10) -- 创建
	end
	return x, y
end

function captain_room_invite_init()
	local x, y = findColor({926, 533, 928, 535}, -- 灰色的开始战斗 离开队伍 队员1 2
		"0|0|0xb0a9a1,-724|4|0xdf6851,-364|-216|0xa29b93,-62|-212|0xa29b93",
		95, 0, 0, 0)
	return x, y
end

function captain_room_invite_first()
	local x, y = findColor({686, 511, 687, 513}, -- 邀请 取消 离开队伍
		"0|0|0xf3b25e,-241|-2|0xdf6851,-486|27|0xdf6851,-182|-294|0xcec6bc",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, 450, 215, 30, 10) -- 选择第一个好友
		ran_interv()
		ran_touch(0, 687, 512, 20, 10) -- 邀请
	end
	return x, y
end

function captain_room_start_with_1_members()
	local x, y = findColor({925, 535, 927, 537},  -- 开始战斗
		"0|0|0xf3b25e,-60|-11|0xf3b25e,-63|13|0xf3b25e,65|2|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		ran_sleep(1000)
		ran_touch(0, x, y, 20, 10)
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
			ran_sleep(1000)
			ran_touch(0, x, y, 20, 10) -- 开始战斗
		end
	end
	return x, y
end

function member_team_accept_invite(auto)
	local x, y
	local x_auto, y_auto
	-- IOS
	x, y = findColor({120, 200, 125, 450}, -- √
		"0|0|0x57b361,15|-13|0x63bc6e,-2|-20|0x876f5b,17|8|0x87705c",
		80, 0, 0, 0)
	if x > -1 then
		ran_interv()
		if (auto == 1) then
			x_auto, y_auto = findColor({205, 225, 210, 440}, -- 自动准备的按钮
				"0|0|0xedc791,0|13|0x5ab565,8|19|0x51ad5b,17|9|0x5bb665",
				80, 0, 0, 0)
			if x_auto > -1 then
				HUD_show_or_hide(HUD,hud_scene,"收到自动组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
				ran_touch(0, x_auto, y_auto, 5, 5) -- 自动准备的按钮
				return x, y, RET_OK
			end
		end
		HUD_show_or_hide(HUD,hud_scene,"收到组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 5, 5) -- √
		return x, y, RET_ERR
	end
	
	-- Android
	x, y = findColor({120, 200, 125, 450},
		"0|0|0x57b260,-82|-5|0xdc6958,-41|-4|0xdfceb5,1|-21|0xb7a796",
		90, 0, 0, 0)
	if x > -1 then
		ran_sleep(100)
		if (auto == 1) then
			x_auto, y_auto = findColor({205, 225, 210, 440},
				"0|0|0xefc594,0|13|0x5ab563,19|9|0x61bc6a,20|20|0xb7a896",
				90, 0, 0, 0)
			if x_auto > -1 then
				HUD_show_or_hide(HUD,hud_scene,"收到自动组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
				ran_touch(0, x_auto, y_auto, 5, 5) -- 自动准备的按钮
				return x, y, RET_OK
			end
		end
		HUD_show_or_hide(HUD,hud_scene,"收到组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 5, 5) -- √
	end
	
	return x, y, RET_ERR
end

function member_team_refuse_invite()
	local x, y = findColor({37, 200, 42, 450}, -- x
		"0|0|0xdc6d5a,2|-19|0x866c57,-21|2|0x846b55,21|1|0x856c56",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"拒绝组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 10, 10)
		mSleep(500)
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
	local x, y = findColor({496, 317, 498, 319},
		"0|0|0x73604d,-85|65|0xdf6851,74|65|0xcbb59c,226|66|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, x, y, 3, 3) -- 勾选
	end
	return x, y
end
