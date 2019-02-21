require "util"
require "func"

-- Util func
function lct_yqfy()
	local x, y = findColor({773, 101, 775, 103},
		"0|0|0xe87b2a,-393|15|0x4d0c0c,-421|45|0xfec266,287|10|0xe8d4cf",
		90, 0, 0, 0)
	return x, y
end

function zudui_move()
	random_move(0, 220, 550, 220, 130, 50, 10)
end

function yqfy_queue()
	local x, y = findColor({854, 100, 856, 102},
		"0|0|0xe97c2c,205|11|0xe8d4cf,-173|457|0xf3b25e,-112|400|0x262422",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"匹配中",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function yqfy_mark(mark)
	local pos
	local cnt
	local pos_x = {350, 550, 750}
	local pos_y = {200, 200, 200}
	
	cnt = math.random(2, 3)
	for i = 1, cnt do
		random_sleep(150)
		pos = math.random(1, 3)
		if mark == "大怪" then
			random_touch(0, 555, 75, 10, 30)
		elseif (mark == "小怪") then
			random_touch(0, pos_x[pos], pos_y[pos], 10, 10)
		end
	end
end

function yqfy_deny_quit()
	local x, y = findColor({460, 382, 462, 384},
		"0|0|0xdf6851,212|1|0xf3b25e,269|111|0x080807",
		90, 0, 0, 0)
	if x > -1 then
		random_sleep(500)
		random_touch(0, x, y, 30, 10)
	end
	return x, y
end

-- Main func
function yqfy(round, sel, mark)
	print(string.format("次数 %d 妖气 %s 标记 %s", round, sel, mark))
	print_global_config()
	local ret
	
	while (1) do
		ret = yqfy_(round, sel, mark)
		if ret ~= RET_RECONN then
			return ret
		end
	end
	
	return RET_ERR
end

function yqfy_(round, sel, mark)
	local quit = 0
	local wait = 0
	local ran_wait = 0
	local selected = 0
	local ret = 0
	local x, y
	
	while (1) do
		while (1) do
			-- 一回目
			x, y = round_one() if (x > -1) then yqfy_mark(mark) break end
			-- 二回目
			x, y = round_two() if (x > -1) then yqfy_mark(mark) break end
			-- 三回目
			x, y = round_three() if (x > -1) then yqfy_mark(mark) break end
			mSleep(500)
			-- 循环通用
			ret = loop_generic() if ret == RET_RECONN then return RET_RECONN end
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 庭院
			x, y = lct_tingyuan()
			if (x > -1) then
				if quit == 1 then
					lua_exit()
				end
				-- 等待
				if wait == 1 then
					if sel == "联动" then
						ran_wait = 30*60*1000 + math.random(1000, 5000)
					elseif sel == "石距" then
						ran_wait = 60*60*1000 + math.random(1000, 5000)
					elseif sel == "年兽" then
						ran_wait = 10*60*60*1000 + math.random(1000, 5000)
					else
						ran_wait = math.random(500, 1000)
						HUD_show_or_hide(HUD,hud_info,string.format("随机等待时间: %s s", ran_wait/1000),20,"0xff000000","0xffffffff",0,100,0,300,32)
						mSleep(ran_wait)
					end
				end
				tingyuan_enter_zudui()
				break
			end
			-- 自动匹配
			x, y = yqfy_queue() if x > -1 then break end
			-- 妖气封印
			x, y = lct_yqfy()
			if x > -1 then
				HUD_show_or_hide(HUD,hud_info,"妖气封印",20,"0xff000000","0xffffffff",0,100,0,300,32)
				if sel == "跳跳哥哥" then
					random_touch(0, 430, 230, 50, 10)
				elseif sel == "椒图" then
					random_touch(0, 430, 290, 50, 10)
				elseif sel == "骨女" then
					random_touch(0, 430, 350, 50, 10)
				elseif sel == "饿鬼" then
					random_touch(0, 430, 410, 50, 10)
				elseif sel == "二口女" then
					random_touch(0, 430, 470, 50, 10)
				elseif sel == "海坊主" then
					random_move(0, 430, 500, 430, 200, 50, 10)
					random_sleep(1000)
					random_touch(0, 430, 310, 50, 10)
				elseif sel == "鬼使黑" then
					random_move(0, 430, 500, 430, 200, 50, 10)
					random_sleep(1000)
					random_touch(0, 430, 370, 50, 10)
				elseif sel == "小松丸" then
					random_move(0, 430, 500, 430, 200, 50, 10)
					random_sleep(1000)
					random_touch(0, 430, 430, 50, 10)
				elseif sel == "日和坊" then
					random_move(0, 430, 500, 430, 200, 50, 10)
					random_sleep(1000)
					random_touch(0, 430, 490, 50, 10)
				end
				mSleep(1000)
				right_lower_click()
				selected = 1
				break
			end
			-- 组队
			x, y = lct_zudui()
			if (x > -1) then
				HUD_show_or_hide(HUD,hud_info,"组队",20,"0xff000000","0xffffffff",0,100,0,300,32)
				if selected == 1 then
					random_touch(0, 680, 560, 50, 10)
					selected = 0
					break
				end
				if sel == "联动" then
					if linkage == "Enable" then
						random_touch(0, 220, 150, 50, 10) -- 联动
						selected = 1
					else
						HUD_show_or_hide(HUD,hud_info,"未开启联动活动",20,"0xff000000","0xffffffff",0,100,0,300,32)
					end
				elseif sel == "石距" then
					zudui_move()
					random_sleep(1000)
					random_touch(0, 220, 410, 50, 10) -- 石距
					selected = 1
				elseif sel == "年兽" then
					zudui_move()
					random_sleep(1000)
					random_touch(0, 220, 350, 50, 10) -- 年兽
					selected = 1
				else
					if linkage == "Enable" then
						zudui_move()
						random_sleep(1000)
						random_touch(0, 220, 150, 50, 10) -- 妖气封印
					elseif linkage == "Disable" then
						random_touch(0, 220, 520, 50, 10) -- 妖气封印
					end
					selected = 1
				end
				random_sleep(1000)
				break
			end
			-- 队员接手队长
			x, y = member_room_find_start() if (x > -1) then random_touch(0, 925, 535, 20, 10) break end -- 开始战斗
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then HUD_show_or_hide(HUD,hud_info,"战斗准备",20,"0xff000000","0xffffffff",0,100,0,300,32) break end
			-- 战斗胜利
			x, y = fight_success()
			if (x > -1) then
				wait = 1
				win_cnt.global = win_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.yqfy = win_cnt.yqfy + 1
				if win_cnt.yqfy >= round then
					quit = 1
				end
				break
			end
			-- 战斗失败
			x, y = fight_failed()
			if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.yqfy = fail_cnt.yqfy + 1
				break
			end
			-- 取消退出
			x, y = yqfy_deny_quit() if x > -1 then break end
			-- 退出个人资料
			x, y = member_user_profile() if x > -1 then break end
			break
		end
	end
	return RET_ERR
end