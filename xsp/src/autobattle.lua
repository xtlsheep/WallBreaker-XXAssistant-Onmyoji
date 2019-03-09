require "util"
require "func"

-- Util func
function lct_douji()
	local x, y = findColor({1046, 119, 1048, 121},
		"0|0|0xf0d3d2,-35|-1|0xa48959,-43|-10|0x5f3832,-35|9|0x181d4d",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"斗技",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function lct_rank()
	local x, y = findColor({1046, 119, 1048, 121},
		"0|0|0xe8d4cf,-937|27|0x9c7f4e,-924|342|0xfaeaa2,-904|347|0x241e1e",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 1050, 225, 5, 10)
	end
	return x, y
end

function lct_grade()
	local x, y = findColor({1046, 119, 1048, 121},
		"0|0|0xe8d4cf,-937|27|0x9c7f4e,-924|342|0xfaeaa2,-905|350|0xded5c6",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 1050, 225, 5, 10)
	end
	return x, y
end

function battle_success()
	function success_drum()
		local x, y = findColor({421, 75, 430, 145},
			"0|0|0x821c12,-24|43|0x9c1c12,27|40|0x9a1c12,297|26|0xd6be8d",
			95, 0, 0, 0)
		return x, y
	end
	
	local x, y
	local cnt = 0
	
	x, y = success_drum()
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"斗技胜利",20,"0xff000000","0xffffffff",0,100,0,300,32)
		while (1) do
			loop_generic()
			x, y = success_drum()
			if x > -1 then
				right_lower_click()
			elseif x == -1 then
				return RET_OK, RET_OK
			end
			cnt = cnt + 1
			if cnt >= 10 then
				return RET_OK, RET_OK
			end
			random_sleep(50)
		end
	end
	
	return RET_ERR, RET_ERR
end

function upgrade()
	local x, y = findColor({1046, 119, 1048, 121},
		"0|0|0x5d5553,-275|120|0xfff6e0,-307|190|0xd84031,-276|177|0x957742",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"段位上升",20,"0xff000000","0xffffffff",0,100,0,300,32)
		right_lower_click()
	end
	return x, y
end

-- Main func
function autobattle(round, round_time, force_quit, mark_self, mark)
	print(string.format("胜利次数 %d, 回合时间 %d, 强制退出 %d, 己方标记 %s, 敌方标记 %d", round, round_time, force_quit, mark_self, mark))
	print_global_config()
	
	local quit = 0
	local time_cnt = 0
	local x, y, x_, y_
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 循环通用
			loop_generic()
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing()
			if x > -1 then
				if (force_quit == 1) or (time_cnt*500 > round_time*1000) then
					random_touch(0, 30, 30, 5, 5) -- 右上退出
					mSleep(500)
				end
				time_cnt = time_cnt + 1
				x_, y_ = manual_detect()
				break
			end
			-- 战斗胜利
			x, y = battle_success()
			if x > -1 then
				if win_cnt.battle > round then
					quit = 1
				end
				time_cnt = 0
				win_cnt.global = win_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.battle = win_cnt.battle + 1
			end
			-- 战斗失败
			x, y = fight_failed()
			if (x > -1) then
				time_cnt = 0
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.battle = fail_cnt.battle + 1
				break
			end
			-- 领取奖励
			x, y = get_bonus() if x > -1 then break end
			-- 排名
			x, y = lct_rank() if x > -1 then break end
			-- 段位
			x, y = lct_grade() if x > -1 then break end
			-- 斗技
			x, y = lct_douji()
			if x > -1 then
				if quit == 1 then
					random_touch(0, 1050, 120, 10, 10)
					return RET_OK
				end
				random_touch(0, 950, 500, 10, 10)
				break
			end
			-- 确认退出
			x, y = quit_confirm("确认") if x > -1 then mSleep(500) break end
			-- 段位上升
			x, y = upgrade() if x > -1 then break end
			-- 町中
			x, y = lct_dingzhong() if x > -1 then random_touch(0, 690, 150, 5, 5) break end
			-- 庭院
			x, y = lct_tingyuan() if x > -1 then tingyuan_enter_dingzhong() break end
			break
		end
	end
	
	return RET_ERR
end