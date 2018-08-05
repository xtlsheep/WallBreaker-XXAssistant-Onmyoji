require "util"
require "func"

-- Util func
function lct_yyh()
	local x, y = findColor({807, 439, 819, 441}, -- 业原火
		"0|0|0xf3b25e,-59|-236|0xdd7cb3,-124|-168|0xf2faf9,-83|-142|0x2eae93",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"业原火",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

-- Main func
function yeyuanhuo(round_tan, round_chen, round_chi, lock, offer_arr)
	print(string.format("贪 %d, 嗔 %d, 痴 %d，锁定 %d", round_tan, round_chen, round_chi, lock))
	
	local rd_tan = round_tan
	local rd_chen = round_chen
	local rd_chi = round_chi
	local win_cnt = 0
	local fail_cnt = 0
	local end_tan = 0
	local end_chen = 0
	local end_chi = 0
	local last_sel = 0
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
				if (last_sel == "tan") then
					rd_tan = rd_tan - 1
				elseif (last_sel == "chen") then
					rd_chen = rd_chen - 1
				elseif (last_sel == "chi") then
					rd_chi = rd_chi - 1
				end
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo(offer_arr)
				break
			end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 退出
			if (rd_tan <= 0) then
				end_tan = 1
			end
			if (rd_chen <= 0) then
				end_chen = 1
			end
			if (rd_chi <=0 ) then
				end_chi = 1
			end
			if (end_tan == 1 and end_chen == 1 and end_chi == 1) then
				return
			end
			-- 业原火
			x, y = lct_yyh()
			if x > -1 then
				-- 锁定 or not
				lock_or_unlock(lock, "业原火")
				-- 贪
				if (end_tan ~= 1 and rd_tan > 0) then
					if (last_sel ~= "tan") then
						ran_touch(0, 360, 160, 50, 10) -- 贪
					end
					ran_sleep(250)
					ret = solo_start()
					if (ret == RET_ERR) then
						end_tan = 1
						break
					end
					last_sel = "tan"
					break
				end
				-- 嗔
				if (end_chen ~= 1 and rd_chen > 0) then
					if (last_sel ~= "chen") then
						ran_touch(0, 360, 250, 50, 10) -- 嗔
					end
					ran_sleep(250)
					ret = solo_start()
					if (ret == RET_ERR) then
						end_chen = 1
						break
					end
					last_sel = "chen"
					break
				end
				-- 痴
				if (end_chi ~= 1 and rd_chi > 0) then
					if (last_sel ~= "chi") then
						ran_touch(0, 360, 330, 50, 10) -- 痴
					end
					ran_sleep(250)
					ret = solo_start()
					if (ret == RET_ERR) then
						end_chi = 1
						break
					end
					last_sel = "chi"
					break
				end
			end
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 180, 590, 20, 20) ran_sleep(1000) break end -- 御魂
			-- 御魂
			x, y = lct_yuhun() if (x > -1) then ran_touch(0, 845, 320, 50, 50) ran_sleep(1000) break end -- 业原火
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("单人",offer_arr)
				break
			end
			-- Handle error
			x, y = lct_8dashe() if x > -1 then  ran_touch(0, 928, 108, 5, 5) break end -- 八岐大蛇
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
end