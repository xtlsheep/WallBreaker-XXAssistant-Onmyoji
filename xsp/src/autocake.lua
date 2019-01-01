require "util"
require "func"

-- Util func
function tansuo_auto_fight()
	local x, y = findColor({909, 569, 911, 571},
		"0|0|0x303663,6|10|0x313764,-5|10|0x323865,5|4|0x6c6c6c,-5|4|0x6c6c6b,0|12|0x6d6d6d",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 10, 10) -- 自动挑战
	end
end

function tansuo_pre_feed()
	local x, y = findColor({1104, 574, 1106, 576},
		"0|0|0x2b1e1c,-20|-9|0xcfccc7,-129|-79|0xe87a2a,-1071|-517|0xf0f5fb",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 1080, 580, 20, 20) -- 小纸人
		random_sleep(250)
		random_touch(0, 1050, 475, 30, 30) -- 喂食
		random_sleep(250)
		tansuo_auto_fight()
	end
	return x, y
end

function yujue_solo_auto_fight()
	local x, y = findColor({743, 371, 745, 373},
		"0|0|0x6c6c6c,-6|-8|0x6c6c6c,-11|1|0x6b6a6b,-12|-6|0x2f3562,-1|-6|0x323865,-6|4|0x313764",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 10, 10) -- 自动挑战
	end
end

function yujue_solo_pre_feed()
	local x, y = findColor({899, 369, 901, 371},
		"0|0|0x2b1e1c,-53|75|0xf3b25e,30|-256|0xe8d4cf,-328|77|0xf3b25e",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 880, 371, 20, 20) -- 小纸人
		random_sleep(250)
		random_touch(0, 705, 415, 30, 30) -- 喂食
		random_sleep(250)
		lower_right_blank_click()
		random_sleep(250)
		yujue_solo_auto_fight()
	end
	return x, y
end

function yujue_group_auto_fight()
	local x, y = findColor({256, 469, 258, 471},
		"0|0|0x6e6e6e,-4|-7|0x6e6e6e,-9|0|0x6d6d6d,-10|-5|0x323864,-4|4|0x333965,1|-6|0x323865",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 10, 10) --自动挑战
	end
end

function yujue_group_pre_feed()
	local x, y = findColor({399, 459, 401, 461},
		"0|0|0x302220,-17|-5|0xcfccc7,-197|78|0xdf6851,662|-398|0xfefbe4",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, 380, 465, 20, 20) -- 小纸人
		random_sleep(250)
		random_touch(0, 710, 420, 30, 30) -- 喂食
		random_sleep(250)
		lower_right_blank_click()
		random_sleep(250)
		yujue_group_auto_fight()
	end
	return x, y
end

-- Main func
function autocake(feed_times)
	print(string.format("喂食次数 %d", feed_times))
	print_global_vars()
	
	local feed_cnt = 0
	local mode = nil
	local x, y
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 循环通用
			global_loop_func()
			-- 探索喂食
			x, y = tansuo_pre_feed()
			if x > -1 then
				feed_cnt = feed_cnt + 1
				HUD_show_or_hide(HUD,hud_info,string.format("喂食%d次", feed_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
				if feed_cnt >= feed_times then
					mSleep(5000)
					return
				end
			end
			-- 御觉单人喂食
			x, y = yujue_solo_pre_feed()
			if x > -1 then
				feed_cnt = feed_cnt + 1
				HUD_show_or_hide(HUD,hud_info,string.format("喂食%d次", feed_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
				if feed_cnt >= feed_times then
					mSleep(5000)
					return
				end
			end
			-- 御觉组队喂食
			x, y = yujue_group_pre_feed()
			if x > -1 then
				feed_cnt = feed_cnt + 1
				HUD_show_or_hide(HUD,hud_info,string.format("喂食%d次", feed_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
				if feed_cnt >= feed_times then
					mSleep(5000)
					return
				end
			end
			break
		end
	end
	return
end