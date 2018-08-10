require "util"
require "func"

-- Util func
function lct_sg_jiutun_window()
	local x, y = findColor({24, 200, 26, 450}, -- 弹窗箭头
		"0|0|0xcc8b3b,254|-11|0xce765f,57|-23|0xe3d9ce,432|-24|0xdcd2c7",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现超鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x+200, y, 50, 20) -- 点击弹窗
		mSleep(1000)
		sg_jiutun()
		return RET_OK
	end
	return RET_ERR
end

function lct_sg_jiutun()
	local x, y = findColor({107, 73, 109, 75},  -- 超鬼王页面
		"0|0|0x71090c,297|43|0x28090f,730|-60|0xc9ddee,935|17|0xe8d4cf",
		95, 0, 0, 0)
	return x, y
end

function cs_6(left, top, right, bot)
	x, y = findColor({left, top-35, right, bot-35},
		"0|0|0xf5e5d5,-21|-21|0x6d4f59,7|15|0x524650",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现 6星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function cs_5(left, top, right, bot)
	local x, y = findColor({left, top, right, bot},
		"0|0|0xfc8a2a,11|0|0xfba23a,-23|-31|0x9b7b54",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现 5星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function cs_4(left, top, right, bot)
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a033,11|0|0xf49f33,-15|-26|0x906b87",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现 4星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function cs_3(left, top, right, bot)
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf6a031,11|0|0xf6a031,-22|-28|0x4e524e",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现 3星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function cs_2(left, top, right, bot)
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a033,11|0|0xf49f33,-22|-59|0xdf4d4b",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现 2星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function cs_1(left, top, right, bot)
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a432,-28|-59|0xdf4d4b,-10|-2|0xa08b82",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现 1星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function check_blood(x, y) -- x-25, y+20
	local x, y = findColor({x-25-1, y+20-1, x-25+1, y+20+1},
		"0|0|0xc43b26",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	return RET_ERR
end

function find_guiwang()
	local x = -1
	local y = -1
	local ret = -1
	local top = {235, 350, 465}
	local bottom = {240, 355, 470}
	local left = 130
	local right = 140
	
	for i = 1, 3 do
		x, y = cs_1(left, top[i], right, bottom[i]) if x > -1 then ret = check_blood(x, y) if ret == RET_OK then return x, y, 1 end end
		x, y = cs_2(left, top[i], right, bottom[i]) if x > -1 then ret = check_blood(x, y) if ret == RET_OK then return x, y, 2 end end
		x, y = cs_3(left, top[i], right, bottom[i]) if x > -1 then ret = check_blood(x, y) if ret == RET_OK then return x, y, 3 end end
		x, y = cs_4(left, top[i], right, bottom[i]) if x > -1 then ret = check_blood(x, y) if ret == RET_OK then return x, y, 4 end end
		x, y = cs_5(left, top[i], right, bottom[i]) if x > -1 then ret = check_blood(x, y) if ret == RET_OK then return x, y, 5 end end
		x, y = cs_6(left, top[i], right, bottom[i]) if x > -1 then ret = check_blood(x, y) if ret == RET_OK then return x, y, 6 end end
	end
	return x, y, 0
end

function switch_force(star)
	local x, y
	x, y = findColor({706, 492, 708, 494},  -- 普通追击
		"0|0|0x402f11,-182|-7|0x4354d1,333|-400|0xe8d4cf,-601|-419|0x71090c",
		95, 0, 0, 0)
	if x > -1 then
		if star >= sg_force then
			ran_touch(0, x, y, 5, 5) -- 选择强力
			return
		end
	end
	x, y = findColor({526, 490, 528, 492},  -- 强力追击
		"0|0|0x402f11,177|-4|0x475ade,515|-399|0xe8d4cf,-419|-416|0x6d090c",
		95, 0, 0, 0)
	if x > -1 then
		if star < sg_force then
			ran_touch(0, x, y, 5, 5) -- 选择普通
			return
		end
	end
	return
end

function vibrator(star, last_star)
	if last_star ~= star then
		if star >= sg_vibra then
			for i = 1, 3 do
				vibrator()             --振动
				mSleep(1000)           --持续 1 秒
			end
		end
	end
end

function fight_failed_sg()
	local x, y = findColor({413, 104, 415, 106},
		"0|0|0x514a5b,251|6|0xddd9cd,-135|-6|0xcdc59c,30|34|0x5b5265",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"战斗失败",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, 1040, 350, 50, 50) -- 右下空白
	end
	return x, y
end

function keep_fight_failed_sg()
	local x, y
	while (1) do
		find_offer()
		x, y = findColor({413, 104, 415, 106},
			"0|0|0x514a5b,251|6|0xddd9cd,-135|-6|0xcdc59c,30|34|0x5b5265",
			95, 0, 0, 0)
		if x > -1 then
			ran_touch(0, 1040, 350, 50, 50) -- 右下空白
		elseif x == -1 then
			return
		end
		mSleep(500)
	end
end

-- Main func
function sg_jiutun()
	print(string.format("超鬼王: %d 强力追击 %d 震动提醒 %d 标记 Boss %d 草人 %d 6星 %s 5星 %s 4星 %s 3星 %s 2星 %s 1星 %s ",
			sg_en, sg_force, sg_vibra, sg_mark[1], sg_mark[2], sg_tired_6, sg_tired_5, sg_tired_4, sg_tired_3, sg_tired_2, sg_tired_1))
	print_offer_arr()
	
	if sg_en == 0 then
		return
	end
	mSleep(1000)
	
	local x = -1
	local y = -1
	local x_f = -1
	local y_f = -1
	local ret = 0
	local last_star = 0
	local ready_to_go = 0
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 弹窗
			lct_sg_jiutun_window()
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 超鬼王页面
			x, y = lct_sg_jiutun()
			if x > -1 then
				ran_sleep(500)
				-- Check
				x_f, y_f, star = find_guiwang()
				if star > 0 then
					if ready_to_go == 1 then
						ran_sleep(500)
						ran_touch(0, 1030, 540, 20, 20) -- 挑战
						ready_to_go = 0
						last_star = star
						break
					end
					ran_touch(0, x_f+150, y_f, 30, 5) -- 选择鬼王
					switch_force(star)
					if sg_vibra > 0 then
						vibrator(star, last_star)
					end
					ready_to_go = 1
					break
				else
					ran_touch(0, 1042, 93, 5, 5) -- 右上退出
					return
				end
				break
			end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo()
				break
			end
			-- 战斗失败
			x, y = fight_failed_sg() if (x > -1) then
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed_sg()
				break
			end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return
end