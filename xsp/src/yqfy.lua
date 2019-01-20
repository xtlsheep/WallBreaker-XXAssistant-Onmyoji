require "util"
require "func"

-- Util func
function lct_yqfy()
	local x, y = findColor({368, 115, 370, 117},
		"0|0|0xf7f2df,12|-1|0x4f0c0c,42|4|0xf8f3e0,42|-5|0xf8f3e0,23|441|0xf3b25e",
		80, 0, 0, 0)
	return x, y
end

function yqfy_queue()
	local x, y = findColor({368, 115, 370, 117},
		"0|0|0xf7f2df,12|1|0x4d0c0c,362|378|0x151311,251|441|0xf3b25e,497|443|0xb0a9a1",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"妖气封印 - 匹配中",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function yqfy_mark(mark)
	random_sleep(500)
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
		80, 0, 0, 0)
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
	
	local quit = 0
	local ran_wait = 0
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
            loop_generic()
            -- 拒绝邀请
            x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 庭院
			x, y = lct_tingyuan()
			if (x > -1) then
				if quit == 1 then
					return RET_OK
				end
				ran_wait = math.random(500, 1000)
				HUD_show_or_hide(HUD,hud_info,string.format("随机等待时间: %s ms", ran_wait),20,"0xff000000","0xffffffff",0,100,0,300,32)
				mSleep(ran_wait)
				tingyuan_enter_zudui()
				break
			end
			-- 自动匹配
			x, y = yqfy_queue() if x > -1 then break end
			-- 妖气封印
			x, y = lct_yqfy()
			random_sleep(500)
			if x > -1 then
				if sel == "跳跳哥哥" then
					random_touch(0, 430, 230, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				elseif sel == "椒图" then
					random_touch(0, 430, 290, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				elseif sel == "骨女" then
					random_touch(0, 430, 350, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				elseif sel == "饿鬼" then
					random_touch(0, 430, 410, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				elseif sel == "二口女" then
					random_touch(0, 430, 470, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				elseif sel == "海坊主" then
					random_move(0, 430, 470, 430, 230, 50, 10)
					random_sleep(750)
					random_touch(0, 430, 310, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				elseif sel == "鬼使黑" then
					random_move(0, 430, 470, 430, 230, 50, 10)
					random_sleep(750)
					random_touch(0, 430, 370, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				elseif sel == "小松丸" then
					random_move(0, 430, 470, 430, 230, 50, 10)
					random_sleep(750)
					random_touch(0, 430, 430, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				elseif sel == "日和坊" then
					random_move(0, 430, 470, 430, 230, 50, 10)
					random_sleep(750)
					random_touch(0, 430, 490, 50, 10)
					random_sleep(750)
					random_touch(0, 680, 560, 50, 10)
				end
				random_sleep(500)
				break
			end
			-- 组队
			x, y = lct_zudui()
			if (x > -1) then
				HUD_show_or_hide(HUD,hud_info,"组队",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_sleep(500)
				if linkage == "Enable" then
					random_move(0, 220, 520, 220, 130, 50, 10)
					random_sleep(750)
					random_touch(0, 220, 145, 50, 10)
				elseif linkage == "Disable" then
					random_touch(0, 220, 520, 50, 10)
				end
				random_sleep(750)
				break
			end
			-- 队员接手队长
			x, y = member_room_find_start() if (x > -1) then random_touch(0, 925, 535, 20, 10) break end -- 开始战斗
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then HUD_show_or_hide(HUD,hud_info,"战斗准备",20,"0xff000000","0xffffffff",0,100,0,300,32) break end
			-- 战斗胜利
			x, y = fight_success("组队") 
			if (x > -1) then
				win_cnt.global = win_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.yqfy = win_cnt.yqfy + 1
				if win_cnt.yqfy >= round then
					quit = 1
				end
				break
			end
			-- 战斗失败
			x, y = fight_failed("组队") 
			if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.yqfy = fail_cnt.yqfy + 1
				break
			end
			-- 取消退出
			x, y = yqfy_deny_quit() if x > -1 then break end
			-- 退出个人资料
			x, y = member_room_user_profile() if x > -1 then break end
			break
		end
	end
	return RET_ERR
end