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

function yuling_mark(doll)
	local x = -1
	local y = -1
	
	if doll == 1 then
		x, y = findColor({650, 200, 700, 300}, -- 草人标记
			"0|0|0xda0b4b,-19|1|0xef44a9,18|1|0xf65cb8,3|24|0xd41636,-3|31|0xf9505d",
			95, 0, 0, 0)
		if x > -1 then
			return x, y
		end
		
		x, y = findColor({600, 250, 700, 350}, -- 草人血条
			"0|0|0xb1120e,3|0|0xb10e0b,6|0|0xb40e0b",
			95, 0, 0, 0)
		if x > -1 then
			random_touch(0, 700, 380, 5, 5) -- 草人
			mSleep(5000)
		end
	end
	return x, y
end

-- Main func
function yuling(sel, level, round, doll, lock)
	print(string.format("种类 %s，层数 %d, 次数 %d，草人 %d, 锁定 %d", sel, level, round, doll, lock))
	print_global_config()
	
	while (1) do
		yuling_(sel, level, round, doll, lock)
	end
	
	return RET_ERR
end

function yuling_(sel, level, round, doll, lock)
	local quit = 0
	local init = 1
	local x, y
	
	while (1) do
		while (1) do
			-- 战斗开始
			x, y = round_fight() if (x > -1) then break end
			mSleep(500)
			-- 循环通用
			ret = loop_generic() if ret == RET_RECONN then return RET_RECONN end
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("单人")
			if (x > -1) then
				win_cnt.global = win_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				win_cnt.yuling = win_cnt.yuling + 1
				if win_cnt.yuling >= round then
					quit = 1
				end
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
			-- 草人标记
			x, y = yuling_mark(doll) if x > -1 then break end
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then random_touch(0, 375, 590, 20, 20) break end -- 御灵
			-- 御灵选择
			x, y = lct_yuling_all()
			if (x > -1) then
				if quit == 1 then
					random_touch(0, 930, 110, 5, 5)
					lua_exit()
				end
				if (sel == "神龙") then
					random_touch(0, 230, 240, 20, 20)
				elseif (sel == "白藏主") then
					random_touch(0, 470, 240, 20, 20)
				elseif (sel == "黑豹") then
					random_touch(0, 700, 240, 20, 20)
				elseif (sel == "孔雀") then
					random_touch(0, 950, 240, 20, 20)
				end
			end
			-- 战斗失败
			x, y = fight_failed("单人")
			if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				fail_cnt.yuling = fail_cnt.yuling + 1
				break
			end
			break
		end
	end
	return RET_ERR
end