require "util"
require "func"

-- Util func
function lct_yuling_all()
	local x, y = findColor({113, 157, 115, 169}, 
		"0|0|0xe1d8c8,-29|204|0xe2d8c8,193|452|0x322610,416|450|0x161a0d",
		95, 0, 0, 0)
	return x, y
end

function lct_yuling_single()
	local x, y = findColor({279, 464, 281, 466}, 
		"0|0|0x3a3e45,68|-1|0x3a3f46,132|-2|0x61476b,199|-1|0x6a543a",
		95, 0, 0, 0)
	return x, y
end

-- Main func
function yuling(sel, level, round, lock, offer_arr)
	print(string.format("种类 %s，层数 %d, 次数 %d，锁定 %d", sel, level, round, lock))
	print_offer_arr(offer_arr)
	
	local rd = round
	local win_cnt = 0
	local fail_cnt = 0
	local init = 1
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y
	
	while (1) do
		while (1) do
			-- 战斗开始
			x, y = round_fight() if (x > -1) then break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("单人") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				win_cnt = win_cnt + 1
				rd = rd - 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo(offer_arr)
				break
			end
			-- 御灵
			x, y = lct_yuling_single()
			if (x > -1) then
				level_select(level, init, lock, "御灵")
				init = 0
				solo_start()
				break
			end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 退出
			if (rd <= 0) then
				return
			end
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 375, 590, 20, 20) break end -- 御灵
			-- 御灵选择
			x, y = lct_yuling_all()
			if (x > -1) then
				if (sel == "神龙") then
					ran_touch(0, 230, 240, 20, 20)
				elseif (sel == "白藏主") then
					ran_touch(0, 470, 240, 20, 20)
				elseif (sel == "黑豹") then
					ran_touch(0, 700, 240, 20, 20)
				elseif (sel == "孔雀") then
					ran_touch(0, 950, 240, 20, 20)
				end
			end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("单人",offer_arr)
				break
			end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
end