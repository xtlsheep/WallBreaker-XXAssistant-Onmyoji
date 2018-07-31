require "util"
require "func"

-- Def
solo_ana_x = {392, 698, 1002}
solo_ana_y = {164, 284, 403}
solo_ana_metal_x_diff = {169, 134, 99, 64, 28}
solo_center_x = {300, 600, 900, 300, 600, 900, 300, 600, 900}
solo_center_y = {135, 135, 135, 255, 255, 255, 375, 375, 375}
solo_whr_x1 = {121, 426, 732, 121, 426, 732, 121, 426, 732}
solo_whr_y1 = {205, 205, 205, 323, 323, 323, 445, 445, 445}
solo_whr_x2 = {405, 711, 1017, 405, 711, 1017, 405, 711, 1017}
solo_whr_y2 = {254, 254, 254, 376, 376, 376, 495, 495, 495}
solo_fight_x = {333, 639, 942, 333, 639, 942, 333, 639, 942}
solo_fight_y = {300, 300, 300, 420, 420, 420, 540, 540, 540}

pub_ana_metal_x = {603, 904, 603, 904, 603, 904, 603, 904}
pub_ana_metal_y1 = {130, 130, 250, 250, 370, 370, 490, 490}
pub_ana_metal_y2 = {240, 240, 360, 360, 480, 480, 600, 600}
pub_mid_metal_ff_x_diff = 100
pub_mid_metal_ff_y_diff = -35

-- Util func
function solo_lct_jjtp()
	x, y = findColor({140, 547, 142, 549},
		"0|0|0xf3b25e,4|-66|0xa6521e,139|-70|0x752907,589|-11|0xde3945",
		95, 0, 0, 0)
	return x, y
end

function solo_analyse_map(solo_sel)
	-- 检测当前突破情况, return array and number
	-- -1: 突破成功
	-- 0 ~ 5: 勋章数量
	map = {}
	winess = 0
	invalid= 0
	index = 1
	for i = 1, 3 do
		for j = 1, 3 do
			map[index] = "null"
			x, y = findColor({solo_ana_x[j]-1, solo_ana_y[i]-1, solo_ana_x[j]+1, solo_ana_y[i]+1},
				"0|0|0x686158",
				95, 0, 0, 0)
			if x > -1 then
				map[index] = -1
				winess = winess + 1
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
				if map[index] == "null" then
					map[index] = 5
				end
			end
			index = index + 1
		end
	end
	
	invalid = winess
	
	for i = 1, 9 do
		if solo_sel == "3_to_5" then
			if (map[i] < 3) then
				map[i] = -1
				invalid = invalid + 1
			end
		elseif solo_sel == "3_to_0" then
			if (map[i] > 3) then
				map[i] = -1
				invalid = invalid + 1
			end
		end
	end
	
	return map, winess, invalid
end

function solo_find_next_target_loop(map, ran_arr, exp1, exp2, exp3)
	pos = -1
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
	showHUD_ios_ver(ios_ver,hud_scene,"寻找突破目标",20,"0xff000000","0xffffffff",0,100,0,300,32)
	-- 找到下一个突破目标
	ran_arr = {}
	pos = -1
	ret = RET_ERR
	ran_arr = getRandomList(9)
	
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
				break
			end
		end
	end
	
	return ret, pos
end

function solo_refresh(winess, invalid, refresh)
	if (winess >= refresh or invalid == 9) then
		x, y = findColor({278, 480, 280, 482}, -- 刷新
			"0|0|0x762906,-12|69|0xf3b25e,604|2|0xf3b25e,715|70|0x493625",
			95, 0, 0, 0)
		if x > -1 then
			ran_sleep(1000)
			showHUD_ios_ver(ios_ver,hud_scene,"刷新结界",20,"0xff000000","0xffffffff",0,100,0,300,32)
			ran_touch(0, 933, 481, 30, 10) -- 刷新
			ran_sleep(500)
			ran_touch(0, 674, 384, 30, 10) -- 确认
			return RET_OK
		else
			showHUD_ios_ver(ios_ver,hud_scene,"等待刷新",20,"0xff000000","0xffffffff",0,100,0,300,32)
			mSleep(10000)
			return RET_VALID
		end
	end
	return RET_ERR
end

function solo_get_bonus()
	x, y = findColor({605, 464, 607, 466},
		"0|0|0xbb3c1a,64|-6|0xd19118,-20|-63|0xcbb599,-37|-78|0xd73846,-339|84|0x79582e,-7|106|0x6a645c",
		95, 0, 0, 0)
	if x > -1 then
		showHUD_ios_ver(ios_ver,hud_scene,"领取奖励",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, 1095, 485, 20, 50) -- 左下空白
	end
	return x, y
end

function solo_fight_start(pos)
	x = RET_ERR 
	y = RET_ERR
	if (pos == -1) then
		return x, y
	end
	
	x, y = findColor({solo_fight_x[pos]-1, solo_fight_y[pos]-1, solo_fight_x[pos]+1, solo_fight_y[pos]+1},
		"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		showHUD_ios_ver(ios_ver,hud_scene,string.format("突破目标 - %d", pos),20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, solo_fight_x[pos], solo_fight_y[pos], 30, 10) -- 进攻
	end
	return x, y
end

function solo_check_ticket(pos)
	if pos == -1 then
		return RET_ERR
	end
	
	mSleep(1000)
	x, y = findColor({solo_fight_x[pos]-1, solo_fight_y[pos]-1, solo_fight_x[pos]+1, solo_fight_y[pos]+1},
		"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	return RET_ERR
end

function solo_quit_defense_record()
	x, y = findColor({677, 105, 679, 107}, -- 防守记录
		"0|0|0xf3b25e,-37|2|0xcbb59c,-18|93|0xd6c9b9,-9|394|0xd6c9b9",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, 1090, 475, 10, 50) --右下空白
	end
	return x, y
end

function solo_lock()
	x, y = findColor({916, 541, 918, 543},
		"0|0|0x816645,-11|1|0x2f2318,14|0|0x2f2318",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, x, y, 5, 5)
	end
	return x, y
end

function solo_to_pub()
	showHUD_ios_ver(ios_ver,hud_scene,"切换至阴阳寮突破",20,"0xff000000","0xffffffff",0,100,0,300,32)
	ran_touch(0, 1095, 300, 5, 5)
end

function pub_lct_jjtp()
	x, y = findColor({346, 256, 348, 258}, -- 三个红条 突破记录
		"0|0|0x8e0518,4|100|0x830516,9|234|0x870517,-238|329|0xcba97c",
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
	x, y = findColor({x1, y1, x2, y2},
		"0|0|0xaba59f,-35|0|0xa5a099,-70|0|0xb3ada7,35|0|0xaba59f,70|0|0xa7a19b",
		95, 0, 0, 0)
	return x, y
end

function pub_f4(x1, y1, x2, y2)
	x, y = findColor({x1, y1, x2, y2},
		"0|0|0xb4afa9,-36|0|0xb7b1ab,-71|0|0xb5b0aa,35|0|0xb4afa9,69|0|0xb3a28d",
		95, 0, 0, 0)
	return x, y
end

function pub_f3(x1, y1, x2, y2)
	x, y = findColor({x1, y1, x2, y2},
		"0|0|0xaba59f,-35|0|0xa5a099,-70|0|0xb3ada7,35|0|0xb3a28c,70|0|0xb3a28c",
		95, 0, 0, 0)
	return x, y
end

function pub_f2(x1, y1, x2, y2)
	x, y = findColor({x1, y1, x2, y2},
		"0|0|0xb3a28d,-35|0|0xb5b0aa,-71|0|0xb5b0a9,35|0|0xb3a28d,71|0|0xb3a28d",
		95, 0, 0, 0)
	return x, y
end

function pub_f1(x1, y1, x2, y2)
	x, y = findColor({x1, y1, x2, y2},
		"0|0|0xb3a28d,-35|0|0xb3a28d,-71|0|0xb5b0a9,35|0|0xb3a28d,69|0|0xb3a28d",
		95, 0, 0, 0)
	return x, y
end

function pub_f0(x1, y1, x2, y2)
	x, y = findColor({x1, y1, x2, y2},
		"0|0|0xb3a28c,-35|0|0xb3a28c,-70|0|0xb3a28c,35|0|0xb3a28c,70|0|0xb3a28c",
		95, 0, 0, 0)
	return x, y
end

function pub_cnt_metal(x1, y1, x2, y2)
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
			print(x)
			return x, y, -1
		end
		print(x)
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
	return x, y, -1
end

function pub_ff_open()
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
	showHUD_ios_ver(ios_ver,hud_scene,"分析地图",20,"0xff000000","0xffffffff",0,100,0,300,32)
	map = {}
	coor_map_x = {}
	coor_map_y = {}
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
		if map[i] ~= -1 then
			return i
		end
	end
	return RET_ERR
end

function pub_refresh()
	showHUD_ios_ver(ios_ver,hud_scene,"翻页",20,"0xff000000","0xffffffff",0,100,0,300,32)
	x_ran = 725 + math.random(-100, 100)
	y_ran = 500 + math.random(-50, 50)
	x_interv = math.random(-6, 6)
	y_interv = -20
	steps = 15
	
	touchDown(0, x_ran, y_ran)
	for i = 0, steps, 1 do
		touchMove(0, x_ran+i*x_interv, y_ran+i*y_interv)
		mSleep(25)
	end
	touchUp(0, x_ran+steps*y_interv, y_ran+steps*y_interv)
end

function pub_find_start()
	x = RET_ERR
	y = RET_ERR
	x, y = findColor({645, 220, 647, 580},
		"0|0|0xf3b25e,-54|-24|0x983c2e,-54|19|0x983d2e,52|-24|0x973c2e,52|19|0x983c2e",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK, x, y
	end
	x, y = findColor({945, 220, 947, 580},
		"0|0|0xf3b25e,-54|-24|0x983c2e,-54|19|0x983d2e,52|-24|0x973c2e,52|19|0x983c2e",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK, x, y
	end
	return RET_ERR, x, y
end

function pub_map_finished(map)
	for i = 1, 8, 1 do
		if map[i] ~= -1 then
			return RET_ERR
		end
	end
	return RET_OK
end

function find_whr(pos, whr, role)
	if (pos == -1) then
		return RET_ERR
	end
	
	if (role == "solo") then
		x, y = findColor({solo_fight_x[pos]-1, solo_fight_y[pos]-1, solo_fight_x[pos]+1, solo_fight_y[pos]+1}, -- 进攻
			"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
			95, 0, 0, 0)
		if x == -1 then
			return RET_ERR
		end
		mSleep(500)
		x1 = solo_whr_x1[pos]
		x2 = solo_whr_x2[pos]
		y1 = solo_whr_y1[pos]
		y2 = solo_whr_y2[pos]
	elseif (role == "public") then
		mSleep(500)
		if pos%2 == 1 then
			x1 = 435
			y1 = 155
			x2 = 715
			y2 = 610
		else
			x1 = 735
			y1 = 155
			x2 = 1015
			y2 = 610
		end
	end
	
	if (whr[1] == 1) then
		-- 彼岸花原皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf2deda,3|10|0xe1ab8e,9|-16|0x4b4a49,-6|-3|0x262728",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"彼岸花原皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 彼岸花觉醒皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0x2b2331,0|4|0xf9e5d6,9|-1|0xb82321,19|4|0xdbdbe5",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"彼岸花觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 彼岸花商店皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf9f7f5,-3|-13|0xdaced0,12|-1|0x741319,-2|9|0x941f26,-16|0|0xa88150,9|0|0x968e92",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"彼岸花商店皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
	end
	if (whr[3] == 1) then
		-- 日和坊原皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xfcfcfc,-14|6|0x323234,-14|-2|0x494a4c,-17|15|0xfcead9,-25|23|0xf3f2f1",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"日和坊原皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 日和坊觉醒皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xffd45a,-9|2|0x564f4f,-12|15|0xfef0da,-6|22|0xcbc5c4,-34|22|0x35302f",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"日和坊觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
	end
	if (whr[4] == 1) then
		-- 御馔津原皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xfff8ef,13|-15|0x323440,18|-7|0xa07448,-4|15|0xfcfcf9,-19|-3|0xa78050,-17|9|0xe6b96a",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"御馔津原Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 御馔津觉醒皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xffebdc,7|-4|0x59433a,4|-16|0x1f1110,17|-11|0x6b5a4b,-18|-5|0xfbd985,-9|11|0xdccec9",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"御馔津觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 御馔津商店皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0x2e322c,13|-3|0xc6c3d1,20|-1|0x91614b,-10|12|0xeecdb1,-17|12|0x555761,-2|26|0xffffff",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"御馔津商店皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
	end
	if (whr[2] == 1) then
		-- 小僧原皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xfbdbb9,1|8|0xfce1c2,4|5|0xfce0be,-10|5|0xfad9be,9|0|0x4e514d",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"小僧原皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 小僧觉醒皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xd7d3d5,5|5|0xcccacc,15|-3|0x46494f,-17|13|0x4e534e",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"小僧觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 小僧商店皮
		x, y = findColor({x1, y1, x2, y2},
			"0|0|0xe4d9c3,10|13|0xbcd9da,-3|17|0xcfac69,-12|12|0x4c514d",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"小僧商店皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
	end
	return RET_ERR
end

-- Main func
function jjtp(mode, whr_solo, whr_pub, round_time, refresh, solo_sel, pub_sel, lock, offer_arr)
	print(string.format("模式：%s，五花肉-个人：(彼岸花 %d, 小僧 %d, 日和坊 %d, 御馔津 %d)，战斗时间：%d，刷新：%d，个人突破：%s，阴阳寮突破：%d, 锁定: %d",
			mode, whr_solo[1], whr_solo[2], whr_solo[3], whr_solo[4], round_time, refresh, solo_sel, pub_sel, lock))
	print(string.format("五花肉-阴阳寮：(彼岸花 %d, 小僧 %d, 日和坊 %d, 御馔津 %d), 悬赏封印：%d (勾玉：%d 体力：%d 樱饼：%d 金币：%d 零食：%d)",
			whr_pub[1], whr_pub[2], whr_pub[3], whr_pub[4], offer_arr[1], offer_arr[2], offer_arr[3], offer_arr[4], offer_arr[5], offer_arr[6]))
	
	if (mode == "个人") then
		jjtp_solo(whr_solo, round_time, refresh, solo_sel, lock, offer_arr)
	elseif (mode == "阴阳寮") then
		jjtp_pub(whr_pub, round_time, pub_sel, lock, offer_arr)
	end
end

function jjtp_solo(whr, round_time, refresh, solo_sel, lock, offer_arr)
	time_cnt = 0
	map = {}
	winess = -1
	invalid = -1
	pos = -1
	found_target = -1
	found_whr = -1
	win_cnt = 0
	fail_cnt = 0
	disconn_fin = 1
	real_8dashe = 0
	secret_vender = 0
	
	if (round_time == 0) then
		round_time = 999
	end
	
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
			print(string.format("winess %d, invalid %d, pos %d, found_target %d", winess, invalid, pos, found_target))
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 个人结界突破
			x, y = solo_lct_jjtp()
			if (x > -1) then
				-- 锁定出战
				lock_or_unlock(lock, "结界突破")
				-- 分析地图
				if (table.getn(map) == 0) then
					map, winess, invalid = solo_analyse_map(solo_sel)
					break
				end
				-- 刷新判断
				ret = solo_refresh(winess, invalid, refresh)
				if ret == RET_OK then
					map = {}
					winess = -1
					invalid = -1
					pos = -1
					found_target = -1
				elseif ret == RET_ONE then
					pos = -1
					found_target = 0
				end
				-- 点击目标
				if (pos ~= -1 and found_target == 0) then
					ran_touch(0, solo_center_x[pos], solo_center_y[pos], 50, 20)
					break
				end
			end
			-- 获取奖励
			x, y = solo_get_bonus() if (x > -1) then break end
			-- 寻找目标
			if ((table.getn(map) ~= 0) and (found_target == -1)) then
				found_target, pos = solo_find_next_target(map, solo_sel)
				break
			end
			-- 五花肉
			ret = find_whr(pos, whr, "solo")
			if ret == RET_OK then
				ran_touch(0, 1095, 495, 10, 50) -- 右下空白
				map[pos] = -1
				pos = -1
				found_target = -1
				invalid = invalid + 1
				break
			else
				x, y = solo_fight_start(pos)
				ret = solo_check_ticket(pos)
				if ret == RET_OK then
					ran_touch(0, 1095, 495, 10, 50) -- 右下空白
					return
				end
				if (x > -1) then
					break
				end
			end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				time_cnt = time_cnt + 1
				if (time_cnt > round_time*60*2) then
					ran_touch(0, 35, 30, 5, 5) -- 右上退出
					ran_sleep(1000)
					ran_touch(0, 660, 378, 20, 10) -- 确定
				end
				break
			end
			-- 战斗胜利
			x, y = fight_success("单人") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				winess = winess + 1
				invalid = invalid + 1
				map[pos] = -1
				pos = -1
				found_target = -1
				win_cnt = win_cnt + 1
				time_cnt = 0
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo(offer_arr)
				break
			end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				invalid = invalid + 1
				map[pos] = -1
				pos = -1
				found_target = -1
				fail_cnt = fail_cnt + 1
				time_cnt = 0
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed(offer_arr)
				break
			end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 280, 590, 20, 20) break end -- 结界突破
			-- 退出防守记录
			x, y = solo_quit_defense_record() if (x > -1) then break end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return
end

function jjtp_pub(whr, round_time, pub_sel, lock, offer_arr)
	map = {}
	coor_map_x = {}
	coor_map_y = {}
	pos = -1
	time_cnt = 0
	win_cnt = 0
	fail_cnt = 0
	refresh = 0
	page = 0
	disconn_fin = 1
	real_8dashe = 0
	secret_vender = 0
	
	while (1) do
		while (1) do
			if table.getn(map) > 0 then
				print(string.format("map: %d - %d", map[1], map[2]))
				print(string.format("	 %d - %d", map[3], map[4]))
				print(string.format("	 %d - %d", map[5], map[6]))
				print(string.format("	 %d - %d", map[7], map[8]))
			else
				print("Map is not created")
			end
			print(string.format("pos = %d", pos))
			
			mSleep(500)
			
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 阴阳寮突破
			x, y = pub_lct_jjtp()
			if (x > 0) then
				-- 翻页
				ret = pub_map_finished(map)
				if ret == RET_OK then
					pub_refresh()
					map = {}
					pos = -1
					page = page + 1
					break
				end
				if refresh > 0 then
					for i = 1, page, 1 do
						find_offer(offer_arr)
						pub_refresh()
						mSleep(500)
					end
					--coor_map_x, coor_map_y, map = pub_analyse_map(pub_sel)
					refresh = 0
				end
				-- 点击目标
				if pos ~= -1 then
					ran_touch(0, coor_map_x[pos], coor_map_y[pos], 50, 10)
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
					break
				end
			end
			-- 进攻button检测
			ret_f, x_f, y_f = pub_find_start()
			if ret_f == RET_OK then
				-- 失败的结界
				ret = pub_ff_open()
				if ret == RET_OK then
					showHUD_ios_ver(ios_ver,hud_scene,"失败的结界",20,"0xff000000","0xffffffff",0,100,0,300,32)
					map[pos] = -1
					pos = -1
					ran_touch(0, 1095, 495, 10, 50) -- 右下空白
					break
				end
				-- 五花肉
				if whr == {0, 0, 0, 0} then
					showHUD_ios_ver(ios_ver,hud_scene,"进攻",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, x_f, y_f, 20, 5) -- 进攻
					break
				else
					ret_w = find_whr(pos, whr, "public")
					if ret_w == RET_OK then
						ran_touch(0, 1095, 495, 10, 50) -- 右下空白
						map[pos] = -1
						pos = -1
						break
					else
						showHUD_ios_ver(ios_ver,hud_scene,"进攻",20,"0xff000000","0xffffffff",0,100,0,300,32)
						ran_touch(0, x_f, y_f, 20, 5) -- 进攻
						break
					end
				end
			end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				time_cnt = time_cnt + 1
				if (time_cnt > round_time*60*2) then
					ran_touch(0, 35, 30, 5, 5) -- 右上退出
					ran_sleep(1000)
					ran_touch(0, 660, 378, 20, 10) -- 确定
				end
				break
			end
			-- 战斗胜利
			x, y = fight_success("单人") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				win_cnt = win_cnt + 1
				time_cnt = 0
				-- map[pos] = -1
				-- pos = -1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo(offer_arr)
				refresh = 1
			end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt = fail_cnt + 1
				time_cnt = 0
				map[pos] = -1
				pos = -1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed(offer_arr)
				refresh = 1
			end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 280, 590, 20, 20) break end -- 结界突破
			-- 个人突破
			x, y = solo_lct_jjtp()
			if (x > -1) then
				lock_or_unlock(lock, "结界突破")
				ran_sleep(500)
				solo_to_pub()
				break
			end
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return
end