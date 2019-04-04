require "util"
require "func"

-- Util func
function lct_bmd()
	local x, y = findColor({734, 479, 736, 481}, 
"0|0|0xe97c2c,166|-460|0xe97b2a,174|-379|0xe8d4cf,-225|0|0xe87c2c",
95, 0, 0, 0)
if x > -1 then
	HUD_show_or_hide(HUD,hud_info,"血月梦境",20,"0xff000000","0xffffffff",0,100,0,300,32)
end
return x, y
end

function bmd_mark(position)
	local cnt = math.random(2, 3)
	mSleep(1000)
	for i = 1, cnt do
		if position == "左" then
			random_touch(0, 390, 200, 10, 10)
		elseif position == "中" then
			random_touch(0, 530, 145, 10, 10)
		elseif position == "右" then
			random_touch(0, 670, 200, 10, 10)
		end
	end
end

-- Main func
function BloodMoonDream(level, round, round1, round2, round3)
	print(string.format("层数 %d, 次数 %d，标记 (一 %s, 二 %s, 三 %s)", level, round, round1, round2, round3))
	print_global_config()
	
	local x, y
	local init = 0
	local cnt = 0
	
	while (1) do
		while (1) do
			-- 一回目
			x, y = round_one() if (x > -1) then bmd_mark(round1) break end
			-- 二回目
			x, y = round_two() if (x > -1) then bmd_mark(round2) break end
			-- 三回目
			x, y = round_three() if (x > -1) then bmd_mark(round3) break end
			mSleep(500)
			-- 循环通用
			ret = loop_generic() if ret == RET_RECONN then return RET_RECONN end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if x > -1 then break end
			-- 战斗胜利
			x, y = fight_success()
			if (x > -1) then
				cnt = cnt + 1
				if cnt > round then
					return RET_OK
				end
				win_cnt.global = win_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				break
			end
			-- 战斗失败
			x, y = fight_failed()
			if (x > -1) then
				fail_cnt.global = fail_cnt.global + 1
				show_win_fail(win_cnt.global, fail_cnt.global)
				break
			end
			-- 血月梦境
			x, y = lct_bmd()
			if x > -1 then
				random_sleep(1000)
				if init == 0 then
					if level == 1 then
						random_touch(0, 930, 215, 20, 20)
					elseif level == 2 then
						random_touch(0, 1000, 275, 20, 20)
					elseif level == 3 then
						random_touch(0, 975, 375, 20, 20)
					elseif level == 4 then
						random_touch(0, 880, 435, 20, 20)
					end
					mSleep(3000)
					init = 1
				end
				random_touch(0, x, y, 20, 5)
				mSleep(1000)
			end
			break
		end
	end
	return RET_ERR
end