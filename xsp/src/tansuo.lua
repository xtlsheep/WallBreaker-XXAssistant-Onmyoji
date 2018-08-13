require "util"
require "func"

-- Util func
function lct_section_portal()
	local x, y = findColor({928, 132, 930, 134},
		"0|0|0xe9d6d0,-41|-22|0x493625,-673|312|0x404359,-606|320|0xe0bd5f",
		95, 0, 0, 0)
	return x, y
end

function lct_section()
	local x, y = findColor({997, 29, 999, 31},
		"0|0|0xdfc7a1,-386|-7|0x8fb060,-963|27|0xf0f5fb,88|538|0xcfccc7,-967|477|0x99345a",
		95, 0, 0, 0)
	return x, y
end

function tansuo_mark(mark)
	mSleep(500)
	local x, y
	local cnt = math.random(2, 4)
	local mark_ran = math.random(1, 3)
	if mark == "小怪" then
		if mark_ran == 1 then
			x = 566 y = 126
		elseif mark_ran == 2 then
			x = 697 y = 186
		else
			x = 861 y = 177
		end
		for i = 1, cnt do
			ran_touch(0, x, y, 5, 5)
		end
	elseif mark == "Boss" then
		for i = 1, cnt do
			ran_touch(0, 765, 60, 5, 5)
		end
	end
end

function quit_confirm()
	local x, y = findColor({688, 357, 690, 369},
		"0|0|0xf3b25e,-203|-5|0xf3b25e,397|207|0x555452,-658|146|0x3f1525",
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
		95, 0, 0, 0)
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
	local x, y = findColor({300, 100, 900, 200},
		"0|0|0xfdf2e4,4|-41|0xedacb3,-10|-2|0xe9a7ae",
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
		mSleep(200)
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


-- Main func
function tansuo(mode, sel, mark, hard, section, count_mode, win_round, sec_round)
	print(string.format("模式: %s, 选择: 物品-%d,金币-%d,经验-%d,Boss-%d, 标记: %s, 难度: %s, 章节: %d, 限定: %s, 胜利: %s, 通关: %s",
			mode, sel[1], sel[2], sel[3], sel[4], mark, hard, section, count_mode, win_round, sec_round))
	print_offer_arr()
	
	if mode == "单人" then
		tansuo_solo(sel, mark, hard, section, count_mode, win_round, sec_round)
	elseif mode == "队长" then
		tansuo_captain(sel, mark, "困难", section, count_mode, win_round, sec_round)
	elseif mode == "队员" then
		tansuo_member(sel, mark)
	end
end

function tansuo_solo(sel, mark, hard, section, count_mode, win_round, sec_round)
	local move_quit = math.random(6, 8)
	local move_cnt = 0
	local quit = 0
	local unlock = 0
	local hard_sel = 0
	local ret = RET_ERR
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y
	
	while (1) do
		while (1) do
			-- 超鬼王
			lct_sg_window()
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
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 场景
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
						x, y = find_boss()
						if x > -1 then
							ran_touch(0, x, y, 10, 10)
						end
					end
					quit = 1
				end
				break
			end
			-- 章节
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
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("单人")
				break
			end
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

function tansuo_captain(sel, mark, hard, section, count_mode, win_round, sec_round)
	local move_quit = math.random(6, 8)
	local move_cnt = 0
	local quit = 0
	local unlock = 0
	local hard_sel = 0
	local ret = RET_ERR
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y
	
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
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 场景
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
						x, y = find_boss()
						if x > -1 then
							ran_touch(0, x, y, 10, 10)
							mSleep(1000)
						end
					end
					quit = 1
				end
				break
			end
			-- 继续邀请
			x, y = team_invite()
			if x > -1 then
				ran_touch(0, x, y, 20, 5)
				quit = 0
				move_cnt = 0
				move_quit = math.random(6, 8)
				break
			end
			-- 确认退出
			x, y = quit_confirm() if x > -1 then ran_touch(0, x, y, 30, 5) break end
			-- 章节
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
			-- 组队界面
			team_init()
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("组队")
				break
			end
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

function tansuo_member(sel, mark)
	while (1) do
		while (1) do
			-- 超鬼王
			lct_sg_window()
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
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			x, y = lct_section()
			if x > -1 then
				x, y = member_quit()
				if x == -1 then
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
			break
		end
	end
	return
end