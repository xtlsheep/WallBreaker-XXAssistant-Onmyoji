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
		HUD_show_or_hide(HUD,hud_scene,"妖气封印 - 匹配中",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function yqfy_mark(mark)
	mSleep(1000)
	ran_sleep(500)
	local pos = math.random(1, 3)
	local cnt = math.random(1, 2)
	local pos_x = {350, 550, 750}
	local pos_y = {200, 200, 200}
	
	for i = 1, cnt do
		ran_interv()
		if mark == "大怪" then
			ran_touch(0, 555, 75, 10, 30)
		elseif (mark == "小怪") then
			ran_touch(0, pos_x[pos], pos_y[pos], 10, 10)
		end
	end
end

function yqfy_deny_quit()
	local x, y = findColor({460, 382, 462, 384},
		"0|0|0xdf6851,212|1|0xf3b25e,269|111|0x080807",
		80, 0, 0, 0)
	if x > -1 then
		ran_sleep(500)
		ran_touch(0, x, y, 30, 10)
	end
	return x, y
end

-- Main func
function yqfy(round, sel, mark)
	print(string.format("次数 %d 妖气 %s 标记 %s", round, sel, mark))
	print_offer_arr()
	
	local ran_wait = 0
	local rd_cnt = 0
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y
	
	while (1) do
		while (1) do
			-- 一回目
			x, y = round_one() if (x > -1) then yqfy_mark(mark) break end
			-- 二回目
			x, y = round_two() if (x > -1) then yqfy_mark(mark) break end
			-- 三回目
			x, y = round_three() if (x > -1) then yqfy_mark(mark) break end
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 庭院
			x, y = lct_tingyuan()
			if (x > -1) then
				if rd_cnt == round then
					return
				end
				ran_wait = math.random(1000, 3000)
				HUD_show_or_hide(HUD,hud_scene,string.format("随机等待时间: %s ms", ran_wait),20,"0xff000000","0xffffffff",0,100,0,300,32)
				mSleep(ran_wait)
				tingyuan_enter_zudui()
				break
			end
			-- 自动匹配
			x, y = yqfy_queue() if x > -1 then break end
			-- 妖气封印
			x, y = lct_yqfy()
			ran_sleep(500)
			if x > -1 then
				if sel == "跳跳哥哥" then
					ran_touch(0, 430, 230, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				elseif sel == "椒图" then
					ran_touch(0, 430, 290, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				elseif sel == "骨女" then
					ran_touch(0, 430, 350, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				elseif sel == "饿鬼" then
					ran_touch(0, 430, 410, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				elseif sel == "二口女" then
					ran_touch(0, 430, 470, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				elseif sel == "海坊主" then
					ran_move_steps(0, 430, 470, 20, 20, math.random(-3, 3), math.random(-17, -15), 15)
					ran_touch(0, 430, 310, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				elseif sel == "鬼使黑" then
					ran_move_steps(0, 430, 470, 20, 20, math.random(-3, 3), math.random(-17, -15), 15)
					ran_touch(0, 430, 370, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				elseif sel == "小松丸" then
					ran_move_steps(0, 430, 470, 20, 20, math.random(-3, 3), math.random(-17, -15), 15)
					ran_touch(0, 430, 430, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				elseif sel == "日和坊" then
					ran_move_steps(0, 430, 470, 20, 20, math.random(-3, 3), math.random(-17, -15), 15)
					ran_touch(0, 430, 490, 50, 10)
					ran_sleep(1000)
					ran_touch(0, 680, 560, 50, 10)
				end
				ran_sleep(500)
				break
			end
			-- 组队
			x, y = lct_zudui()
			if (x > -1) then
				HUD_show_or_hide(HUD,hud_scene,"组队",20,"0xff000000","0xffffffff",0,100,0,300,32)
				ran_sleep(500)
				if linkage == 1 then
					ran_move_steps(0, 230, 455, 20, 20, math.random(-3, 3), math.random(-26, -24), 12)
					ran_sleep(1000)
					ran_touch(0, 220, 145, 50, 10)
				else
					ran_touch(0, 220, 520, 50, 10)
				end
				ran_sleep(500)
				break
			end
			-- 队员接手队长
			x, y = member_room_find_start() if (x > -1) then ran_touch(0, 925, 535, 20, 10) break end -- 开始战斗
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then HUD_show_or_hide(HUD,hud_scene,"战斗准备",20,"0xff000000","0xffffffff",0,100,0,300,32) break end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo()
				break
			end
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("组队")
				break
			end
			-- 取消退出
			x, y = yqfy_deny_quit() if x > -1 then break end
			-- 退出个人资料
			x, y = member_room_user_profile() if x > -1 then break end
			-- 自动检测
			x, y = auto_check() if x > -1 then break end
			-- Error Handle
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
end