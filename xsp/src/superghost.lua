require "util"
require "func"

-- Util func
function lct_sg_window()
	-- 识别弹窗
	local x, y, x_, y_
	x, y = findColor({24, 200, 26, 450}, -- 弹窗箭头
		"0|0|0xcc8b3b,254|-11|0xce765f,57|-23|0xe3d9ce,432|-24|0xdcd2c7",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"发现超鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, x+200, y, 50, 20) -- 点击弹窗
		superghost()
		return RET_OK
	end
	return RET_ERR
end

function lct_sg_page()
	-- 识别超鬼王页面
	local x, y = findColor({107, 73, 109, 75},
		"0|0|0x71090c,297|43|0x28090f,730|-60|0xc9ddee,935|17|0xe8d4cf",
		95, 0, 0, 0)
	return x, y
end

function lct_sg_in_tansuo()
	-- 识别探索里的超鬼王[Maybe extend findColor area]
	local x, y = findColor({450, 230, 600, 350},
		"0|0|0xe4dfdd,-10|-133|0x423944,38|-174|0xeb635b,-67|-158|0xd9d0bf,-61|-37|0x4c3829",
		95, 0, 0, 0)
	return x, y
end

function lct_sg_group()
	-- 识别超鬼王集结页面
	local x, y = findColor({358, 89, 360, 91},
		"0|0|0xeac89e,75|39|0xa26b4e,329|424|0xf3b25e,429|424|0xcbb59c",
		95, 0, 0, 0)
	return x, y
end

function sg_mark(last_mark)
	-- 标记Boss&草人
	local cnt = math.random(1, 2)
	local x, y, x_, y_
	if sg_mark[1] == 0 and sg_mark[2] == 0 then
		return ""
	end
	if sg_mark[1] == 1 and sg_mark[2] == 0 then
		if last_mark ~= "Boss" then
			for i = 1, cnt do
				ran_sleep(250)
				ran_touch(0, 513, 79, 5, 5) -- 标记boss
			end
		end
		return "Boss"
	elseif sg_mark[1] == 0 and sg_mark[2] == 1 then
		x, y = findColor({600, 190, 605, 220}, -- 丑女血条
			"0|0|0xaf0d0a,2|0|0xb10e0b,4|0|0xb30e0b,-569|-168|0xd6c4a1,-582|-176|0x211b0f",
			80, 0, 0, 0)
		if x > -1 then
			x_, y_ = findColor({610, 140, 660, 170}, -- 箭头
				"0|0|0xd41635,-7|0|0xc71e43,-22|-23|0xef45aa,15|-23|0xf65db9",
				80, 0, 0, 0)
			if x_ == -1 then
				for i = 1, cnt do
					ran_sleep(250)
					ran_touch(0, x+20, y+80, 5, 5) -- 标记草人
				end
			end
		end
		return "草人"
	elseif sg_mark[1] == 1 and sg_mark[2] == 1 then
		x_, y_ = findColor({610, 140, 660, 170}, -- 箭头
			"0|0|0xd41635,-7|0|0xc71e43,-22|-23|0xef45aa,15|-23|0xf65db9",
			80, 0, 0, 0)
		if x_ > -1 then
			return "草人"
		end
		x, y = findColor({600, 190, 605, 220}, -- 丑女血条
			"0|0|0xaf0d0a,2|0|0xb10e0b,4|0|0xb30e0b,-569|-168|0xd6c4a1,-582|-176|0x211b0f",
			80, 0, 0, 0)
		if x > -1 and last_mark ~= "草人" then
			for i = 1, cnt do
				ran_sleep(250)
				ran_touch(0, x+20, y+80, 5, 5) -- 标记草人
			end
			return "草人"
		end
		if last_mark ~= "Boss" then
			for i = 1, cnt do
				ran_sleep(250)
				ran_touch(0, 513, 79, 5, 5) -- 标记boss
			end
			return "Boss"
		end
		return "草人"
	end
	return ""
end

function check_6_star_sg(left, top, right, bot)
	-- 识别6星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a033,-11|0|0xf49f33,-22|0|0xf4a033,-6|-11|0xf1492d",
		95, 0, 0, 0)
	return x, y
end

function check_5_star_sg(left, top, right, bot)
	-- 识别5星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf79d2f,-11|0|0xf69d2f,-23|-32|0xa47e50",
		95, 0, 0, 0)
	return x, y
end

function check_4_star_sg(left, top, right, bot)
	-- 识别4星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a033,11|0|0xf49f33,-15|-26|0x906b87",
		95, 0, 0, 0)
	return x, y
end

function check_3_star_sg(left, top, right, bot)
	-- 识别3星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf6a031,11|0|0xf6a031,-22|-28|0x4e524e",
		95, 0, 0, 0)
	return x, y
end

function check_2_star_sg(left, top, right, bot)
	-- 识别2星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a033,11|0|0xf49f33,-22|-59|0xdf4d4b",
		95, 0, 0, 0)
	return x, y
end

function check_1_star_sg(left, top, right, bot)
	-- 识别1星
	local x, y = findColor({left, top, right, bot},
		"0|0|0xf4a432,-28|-59|0xdf4d4b,-10|-2|0xa08b82",
		95, 0, 0, 0)
	return x, y
end

function check_sg_start()
	-- 识别挑战button
	local x, y = findColor({1014, 539, 1016, 541},
		"0|0|0xe6d0a9,-30|-27|0xdcc8af,55|-27|0xe2cbaf,-8|11|0xccdfee",
		95, 0, 0, 0)
	if x > -1 then
		return RET_OK
	end
	return RET_ERR
end

function find_sg()
	-- 识别是否有可以攻打的超鬼王
	local x = -1
	local y = -1
	local ret = -1
	local top = {235, 350, 465}
	local bottom = {240, 355, 470}
	local left = 130
	local right = 140
	
	-- 第一栏到第三栏顺序寻找, 找到1~6星后会检查是否有挑战button
	for i = 1, 3 do
		x, y = check_1_star_sg(left, top[i], right, bottom[i]) if x > -1 then ret = check_sg_start(x, y) if ret == RET_OK then HUD_show_or_hide(HUD,hud_scene,"发现 1星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32) return x, y, 1 end end
		x, y = check_2_star_sg(left, top[i], right, bottom[i]) if x > -1 then ret = check_sg_start(x, y) if ret == RET_OK then HUD_show_or_hide(HUD,hud_scene,"发现 2星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32) return x, y, 2 end end
		x, y = check_3_star_sg(left, top[i], right, bottom[i]) if x > -1 then ret = check_sg_start(x, y) if ret == RET_OK then HUD_show_or_hide(HUD,hud_scene,"发现 3星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32) return x, y, 3 end end
		x, y = check_4_star_sg(left, top[i], right, bottom[i]) if x > -1 then ret = check_sg_start(x, y) if ret == RET_OK then HUD_show_or_hide(HUD,hud_scene,"发现 4星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32) return x, y, 4 end end
		x, y = check_5_star_sg(left, top[i], right, bottom[i]) if x > -1 then ret = check_sg_start(x, y) if ret == RET_OK then HUD_show_or_hide(HUD,hud_scene,"发现 5星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32) return x, y, 5 end end
		x, y = check_6_star_sg(left, top[i], right, bottom[i]) if x > -1 then ret = check_sg_start(x, y) if ret == RET_OK then HUD_show_or_hide(HUD,hud_scene,"发现 6星鬼王",20,"0xff000000","0xffffffff",0,100,0,300,32) return x, y, 6 end end
	end
	return x, y, 0
end

function sg_switch_mode(star)
	-- 普通或者强力追击切换
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

function sg_fight_failed()
	-- 战斗失败的超鬼王识别
	local x, y = findColor({413, 104, 415, 106},
		"0|0|0x514a5b,251|6|0xddd9cd,-135|-6|0xcdc59c,30|34|0x5b5265",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"战斗失败",20,"0xff000000","0xffffffff",0,100,0,300,32)
		ran_touch(0, 1040, 350, 50, 50) -- 右下空白
	end
	return x, y
end

function sg_keep_fight_failed()
	-- 保持战斗失败的超鬼王识别
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

function sg_tired_detect()
	-- 识别疲劳窗口
	local x, y = findColor({567, 418, 569, 420},
		"0|0|0xf3b25e,-81|-109|0x414277,-9|0|0xeb3219",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"疲劳溢出",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function sg_group_invite()
	-- 邀请1 ~ 4位好友[Consider more options]
	ran_touch(0, 450, 210, 20, 10) -- 1st
	ran_sleep(250)
	ran_touch(0, 700, 210, 20, 10) -- 2nd
	ran_sleep(250)
	ran_touch(0, 450, 300, 20, 10) -- 3rd
	ran_sleep(250)
	ran_touch(0, 700, 300, 20, 10) -- 4th
	ran_sleep(250)
	ran_touch(0, 690, 510, 20, 10) -- 邀请
end

-- Main func
function superghost()
	print(string.format("超鬼王: %d 强力追击 %d 标记 Boss %d 草人 %d 6星 %s 5星 %s 4星 %s 3星 %s 2星 %s 1星 %s",
			sg_en, sg_force, sg_mark[1], sg_mark[2], sg_tired[6], sg_tired[5], sg_tired[4], sg_tired[3], sg_tired[2], sg_tired[1]))
	print_offer_arr()
	
	if sg_en == 0 then
		return
	end
	
	local x = -1
	local y = -1
	local x_f = -1
	local y_f = -1
	local ret = 0
	local sg_curr = 0
	local fight_en = 0
	local last_mark = ""
	local tired_op = ""
	local time_cnt_en = 1
	local time_cnt = 0
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 弹窗
			lct_sg_window()
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 疲劳溢出
			x, y = sg_tired_detect()
			if x > -1 then
				tired_op = sg_tired[sg_curr] -- 获得当前星级的疲劳操作
				if tired_op == "喝茶" then
					ran_touch(0, x, y , 30, 10) -- 58勾
					tired_op = ""
				elseif tired_op == "等待" then
					ran_touch(0, 831, 173, 5, 5) -- 关闭
					mSleep(5*60*1000)
					tired_op = ""
				elseif tired_op == "集结" then
					ran_touch(0, 831, 173, 5, 5) -- 关闭
				end
				break
			end
			-- 集结
			x, y = lct_sg_group() if x > -1 then sg_group_invite() mSleep(5*60*1000) tired_op = "" break end -- 集结并等待5分钟 [Condiser more options]
			-- 超鬼王页面
			x, y = lct_sg_page()
			if x > -1 then
				-- Time cnt
				time_cnt_en = 0 -- 进入超鬼王页面则停止计时
				-- 进入集结
				if (tired_op == "集结") then ran_touch(0, 880, 550, 10, 10) break end -- 疲劳-集结
				-- 寻找超鬼王
				x_f, y_f, sg_curr = find_sg()
				if sg_curr > 0 then
					if fight_en == 1 then
						ret = check_sg_start()
						if ret == RET_OK then
							ran_touch(0, 1030, 540, 20, 20) -- 挑战
						end
						fight_en = 0
						break
					end
					ran_touch(0, x_f+150, y_f, 50, 10) -- 选择超鬼王
					sg_switch_mode(sg_curr) -- 切换战斗模式
					fight_en = 1
					break
				else
					ran_touch(0, 1042, 93, 5, 5) -- 右上退出
					return
				end
				break
			else
				-- 运行超鬼王之后检查3s,未识别到超鬼王页面则退出
				if time_cnt_en == 1 then
					time_cnt = time_cnt + 1
					if time_cnt > 600 then
						return
					end
				end
			end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then last_mark = sg_mark(last_mark) mSleep(3000) break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗失败
			x, y = sg_fight_failed() if (x > -1) then
				sg_keep_fight_failed()
				break
			end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				keep_half_damo()
				break
			end
			-- 自动检测
			x, y = auto_check() if x > -1 then break end
			-- 探索の超鬼王
			x, y = lct_sg_in_tansuo() if x > -1 then ran_touch(0, x, y, 5, 5) break end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return
end