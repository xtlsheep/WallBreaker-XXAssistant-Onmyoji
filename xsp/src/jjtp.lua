require "util"
require "func"

-- Normal func
function solo_lct_jjtp()
	x, y = findColor({140, 547, 142, 549},
		"0|0|0xf3b25e,4|-66|0xa6521e,139|-70|0x752907,589|-11|0xde3945",
		95, 0, 0, 0)
	return x, y
end

function solo_analysis_map(solo_select)
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
			x, y = findColor({jsm_ana_x[j]-1, jsm_ana_y[i]-1, jsm_ana_x[j]+1, jsm_ana_y[i]+1},
				"0|0|0x686158",
				95, 0, 0, 0)
			if x > -1 then
				map[index] = -1
				winess = winess + 1
			else
				for k = 1, 5 do
					x, y = findColor({jsm_ana_x[j] - jsm_ana_metal_x_diff[k] -1, jsm_ana_y[i]-1,
							jsm_ana_x[j] - jsm_ana_metal_x_diff[k] +1, jsm_ana_y[i]+1},
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
		if solo_select == "3_to_5" then
			if (map[i] < 3) then
				map[i] = -1
				invalid = invalid + 1
			end
		elseif solo_select == "3_to_0" then
			if (map[i] > 3) then
				map[i] = -1
				invalid = invalid + 1
			end
		end
	end
	
	return map, winess, invalid
end

function solo_find_next_target_for_loop(map, ran_arr, exp1, exp2, exp3)
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

function solo_find_next_target(map, solo_select)
	showHUD_ios_ver(ios_ver,hud_scene,"寻找突破目标",20,"0xff000000","0xffffffff",0,100,0,300,32)
	-- 找到下一个突破目标
	ran_arr = {}
	pos = -1
	ret = -1
	ran_arr = getRandomList(9)
	
	if solo_select == "0_to_5" then
		ret, pos = solo_find_next_target_for_loop(map, ran_arr, 0, 5, 1)
	elseif solo_select == "3_to_5" then
		ret, pos = solo_find_next_target_for_loop(map, ran_arr, 3, 5, 1)
	elseif solo_select == "5_to_0" then
		ret, pos = solo_find_next_target_for_loop(map, ran_arr, 5, 0, -1)
	elseif solo_select == "3_to_0" then
		ret, pos = solo_find_next_target_for_loop(map, ran_arr, 3, 0, -1)
	elseif solo_select == "random" then
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
		x, y = findColor({882, 479, 884, 481}, -- 刷新
			"0|0|0xf3b25e,95|0|0xf3b25e,52|74|0x493625,75|42|0xd6c9b9",
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
			return RET_ONE
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
	if (pos == -1) then
		return -1, -1
	end
	
	x, y = findColor({jsm_fight_x[pos]-1, jsm_fight_y[pos]-1, jsm_fight_x[pos]+1, jsm_fight_y[pos]+1},
		"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		showHUD_ios_ver(ios_ver,hud_scene,string.format("突破目标 - %d", pos),20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, jsm_fight_x[pos], jsm_fight_y[pos], 30, 10) -- 进攻
	end
	return x, y
end

function solo_check_ticket(pos)
	if pos == -1 then
		return RET_ERR
	end
	
	mSleep(1000)
	x, y = findColor({jsm_fight_x[pos]-1, jsm_fight_y[pos]-1, jsm_fight_x[pos]+1, jsm_fight_y[pos]+1},
		"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	return RET_ERR
end

function solo_define_record()
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

function find_whr(pos, whr)
	if (pos == -1) then
		return RET_ERR
	end
	
	x, y = findColor({jsm_fight_x[pos]-1, jsm_fight_y[pos]-1, jsm_fight_x[pos]+1, jsm_fight_y[pos]+1},
		"0|0|0xf3b25e,-40|-2|0xf3b25e,38|2|0xf3b25e,73|1|0xcbb59c",
		95, 0, 0, 0)
	if x == -1 then
		return RET_ERR
	end
	
	mSleep(500)
	
	x1 = jsm_whr_x1[pos]
	x2 = jsm_whr_x2[pos]
	y1 = jsm_whr_y1[pos]
	y2 = jsm_whr_y2[pos]
	
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
		-- 御馔津觉醒皮
		x, y = findColor({x1, y1, x2, y2}, 
			"0|0|0xffebdc,7|-4|0x59433a,4|-16|0x1f1110,17|-11|0x6b5a4b,-18|-5|0xfbd985,-9|11|0xdccec9",
			95, 0, 0, 0)
		if x > -1 then
			showHUD_ios_ver(ios_ver,hud_scene,"御馔津觉醒皮Get",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_OK
		end
		-- 御馔津商店皮
	end
	return RET_ERR
end

function switch_to_house()
	showHUD_ios_ver(ios_ver,hud_scene,"切换至阴阳寮突破",20,"0xff000000","0xffffffff",0,100,0,300,32)
	ran_touch(0, 1095, 300, 5, 5)
end

function house_lct_jjtp()
	x, y = findColor({223, 253, 225, 255},  -- 三个红条
		"0|0|0x730812,130|100|0x870616,41|231|0x910814,-112|329|0xc9a87b",
		95, 0, 0, 0)
	return x, y
end

-- Main func
function jjtp(mode, whr, round_time, refresh, solo_select, house_select, lock, offer_arr)
	print(string.format("模式：%s，五花肉：(彼岸花 %d, 小僧 %d, 日和坊 %d, 御馔津 %d)，战斗时间：%d，刷新：%d，个人突破：%s，阴阳寮突破：%s, 锁定: %d", 
						mode, whr[1], whr[2], whr[3], whr[4], round_time, refresh, solo_select, house_select, lock))
	print(string.format("悬赏封印：%d (勾玉：%d 体力：%d 樱饼：%d 金币：%d 零食：%d)", 
						offer_arr[1], offer_arr[2], offer_arr[3], offer_arr[4], offer_arr[5], offer_arr[6]))
	
	if (mode == "个人") then
		jjtp_pri(whr, round_time, refresh, solo_select, lock, offer_arr)
	end
end

function jjtp_pri(whr, round_time, refresh, solo_select, lock, offer_arr)
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
--			-- Debug
--			if table.getn(map) == 0 then
--				print("Map is not created")
--			else
--				print(string.format("Map : %d - %d - %d", map[1], map[2], map[3]))
--				print(string.format("      %d - %d - %d", map[4], map[5], map[6]))
--				print(string.format("      %d - %d - %d", map[7], map[8], map[9]))
--			end
--			print(string.format("winess %d, invalid %d, pos %d, found_target %d", winess, invalid, pos, found_target))
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
					map, winess, invalid = solo_analysis_map(solo_select)
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
					ran_touch(0, jsm_center_x[pos], jsm_center_y[pos], 50, 20)
					break
				end
			end
			-- 获取奖励
			x, y = solo_get_bonus() if (x > -1) then break end
			-- 寻找目标
			if ((table.getn(map) ~= 0) and (found_target == -1)) then
				found_target, pos = solo_find_next_target(map, solo_select)
				break
			end
			-- 五花肉
			ret = find_whr(pos, whr)
			if ret == 0 then
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
					map[pos] = -1
					pos = -1
					found_target = -1
					time_cnt = 0
					invalid = invalid + 1
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
			x, y = find_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 280, 590, 20, 20) break end -- 结界突破
			-- 退出防守记录
			x, y = solo_define_record() if (x > -1) then break end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return
end

function jjtp_pub(whr, round_time, house_select)
	disable_lock = 0
	time_cnt = 0
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 阴阳寮结界突破
			x, y = house_lct_jjtp()
			if (x > 0) then
				
			end
			-- 庭院
			x, y = find_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 280, 590, 20, 20) break end -- 结界突破
			-- 个人结界突破
			x, y = solo_lct_jjtp()
			if (x > -1) then
				lock_and_unlock(1, "结界突破")
				ran_sleep(500)
				switch_to_house()
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