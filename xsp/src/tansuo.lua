require "util"
require "func"

-- Util func
function lct_exploration()
	local x, y = findColor({770, 5, 790, 15},
		"0|0|0xe97b2b,-746|49|0xf0f5fb,-729|48|0x313583,305|26|0xa29c7b,305|19|0xdfc7a1",
		95, 0, 0, 0)
	return x, y
end

function lct_exploration_portal()
	local x, y = findColor({928, 132, 930, 134},
		"0|0|0xe9d6d0,-41|-22|0x493625,-673|312|0x404359,-606|320|0xe0bd5f",
		95, 0, 0, 0)
	return x, y
end

function lct_exploration_prepare()
	local x, y = findColor({27, 35, 29, 37},
		"0|0|0xd6c4a1,4|468|0x98335a,92|570|0xfefbe5,25|552|0xf6c990",
		95, 0, 0, 0)
	return x, y
end

function tansuo_mark(mark)
	random_sleep(500)
	local x, y
	local cnt = math.random(2, 3)
	local ran = math.random(1, 3)
	if mark == "小怪" then
		if ran == 1 then
			x = 566 y = 126
		elseif ran == 2 then
			x = 697 y = 186
		elseif ran == 3 then
			x = 861 y = 177
		end
		for i = 1, cnt do
			random_touch(0, x, y, 10, 10)
		end
	elseif mark == "Boss" then
		for i = 1, cnt do
			random_touch(0, 765, 60, 10, 10)
		end
	end
end

function quit_confirm()
	local x, y = findColor({688, 357, 690, 359},
		"0|0|0xf3b25e,-287|-2|0xf3b25e,-654|-302|0x636567,-659|146|0x3e1524",
		95, 0, 0, 0)
	return x, y
end

function find_exp()
	local x, y = findColor({0, 100, 1135, 550},
		"0|0|0xb29773,-13|-4|0x2b6478,-7|8|0x831917",
		95, 0, 0, 0)
	return x, y
end

function find_money()
	local x, y = findColor({0, 100, 1135, 550},
		"0|0|0xdacb6f,5|-11|0xdfd082,12|-2|0xdaca71",
		95, 0, 0, 0)
	return x, y
end

function find_goods()
	local x, y = findColor({0, 100, 1135, 550},
		"0|0|0xf6db12,-10|-9|0xd62e22,-21|-15|0xce4428",
		80, 0, 0, 0)
	return x, y
end

function find_normal(x_f, y_f)
	local x, y
	if x_f == -1 and y_f == -1 then
		local x, y = findColor({0, 100, 1135, 550},
			"0|0|0xd2d4f9,8|15|0x232755,-3|-22|0xf3aeb8,-8|-5|0x5b6daa",
			95, 1, 0, 0)
		if x > -1 then
			return x, y
		end
	end
	local x, y = findColor({x_f-150, y_f-250, x_f, y_f},
		"0|0|0xd2d4f9,8|15|0x232755,-3|-22|0xf3aeb8,-8|-5|0x5b6daa",
		95, 1, 0, 0)
	if x > -1 then
		return x, y
	end
	local x, y = findColor({x_f, y_f-250, x_f+150, y_f},
		"0|0|0xd2d4f9,8|15|0x232755,-3|-22|0xf3aeb8,-8|-5|0x5b6daa",
		95, 0, 0, 0)
	return x, y
end

function find_boss()
	local x, y = findColor({200, 100, 900, 300},
		"0|0|0xb22e32,3|5|0xfffdf9,-7|-16|0x221108",
		95, 0, 0, 0)
	return x, y
end

function find_target(sel)
	local x_f = -1
	local y_f = -1
	local x_t = -1
	local y_t = -1
	
	HUD_show_or_hide(HUD,hud_info,"寻找ing...",20,"0xff000000","0xffffffff",0,100,0,300,32)
	
	for i = 1, 5 do
		x_t, y_t = find_boss()
		if x_t > -1 then
			HUD_show_or_hide(HUD,hud_info,"发现Boss",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return RET_VALID
		end
		
		if sel[1]==1 or sel[2]==1 or sel[3]==1 then
			keepScreen(true)
			-- Exp
			if sel[3] == 1 then
				x_f, y_f = find_exp()
				if x_f > -1 then
					HUD_show_or_hide(HUD,hud_info,"找到经验加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
				end
			end
			-- Money
			if sel[2] == 1 and x_f == -1 then
				x_f, y_f = find_money()
				if x_f > -1 then
					HUD_show_or_hide(HUD,hud_info,"找到金币加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
				end
			end
			-- Goods
			if sel[1] == 1 and x_f == -1 then
				x_f, y_f = find_goods()
				if x_f > -1 then
					HUD_show_or_hide(HUD,hud_info,"找到物品加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
				end
			end
			keepScreen(false)
			if x_f > -1 then
				keepScreen(true)
				x_t, y_t = find_normal(x_f, y_f)
				keepScreen(false)
			end
		else
			keepScreen(true)
			x_t, y_t = find_normal(x_f, y_f)
			keepScreen(false)
		end
		if x_t > -1 then
			random_touch(0, x_t, y_t, 0, 0)
			mSleep(1000)
			return RET_OK
		end
		mSleep(250)
	end
	return RET_ERR
end

function team_invite()
	local x, y = findColor({672, 383, 674, 385},
		"0|0|0xf3b25e,-212|2|0xdf6851,323|-352|0x5c5242,-630|-330|0x626467",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"继续邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function member_quit()
	local x, y = findColor({48, 422, 50, 424},
		"0|0|0x503f2d,8|-16|0xf5f7e9,-3|-35|0xcd343f,12|-30|0x473523",
		95, 0, 0, 0)
	return x, y
end

function full_exp_top()
	local x, y, top_mid, top_right
	top_mid = 0
	top_right = 0
	x, y = findColor({300, 200, 500, 400},
		"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
		95, 0, 0, 0)
	if x > -1 then
		top_mid = 1
	end
	x, y = findColor({600, 250, 800, 450},
		"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
		95, 0, 0, 0)
	if x > -1 then
		top_right = 1
	end
	
	return top_mid, top_right
end

function full_exp_bot()
	local x, y, bot_left, bot_right
	bot_left = 0
	bot_right = 0
	x, y = findColor({0, 250, 100, 450},
		"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
		95, 0, 0, 0)
	if x > -1 then
		bot_left = 1
	end
	x, y = findColor({400, 400, 600, 600},
		"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
		95, 0, 0, 0)
	if x > -1 then
		bot_right = 1
	end
	
	return bot_left, bot_right
end

function skkm_change_all()
	local x, y = findColor({44, 592, 46, 594},
		"0|0|0xffffff,122|20|0x4e3221,105|39|0x3e2d1c,851|22|0x391c12,759|31|0x493321",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_N()
	local x, y = findColor({54, 577, 56, 579},
		"0|0|0x87878a,10|18|0xdfdedd,95|54|0x3e2d1c,841|37|0x391c12,749|46|0x493321",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_egg()
	local x, y = findColor({49, 575, 51, 577},
		"0|0|0x2b90b1,28|6|0x46aece,100|56|0x3e2d1c,846|39|0x391c12,754|48|0x493321",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_sel()
	local x, y = findColor({78, 282, 80, 284},
		"0|0|0x48b0cf,69|7|0x7e7d81,152|51|0x0e5eb2,218|121|0x8d13c5,269|206|0xe9732e,287|298|0xfd2639",
		95, 0, 0, 0)
	return x, y
end

function df_normal_attack(pos_1, pos_2, pos_3)
	local x, y
	if pos_1 == 1 then
		x, y = findColor({829, 617, 831, 629},
			"0|0|0x096297,7|9|0x0a5d8f",
			80, 0, 0, 0)
		if x > -1 then
			random_touch(0, 875, 595, 10, 10)
		end
	end
	random_sleep(500)
	if pos_2 == 1 then
		x, y = findColor({928, 611, 930, 613},
			"0|0|0x0b6da8,8|12|0x096095",
			80, 0, 0, 0)
		if x > -1 then
			random_touch(0, 975, 595, 10, 10)
		end
	end
	random_sleep(500)
	if pos_3 == 1 then
		x, y = findColor({1032, 616, 1034, 618},
			"0|0|0x066dab,16|18|0x09598a",
			80, 0, 0, 0)
		if x > -1 then
			random_touch(0, 1075, 595, 10, 10)
		end
	end
end

function sushi_check()
	local x, y = findColor({916, 87, 918, 89},
		"0|0|0xcbb59c,-1|40|0xcbb59c,-257|19|0xcbb59c",
		95, 0, 0, 0)
	return x, y
end

-- Main func
function tansuo(mode, sel, mark, hard, section, count_mode, win_round, sec_round, captain_auto_invite, nor_attk, auto_change, page_jump, df_type, egg_color)
	print(string.format("模式: %s, 选择: 物品-%d,金币-%d,经验-%d,Boss-%d, 标记: %s, 难度: %s, 章节: %d, 限定: %s, 胜利: %s, 通关: %s, 邀请 %s",
			mode, sel[1], sel[2], sel[3], sel[4], mark, hard, section, count_mode, win_round, sec_round, captain_auto_invite))
	print(string.format("狗粮普攻 %d, 自动更换 %d, 初始翻页 %d, 狗粮类型 %s, 素材类型(红蛋 %d, 白蛋 %d, 蓝蛋 %d, 黑蛋 %d)",
			nor_attk, auto_change, page_jump, df_type, egg_color[1], egg_color[2], egg_color[3], egg_color[4]))
	print_global_vars()
	
	if mode == "单人" then
		tansuo_solo(sel, mark, hard, section, count_mode, win_round, sec_round, nor_attk, auto_change, page_jump, df_type, egg_color)
	elseif mode == "队长" then
		tansuo_captain(sel, mark, hard, section, count_mode, win_round, sec_round, captain_auto_invite, nor_attk, auto_change, page_jump, df_type, egg_color)
	elseif mode == "队员" then
		tansuo_member(sel, mark, nor_attk, auto_change, page_jump, df_type, egg_color)
	end
end

function tansuo_solo(sel, mark, hard, section, count_mode, win_round, sec_round, nor_attk, auto_change, page_jump, df_type, egg_color)
	local move_total = math.random(5, 6)
	local move_cnt = 0
	local scene_quit = 0
	local quit = 0
	local sec_cnt = 0
	local found_boss = 0
	local unlock = 0
	local hard_sel = 0
	local ret = RET_ERR
	local top_mid = 0
	local top_right = 0
	local local_buff_idle_stop = 0
	local tingyuan_time_cnt = 0
	local tansuo_time_cnt = 0
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y, x_, y_
	
	while (1) do
		while (1) do
			-- 战
			x, y = round_fight() if x > -1 then tansuo_mark(mark) break end
			-- 一回目
			x, y = round_one() if x > -1 then tansuo_mark(mark) break end
			-- 二回目
			x, y = round_two() if x > -1 then tansuo_mark(mark) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				-- 狗粮普攻
				if nor_attk == 1 then df_normal_attack(1, 1, 0) end
				break
			end
			-- 战斗胜利
			x, y = fight_success("单人") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				win_cnt.global = win_cnt.global + 1
				local_buff_idle_stop = 0
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.tansuo = win_cnt.tansuo + 1
				if count_mode == "战斗" then
					if win_cnt.tansuo >= win_round then
						scene_quit = 1
						quit = 1
					end
				end
				if found_boss == 1 then
					if count_mode == "章节" then
						sec_cnt = sec_cnt + 1
						if sec_cnt >= sec_round then
							scene_quit = 1
							quit = 1
						end
					end
					found_boss = 0
					scene_quit = 1
				end
				keep_half_damo()
				break
			end
			-- 自动狗粮
			if auto_change == 0 then
				-- 战斗准备
				x, y = fight_ready() if (x > -1) then break end
			else
				-- 更换式神
				x, y = skkm_change_all()
				if x > -1 then
					random_touch(0, 65, 585, 10, 10) -- 全部
					break
				end
				x, y = skkm_change_sel()
				if x > -1 then
					if df_type == "N" then
						random_touch(0, 155, 300, 5, 5) -- N
					elseif df_type == "Egg" then
						random_touch(0, 60, 285, 5, 5) -- 素材
					end
					random_sleep(750)
					break
				end
				-- N卡
				x, y = skkm_change_N()
				if x > -1 then
					if top_right == 1 or top_mid == 1 then
						for i = 1, page_jump -1 do
							find_offer()
							random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
							random_sleep(500)
						end
					end
					if top_right == 1 then
						random_move(0, 200, 500, 200, 250, 20, 20)
						random_sleep(1000)
					end
					if top_mid == 1 then
						random_move(0, 870, 500, 570, 250, 20, 20)
						random_sleep(1000)
					end
					fight_ready()
					top_mid = 0
					top_right = 0
					break
				end
				-- 素材
				x, y = skkm_change_egg()
				if x > -1 then
					if top_right == 1 or top_mid == 1 then
						for i = 1, page_jump - 1 do
							find_offer()
							random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
							random_sleep(500)
						end
					end
					if top_right == 1 then
						random_move(0, 200, 500, 200, 250, 20, 20)
						random_sleep(1000)
					end
					if top_mid == 1 then
						random_move(0, 870, 500, 570, 250, 20, 20)
						random_sleep(1000)
					end
					fight_ready()
					top_mid = 0
					top_right = 0
					break
				end
				-- 探索预备
				x, y = lct_exploration_prepare()
				if x > -1 then
					top_mid, top_right = full_exp_top()
					if top_mid == 1 or top_right == 1 then
						HUD_show_or_hide(HUD,hud_info,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
						random_sleep(500)
						random_touch(0, 350, 420, 30, 30) -- 更换式神
						random_sleep(500)
						break
					end
					random_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 探索场景
			x, y = lct_exploration()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				-- Quit
				if scene_quit == 1 then
					HUD_show_or_hide(HUD,hud_info,"退出场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 45, 60, 10, 10) -- 左上退出
					break
				end
				-- 寻找
				ret = find_target(sel)
				if ret == RET_ERR then
					-- Move
					move_cnt = move_cnt + 1
					HUD_show_or_hide(HUD,hud_info,string.format("场景移动[%d次]", move_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_move(0 ,950, 400, 200, 400, 50, 50) -- 场景移动
					if move_cnt >= move_total then
						scene_quit = 1
						break
					end
				elseif ret == RET_VALID then
					if sel[4] == 1 then
						mSleep(1000)
						x_, y_ = find_boss()
						if x_ > -1 then
							random_touch(0, x_, y_, 10, 10)
							mSleep(1000)
						end
					end
					found_boss = 1
				end
				break
			end
			-- 探索章节
			x, y = lct_exploration_portal()
			if x > -1 then
				if quit == 1 then
					random_touch(0, 930, 135, 5, 5) -- 退出章节
					return
				end
				if hard_sel == 0 then
					if hard == "普通" then
						random_touch(0, 300, 200, 20, 20) -- 普通
					elseif hard == "困难" then
						random_touch(0, 420, 200, 20, 20) -- 困难
					end
					random_sleep(500)
					hard_sel = 1
				end
				HUD_show_or_hide(HUD,hud_info,"进入场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_touch(0, 840, 480, 30, 10) -- 探索
				move_cnt = 0
				move_total = math.random(5, 6)
				scene_quit = 0
				mSleep(2000)
				break
			end
			-- 确认退出
			x, y = quit_confirm() if x > -1 then random_touch(0, x, y, 30, 5) break end
			-- Idle buff stop
			if local_buff_idle_stop == 1 then lct_buff(local_buff_idle_stop) local_buff_idle_stop = 0 break end
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() tingyuan_time_cnt, local_buff_idle_stop = tingyuan_idle_handle(tingyuan_time_cnt) break end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.tansuo = fail_cnt.tansuo + 1
				keep_fight_failed("单人")
				break
			end
			-- 御魂溢出
			x, y = yuhun_overflow() if x > -1 then break end
			-- 查看体力
			x, y = sushi_check() if x > -1 then lower_right_blank_click() break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then random_touch(0, 1024, 533, 30, 10) tansuo_time_cnt, local_buff_idle_stop = tansuo_idle_handle(tansuo_time_cnt) break end -- Temporarily enter last section
			-- Handle error
			x, y = lct_8dashe() if x > -1 then  random_touch(0, 928, 108, 5, 5) break end -- 八岐大蛇
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return
end

function tansuo_captain(sel, mark, hard, section, count_mode, win_round, sec_round, captain_auto_invite, nor_attk, auto_change, page_jump, df_type, egg_color)
	local move_total = math.random(5, 6)
	local move_cnt = 0
	local scene_quit = 0
	local quit = 0
	local sec_cnt = 0
	local found_boss = 0
	local unlock = 0
	local hard_sel = 0
	local ret = RET_ERR
	local bot_left = 0
	local bot_right = 0
	local local_buff_idle_stop = 0
	local tingyuan_time_cnt = 0
	local tansuo_time_cnt = 0
	local invite_zone = -1
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y, x_, y_
	
	if captain_auto_invite == "寮友" then
		invite_zone = 1
	elseif captain_auto_invite == "好友" then
		invite_zone = 2
	elseif captain_auto_invite == "跨区" then
		invite_zone = 3
	end
	
	while (1) do
		while (1) do
			-- 战
			x, y = round_fight() if x > -1 then tansuo_mark(mark) break end
			-- 一回目
			x, y = round_one() if x > -1 then tansuo_mark(mark) break end
			-- 二回目
			x, y = round_two() if x > -1 then tansuo_mark(mark) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				-- 狗粮普攻
				if nor_attk == 1 then df_normal_attack(1, 1, 0) end
				break
			end
			-- 战斗胜利
			x, y = fight_success("单人") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				win_cnt.global = win_cnt.global + 1
				local_buff_idle_stop = 0
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.tansuo = win_cnt.tansuo + 1
				if count_mode == "战斗" then
					if win_cnt.tansuo >= win_round then
						scene_quit = 1
						quit = 1
					end
				end
				if found_boss == 1 then
					if count_mode == "章节" then
						sec_cnt = sec_cnt + 1
						if sec_cnt >= sec_round then
							scene_quit = 1
							quit = 1
						end
					end
					found_boss = 0
					scene_quit = 1
				end
				keep_half_damo()
				break
			end
			-- 自动狗粮
			if auto_change == 0 then
				-- 战斗准备
				x, y = fight_ready() if (x > -1) then break end
			else
				-- 更换式神
				x, y = skkm_change_all()
				if x > -1 then
					random_touch(0, 65, 585, 10, 10) -- 全部
					break
				end
				x, y = skkm_change_sel()
				if x > -1 then
					if df_type == "N" then
						random_touch(0, 155, 300, 5, 5) -- N
					elseif df_type == "Egg" then
						random_touch(0, 60, 285, 5, 5) -- 素材
					end
					random_sleep(750)
					break
				end
				-- N卡
				x, y = skkm_change_N()
				if x > -1 then
					if bot_left == 1 or bot_right == 1 then
						for i = 1, page_jump -1 do
							find_offer()
							random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
							random_sleep(500)
						end
					end
					if bot_right == 1 then
						random_move(0, 200, 500, 300, 250, 20, 20)
						random_sleep(1000)
					end
					if bot_left == 1 then
						random_move(0, 870, 500, 830, 250, 20, 20)
						random_sleep(1000)
					end
					fight_ready()
					bot_right = 0
					bot_left = 0
					break
				end
				-- 素材
				x, y = skkm_change_egg()
				if x > -1 then
					if bot_left == 1 or bot_right == 1 then
						for i = 1, page_jump - 1 do
							find_offer()
							random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
							random_sleep(500)
						end
					end
					if bot_right == 1 then
						random_move(0, 200, 500, 300, 250, 20, 20)
						random_sleep(1000)
					end
					if bot_left == 1 then
						random_move(0, 870, 500, 830, 250, 20, 20)
						random_sleep(1000)
					end
					fight_ready()
					bot_right = 0
					bot_left = 0
					break
				end
				-- 探索预备
				x, y = lct_exploration_prepare()
				if x > -1 then
					bot_left, bot_right = full_exp_bot()
					if bot_left == 1 or bot_right == 1 then
						HUD_show_or_hide(HUD,hud_info,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
						random_touch(0, 350, 420, 30, 30) -- 更换式神
						break
					end
					random_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 探索场景
			x, y = lct_exploration()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				-- Quit
				if scene_quit == 1 then
					HUD_show_or_hide(HUD,hud_info,"退出场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 45, 60, 10, 10) -- 左上退出
					break
				end
				-- 寻找
				ret = find_target(sel)
				if ret == RET_ERR then
					-- Move
					move_cnt = move_cnt + 1
					HUD_show_or_hide(HUD,hud_info,string.format("场景移动[%d次]", move_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_move(0 ,950, 400, 200, 400, 50, 50) -- 场景移动
					if move_cnt >= move_total then
						scene_quit = 1
						break
					end
				elseif ret == RET_VALID then
					if sel[4] == 1 then
						mSleep(1000)
						x_, y_ = find_boss()
						if x_ > -1 then
							random_touch(0, x_, y_, 10, 10)
							mSleep(1000)
						end
					end
					found_boss = 1
				end
				break
			end
			-- 探索章节
			x, y = lct_exploration_portal()
			if x > -1 then
				if quit == 1 then
					random_touch(0, 930, 135, 5, 5) -- 退出章节
					return
				end
				if hard_sel == 0 then
					if hard == "普通" then
						random_touch(0, 300, 200, 20, 20) -- 普通
					elseif hard == "困难" then
						random_touch(0, 420, 200, 20, 20) -- 困难
					end
					random_sleep(500)
					hard_sel = 1
				end
				HUD_show_or_hide(HUD,hud_info,"邀请队员",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_touch(0, 580, 480, 30, 10) -- 组队
				mSleep(2000)
				break
			end
			-- 邀请第一个好友
			if (captain_auto_invite ~= "禁用") then
				x, y = captain_room_invite_first(invite_zone) 
				if (x > -1) then 
					scene_quit = 0
					move_cnt = 0
					move_total = math.random(5, 6)
					mSleep(3000) 
					break 
				end
			end
			-- 继续邀请
			x, y = team_invite()
			if x > -1 then
				if quit == 1 then
					random_touch(0, 465, 385, 20, 5)
				else
					random_touch(0, x, y, 20, 5)
					scene_quit = 0
					move_cnt = 0
					move_total = math.random(5, 6)
					mSleep(5000)
				end
				break
			end
			-- 确认退出
			x, y = quit_confirm() if x > -1 then random_touch(0, x, y, 30, 5) break end
			-- Idle buff stop
			if local_buff_idle_stop == 1 then lct_buff(local_buff_idle_stop) local_buff_idle_stop = 0 break end
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() tingyuan_time_cnt, local_buff_idle_stop = tingyuan_idle_handle(tingyuan_time_cnt) break end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.tansuo = fail_cnt.tansuo + 1
				keep_fight_failed("单人")
				break
			end
			-- 御魂溢出
			x, y = yuhun_overflow() if x > -1 then break end
			-- 查看体力
			x, y = sushi_check() if x > -1 then lower_right_blank_click() break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then random_touch(0, 1024, 533, 30, 10) tansuo_time_cnt, local_buff_idle_stop = tansuo_idle_handle(tansuo_time_cnt) break end -- Temporarily enter last section
			-- Handle error
			x, y = lct_8dashe() if x > -1 then  random_touch(0, 928, 108, 5, 5) break end -- 八岐大蛇
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return
end

function tansuo_member(sel, mark, nor_attk, auto_change, page_jump, df_type, egg_color)
	local unlock = 0
	local ret = RET_ERR
	local top_mid = 0
	local top_right = 0
	local local_buff_idle_stop = 0
	local tingyuan_time_cnt = 0
	local tansuo_time_cnt = 0
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y, x_, y_
	
	while (1) do
		while (1) do
			-- 战
			x, y = round_fight() if x > -1 then tansuo_mark(mark) break end
			-- 一回目
			x, y = round_one() if x > -1 then tansuo_mark(mark) break end
			-- 二回目
			x, y = round_two() if x > -1 then tansuo_mark(mark) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				-- 狗粮普攻
				if nor_attk == 1 then df_normal_attack(0, 1, 1) end
				break
			end
			-- 战斗胜利
			x, y = fight_success("单人") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				win_cnt.global = win_cnt.global + 1
				local_buff_idle_stop = 0
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.tansuo = win_cnt.tansuo + 1
				keep_half_damo()
				break
			end
			-- 探索场景
			x, y = lct_exploration()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				x_, y_ = member_quit()
				if x_ == -1 then
					random_touch(0, 47, 56, 5, 5) -- 左上退出
				end
				break
			end
			-- 接受邀请
			x, y, auto_grouped = member_team_accept_invite(1) if (x > -1) then break end
			-- 自动狗粮
			if auto_change == 0 then
				-- 战斗准备
				x, y = fight_ready() if (x > -1) then break end
			else
				-- 更换式神
				x, y = skkm_change_all()
				if x > -1 then
					random_touch(0, 65, 585, 10, 10) -- 全部
					break
				end
				x, y = skkm_change_sel()
				if x > -1 then
					if df_type == "N" then
						random_touch(0, 155, 300, 5, 5) -- N
					elseif df_type == "Egg" then
						random_touch(0, 60, 285, 5, 5) -- 素材
					end
					random_sleep(750)
					break
				end
				-- N卡
				x, y = skkm_change_N()
				if x > -1 then
					if top_right == 1 or top_mid == 1 then
						for i = 1, page_jump -1 do
							find_offer()
							random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
							random_sleep(500)
						end
					end
					if top_right == 1 then
						random_move(0, 200, 500, 200, 250, 20, 20)
						random_sleep(1000)
					end
					if top_mid == 1 then
						random_move(0, 870, 500, 570, 250, 20, 20)
						random_sleep(1000)
					end
					fight_ready()
					top_mid = 0
					top_right = 0
					break
				end
				-- 素材
				x, y = skkm_change_egg()
				if x > -1 then
					if top_right == 1 or top_mid == 1 then
						for i = 1, page_jump - 1 do
							find_offer()
							random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
							random_sleep(500)
						end
					end
					if top_right == 1 then
						random_move(0, 200, 500, 200, 250, 20, 20)
						random_sleep(1000)
					end
					if top_mid == 1 then
						random_move(0, 870, 500, 570, 250, 20, 20)
						random_sleep(1000)
					end
					fight_ready()
					top_mid = 0
					top_right = 0
					break
				end
				-- 探索预备
				x, y = lct_exploration_prepare()
				if x > -1 then
					top_mid, top_right = full_exp_top()
					if top_mid == 1 or top_right == 1 then
						HUD_show_or_hide(HUD,hud_info,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
						random_sleep(500)
						random_touch(0, 350, 420, 30, 30) -- 更换式神
						random_sleep(500)
						break
					end
					random_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 确认退出
			x, y = quit_confirm() if x > -1 then random_touch(0, x, y, 30, 5) break end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.tansuo = fail_cnt.tansuo + 1
				keep_fight_failed("单人")
				break
			end
			-- 御魂溢出
			x, y = yuhun_overflow() if x > -1 then break end
			-- 查看体力
			x, y = sushi_check() if x > -1 then lower_right_blank_click() break end
			-- Idle buff stop
			if local_buff_idle_stop == 1 then lct_buff(local_buff_idle_stop) local_buff_idle_stop = 0 break end
			-- 庭院
			x, y = lct_tingyuan() if x > -1 then tingyuan_time_cnt, local_buff_idle_stop = tingyuan_idle_handle(tingyuan_time_cnt) break end
			-- 探索
			x, y = lct_tansuo() if x > -1 then tansuo_time_cnt, local_buff_idle_stop = tansuo_idle_handle(tansuo_time_cnt) break end
			break
		end
	end
	return
end
