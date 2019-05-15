require "util"
require "func"

-- Util func
function lct_weishen()
	local x, y = findColorInRegionFuzzy(0xe4d08f, 95, 1038, 515, 1040, 517, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 20, 20)
		mSleep(1000)
	end
	return x, y
end

-- Main func
function WeiShenArrival()
	print_global_config()
	
	local x, y
	
	while (1) do
		while (1) do
			-- 战
			x, y = round_fight() if x > -1 then break end
			mSleep(500)
			-- 循环通用
			loop_generic()
			-- 战斗准备
			x, y = fight_ready() if x > -1 then break end
			-- 战斗进行
			x, y = fight_ongoing() if x > -1 then break end
			-- 战斗胜利
			x, y = fight_success()
			if (x > -1) then
				win_cnt.global = win_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				break
			end
			-- 伪神降临
			x, y = lct_weishen() if x > -1 then break end
			-- 战斗失败
			x, y = fight_failed()
			if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				break
			end
		end
	end
	return RET_ERR
end