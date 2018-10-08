require "util"
require "func"

-- Util func
function diag_click()
	local x, y = findColor({0, 0, 1135, 639},
		"0|0|0xfde8e8,-17|0|0xffebeb,15|0|0xfde8e8,0|-18|0x12100c",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"对话",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 20, 20)
	end
	return x, y
end

function new_char()
	local x, y = findColor({1056, 49, 1058, 51},
		"0|0|0x3c5857,35|-21|0x385553,11|-7|0x2e3d44,23|-14|0x35444a",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"人物",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 50, 50)
	end
	return x, y
end

function bypass_click()
	local x, y = findColor({749, 468, 751, 470},
		"0|0|0x745ae5,7|5|0x4a31dc,-9|11|0x7459e4,12|17|0x3331dc",
		80, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"跳过",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x+40, y+10, 20, 20)
	end
	return x, y
end

function speed_click()
	local x, y = findColor({1037, 51, 1039, 53},
		"0|0|0xd4ad85,-18|0|0xd4ad86,-10|-22|0x34232e,-13|21|0x31202f",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"快进",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 20, 20)
	end
	return x, y
end

function fight_click()
	local x, y = findColor({0, 0, 1135, 639},
		"0|0|0xd2d4f9,8|15|0x232755,-3|-22|0xf3aeb8,-8|-5|0x5b6daa",
		95, 1, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"战斗",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 20, 20)
	end
	return x, y
end

function eye_click()
	local x, y = findColor({0, 0, 1135, 639},
		"0|0|0xfcfcfc,-22|-8|0xcbd5dc,19|10|0xdce3e7,15|-39|0x2f2623,-18|32|0x473e48",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"开眼?",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 20, 20)
	end
	return x, y
end

function questionmark_click()
	local x, y = findColor({0, 0, 1135, 639},
		"0|0|0xffefdd,0|-21|0xffefdd,18|5|0x12100c,-20|6|0x12100c,0|18|0xffefdd",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"问号",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x, y, 20, 20)
	end
	return x, y
end

-- Main func
function autostory()
	print_offer_arr()
	local time_cnt = 0
	local x, y
	
	while (1) do
		while (1) do
			mSleep(1000)
			-- 跳过
			x, y = bypass_click() if (x > -1) then time_cnt = 0 break end
			-- 对话
			x, y = diag_click() if (x > -1) then time_cnt = 0 break end
			-- 新任务
			x, y = new_char() if (x > -1) then time_cnt = 0 break end
			-- 快进
			x, y = speed_click() if (x > -1) then time_cnt = 0 break end
			-- 战斗
			x, y = fight_click() if (x > -1) then time_cnt = 0 break end
			-- 开眼
			x, y = eye_click() if (x > -1) then time_cnt = 0 break end
			-- 问号
			x, y = questionmark_click() if (x > -1) then time_cnt = 0 break end
			-- 自动
			x, y = auto_check() if (x > -1) then time_cnt = 0 break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then time_cnt = 0 break end
			-- 战斗进行
			x, y = fight_ongoing() if x > -1 then time_cnt = 0 break end
			-- 战斗胜利
			x, y = fight_success("单人") if (x > -1) then time_cnt = 0 break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then time_cnt = 0 break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo()
				time_cnt = 0
				break
			end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("单人")
				time_cnt = 0
				break
			end
			time_cnt = time_cnt + 1
			if time_cnt > 20 then
				HUD_show_or_hide(HUD,hud_scene,"移动",20,"0xff000000","0xffffffff",0,100,0,300,32)
				ran_move(0, 700, 300, math.random(-200,200), math.random(-50, 50), 100)
				mSleep(1000)
				time_cnt = 0
			end
			break
		end
	end
	return
end