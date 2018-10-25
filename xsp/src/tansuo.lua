require "util"
require "func"

-- Util func
function lct_section()
	local x, y = findColor({777, 9, 779, 11},
		"0|0|0xe97b2c,219|20|0xdfc7a1,308|25|0xa29c7b,198|486|0xe97c2d",
		80, 0, 0, 0)
	return x, y
end

function lct_section_portal()
	local x, y = findColor({928, 132, 930, 134},
		"0|0|0xe9d6d0,-41|-22|0x493625,-673|312|0x404359,-606|320|0xe0bd5f",
		95, 0, 0, 0)
	return x, y
end

function lct_section_prepare()
	local x, y = findColor({27, 35, 29, 37},
		"0|0|0xd6c4a1,4|468|0x98335a,92|570|0xfefbe5,25|552|0xf6c990",
		95, 0, 0, 0)
	return x, y
end

function tansuo_mark(mark)
	mSleep(1000)
	ran_sleep(500)
	local x, y
	local cnt = math.random(1, 2)
	local ran = math.random(1, 3)
	if mark == "小怪" then
		if ran == 1 then
			x = 566 y = 126
		elseif ran == 2 then
			x = 697 y = 186
		else
			x = 861 y = 177
		end
		for i = 1, cnt do
			ran_touch(0, x, y, 10, 10)
		end
	elseif mark == "Boss" then
		for i = 1, cnt do
			ran_touch(0, 765, 60, 10, 10)
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
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现Boss",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function find_target(sel)
	local x_f = -1
	local y_f = -1
	local x_t = -1
	local y_t = -1
	
	for i = 1, 5 do
		x_t, y_t = find_boss()
		if x_t > -1 then
			return RET_VALID
		end
		
		if sel[1]==1 or sel[2]==1 or sel[3]==1 then
			keepScreen(true)
			-- Exp
			if sel[3] == 1 then
				x_f, y_f = find_exp()
			end
			-- Money
			if sel[2] == 1 and x_f == -1 then
				x_f, y_f = find_money()
			end
			-- Goods
			if sel[1] == 1 and x_f == -1 then
				x_f, y_f = find_goods()
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
			ran_touch(0, x_t, y_t, 0, 0)
			return RET_OK
		end
		mSleep(250)
	end
	return RET_ERR
end

function tansuo_move()
	x = 630 -- to 255/105 +- 30
	y = 530 -- to 530     +- 50
	x_ran = 30
	y_ran = 50
	x_interv = -30
	y_interv = math.random(-3, 3)
	steps = math.random(10, 15)
	
	ran_move_steps(0 ,x, y, x_ran, y_ran, x_interv, y_interv, steps)
end

function team_init()
	local x, y
	x, y = findColor({928, 132, 930, 134},
		"0|0|0xe8d4cf,-601|-2|0xeac89e,-499|-8|0xa26b4e,-399|-5|0xa26b4e",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, 464, 116, 10, 5) -- 好友
		return
	end
	x, y = findColor({928, 132, 930, 134},
		"0|0|0xe9d6d0,-604|-6|0xa26b4e,-501|-5|0xa26b4e,-397|-3|0xa26b4e",
		95, 0, 0, 0)
	if x > -1 then
		mSleep(5000)
		ran_touch(0, 464, 116, 10, 5) -- 好友
		return
	end
	x, y = findColor({928, 132, 930, 134},
		"0|0|0xe8d4cf,-500|0|0xeac89e,-603|-4|0xa26b4e,-399|-1|0xa26b4e",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, 444, 210, 30, 10) -- 第一个好友
		mSleep(500)
		ran_touch(0, 690, 510, 20, 10) -- 邀请
		mSleep(5000)
	end
end

function team_invite()
	local x, y = findColor({672, 383, 674, 385},
		"0|0|0xf3b25e,-212|2|0xdf6851,323|-352|0x5c5242,-630|-330|0x626467",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"继续邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function member_quit()
	local x, y = findColor({51, 409, 53, 411},
		"0|0|0xf8f9ee,-6|-21|0xcd3641,6|-18|0x473523",
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
	local x, y = findColor({26, 35, 28, 37},
		"0|0|0xd6c4a1,69|-17|0xd6c4a1,19|556|0xffffff,31|559|0x3537b9",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_N()
	local x, y = findColor({26, 35, 28, 37},
		"0|0|0xd6c4a1,69|-17|0xd6c4a1,29|540|0x838386,34|523|0x563f2b",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_egg()
	local x, y = findColor({26, 35, 28, 37},
		"0|0|0xd6c4a1,69|-17|0xd6c4a1,24|540|0x2d92b3,34|523|0x563f2b",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_sel()
	local x, y = findColor({42, 296, 44, 298},
		"0|0|0x2c92b3,91|11|0x828285,170|48|0x0d5cb1,244|110|0x860dc2",
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
			ran_touch(0, 875, 595, 10, 10)
		end
	end
	ran_sleep(500)
	if pos_2 == 1 then
		x, y = findColor({928, 611, 930, 613},
			"0|0|0x0b6da8,8|12|0x096095",
			80, 0, 0, 0)
		if x > -1 then
			ran_touch(0, 975, 595, 10, 10)
		end
	end
	ran_sleep(500)
	if pos_3 == 1 then
		x, y = findColor({1032, 616, 1034, 618},
			"0|0|0x066dab,16|18|0x09598a",
			80, 0, 0, 0)
		if x > -1 then
			ran_touch(0, 1075, 595, 10, 10)
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
function tansuo(mode, sel, mark, hard, section, count_mode, win_round, sec_round, nor_attk, auto_change, page_jump, df_type, egg_color)
	print(string.format("模式: %s, 选择: 物品-%d,金币-%d,经验-%d,Boss-%d, 标记: %s, 难度: %s, 章节: %d, 限定: %s, 胜利: %s, 通关: %s",
			mode, sel[1], sel[2], sel[3], sel[4], mark, hard, section, count_mode, win_round, sec_round))
	print(string.format("狗粮普攻 %d, 自动更换 %d, 初始翻页 %d, 狗粮类型 %s, 素材类型(红蛋 %d, 白蛋 %d, 蓝蛋 %d, 黑蛋 %d)",
			nor_attk, auto_change, page_jump, df_type, egg_color[1], egg_color[2], egg_color[3], egg_color[4]))
	print_global_vars()
	
	if mode == "单人" then
		tansuo_solo(sel, mark, hard, section, count_mode, win_round, sec_round, nor_attk, auto_change, page_jump, df_type, egg_color)
	elseif mode == "队长" then
		tansuo_captain(sel, mark, "困难", section, count_mode, win_round, sec_round, nor_attk, auto_change, page_jump, df_type, egg_color)
	elseif mode == "队员" then
		tansuo_member(sel, mark, nor_attk, auto_change, page_jump, df_type, egg_color)
	end
end

function tansuo_solo(sel, mark, hard, section, count_mode, win_round, sec_round, nor_attk, auto_change, page_jump, df_type, egg_color)
	local move_quit = math.random(6, 8)
	local move_cnt = 0
	local quit = 0
	local unlock = 0
	local hard_sel = 0
	local ret = RET_ERR
	local top_mid = 0
	local top_right = 0
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
			-- 自动检测
			x, y = auto_check() if x > -1 then break end
			-- 自动检测
			x, y = auto_check() if x > -1 then break end
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
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
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
					ran_touch(0, 65, 585, 10, 10) -- 全部
					break
				end
				x, y = skkm_change_sel()
				if x > -1 then
					if df_type == "N" then
						ran_touch(0, 140, 320, 5, 5) -- N
					elseif df_type == "Egg" then
						ran_touch(0, 55, 305, 5, 5) -- 素材
					end
					break
				end
				-- N卡
				x, y = skkm_change_N()
				if x > -1 then
					ran_sleep(1000)
					for i = 1, page_jump-1 do
						find_offer()
						ran_move_steps(0 ,760, 515, 50, 50, -30, math.random(-3, 3), 15) -- 翻页
						ran_sleep(500)
					end
					if top_right == 1 then
						ran_move_steps(0 ,420, 510, 10, 10, math.random(-18, -16), math.random(-16, -14), 15)
						ran_sleep(1000)
					end
					if top_mid == 1 then
						ran_move_steps(0 ,650, 510, 10, 10, math.random(-6, -5), math.random(-16, -14), 14)
						ran_sleep(1000)
					end
					fight_ready()
					top_mid = 0
					top_right = 0
					break
				end
				-- 素材
				x, y = skkm_change_egg()
				if x > -1 then
					for i = 1, page_jump do
						find_offer()
						ran_move_steps(0 ,760, 515, 50, 50, -30, math.random(-3, 3), 15) -- 翻页
						ran_sleep(250)
					end
					if top_right == 1 then
						ran_move_steps(0 ,420, 510, 10, 10, math.random(-18, -16), math.random(-16, -14), 15)
						ran_sleep(1000)
					end
					if top_mid == 1 then
						ran_move_steps(0 ,650, 510, 10, 10, math.random(-6, -5), math.random(-16, -14), 14)
						ran_sleep(1000)
					end
					top_mid = 0
					top_right = 0
					fight_ready()
					break
				end
				-- 探索预备
				x, y = lct_section_prepare()
				if x > -1 then
					top_mid, top_right = full_exp_top()
					if top_mid == 1 or top_right == 1 then
						HUD_show_or_hide(HUD,hud_scene,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
						ran_sleep(500)
						ran_touch(0, 350, 420, 30, 30) -- 更换式神
						ran_sleep(500)
						break
					end
					ran_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 探索场景
			x, y = lct_section()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				-- Quit
				if quit == 1 then
					HUD_show_or_hide(HUD,hud_scene,"退出场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 45, 60, 10, 10) -- 左上退出
					break
				end
				-- 寻找
				ret = find_target(sel)
				if ret == RET_ERR then
					-- Move
					move_cnt = move_cnt + 1
					HUD_show_or_hide(HUD,hud_scene,string.format("寻找ing... [移动%d次]", move_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
					tansuo_move()
					if move_cnt >= move_quit then
						quit = 1
						break
					end
				elseif ret == RET_VALID then
					if sel[4] == 1 then
						mSleep(1000)
						x_, y_ = find_boss()
						if x_ > -1 then
							ran_touch(0, x_, y_, 10, 10)
						end
					end
					quit = 1
				end
				break
			end
			-- 探索章节
			x, y = lct_section_portal()
			if x > -1 then
				if hard_sel == 0 then
					if hard == "普通" then
						ran_touch(0, 300, 200, 20, 20) -- 普通
					elseif hard == "困难" then
						ran_touch(0, 420, 200, 20, 20) -- 困难
					end
					ran_sleep(500)
					hard_sel = 1
				end
				HUD_show_or_hide(HUD,hud_scene,"进入场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
				ran_touch(0, 840, 480, 30, 10) -- 探索
				move_cnt = 0
				move_quit = math.random(6, 8)
				quit = 0
				mSleep(2000)
				break
			end
			-- 确认退出
			x, y = quit_confirm() if x > -1 then ran_touch(0, x, y, 30, 5) break end
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() break end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("单人")
				break
			end
			-- 御魂溢出
			x, y = yuhun_overflow() if x > -1 then break end
			-- 查看体力
			x, y = sushi_check()() if x > -1 then right_bottom_click() break end -- 右下空白
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 1024, 533, 30, 10) break end -- Temporarily enter last section
			-- Handle error
			x, y = lct_8dashe() if x > -1 then  ran_touch(0, 928, 108, 5, 5) break end -- 八岐大蛇
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return
end

function tansuo_captain(sel, mark, hard, section, count_mode, win_round, sec_round, nor_attk, auto_change, page_jump, df_type, egg_color)
	local move_quit = math.random(6, 8)
	local move_cnt = 0
	local quit = 0
	local unlock = 0
	local hard_sel = 0
	local ret = RET_ERR
	local bot_left = 0
	local bot_right = 0
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
			-- 自动检测
			x, y = auto_check() if x > -1 then break end
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
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
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
					ran_touch(0, 65, 585, 10, 10) -- 全部
					break
				end
				x, y = skkm_change_sel()
				if x > -1 then
					if df_type == "N" then
						ran_touch(0, 140, 320, 5, 5) -- N
					elseif df_type == "Egg" then
						ran_touch(0, 55, 305, 5, 5) -- 素材
					end
					break
				end
				-- N卡
				x, y = skkm_change_N()
				if x > -1 then
					ran_sleep(1000)
					for i = 1, page_jump-1 do
						find_offer()
						ran_move_steps(0 ,760, 515, 50, 50, -30, math.random(-3, 3), 15) -- 翻页
						ran_sleep(500)
					end
					if bot_right == 1 then
						ran_move_steps(0 ,420, 510, 10, 10, math.random(-9, -8), math.random(-17, -16), 15)
						ran_sleep(1000)
					end
					if  bot_left == 1 then
						ran_move_steps(0 ,650, 510, 10, 10, math.random(11, 13), math.random(-17, -16), 15)
						ran_sleep(1000)
					end
					fight_ready()
					top_mid = 0
					top_right = 0
					break
				end
				-- 素材
				x, y = skkm_change_egg()
				if x > -1 then
					for i = 1, page_jump do
						find_offer()
						ran_move_steps(0 ,760, 515, 50, 50, -30, math.random(-3, 3), 15) -- 翻页
						ran_sleep(250)
					end
					if bot_right == 1 then
						ran_move_steps(0 ,420, 510, 10, 10, math.random(-9, -8), math.random(-17, -16), 15)
						ran_sleep(1000)
					end
					if bot_left == 1 then
						ran_move_steps(0 ,650, 510, 10, 10, math.random(11, 13), math.random(-17, -16), 15)
						ran_sleep(1000)
					end
					top_mid = 0
					top_right = 0
					fight_ready()
					break
				end
				-- 探索预备
				x, y = lct_section_prepare()
				if x > -1 then
					bot_left, bot_right = full_exp_bot()
					if bot_left == 1 or bot_right == 1 then
						HUD_show_or_hide(HUD,hud_scene,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
						ran_touch(0, 350, 420, 30, 30) -- 更换式神
						break
					end
					ran_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 探索场景
			x, y = lct_section()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				-- Quit
				if quit == 1 then
					HUD_show_or_hide(HUD,hud_scene,"退出场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 45, 60, 10, 10) -- 左上退出
					break
				end
				-- 寻找
				ret = find_target(sel)
				if ret == RET_ERR then
					-- Move
					move_cnt = move_cnt + 1
					HUD_show_or_hide(HUD,hud_scene,string.format("寻找ing... [移动%d次]", move_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
					tansuo_move()
					if move_cnt >= move_quit then
						quit = 1
						break
					end
				elseif ret == RET_VALID then
					if sel[4] == 1 then
						mSleep(1000)
						x_, y_ = find_boss()
						if x_ > -1 then
							ran_touch(0, x_, y_, 10, 10)
							mSleep(1000)
						end
					end
					quit = 1
				end
				break
			end
			-- 探索章节
			x, y = lct_section_portal()
			if x > -1 then
				if hard_sel == 0 then
					if hard == "普通" then
						ran_touch(0, 300, 200, 20, 20) -- 普通
					elseif hard == "困难" then
						ran_touch(0, 420, 200, 20, 20) -- 困难
					end
					ran_sleep(500)
					hard_sel = 1
				end
				HUD_show_or_hide(HUD,hud_scene,"邀请队员",20,"0xff000000","0xffffffff",0,100,0,300,32)
				ran_touch(0, 580, 480, 30, 10) -- 组队
				mSleep(2000)
				break
			end
			-- 继续邀请
			x, y = team_invite()
			if x > -1 then
				ran_touch(0, x, y, 20, 5)
				quit = 0
				move_cnt = 0
				move_quit = math.random(6, 8)
				mSleep(5000)
				break
			end
			-- 确认退出
			x, y = quit_confirm() if x > -1 then ran_touch(0, x, y, 30, 5) break end
			-- 组队界面
			team_init()
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() break end
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("组队")
				break
			end
			-- 御魂溢出
			x, y = yuhun_overflow() if x > -1 then break end
			-- 查看体力
			x, y = sushi_check()() if x > -1 then right_bottom_click() break end -- 右下空白
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 1024, 533, 30, 10) break end -- Temporarily enter last section
			-- Handle error
			x, y = lct_8dashe() if x > -1 then  ran_touch(0, 928, 108, 5, 5) break end -- 八岐大蛇
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
			-- 接受邀请
			x, y, auto_grouped = member_team_accept_invite(1) if (x > -1) then break end
			-- 自动检测
			x, y = auto_check() if x > -1 then break end
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
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
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
					ran_touch(0, 65, 585, 10, 10) -- 全部
					break
				end
				x, y = skkm_change_sel()
				if x > -1 then
					if df_type == "N" then
						ran_touch(0, 140, 320, 5, 5) -- N
					elseif df_type == "Egg" then
						ran_touch(0, 55, 305, 5, 5) -- 素材
					end
					break
				end
				-- N卡
				x, y = skkm_change_N()
				if x > -1 then
					ran_sleep(1000)
					for i = 1, page_jump-1 do
						find_offer()
						ran_move_steps(0 ,760, 515, 50, 50, -30, math.random(-3, 3), 15) -- 翻页
						ran_sleep(500)
					end
					if top_right == 1 then
						ran_move_steps(0 ,420, 510, 10, 10, math.random(-18, -16), math.random(-16, -14), 15)
						ran_sleep(1000)
					end
					if top_mid == 1 then
						ran_move_steps(0 ,650, 510, 10, 10, math.random(-6, -5), math.random(-16, -14), 14)
						ran_sleep(1000)
					end
					fight_ready()
					top_mid = 0
					top_right = 0
					break
				end
				-- 素材
				x, y = skkm_change_egg()
				if x > -1 then
					for i = 1, page_jump do
						find_offer()
						ran_move_steps(0 ,760, 515, 50, 50, -30, math.random(-3, 3), 15) -- 翻页
						ran_sleep(250)
					end
					if top_right == 1 then
						ran_move_steps(0 ,420, 510, 10, 10, math.random(-18, -16), math.random(-16, -14), 15)
						ran_sleep(1000)
					end
					if top_mid == 1 then
						ran_move_steps(0 ,650, 510, 10, 10, math.random(-6, -5), math.random(-16, -14), 14)
						ran_sleep(1000)
					end
					top_mid = 0
					top_right = 0
					fight_ready()
					break
				end
				-- 探索预备
				x, y = lct_section_prepare()
				if x > -1 then
					top_mid, top_right = full_exp_top()
					if top_mid == 1 or top_right == 1 then
						HUD_show_or_hide(HUD,hud_scene,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
						ran_sleep(500)
						ran_touch(0, 350, 420, 30, 30) -- 更换式神
						ran_sleep(500)
						break
					end
					ran_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 探索场景
			x, y = lct_section()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				x_, y_ = member_quit()
				if x_ == -1 then
					ran_touch(0, 47, 56, 5, 5) -- 左上退出
				end
				break
			end
			-- 确认退出
			x, y = quit_confirm() if x > -1 then ran_touch(0, x, y, 30, 5) break end
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("组队")
				break
			end
			-- 御魂溢出
			x, y = yuhun_overflow() if x > -1 then break end
			-- 查看体力
			x, y = sushi_check()() if x > -1 then right_bottom_click() break end -- 右下空白
			-- 自动检测
			x, y = auto_check() if x > -1 then break end
			break
		end
	end
	return
end