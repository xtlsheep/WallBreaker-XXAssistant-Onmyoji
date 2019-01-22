require "util"
require "func"

-- Def
local solo_ana_x = {392, 698, 1002}
local solo_ana_y = {164, 284, 403}
local solo_ana_metal_x_diff = {169, 134, 99, 64, 28}
local solo_center_x = {300, 600, 900, 300, 600, 900, 300, 600, 900}
local solo_center_y = {135, 135, 135, 255, 255, 255, 375, 375, 375}
local solo_whr_x1 = {121, 426, 732, 121, 426, 732, 121, 426, 732}
local solo_whr_y1 = {205, 205, 205, 323, 323, 323, 445, 445, 445}
local solo_whr_x2 = {405, 711, 1017, 405, 711, 1017, 405, 711, 1017}
local solo_whr_y2 = {254, 254, 254, 376, 376, 376, 495, 495, 495}
local solo_fight_x = {333, 639, 942, 333, 639, 942, 333, 639, 942}
local solo_fight_y = {300, 300, 300, 420, 420, 420, 540, 540, 540}

local pub_ana_metal_x = {540, 840, 540, 840, 540, 840, 540, 840}
local pub_ana_metal_y1 = {130, 130, 250, 250, 370, 370, 490, 490}
local pub_ana_metal_y2 = {240, 240, 360, 360, 480, 480, 600, 600}
local pub_mid_metal_ff_x_diff = 100
local pub_mid_metal_ff_y_diff = -35

-- Util func
function find_whr(pos, whr, role)
	local x, y, x1, x2, y1, y2
	if (pos == -1) then
		return RET_ERR
	end
	
	mSleep(1000)
	
	if (role == "solo") then
		x, y = findColor({solo_fight_x[pos]-1, solo_fight_y[pos]-1, solo_fight_x[pos]+1, solo_fight_y[pos]+1}, -- 进攻
			"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
			95, 0, 0, 0)
		if x == -1 then
			return RET_ERR
		end
		x1 = solo_whr_x1[pos]
		x2 = solo_whr_x2[pos]
		y1 = solo_whr_y1[pos]
		y2 = solo_whr_y2[pos]
	elseif (role == "public") then
		if pos%2 == 1 then
			x1 = 375
			y1 = 155
			x2 = 655
			y2 = 610
		else
			x1 = 675
			y1 = 155
			x2 = 955
			y2 = 610
		end
	end
	
	if (whr[1] == 1) then
		-- 彼岸花原皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf2deda,3|10|0xe1ab8e,9|-16|0x4b4a49,-6|-3|0x262728",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"彼岸花原皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 彼岸花觉醒皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0x2b2331,0|4|0xf9e5d6,9|-1|0xb82321,19|4|0xdbdbe5",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"彼岸花觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 彼岸花商店皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf9f7f5,-3|-13|0xdaced0,12|-1|0x741319,-2|9|0x941f26,-16|0|0xa88150,9|0|0x968e92",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"彼岸花商店皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 彼岸花秘闻皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf9f7f5,5|2|0xf7f1f0,10|-1|0xa79fa2,13|-15|0xceae4e,-2|-11|0xdbced1",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"彼岸花秘闻皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
	end
	if (whr[3] == 1) then
		-- 日和坊原皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xfcfcfc,-14|6|0x323234,-14|-2|0x494a4c,-17|15|0xfcead9,-25|23|0xf3f2f1",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"日和坊原皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 日和坊觉醒皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xffd45a,-9|2|0x564f4f,-12|15|0xfef0da,-6|22|0xcbc5c4,-34|22|0x35302f",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"日和坊觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 日和坊商店皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf9f1e3,-13|-8|0x453a3d,-20|-3|0x2e2628,-16|0|0xfaf4eb,14|-10|0xfcf8ee",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"日和坊商店皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
	end
	if (whr[4] == 1) then
		-- 御馔津原皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xfffcf2,-3|7|0xfffcf2,5|5|0xfff7ee,10|-14|0x323440,-15|5|0xc19952",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"御馔津原Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 御馔津觉醒皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xffebdc,7|-4|0x59433a,4|-16|0x1f1110,17|-11|0x6b5a4b,-18|-5|0xfbd985,-9|11|0xdccec9",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"御馔津觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 御馔津商店皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0x2e322c,13|-3|0xc6c3d1,20|-1|0x91614b,-10|12|0xeecdb1,-17|12|0x555761,-2|26|0xffffff",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"御馔津商店皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
	end
	if (whr[2] == 1) then
		-- 小僧原皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf7d6bb,16|-1|0xfbdcb9,12|-5|0xfbdab6,18|-8|0x425769,9|12|0xf1cab0",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"小僧原皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 小僧觉醒皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xd1d2d1,7|-4|0xd3d1d0,12|6|0xc8c7c5,19|-6|0x42586a,9|15|0xccc1bc",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"小僧觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 小僧商店皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xdfd3b9,-7|6|0xe2d7c1,20|5|0xdbd1bb,10|17|0xbcdada,-2|21|0xcdaa67",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"小僧商店皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
	end
	return RET_ERR
end

function quit_jjtp()
	random_touch(0, 1050, 50, 10, 10) -- 退出
end

function jjtp_touch_blank()
	random_touch(0, 1100, 500, 30, 50)
end

function solo_lct_jjtp()
	local x, y = findColor({1050, 59, 1052, 61},
		"0|0|0xe8d4cf,-772|420|0x762906,-905|422|0xa6521e,-298|490|0xdc2f3c",
		95, 0, 0, 0)
	return x, y
end

function solo_analyse_map(solo_sel, map_)
	-- 检测当前突破情况, return array and number
	-- -1: 突破成功
	-- 0 ~ 5: 勋章数量
	local map = map_
	local winess = 0
	local invalid = 0
	local index = 1
	local x, y
	for i = 1, 3 do
		for j = 1, 3 do
			if map[index] ~= -5 then
				map[index] = -1
				-- Failed
				x, y = findColor({solo_ana_x[j]-1, solo_ana_y[i]-41, solo_ana_x[j]+1, solo_ana_y[i]-39},
					"0|0|0xf8c85b",
					90, 0, 0, 0)
				if x > -1 then
					map[index] = -1
					invalid = invalid + 1
				else
					-- Succeed
					x, y = findColor({solo_ana_x[j]-1, solo_ana_y[i]-1, solo_ana_x[j]+1, solo_ana_y[i]+1},
						"0|0|0x686158",
						95, 0, 0, 0)
					if x > -1 then
						map[index] = -1
						winess = winess + 1
						invalid = invalid + 1
					else
						for k = 1, 5 do
							x, y = findColor({solo_ana_x[j] - solo_ana_metal_x_diff[k] -1, solo_ana_y[i]-1,
									solo_ana_x[j] - solo_ana_metal_x_diff[k] +1, solo_ana_y[i]+1},
								"0|0|0xb3a28c",
								95, 0, 0, 0)
							if x > -1 then
								map[index] = k - 1
								break
							end
						end
						if map[index] == -1 then
							map[index] = 5
						end
					end
					if solo_sel == "3_to_5" then
						if (map[index] < 3) then
							map[index] = -1
							invalid = invalid + 1
						end
					elseif solo_sel == "3_to_0" then
						if (map[index] > 3) then
							map[index] = -1
							invalid = invalid + 1
						end
					end
				end
			else
				invalid = invalid + 1
			end
			index = index + 1
		end
	end
	
	return map, winess, invalid
end

function solo_find_next_target_loop(map, ran_arr, exp1, exp2, exp3)
	local pos = -1
	if (exp1 >= exp2) then
		for k = exp1, exp2, exp3 do
			for i = 1, 9 do
				if map[ran_arr[i]] == k then
					pos = ran_arr[i]
					return RET_OK, pos
				end
			end
		end
	else
		for k = exp1, exp2, exp3 do
			for i = 1, 9 do
				if map[ran_arr[i]] == k then
					pos = ran_arr[i]
					return RET_OK, pos
				end
			end
		end
	end
	return RET_ERR, pos
end

function solo_find_next_target(map, solo_sel)
	HUD_show_or_hide(HUD,hud_info,"寻找突破目标",20,"0xff000000","0xffffffff",0,100,0,300,32)
	-- 找到下一个突破目标
	local ran_arr = {}
	local pos = -1
	local ret = RET_ERR
	local ran_arr = getRandomList(9)
	
	if solo_sel == "0_to_5" then
		ret, pos = solo_find_next_target_loop(map, ran_arr, 0, 5, 1)
	elseif solo_sel == "3_to_5" then
		ret, pos = solo_find_next_target_loop(map, ran_arr, 3, 5, 1)
	elseif solo_sel == "5_to_0" then
		ret, pos = solo_find_next_target_loop(map, ran_arr, 5, 0, -1)
	elseif solo_sel == "3_to_0" then
		ret, pos = solo_find_next_target_loop(map, ran_arr, 3, 0, -1)
	elseif solo_sel == "random" then
		for j = 1, 9 do
			if map[ran_arr[j]] ~= -1 then
				pos = ran_arr[j]
				ret = RET_OK
				break
			end
		end
	end
	
	return ret, pos
end

function solo_refresh(winess, invalid, refresh)
	local x, y
	if (winess >= refresh or invalid == 9) then
		x, y = findColor({278, 480, 280, 482}, -- 刷新
			"0|0|0x762906,-12|69|0xf3b25e,604|2|0xf3b25e,715|70|0x493625",
			95, 0, 0, 0)
		if x > -1 then
			HUD_show_or_hide(HUD,hud_info,"刷新结界",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		else
			HUD_show_or_hide(HUD,hud_info,"等待刷新",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_VALID
		end
	end
	return RET_ERR
end

function solo_get_bonus()
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

function solo_fight_start(pos)
	local x, y = RET_ERR
	if (pos == -1) then
		return x, y
	end
	
	x, y = findColor({solo_fight_x[pos]-1, solo_fight_y[pos]-1, solo_fight_x[pos]+1, solo_fight_y[pos]+1},
		"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,string.format("突破目标 - %d", pos),20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, solo_fight_x[pos], solo_fight_y[pos], 30, 10) -- 进攻
	end
	return x, y
end

function solo_check_ticket(pos)
	if pos == -1 then
		return RET_ERR
	end
	
	mSleep(1000)
	local x, y = findColor({solo_fight_x[pos]-1, solo_fight_y[pos]-1, solo_fight_x[pos]+1, solo_fight_y[pos]+1},
		"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	return RET_ERR
end

function solo_quit_defense_record()
	local x, y = findColor({677, 105, 679, 107}, -- 防守记录
		"0|0|0xf3b25e,-37|2|0xcbb59c,-18|93|0xd6c9b9,-9|394|0xd6c9b9",
		95, 0, 0, 0)
	if x > -1 then
		jjtp_touch_blank()
	end
	return x, y
end

function solo_lock()
	local x, y = findColor({916, 541, 918, 543},
		"0|0|0x816645,-11|1|0x2f2318,14|0|0x2f2318",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 5, 5)
	end
	return x, y
end

function solo_to_pub()
	HUD_show_or_hide(HUD,hud_info,"切换至阴阳寮突破",20,"0xff000000","0xffffffff",0,100,0,300,32)
	random_touch(0, 1100, 300, 10, 10)
end

function pub_unstart()
	local x, y = findColor({1050, 58, 1052, 60},
		"0|0|0xe8d4cf,-519|124|0x131313,-510|206|0xe9e9e9,40|251|0xbd681a",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"寮突破未开启",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function pub_lct_jjtp()
	local x, y = findColor({1051, 59, 1053, 61},
		"0|0|0xe8d4cf,-919|195|0x4c0c18,-753|292|0x98081a,-973|524|0xc9a87b",
		95, 0, 0, 0)
	return x, y
end

function pub_ff(x1, y1, x2, y2)
	local x, y = findColor({x1, y1, x2, y2}, -- 右上角金色
		"0|0|0xf8c958,-15|-10|0xf6c65d",
		95, 0, 0, 0)
	return x, y
end

function pub_f5(x1, y1, x2, y2)
	local x, y = findColor({x1, y1, x2, y2},
		"0|0|0xaba59f,-35|0|0xa5a099,-70|0|0xb3ada7,35|0|0xaba59f,70|0|0xa7a19b",
		95, 0, 0, 0)
	return x, y
end

function pub_f4(x1, y1, x2, y2)
	local x, y = findColor({x1, y1, x2, y2},
		"0|0|0xb4afa9,-36|0|0xb7b1ab,-71|0|0xb5b0aa,35|0|0xb4afa9,69|0|0xb3a28d",
		95, 0, 0, 0)
	return x, y
end

function pub_f3(x1, y1, x2, y2)
	local x, y = findColor({x1, y1, x2, y2},
		"0|0|0xaba59f,-35|0|0xa5a099,-70|0|0xb3ada7,35|0|0xb3a28c,70|0|0xb3a28c",
		95, 0, 0, 0)
	return x, y
end

function pub_f2(x1, y1, x2, y2)
	local x, y = findColor({x1, y1, x2, y2},
		"0|0|0xb3a28d,-35|0|0xb5b0aa,-71|0|0xb5b0a9,35|0|0xb3a28d,71|0|0xb3a28d",
		95, 0, 0, 0)
	return x, y
end

function pub_f1(x1, y1, x2, y2)
	local x, y = findColor({x1, y1, x2, y2},
		"0|0|0xb3a28d,-35|0|0xb3a28d,-71|0|0xb5b0a9,35|0|0xb3a28d,69|0|0xb3a28d",
		95, 0, 0, 0)
	return x, y
end

function pub_f0(x1, y1, x2, y2)
	local x, y = findColor({x1, y1, x2, y2},
		"0|0|0xb3a28c,-35|0|0xb3a28c,-70|0|0xb3a28c,35|0|0xb3a28c,70|0|0xb3a28c",
		95, 0, 0, 0)
	return x, y
end

function pub_cnt_metal(x1, y1, x2, y2)
	local x, y, x_f, y_f
	x, y = pub_f5(x1, y1, x2, y2)
	if x > -1 then
		x_f, y_f = pub_ff(x+pub_mid_metal_ff_x_diff, y+pub_mid_metal_ff_y_diff,
			x+pub_mid_metal_ff_x_diff+20, y+pub_mid_metal_ff_y_diff+20)
		if x_f > -1 then
			return x, y, -1
		end
		return x, y, 5
	end
	x, y = pub_f4(x1, y1, x2, y2)
	if x > -1 then
		x_f, y_f = pub_ff(x+pub_mid_metal_ff_x_diff, y+pub_mid_metal_ff_y_diff,
			x+pub_mid_metal_ff_x_diff+20, y+pub_mid_metal_ff_y_diff+20)
		if x_f > -1 then
			return x, y, -1
		end
		return x, y, 4
	end
	x, y = pub_f3(x1, y1, x2, y2)
	if x > -1 then
		x_f, y_f = pub_ff(x+pub_mid_metal_ff_x_diff, y+pub_mid_metal_ff_y_diff,
			x+pub_mid_metal_ff_x_diff+20, y+pub_mid_metal_ff_y_diff+20)
		if x_f > -1 then
			return x, y, -1
		end
		return x, y, 3
	end
	x, y = pub_f2(x1, y1, x2, y2)
	if x > -1 then
		x_f, y_f = pub_ff(x+pub_mid_metal_ff_x_diff, y+pub_mid_metal_ff_y_diff,
			x+pub_mid_metal_ff_x_diff+20, y+pub_mid_metal_ff_y_diff+20)
		if x_f > -1 then
			return x, y, -1
		end
		return x, y, 2
	end
	x, y = pub_f1(x1, y1, x2, y2)
	if x > -1 then
		x_f, y_f = pub_ff(x+pub_mid_metal_ff_x_diff, y+pub_mid_metal_ff_y_diff,
			x+pub_mid_metal_ff_x_diff+20, y+pub_mid_metal_ff_y_diff+20)
		if x_f > -1 then
			return x, y, -1
		end
		return x, y, 1
	end
	x, y = pub_f0(x1, y1, x2, y2)
	if x > -1 then
		x_f, y_f = pub_ff(x+pub_mid_metal_ff_x_diff, y+pub_mid_metal_ff_y_diff,
			x+pub_mid_metal_ff_x_diff+20, y+pub_mid_metal_ff_y_diff+20)
		if x_f > -1 then
			return x, y, -1
		end
		return x, y, 0
	end
	return x, y, -5
end

function pub_ff_open()
	local x, y
	x, y = findColor({700, 40, 705, 465},
		"0|0|0xedd185,-5|6|0xfaca57,16|-13|0xa83434,11|-23|0xa93232",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	x, y = findColor({1000, 40, 1005, 465},
		"0|0|0xedd185,-5|6|0xfaca57,16|-13|0xa83434,11|-23|0xa93232",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	return RET_ERR
end

function pub_analyse_map(pub_sel)
	HUD_show_or_hide(HUD,hud_info,"分析地图",20,"0xff000000","0xffffffff",0,100,0,300,32)
	local map = {-1, -1, -1, -1, -1, -1, -1, -1}
	local coor_map_x = {}
	local coor_map_y = {}
	
	for i = 1, 8 do
		coor_map_x[i], coor_map_y[i], map[i] = pub_cnt_metal(pub_ana_metal_x[i], pub_ana_metal_y1[i],
			pub_ana_metal_x[i] + 5, pub_ana_metal_y2[i])
		if map[i] > pub_sel then
			map[i] = -1
			coor_map_x[i] = -1
			coor_map_y[i] = -1
		end
	end
	return coor_map_x, coor_map_y, map
end

function pub_find_next_target(map)
	for i = 1, 8 do
		if map[i] ~= -1 and map[i] ~= -5 then
			return i
		end
	end
	return RET_ERR
end

function pub_refresh()
	HUD_show_or_hide(HUD,hud_info,"翻页",20,"0xff000000","0xffffffff",0,100,0,300,32)
	local x = 725
	local y = 500
	local x_ran = 100
	local y_ran = 50
	local x_interv = math.random(-6, 6)
	local y_interv = -20
	local steps = 15
	
	random_move(0, 800, 500, 800, 150, 100, 20)
end

function pub_find_button()
	local x, y
	x, y = findColor({580, 220, 582, 580},
		"0|0|0xf3b25e,-140|-4|0xf3b25e,-69|-5|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK, x, y
	end
	x, y = findColor({880, 220, 882, 580},
		"0|0|0xf3b25e,-140|-4|0xf3b25e,-69|-5|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK, x, y
	end
	return RET_ERR, x, y
end

function pub_find_ivld_button()
	local x, y
	x, y = findColor({585, 220, 587, 580},
		"0|0|0xb0a9a1,-70|0|0xcbb59c,-101|0|0xf3b25e,-177|0|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	x, y = findColor({885, 220, 887, 580},
		"0|0|0xb0a9a1,-70|0|0xcbb59c,-101|0|0xf3b25e,-177|0|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	return RET_ERR
end

function pub_map_finished(map)
	local valid = 1
	for i = 1, 8 do
		if map[i] ~= -1 and map[i] ~= -5 then
			return RET_ERR
		end
		if map[i] == -5 then
			valid = 0
		end
	end
	
	if valid == 1 then
		return RET_VALID
	else
		return RET_OK
	end
end

function pub_to_solo()
	HUD_show_or_hide(HUD,hud_info,"切换至个人突破",20,"0xff000000","0xffffffff",0,100,0,300,32)
	random_touch(0, 1100, 200, 10, 10)
end

-- Main func
function jjtp(mode, whr_solo, whr_pub, round_time, refresh, solo_sel, pub_sel, lock)
	print(string.format("模式：%s，战斗时间：%d，刷新：%d，个人突破：%s，阴阳寮突破：%d, 锁定: %d", mode, round_time, refresh, solo_sel, pub_sel, lock))
	print(string.format("五花肉-个人：(彼岸花 %d, 小僧 %d, 日和坊 %d, 御馔津 %d)", whr_solo[1], whr_solo[2], whr_solo[3], whr_solo[4]))
	print(string.format("五花肉-阴阳寮：(彼岸花 %d, 小僧 %d, 日和坊 %d, 御馔津 %d)", whr_pub[1], whr_pub[2], whr_pub[3], whr_pub[4]))
	print_global_config()
	
	local ret_solo, ret_pub
	local action_solo, action_pub
	
	if (mode == "个人") then
		action_solo = "Quit"
		jjtp_solo(whr_solo, round_time, refresh, solo_sel, lock, action_solo)
	elseif (mode == "阴阳寮") then
		action_pub = "Wait"
		jjtp_solo_to_pub()
		jjtp_pub(whr_pub, round_time, pub_sel, lock, action_pub)
	elseif (mode == "个人+阴阳寮") then
		action_solo = "Switch"
		while (1) do
			if ret_solo == "Finish" and ret_pub == "Finish" then
				return RET_OK
			end
			
			ret_solo = jjtp_solo(whr_solo, round_time, refresh, solo_sel, lock, action_solo)
			if ret_solo == "Finish" then
				action_pub = "Wait"
			elseif ret_solo == "Unfinish" then
				action_pub = "Switch"
			end
			
			ret_pub = jjtp_pub(whr_pub, round_time, pub_sel, lock, action_pub)
			if ret_pub == "Finish" then
				action_solo = "Wait"
			elseif ret_pub == "Unfinish" then
				action_solo = "Hold"
			end
		end
	end
	return RET_OK
end

function jjtp_solo_to_pub()
	local x, y
	while (1) do
		while (1) do
			mSleep(500)
			-- 循环通用
			loop_generic()
			-- 个人突破
			x, y = solo_lct_jjtp()
			if (x > -1) then
				random_sleep(500)
				solo_to_pub()
			end
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then random_touch(0, 280, 590, 20, 20) break end -- 结界突破
			-- 防守记录
			x, y = solo_quit_defense_record() if x > -1 then break end
			-- 阴阳寮突破
			x, y = pub_lct_jjtp() if x > -1 then return RET_OK end
			-- 阴阳寮Unstart
			x, y = pub_unstart() if x > -1 then return RET_OK end
			break
		end
	end
	return RET_ERR
end

function jjtp_solo(whr, round_time, refresh, solo_sel, lock, action)
	local time_cnt = 0
	local map = {}
	local winess = -1
	local invalid = -1
	local pos = -1
	local found_target = -1
	local found_whr = -1
	local finish = 0
	local wait = 0
	local action_solo = action
	local x, y
	
	while (1) do
		while (1) do
			-- Debug
			if table.getn(map) == 0 then
				print("Map is not created")
			else
				print(string.format("Map : %d - %d - %d", map[1], map[2], map[3]))
				print(string.format("      %d - %d - %d", map[4], map[5], map[6]))
				print(string.format("      %d - %d - %d", map[7], map[8], map[9]))
			end
			print(string.format("winess %d, invalid %d, pos %d, found_target %d, action %s", winess, invalid, pos, found_target, action_solo))
			
			mSleep(500)
			-- 循环通用
			loop_generic()
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				time_cnt = time_cnt + 1
				if (time_cnt > round_time*60*2) then
					random_touch(0, 35, 30, 5, 5) -- 左上退出
					random_sleep(1000)
					random_touch(0, 660, 378, 20, 10) -- 确定
				end
				break
			end
			-- 获取奖励
			x, y = solo_get_bonus() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("单人")
			if (x > -1) then
				map[pos] = -1
				pos = -1
				found_target = -1
				win_cnt.global = win_cnt.global + 1
				time_cnt = 0
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.jjtp = win_cnt.jjtp + 1
				break
			end
			-- 个人突破
			x, y = solo_lct_jjtp()
			if (x > -1) then
				-- Action
				if action_solo == "Quit" then
					if finish == 1 then
						quit_jjtp()
						return "Finish"
					end
				elseif action_solo == "Wait" then
					if finish == 1 then
						solo_to_pub() -- Switch
						return "Finish"
					end
				elseif action_solo == "Switch" then
					if finish == 1 then
						solo_to_pub() -- Switch
						return "Finish"
					end
					if wait == 1 then
						solo_to_pub() -- Switch
						return "Unfinish"
					end
				elseif action_solo == "Hold" then
					if finish == 1 then
						solo_to_pub() -- Switch
						return "Finish"
					end
				end
				-- 锁定出战
				lock_or_unlock(lock, "Solo结界突破")
				-- 分析地图
				map, winess, invalid = solo_analyse_map(solo_sel, map)
				-- 刷新判断
				ret = solo_refresh(winess, invalid, refresh)
				if ret == RET_OK then
					random_touch(0, 933, 481, 30, 10) -- 刷新
					random_sleep(500)
					random_touch(0, 674, 384, 30, 10) -- 确认
					map = {}
					winess = -1
					invalid = -1
					pos = -1
					found_target = -1
					wait = 0
					if action_solo == "Hold" then
						action_solo = "Switch"
					end
				elseif ret == RET_VALID then
					pos = -1
					found_target = 0
					wait = 1
				end
				-- 点击目标
				if (pos ~= -1 and found_target == 0) then
					random_touch(0, solo_center_x[pos], solo_center_y[pos], 50, 20)
					break
				end
				-- 寻找目标
				if ((table.getn(map) ~= 0) and (found_target == -1)) then
					found_target, pos = solo_find_next_target(map, solo_sel)
					break
				end
			end
			-- 五花肉
			ret = find_whr(pos, whr, "solo")
			if ret == RET_OK then
				jjtp_touch_blank()
				map[pos] = -5
				pos = -1
				found_target = -1
				invalid = invalid + 1
				break
			else
				x, y = solo_fight_start(pos)
				ret = solo_check_ticket(pos)
				if ret == RET_OK then
					jjtp_touch_blank()
					finish = 1
				end
				if (x > -1) then
					break
				end
			end
			-- 战斗失败
			x, y = fight_failed("单人")
			if (x > -1) then
				map[pos] = -1
				pos = -1
				found_target = -1
				fail_cnt.global = fail_cnt.global + 1
				time_cnt = 0
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.jjtp = fail_cnt.jjtp + 1
				break
			end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 阴阳寮突破
			x, y = pub_lct_jjtp() if x > -1 then quit_jjtp() break end
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then random_touch(0, 280, 590, 20, 20) break end -- 结界突破
			-- 退出防守记录
			x, y = solo_quit_defense_record() if (x > -1) then break end
			break
		end
	end
	return RET_ERR
end

function jjtp_pub(whr, round_time, pub_sel, lock, action)
	local map = {}
	local coor_map_x = {}
	local coor_map_y = {}
	local pos = -1
	local time_cnt = 0
	local finish = 0
	local wait = 0
	local action_pub = action
	local click_cnt = 0
	local x, y
	
	while (1) do
		while (1) do
			if table.getn(map) > 0 then
				print(string.format("map: %d - %d", map[1], map[2]))
				print(string.format("	 %d - %d", map[3], map[4]))
				print(string.format("	 %d - %d", map[5], map[6]))
				print(string.format("	 %d - %d", map[7], map[8]))
				print(string.format("    pos = %d, wait = %d, finish = %d", pos, wait, finish))
			else
				print("Map is not created")
			end
			
			mSleep(500)
			-- 循环通用
			loop_generic()
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				time_cnt = time_cnt + 1
				if (time_cnt > round_time*60*2) then
					random_touch(0, 35, 30, 5, 5) -- 左上退出
					random_sleep(1000)
					random_touch(0, 660, 378, 20, 10) -- 确定
				end
				break
			end
			-- 战斗胜利
			x, y = fight_success("单人")
			if (x > -1) then
				win_cnt.global = win_cnt.global + 1
				time_cnt = 0
				click_cnt = 0
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.jjtp = win_cnt.jjtp + 1
			end
			-- 个人突破
			x, y = solo_lct_jjtp() if x > -1 then quit_jjtp() break end
			-- 阴阳寮突破
			x, y = pub_lct_jjtp()
			if (x > 0) then
				-- Action
				if action_pub == "Wait" then
					if finish == 1 then
						quit_jjtp()
						return "Finish"
					end
					if wait == 1 then
						-- 智能突破
						if auto_jjtp_en == 1 then
							quit_jjtp()
							return "Finish"
						end
						HUD_show_or_hide(HUD,hud_info,"突破冷却中",20,"0xff000000","0xffffffff",0,100,0,300,32)
						mSleep(60*1000)
						map = {}
						pos = -1
						wait = 0
						break
					end
				elseif action_pub == "Switch" then
					if finish == 1 then
						pub_to_solo()
						return "Finish"
					end
					if wait == 1 then
						-- 智能突破
						if auto_jjtp_en == 1 then
							pub_to_solo()
							return "Finish"
						end
						pub_to_solo()
						return "Unfinish"
					end
				end
				-- 锁定出战
				lock_or_unlock(lock, "Pub结界突破")
				-- 点击目标
				if pos ~= -1 then
					random_touch(0, coor_map_x[pos], coor_map_y[pos], 50, 10)
					break
				end
				-- 寻找目标
				if (table.getn(map) ~= 0 and pos == -1) then
					pos = pub_find_next_target(map)
					break
				end
				-- 分析地图
				if (table.getn(map) == 0) then
					coor_map_x, coor_map_y, map = pub_analyse_map(pub_sel)
					ret = pub_map_finished(map)
					if ret == RET_OK then
						-- 退出
						finish = 1
					elseif ret == RET_VALID then
						-- 翻页
						pub_refresh()
						map = {}
						pos = -1
					end
				end
			end
			-- 进攻button检测
			-- Invalid
			ret_f = pub_find_ivld_button()
			if ret_f == RET_OK then
				if intel_jjtp_pub == 1 then
					finish = 1
				else
					wait = 1
				end
				jjtp_touch_blank()
				break
			end
			-- Valid
			ret_f, x_f, y_f = pub_find_button()
			if ret_f == RET_OK then
				wait = 0
				-- 失败的结界
				ret = pub_ff_open()
				if ret == RET_OK then
					HUD_show_or_hide(HUD,hud_info,"失败的结界",20,"0xff000000","0xffffffff",0,100,0,300,32)
					map[pos] = -1
					pos = -1
					jjtp_touch_blank()
					break
				end
				-- 点击无效的结界
				if click_cnt >= 3 then
					HUD_show_or_hide(HUD,hud_info,"点击3次无效, 跳过结界",20,"0xff000000","0xffffffff",0,100,0,300,32)
					map[pos] = -1
					pos = -1
					click_cnt = 0
					jjtp_touch_blank()
					break
				end
				-- 五花肉
				if whr == {0, 0, 0, 0} then
					HUD_show_or_hide(HUD,hud_info,"进攻",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, x_f, y_f+20, 20, 5) -- 进攻
					click_cnt = click_cnt + 1
					break
				else
					ret_w = find_whr(pos, whr, "public")
					if ret_w == RET_OK then
						jjtp_touch_blank()
						map[pos] = -1
						pos = -1
						break
					else
						HUD_show_or_hide(HUD,hud_info,"进攻",20,"0xff000000","0xffffffff",0,100,0,300,32)
						random_touch(0, x_f, y_f+20, 20, 5) -- 进攻
						click_cnt = click_cnt + 1
						break
					end
				end
			end
			-- 战斗失败
			x, y = fight_failed("单人")
			if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				click_cnt = 0
				time_cnt = 0
				map[pos] = -1
				pos = -1
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.jjtp = fail_cnt.jjtp + 1
			end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 未开寮突
			x, y = pub_unstart()
			if x > -1 then
				if action_pub == "Wait" then
					quit_jjtp()
				else
					pub_to_solo()
				end
				return "Finish"
			end
			break
		end
	end
	return RET_ERR
end
