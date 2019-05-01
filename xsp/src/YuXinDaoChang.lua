require "util"
require "func"

-- Util func
function lct_lidao()
	local x, y = findColor({32, 45, 34, 47},
		"0|0|0xeff5fb,963|-24|0xe99e0f,963|-30|0xf7f5f5,16|419|0xab4b2e",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"离岛",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function lct_yxdc()
	local x, y = findColor({959, 138, 961, 140},
		"0|0|0xe8d4cf,36|-117|0xe99e0f,38|-123|0xf3f1f1,18|344|0xb88a62",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"御心道场",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function lct_fszd()
	local x, y = findColor({959, 138, 961, 140},
		"0|0|0xe8d4cf,36|-117|0xe99e0f,38|-123|0xf3f1f1,8|360|0xdcd8cf",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"浮世澡堂",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function bypass_click()
	local x, y = findColor({748, 468, 750, 470},
		"0|0|0x7555dd,-4|8|0x7d61e1,29|-4|0x3640ac",
		70, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"跳过",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, x+40, y+10, 20, 10)
	end
	return x, y
end

-- Main func
function YuXinDaoChang(sel, level, bath, buy)
	print(string.format("道场 %s, 难度 %s, 汤浴 %s, 勾玉 %d", sel, level, bath, buy))
	print_global_config()
	
	local x, y
	local init = 1
	local ret = RET_OK
	local cnt = 0
	local bath_init = 1
	
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
				cnt = 0
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
			-- 御心道场
			x, y = lct_yxdc()
			if x > -1 then
				if init == 1 then
					if sel == "经验" then
						random_touch(0, 605, 140, 20, 20)
					elseif sel == "金币" then
						random_touch(0, 720, 140, 20, 20)
					elseif sel == "觉醒" then
						random_touch(0, 835, 140, 20, 20)
					end
					random_sleep(1000)
					if level == "简单" then
						random_touch(0, 620, 340, 20, 20)
					elseif level == "普通" then
						random_touch(0, 740, 340, 20, 20)
					elseif level == "困难" then
						random_touch(0, 860, 340, 20, 20)
					end
					random_sleep(1000)
					init = 0
				end
				random_touch(0, 980, 475, 20, 20) -- 挑战
				mSleep(1000)
				cnt = cnt + 1
				if cnt > 3 then
					random_touch(0, 960, 140, 10, 10) -- 退出
					cnt = 0
					init = 0
				end
				break
			end
			-- 浮世澡堂
			x, y = lct_fszd()
			if x > -1 then
				init = 1
				if bath == "粗盐" then
					random_touch(0, 585, 230, 10, 10)
				elseif bath == "薰草" then
					random_touch(0, 585, 350, 10, 10)
				elseif bath == "露天" then
					random_touch(0, 585, 470, 10, 10)
				end
				random_sleep(1000)
				if bath_init ~= 1 then
					HUD_show_or_hide(HUD,hud_info,"等待5 min ...",20,"0xff000000","0xffffffff",0,100,0,300,32)
					mSleep(5*60*1000)
				end
				bath_init = 0
				random_touch(0, 960, 530, 20, 20) -- 泡浴
				mSleep(5000)
				random_sleep(500)
				right_lower_click()
				random_sleep(1000)
				random_touch(0, 960, 140, 10, 10) -- 退出
				break
			end
			-- 离岛
			x, y = lct_lidao()
			if x > -1 then
				if init == 1 then
					random_touch(0, 385, 315, 5, 30) -- 御心道场
				else
					random_touch(0, 200, 430, 5, 30) -- 浮世澡堂
				end
				random_sleep(1000)
				break
			end
			break
		end
	end
	return RET_ERR
end