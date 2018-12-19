require "util"
require "func"

-- 超鬼王Global
sg_en = 0
sg_force = 0
sg_mark_sel = {0, 0}
sg_action = {0, 0, 0, 0, 0, 0}

-- Util func
function lct_sg_window()
	-- 识别弹窗
	local x, y, x_, y_
	x, y = findColor({24, 200, 26, 450}, -- 弹窗箭头
		"0|0|0xcf8d43,26|1|0x846e5c,273|-10|0xd3755c,354|-75|0x13100e,407|-30|0xe1dad1",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现超鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, x + 200, y, 50, 20) -- 点击弹窗
		return x, y
	end
	return x, y
end

function lct_sg_page()
	-- 识别超鬼王页面
	local x, y = findColor({419, 180, 421, 182},
		"0|0|0xa67a28,-37|-45|0xcd9f45,-365|-125|0xf0f5fb,8|-157|0x3d1f1e",
		95, 0, 0, 0)
	return x, y
end

function lct_sg_group()
	-- 识别超鬼王集结页面
	local x, y = findColor({844, 57, 846, 59},
		"0|0|0xf6dfd8,-573|12|0xe2758c,-408|-32|0x1c0c0c,27|483|0x625641,-791|-3|0x636567",
		95, 0, 0, 0)
	return x, y
end

function sg_mark(last_mark)
	-- 标记Boss&草人
	local cnt = math.random(1, 2)
	local x, y, x_, y_
	if sg_mark_sel[1] == 0 and sg_mark_sel[2] == 0 then
		return ""
	end
	if sg_mark_sel[1] == 1 and sg_mark_sel[2] == 0 then
		if last_mark ~= "Boss" then
			for i = 1, cnt do
				random_sleep(250)
				random_touch(0, 513, 79, 5, 5) -- 标记boss
			end
		end
		return "Boss"
	elseif sg_mark_sel[1] == 0 and sg_mark_Sel[2] == 1 then
		x, y = findColor({600, 190, 605, 220}, -- 丑女血条
			"0|0|0xaf0d0a,2|0|0xb10e0b,4|0|0xb30e0b,-569|-168|0xd6c4a1,-582|-176|0x211b0f",
			80, 0, 0, 0)
		if x > -1 then
			x_, y_ = findColor({610, 140, 660, 170}, -- 箭头
				"0|0|0xd41635,-7|0|0xc71e43,-22|-23|0xef45aa,15|-23|0xf65db9",
				80, 0, 0, 0)
			if x_ == -1 then
				for i = 1, cnt do
					random_sleep(250)
					random_touch(0, x+20, y+80, 5, 5) -- 标记草人
				end
			end
		end
		return "草人"
	elseif sg_mark_sel[1] == 1 and sg_mark_sel[2] == 1 then
		x_, y_ = findColor({610, 140, 660, 170}, -- 箭头
			"0|0|0xd41635,-7|0|0xc71e43,-22|-23|0xef45aa,15|-23|0xf65db9",
			80, 0, 0, 0)
		if x_ > -1 then
			return "草人"
		end
		x, y = findColor({600, 190, 605, 220}, -- 丑女血条
			"0|0|0xaf0d0a,2|0|0xb10e0b,4|0|0xb30e0b,-569|-168|0xd6c4a1,-582|-176|0x211b0f",
			80, 0, 0, 0)
		if x > -1 and last_mark ~= "草人" then
			for i = 1, cnt do
				random_sleep(250)
				random_touch(0, x+20, y+80, 5, 5) -- 标记草人
			end
			return "草人"
		end
		if last_mark ~= "Boss" then
			for i = 1, cnt do
				random_sleep(250)
				random_touch(0, 513, 79, 5, 5) -- 标记boss
			end
			return "Boss"
		end
		return "草人"
	end
	return ""
end

function find_sg_6(left, top, right, bot)
	-- 识别6星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a033,-11|0|0xf49f33,-22|0|0xf4a033,-6|-11|0xf1492d",
		95, 0, 0, 0)
	return x, y
end

function find_sg_5(left, top, right, bot)
	-- 识别5星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf79d2f,-11|0|0xf69d2f,-23|-32|0xa47e50",
		95, 0, 0, 0)
	return x, y
end

function find_sg_4(left, top, right, bot)
	-- 识别4星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a033,11|0|0xf49f33,-15|-26|0x906b87",
		95, 0, 0, 0)
	return x, y
end

function find_sg_3(left, top, right, bot)
	-- 识别3星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf6a031,11|0|0xf6a031,-22|-28|0x4e524e",
		95, 0, 0, 0)
	return x, y
end

function find_sg_2(left, top, right, bot)
	-- 识别2星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a033,11|0|0xf49f33,-22|-59|0xdf4d4b",
		95, 0, 0, 0)
	return x, y
end

function find_sg_1(left, top, right, bot)
	-- 识别1星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a432,-28|-59|0xdf4d4b,-10|-2|0xa08b82",
		95, 0, 0, 0)
	return x, y
end

function find_sg_start()
	-- 退治识别
	local x, y = findColor({1028, 534, 1030, 536},
		"0|0|0xe5c089,-37|5|0xd1e3f1,-32|12|0xe07c52,-19|23|0xccdfee",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	return RET_ERR
end

function sg_switch_mode(star)
	-- 普通或者强力追击切换
	local x, y
	x, y = findColor({706, 492, 708, 494},  -- 普通追击
		"0|0|0x402f11,-182|-7|0x4354d1,333|-400|0xe8d4cf,-601|-419|0x71090c",
		95, 0, 0, 0)
	if x > -1 then
		if star >= sg_force then
			random_touch(0, x, y, 5, 5) -- 选择强力
			return
		end
	end
	x, y = findColor({526, 490, 528, 492},  -- 强力追击
		"0|0|0x402f11,177|-4|0x475ade,515|-399|0xe8d4cf,-419|-416|0x6d090c",
		95, 0, 0, 0)
	if x > -1 then
		if star < sg_force then
			random_touch(0, x, y, 5, 5) -- 选择普通
			return
		end
	end
	return
end

function sg_fight_failed()
	-- 战斗失败的超鬼王识别
	local x, y = findColor({413, 104, 415, 106},
		"0|0|0x514a5b,251|6|0xddd9cd,-135|-6|0xcdc59c,30|34|0x5b5265",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"战斗失败",20,"0xff000000","0xffffffff",0,100,0,300,32)
		lower_right_blank_click()
	end
	return x, y
end

function sg_keep_fight_failed()
	-- 保持战斗失败的超鬼王识别
	local x, y
	while (1) do
		receive_offer()
		x, y = findColor({413, 104, 415, 106},
			"0|0|0x514a5b,251|6|0xddd9cd,-135|-6|0xcdc59c,30|34|0x5b5265",
			95, 0, 0, 0)
		if x > -1 then
			lower_right_blank_click()
		elseif x == -1 then
			return
		end
		mSleep(500)
	end
end

function sg_tired_detect()
	-- 识别疲劳窗口
	local x, y = findColor({567, 418, 569, 420},
		"0|0|0xf3b25e,-81|-109|0x414277,-9|0|0xeb3219",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"疲劳溢出",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function sg_group_invite()
	-- 邀请1 ~ 4位好友[Consider more options]
	random_touch(0, 450, 210, 20, 10) -- 1st
	random_sleep(250)
	random_touch(0, 700, 210, 20, 10) -- 2nd
	random_sleep(250)
	random_touch(0, 450, 300, 20, 10) -- 3rd
	random_sleep(250)
	random_touch(0, 700, 300, 20, 10) -- 4th
	random_sleep(250)
	random_touch(0, 690, 510, 20, 10) -- 邀请
end

-- Main func
function superghost()
	local x = -1
	local y = -1
	local x_f = -1
	local y_f = -1
	local ret = 0
	local sg_curr = 0
	local fight_en = 0
	local last_mark = ""
	local tired_op = ""
	local time_cnt_en = 1
	local time_cnt = 0
	local sg_window = 0
	local sg_page = 0
	local real_8dashe = 0
	local secret_vender = 0
	
	if sg_en == 0 then
		return RET_ERR
	end
	
	-- 超鬼王识别
	x, y = lct_sg_window() if x > -1 then sg_window = 1 end
	x, y = lct_sg_page() if x > -1 then sg_page = 1 end
	if (sg_window == 0) and (sg_page == 0) then
		return RET_ERR
	end
	
	HUD_show_or_hide(HUD,hud_info,string.format("超鬼王", win_cnt, fail_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 弹窗
			x, y = lct_sg_window() if x > -1 then break end
			-- 悬赏封印
			x, y = receive_offer() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then last_mark = sg_mark(last_mark) mSleep(3000) break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗失败
			x, y = sg_fight_failed() if (x > -1) then
				sg_keep_fight_failed()
				break
			end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				keep_half_damo()
				break
			end
			-- 疲劳溢出
			x, y = sg_tired_detect()
			if x > -1 then
				random_touch(0, 831, 173, 5, 5) -- 关闭
				mSleep(5*60*1000) -- 等待
				break
			end
			-- 超鬼王页面
			x, y = lct_sg_page()
			if x > -1 then
				random_sleep(1500)
				ret = find_sg_start()
				if ret == RET_OK then
					random_touch(0, 1030, 540, 20, 20) -- 退治
				else
					random_touch(0, 60, 55, 5, 5) -- 退出
					return RET_OK
				end
				break
			end
			-- Handle error
			x, y = handle_error(real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_ERR
end
