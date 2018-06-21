require "util"
require "func"

-- Main func
function yuling(sel, round, lock, offer_arr)
	print(string.format("种类 %s，次数 %d，锁定 %d", sel, round, lock))
	
	rd = round
	win_cnt = 0
	fail_cnt = 0
	x = -1
	y = -1
	disconn_fin = 1
	real_8dashe = 0
	secret_vender = 0
	
	while (1) do
		while (1) do
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
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 退出
			if (rd_ <= 0) then
				return
			end
			-- 庭院
			x, y = find_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 180, 590, 20, 20) break end -- 御魂
			-- 进入御灵
			
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed(offer_arr)
				break
			end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
end