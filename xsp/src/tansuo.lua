require "util"
require "func"

-- Util func
function lct_tansuo_scene()
	local x, y = findColor({770, 5, 790, 15},
		"0|0|0xe97b2b,217|36|0xe2c9a3,-746|48|0xf0f5fb,195|486|0xe87a2a",
		90, 0, 0, 0)
	return x, y
end

function lct_tansuo_prepare()
	local x, y = findColor({27, 35, 29, 37},
		"0|0|0xd6c4a1,4|468|0x98335a,92|570|0xfefbe5,25|552|0xf6c990",
		90, 0, 0, 0)
	return x, y
end

function section_select(section)
	local sec_func = {}
	
	sec_func[10] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf8f3e0,-10|2|0xf8f3e0,9|0|0xf4efdc,-7|-7|0x44332b,-10|11|0x44332b,-1|9|0x44332b,-1|5|0x44332b,9|10|0x44332b",
			90, 0, 0, 0)
		if x > -1 then return x, y, 1 else return x, y, 0 end
	end
	
	sec_func[1] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0x44332b,-3|-6|0xf8f3e0,2|-6|0xf8f3e0,-8|7|0xf8f3e0,8|6|0xf8f3e0,-10|-5|0x44332b,10|0|0x44332b",
			90, 0, 0, 0)
		if x > -1 then return x, y, 2 else return x, y, 0 end
	end
	
	sec_func[2] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf7f2df,-3|-7|0xf2eddb,3|-8|0xebe6d3,1|-4|0x281f15,-2|5|0x231910,7|0|0x44332b,-7|9|0xf8f3e0,8|8|0xf8f3e0",
			90, 0, 0, 0)
		if x > -1 then return x, y, 3 else return x, y, 0 end
	end
	
	sec_func[3] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0x22180f,-8|-5|0xf8f3e0,9|-6|0xf8f3e0,7|6|0xf8f3e0,-7|6|0xf7f2df,-9|0|0xf8f3e0,9|0|0xf8f3e0",
			90, 0, 0, 0)
		if x > -1 then return x, y, 4 else return x, y, 0 end
	end
	
	sec_func[4] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf8f3e0,0|4|0x22180f,-2|-7|0xf6f1de,5|-8|0xf8f2df,-7|9|0xf0ebd9,10|9|0xf8f3e0,11|0|0x44332b,-9|-5|0x44332b",
			90, 0, 0, 0)
		if x > -1 then return x, y, 5 else return x, y, 0 end
	end
	
	sec_func[5] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0x3d2e26,-1|-5|0xf8f3e0,-2|-9|0xf6f1de,-9|-4|0xece7d5,8|-5|0xf7f2df,6|6|0xefead7,-1|8|0x44332b,-11|-11|0x44332b",
			90, 0, 0, 0)
		if x > -1 then return x, y, 6 else return x, y, 0 end
	end
	
	sec_func[6] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf4efdc,0|-7|0xf6f1df,-8|2|0xf8f3e0,9|-2|0xf8f3e0,6|8|0xf6f0de,-8|10|0x44332b,-9|-9|0x44332b",
			90, 0, 0, 0)
		if x > -1 then return x, y, 7 else return x, y, 0 end
	end
	
	sec_func[7] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0x43322a,-4|-2|0xe2dcca,-8|2|0xf5f0dd,3|-5|0xf7f2df,9|3|0xf8f3e0,4|-3|0xf8f3e0,7|1|0xf8f3e0,-10|-7|0x44332b",
			90, 0, 0, 0)
		if x > -1 then return x, y, 8 else return x, y, 0 end
	end
	
	sec_func[8] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf8f3e0,4|-5|0xf6f1de,9|-3|0xf8f3e0,15|11|0xf4efdc,7|11|0xf8f3e0,12|3|0x46322b,0|11|0x46322b,-3|-6|0x46322b",
			90, 0, 0, 0)
		if x > -1 then return x, y, 9 else return x, y, 0 end
	end
	
	sec_func[9] = function(x1, y1, x2, y2)
		local x, y = findColor({x1, y1, x2, y2},
			"0|0|0xf8f3e0,0|-7|0xf1ecd9,0|-4|0xeee9d6,-9|1|0xf3eedb,-1|9|0xf8f3e0,-10|-7|0x44332b,8|-8|0x44332b,8|10|0x44332b",
			90, 0, 0, 0)
		if x > -1 then return x, y, 10 else return x, y, 0 end
	end
	
	function sec_recg(x1, y1, x2, y2)
		local x, y, x_, y_, x__, y__, ret
		local section = 0
		local section_str = ""
		
		for i = 1, 10 do
			x, y, ret = sec_func[i](x1, y1, x2, y2)
			if ret > 0 then
				section_str = section_str..ret
				break
			end
		end
		
		if ret > 0 then
			for i = 1, 10 do
				x_, y_, ret = sec_func[i](x+10, y-10, x+30, y+10)
				if ret > 0 then
					if section_str == "10" then
						section_str = "1"
					end
					section_str = section_str..ret
					break
				end
			end
		end
		
		if ret > 0 then
			for i = 1, 10 do
				x__, y__, ret = sec_func[i](x_+10, y_-10, x_+30, y_+10)
				if ret > 0 then
					section_str = string.sub(section_str, 1, 1)
					section_str = section_str..ret
					break
				end
			end
		end
		
		-- Handle section 20 case
		if section_str == "210" then
			section_str = "20"
		end
		
		if string.len(section_str) > 0 then
			section = tonumber(section_str)
		end
		
		return x, y, section
	end
	
	local x, y, sec, ret, rd
	local cnt = 0
	
	if section == 0 then
		random_touch(0, 1025, 220, 20, 20)
	elseif section == -1 then
		random_touch(0, 1025, 530, 20, 20)
	else
		while (1) do
			x, y, sec = sec_recg(990, 250, 1025, 350)
			print(string.format("Section - %d", sec))
			if sec == 0 then
				HUD_show_or_hide(HUD,hud_info,"重新调整, 可使用手动模式",20,"0xff000000","0xffffffff",0,100,0,300,32)
				rd = math.random(1, 2)
				if rd % 2 == 0 then
					random_move(0, 1025, 560, 1025, 210, 10, 30)
				else
					random_move(0, 1025, 210, 1025, 560, 10, 30)
				end
				cnt = cnt + 1
				if cnt >= 5 then
					break
				end
			else
				if sec < section then
					if section - sec == 1 then
						random_touch(0, x+20, y+30+100, 20, 20)
						break
					elseif section - sec == 2 then
						random_touch(0, x+20, y+30+200, 20, 20)
						break
					else
						random_move(0, 1025, 560, 1025, 210, 10, 30)
					end
				elseif sec > section then
					if sec - section == 1 then
						random_touch(0, x+20, y+30-100, 20, 20)
						break
					else
						random_move(0, 1025, 210, 1025, 560, 10, 30)
					end
				else
					random_touch(0, x+20, y+30, 20, 20)
					break
				end
			end
			mSleep(500)
		end
	end
	
	mSleep(1000)
	return RET_OK
end

function degree_select(hard)
	local x, y
	
	if hard == "普通" then
		x, y = findColor({293, 197, 295, 199},
			"0|0|0x331b0c,-10|-4|0xf1f1f1,27|18|0xa9a7a4,-7|17|0xababa8",
			95, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 10, 10)
		end
	elseif hard == "困难" then
		x, y = findColor({415, 208, 417, 210},
			"0|0|0x1a0d06,-27|-27|0xc3a46e,-16|-4|0xf0dca8,25|14|0xc9aa72",
			95, 0, 0, 0)
		if x > -1 then
			random_touch(0, x, y, 10, 10)
		end
	end
	
	random_sleep(500)
	return x, y
end

function tansuo_mark(mark)
	random_sleep(500)
	local x, y
	local cnt = math.random(2, 3)
	local ran = math.random(1, 3)
	if mark == "小怪" then
		if ran == 1 then
			x = 566 y = 126
		elseif ran == 2 then
			x = 697 y = 186
		elseif ran == 3 then
			x = 861 y = 177
		end
		for i = 1, cnt do
			random_touch(0, x, y, 10, 10)
		end
	elseif mark == "Boss" then
		for i = 1, cnt do
			random_touch(0, 760, 90, 10, 10)
		end
	end
	mSleep(1000)
end

function scene_quit_confirm()
	local x, y = findColor({688, 357, 690, 359},
		"0|0|0xf3b25e,-287|-2|0xf3b25e,-654|-302|0x636567,-659|146|0x3e1524",
		95, 0, 0, 0)
	return x, y
end

function find_exp()
	local x, y
	-- small
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0xded1aa,-13|8|0x8e2320,15|-1|0x921d1c,15|-9|0x286d7e",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现经验加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	-- normal
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0xb29773,-13|-4|0x2b6478,-7|8|0x831917",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现经验加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	-- big
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0xebdcb0,-22|12|0x871c1c,28|-3|0x891918,29|-17|0x21566e",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现经验加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	return x, y
end

function find_money()
	local x, y
	-- small
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0x713d2c,2|-12|0xd5bc62,-11|-7|0xdece77,10|15|0xecd41c",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现金币加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	-- normal
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0xdacb6f,5|-11|0xdfd082,12|-2|0xdaca71",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现金币加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	-- big
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0x70412f,2|-18|0xdbc76c,-20|-10|0xdece76,16|28|0xedd817",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现金币加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	return x, y
end

function find_goods()
	local x, y
	-- small
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0xd52a22,21|7|0xf9e219,14|8|0xfbf525,6|-13|0xf8f7e7",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现掉落加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	-- normal
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0xf6db12,-10|-9|0xd62e22,-21|-15|0xce4428",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现掉落加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	-- big
	x, y = findColor({0, 0, 1136, 640},
		"0|0|0xd62d24,25|13|0xfaf124,38|10|0xfce711,10|-26|0xfbfbeb",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现掉落加成小怪",20,"0xff000000","0xffffffff",0,100,0,300,32)
		return x, y
	end
	return x, y
end

function find_boss()
	local x, y = findColor({0, 0, 1136, 640},
		"0|0|0xeba9b0,9|5|0xfffaf4,7|-1|0xb12c31,0|-15|0x221108,25|-6|0xfaede1,12|14|0x130904",
		90, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现Boss",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function find_attack(x_f, y_f)
	local x, y
	if x_f == -1 and y_f == -1 then
		local x, y = findColor({0, 100, 1135, 550},
			"0|0|0xd2d4f9,8|15|0x232755,-3|-22|0xf3aeb8,-8|-5|0x5b6daa",
			95, 1, 0, 0)
		if x > -1 then
			return x, y
		end
	end
	local x, y = findColor({x_f-150, y_f-250, x_f, y_f},
		"0|0|0xd2d4f9,8|15|0x232755,-3|-22|0xf3aeb8,-8|-5|0x5b6daa",
		95, 1, 0, 0)
	if x > -1 then
		return x, y
	end
	local x, y = findColor({x_f, y_f-250, x_f+150, y_f},
		"0|0|0xd2d4f9,8|15|0x232755,-3|-22|0xf3aeb8,-8|-5|0x5b6daa",
		95, 0, 0, 0)
	return x, y
end

function find_target(sel)
	local x_t, y_t, x_a, y_a
	
	HUD_show_or_hide(HUD,hud_info,"寻找ing...",20,"0xff000000","0xffffffff",0,100,0,300,32)
	
	for i = 1, 3 do
		keepScreen(true)
		-- Boss
		if sel[4] == 1 then
			x_t, y_t = find_boss()
			if x_t > -1 then
				keepScreen(false)
				mSleep(1000)
				x_a, y_a = find_boss()
				random_touch(0, x_a, y_a, 5, 5)
				mSleep(1000)
				return RET_VALID
			end
		end
		-- Goods
		if sel[1] == 1 then
			x_t, y_t = find_goods()
			if x_t > -1 then
				keepScreen(false)
				x_a, y_a = find_attack(x_t, y_t)
				if x_a > -1 then
					random_touch(0, x_a, y_a, 5, 5)
					mSleep(1000)
					return RET_OK
				end
			end
		end
		-- Money
		if sel[2] == 1 then
			x_t, y_t = find_money()
			if x_t > -1 then
				keepScreen(false)
				x_a, y_a = find_attack(x_t, y_t)
				if x_a > -1 then
					random_touch(0, x_a, y_a, 5, 5)
					mSleep(1000)
					return RET_OK
				end
			end
		end
		-- Exp
		if sel[3] == 1 then
			x_t, y_t = find_exp()
			if x_t > -1 then
				keepScreen(false)
				x_a, y_a = find_attack(x_t, y_t)
				if x_a > -1 then
					random_touch(0, x_a, y_a, 5, 5)
					mSleep(1000)
					return RET_OK
				end
			end
		end
		keepScreen(false)
		mSleep(250)
	end
	return RET_ERR
end

function team_invite()
	local x, y = findColor({672, 383, 674, 385},
		"0|0|0xf3b25e,-212|2|0xdf6851,323|-352|0x5c5242,-630|-330|0x626467",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"继续邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function member_quit()
	local x, y = findColor({48, 422, 50, 424},
		"0|0|0x503f2d,8|-16|0xf5f7e9,-3|-35|0xcd343f,12|-30|0x473523",
		95, 0, 0, 0)
	return x, y
end

function full_exp_top(df_pos)
	local x, y
	local top_left = -1
	local top_mid = -1
	local top_right = -1
	
	if ver == "iOS" then
		if df_pos[1] == 1 then
			x, y = findColor({150, 150, 350, 350},
				"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
				90, 0, 0, 0)
			if x > -1 then
				top_left = 1
			end
		end
		if df_pos[2] == 1 then
			x, y = findColor({350, 200, 550, 400},
				"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
				90, 0, 0, 0)
			if x > -1 then
				top_mid = 1
			end
		end
		if df_pos[3] == 1 then
			x, y = findColor({550, 250, 750, 450},
				"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
				90, 0, 0, 0)
			if x > -1 then
				top_right = 1
			end
		end
	elseif ver == "android" then
		if df_pos[1] == 1 then
			x, y = findColor({150, 150, 350, 350},
				"0|0|0xfe9e1a,3|0|0xfba01a,-3|11|0xeedd24,7|13|0xf7e611",
				90, 0, 0, 0)
			if x > -1 then
				top_left = 1
			end
		end
		if df_pos[2] == 1 then
			x, y = findColor({350, 200, 550, 400},
				"0|0|0xfe9e1a,3|0|0xfba01a,-3|11|0xeedd24,7|13|0xf7e611",
				90, 0, 0, 0)
			if x > -1 then
				top_mid = 1
			end
		end
		if df_pos[3] == 1 then
			x, y = findColor({550, 250, 750, 450},
				"0|0|0xfe9e1a,3|0|0xfba01a,-3|11|0xeedd24,7|13|0xf7e611",
				90, 0, 0, 0)
			if x > -1 then
				top_right = 1
			end
		end
	end
	return top_left, top_mid, top_right
end

function full_exp_bot(df_pos)
	local x, y
	local bot_left = -1
	local bot_right = -1
	
	if ver == "iOS" then
		if df_pos[1] == 1 then
			x, y = findColor({0, 200, 150, 400},
				"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
				90, 0, 0, 0)
			if x > -1 then
				bot_left = 1
			end
		end
		if df_pos[3] == 1 then
			x, y = findColor({400, 400, 600, 600},
				"0|0|0xffa219,-1|8|0xfecf0b,7|13|0xffeb03,5|-1|0xff9d1a",
				90, 0, 0, 0)
			if x > -1 then
				bot_right = 1
			end
		end
	elseif ver == "android" then
		if df_pos[1] == 1 then
			x, y = findColor({0, 200, 150, 400},
				"0|0|0xfe9e1a,3|0|0xfba01a,-3|11|0xeedd24,7|13|0xf7e611",
				90, 0, 0, 0)
			if x > -1 then
				bot_left = 1
			end
		end
		if df_pos[3] == 1 then
			x, y = findColor({400, 400, 600, 600},
				"0|0|0xfe9e1a,3|0|0xfba01a,-3|11|0xeedd24,7|13|0xf7e611",
				90, 0, 0, 0)
			if x > -1 then
				bot_right = 1
			end
		end
	end
	return bot_left, bot_right
end

function skkm_change_all()
	local x, y = findColor({44, 592, 46, 594},
		"0|0|0xffffff,122|20|0x4e3221,105|39|0x3e2d1c,851|22|0x391c12,759|31|0x493321",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_N()
	local x, y = findColor({54, 577, 56, 579},
		"0|0|0x87878a,10|18|0xdfdedd,95|54|0x3e2d1c,841|37|0x391c12,749|46|0x493321",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_egg()
	local x, y = findColor({49, 575, 51, 577},
		"0|0|0x2b90b1,28|6|0x46aece,100|56|0x3e2d1c,846|39|0x391c12,754|48|0x493321",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_sel()
	local x, y = findColor({78, 282, 80, 284},
		"0|0|0x48b0cf,69|7|0x7e7d81,152|51|0x0e5eb2,218|121|0x8d13c5,269|206|0xe9732e,287|298|0xfd2639",
		95, 0, 0, 0)
	return x, y
end

function skkm_change_scroll(page_jump)
	if page_jump == "page1" then
		return
	elseif page_jump == "page5" then
		for i = 1, 4 do
			random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
			random_sleep(250)
		end
		return
	elseif page_jump == "page10" then
		for i = 1, 9 do
			random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
			random_sleep(250)
		end
		return
	end
	
	local index = 0
	local percent_scroll = {250, 350, 550, 650, 750}
	
	if page_jump == "percent10" then
		index = 1
	elseif page_jump == "percent30" then
		index = 2
	elseif page_jump == "percent50" then
		index = 3
	elseif page_jump == "percent70" then
		index = 4
	elseif page_jump == "percent90" then
		index = 5
	end
	
	random_move(0 ,170, 615, percent_scroll[index], 615, 5, 5) -- 滚动
	return
end

function skkm_change_switch(top_left, top_mid, top_right, bot_left, bot_right)
	local cnt
	if top_right == 1 then
		cnt = math.random(2, 3)
		for i = 1, cnt do
			random_move(0, 200, 500, 180, 250, 5, 10)
			random_sleep(500)
		end
	end
	if top_mid == 1 then
		cnt = math.random(2, 3)
		for i = 1, cnt do
			random_move(0, 800, 500, 550, 250, 5, 10)
			random_sleep(500)
		end
	end
	if top_left == 1 then
		random_move(0 ,800, 520, 300, 520, 20, 20) -- 翻页
		cnt = math.random(2, 3)
		for i = 1, cnt do
			random_move(0, 800, 500, 960, 250, 5, 10)
			random_sleep(500)
		end
	end
	if bot_right == 1 then
		cnt = math.random(2, 3)
		for i = 1, cnt do
			random_move(0, 200, 500, 330, 280, 5, 10)
			random_sleep(1000)
		end
	end
	if bot_left == 1 then
		cnt = math.random(2, 3)
		for i = 1, cnt do
			random_move(0, 800, 500, 850, 280, 5, 10)
			random_sleep(1000)
		end
	end
end

function df_normal_attack(df_pos, mode)
	local x, y
	if mode == "solo" then
		if df_pos[1] == 1 then
			x, y = findColor({784, 617, 786, 619},
				"0|0|0xfbfbfa,-11|-5|0x452116,9|7|0xfefefe",
				90, 0, 0, 0)
			if x > -1 then
				random_touch(0, 775, 595, 10, 10)
				return
			end
		end
		if df_pos[2] == 1 then
			x, y = findColor({884, 617, 886, 619},
				"0|0|0xfbfbfa,-11|-5|0x452116,9|7|0xfefefe",
				90, 0, 0, 0)
			if x > -1 then
				random_touch(0, 875, 595, 10, 10)
				return
			end
		end
		if df_pos[3] == 1 then
			x, y = findColor({984, 617, 986, 619},
				"0|0|0xfbfbfa,-11|-5|0x452116,9|7|0xfefefe",
				90, 0, 0, 0)
			if x > -1 then
				random_touch(0, 975, 595, 10, 10)
				return
			end
		end
	elseif mode == "group" then
		if df_pos[1] == 1 then
			x, y = findColor({884, 617, 886, 619},
				"0|0|0xfbfbfa,-11|-5|0x452116,9|7|0xfefefe",
				90, 0, 0, 0)
			if x > -1 then
				random_touch(0, 875, 595, 10, 10)
				return
			end
		end
		if df_pos[2] == 1 then
			x, y = findColor({984, 617, 986, 619},
				"0|0|0xfbfbfa,-11|-5|0x452116,9|7|0xfefefe",
				90, 0, 0, 0)
			if x > -1 then
				random_touch(0, 975, 595, 10, 10)
				return
			end
		end
		if df_pos[3] == 1 then
			x, y = findColor({1084, 617, 1086, 619},
				"0|0|0xfbfbfa,-11|-5|0x452116,9|7|0xfefefe",
				90, 0, 0, 0)
			if x > -1 then
				random_touch(0, 1075, 595, 10, 10)
				return
			end
		end
	end
end

function sushi_check()
	local x, y = findColor({916, 87, 918, 89},
		"0|0|0xcbb59c,-1|40|0xcbb59c,-257|19|0xcbb59c",
		95, 0, 0, 0)
	return x, y
end

function get_scene_move(scene_move)
	local move_total = 0
	
	if scene_move == "2-3" then
		move_total = math.random(2, 3)
	elseif scene_move == "3-4" then
		move_total = math.random(3, 4)
	elseif scene_move == "4-5" then
		move_total = math.random(4, 5)
	end
	
	return move_total
end

function treasure_box()
	local x, y = findColor({70, 150, 80, 550},
		"0|0|0xbd4a1c,6|-1|0xd08635,2|-8|0x261917,17|-17|0xece0c7",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"发现宝箱",20,"0xff000000","0xffffffff",0,100,0,300,32)
		mSleep(1000)
		random_touch(0, x, y, 5, 5)
	end
	return x, y
end

-- Main func
function tansuo(mode, sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type)
	print(string.format("模式: %s, 选择: 物品-%d,金币-%d,经验-%d,Boss-%d, 标记: %s, 难度: %s, 移动: %s, 章节: %d, 限定: %s, 胜利: %s, 通关: %s, 邀请 %s",
			mode, sel[1], sel[2], sel[3], sel[4], mark, scene_move, hard, section, count_mode, win_round, sec_round, captain_auto_invite))
	print(string.format("狗粮普攻 %d, 队长位置 %s 满级操作 %s, 初始翻页 %s, 狗粮类型 %s)",
			nor_attk, captain_pos, full_exp, page_jump, df_type))
	print_global_config()
	
	local ret = 0
	
	if buff_start == 1 then
		buff_start_en = 1
		buff_sel[1] = 0
		buff_sel[2] = 0
		if sel[2] == 1 then
			buff_sel[3] = 1
		end
		if sel[3] == 1 then
			buff_sel[4] = 1
		end
	end
	
	turbo_settle = 0
	
	while (1) do
		if mode == "单人" then
			ret = tansuo_solo(sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_pos, nor_attk, full_exp, page_jump, df_type)
		elseif mode == "队长" then
			ret = tansuo_captain(sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type)
		elseif mode == "队员" then
			ret = tansuo_member(sel, mark, count_mode, win_round, sec_round, captain_pos, nor_attk, full_exp, page_jump, df_type)
		end
		
		if ret ~= RET_RECONN then
			return ret
		end
	end
	
	return RET_ERR
end

function tansuo_solo(sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_pos, nor_attk, full_exp, page_jump, df_type)
	local move_total = get_scene_move(scene_move)
	local move_cnt = 0
	local quit_sce = 0
	local quit_end = 0
	local quit_con = 0
	local sec_cnt = 0
	local found_boss = 0
	local unlock = 0
	local ret = RET_ERR
	local df_pos = {}
	local top_left = 0
	local top_mid = 0
	local top_right = 0
	local tingyuan_time_cnt = 0
	local tansuo_time_cnt = 0
	local x, y, x_, y_
	
	if captain_pos == "左前" then
		df_pos = {0, 1, 1}
	else
		df_pos = {1, 1, 1}
	end
	
	while (1) do
		while (1) do
			-- 战
			x, y = round_fight() if x > -1 then tansuo_mark(mark) break end
			-- 一回目
			x, y = round_one() if x > -1 then tansuo_mark(mark) break end
			-- 二回目
			x, y = round_two() if x > -1 then tansuo_mark(mark) break end
			mSleep(500)
			-- 循环通用
			ret = loop_generic() if ret == RET_RECONN then return RET_RECONN end
			-- 超鬼王
			SuperGhost()
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo()
			if (x > -1) then
				x_, y_ = treasure_box()
				if x_ > -1 then
					break
				end
				if quit_end == 1 then
					stop_buff()
					lua_exit()
				end
				if quit_con == 1 then
					stop_buff()
					return RET_VALID
				end
				if buff_start_en == 1 then
					start_buff()
					buff_start_en = 0
				end
				section_select(section)
				tansuo_time_cnt = idle_at_tansuo(tansuo_time_cnt)
				break
			end
			-- 自动狗粮
			if full_exp == "null" then
				-- 战斗准备
				x, y = fight_ready() if (x > -1) then break end
			else
				if full_exp == "change" then
					-- 更换式神
					x, y = skkm_change_all()
					if x > -1 then
						random_touch(0, 65, 585, 10, 10) -- 全部
						break
					end
					x, y = skkm_change_sel()
					if x > -1 then
						if df_type == "N" then
							random_touch(0, 155, 300, 5, 5) -- N
						elseif df_type == "Egg" then
							random_touch(0, 60, 285, 5, 5) -- 素材
						end
						random_sleep(750)
						break
					end
					-- N卡
					x, y = skkm_change_N()
					if x > -1 then
						if top_left == 1 or top_right == 1 or top_mid == 1 then
							skkm_change_scroll(page_jump)
						end
						skkm_change_switch(top_left, top_mid, top_right, 0, 0)
						fight_ready()
						top_left = 0
						top_mid = 0
						top_right = 0
						break
					end
					-- 素材
					x, y = skkm_change_egg()
					if x > -1 then
						if top_left == 1 or top_right == 1 or top_mid == 1 then
							skkm_change_scroll(page_jump)
						end
						skkm_change_switch(top_left, top_mid, top_right, 0, 0)
						fight_ready()
						top_left = 0
						top_mid = 0
						top_right = 0
						break
					end
				end
				-- 探索预备
				x, y = lct_tansuo_prepare()
				if x > -1 then
					mSleep(500)
					top_left, top_mid, top_right = full_exp_top(df_pos)
					if top_left == 1 or top_mid == 1 or top_right == 1 then
						if full_exp == "change" then
							HUD_show_or_hide(HUD,hud_info,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
							random_touch(0, 350, 420, 30, 30) -- 更换式神
							break
						elseif full_exp == "alarm" then
							ret = alarm("pause")
						end
					end
					random_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 探索场景
			x, y = lct_tansuo_scene()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				-- 退出场景
				if quit_sce == 1 then
					HUD_show_or_hide(HUD,hud_info,"退出场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 45, 60, 10, 10) -- 左上退出
					break
				end
				-- 寻找
				ret = find_target(sel)
				if ret == RET_ERR then
					-- Move
					move_cnt = move_cnt + 1
					HUD_show_or_hide(HUD,hud_info,string.format("场景移动[%d次]", move_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_move(0 ,950, 400, 200, 400, 30, 30) -- 场景移动
					if move_cnt >= move_total then
						quit_sce = 1
						break
					end
				elseif ret == RET_VALID then
					found_boss = 1
				end
				break
			end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				-- 狗粮普攻
				if nor_attk == 1 then df_normal_attack(df_pos, "solo") break end
				break
			end
			-- 战斗胜利
			x, y, ret = fight_settle("探索")
			if (x > -1) then
				tingyuan_time_cnt = 0
				tansuo_time_cnt = 0
				if ret == "Success" then
					win_cnt.global = win_cnt.global + 1
					show_win_fail(win_cnt.global, fail_cnt.global)
					win_cnt.tansuo = win_cnt.tansuo + 1
					if count_mode == "战斗" then
						if win_cnt.tansuo >= win_round then
							quit_sce = 1
							quit_end = 1
						end
					end
					if found_boss == 1 then
						found_boss = 0
						quit_sce = 1
						if count_mode == "章节" then
							sec_cnt = sec_cnt + 1
							if sec_cnt >= sec_round then
								quit_end = 1
							end
						end
					end
				elseif ret == "Failed" then
					fail_cnt.global = fail_cnt.global + 1
					show_win_fail(win_cnt.global, fail_cnt.global)
					fail_cnt.tansuo = fail_cnt.tansuo + 1
					if found_boss == 1 then
						found_boss = 0
					end
				end
				break
			end
			-- 探索章节
			x, y = lct_tansuo_portal()
			if x > -1 then
				if quit_end == 1 then
					random_touch(0, 930, 135, 5, 5) -- 退出章节
					mSleep(1000)
					break
				end
				-- 智能突破Check
				quit_con = auto_jjtp_time_check()
				if quit_con == 1 then
					random_touch(0, 930, 135, 5, 5) -- 退出章节
					mSleep(1000)
					break
				end
				degree_select(hard)
				HUD_show_or_hide(HUD,hud_info,"进入场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_touch(0, 840, 480, 30, 10) -- 探索
				move_total = get_scene_move(scene_move)
				move_cnt = 0
				quit_sce = 0
				mSleep(2000)
				break
			end
			-- 确认退出
			x, y = scene_quit_confirm() if x > -1 then random_touch(0, x, y, 30, 5) break end
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() tingyuan_time_cnt = idle_at_tingyuan(tingyuan_time_cnt) break end
			-- 查看体力
			x, y = sushi_check() if x > -1 then right_lower_click() break end
			-- 神秘商人
			x, y = mysterious_vender() if x > -1 then break end
			-- 体力不足
			x, y = out_of_sushi() if x > -1 then break end
			-- 世界频道
			x, y = lct_channel() if x > -1 then random_touch(0, x, y, 5, 5) mSleep(500) break end
			break
		end
	end
	return RET_ERR
end

function tansuo_captain(sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type)
	local move_total = get_scene_move(scene_move)
	local move_cnt = 0
	local quit_sce = 0
	local quit_end = 0
	local quit_con = 0
	local sec_cnt = 0
	local found_boss = 0
	local unlock = 0
	local ret = RET_ERR
	local df_pos = {}
	local bot_left = 0
	local bot_right = 0
	local tingyuan_time_cnt = 0
	local tansuo_time_cnt = 0
	local invite_zone = 0
	local x, y, x_, y_
	
	if captain_pos == "正左" then
		df_pos = {0, 0, 1}
	else
		df_pos = {1, 0, 1}
	end
	
	if captain_auto_invite == "寮友" then
		invite_zone = 1
	elseif captain_auto_invite == "好友" then
		invite_zone = 2
	elseif captain_auto_invite == "跨区" then
		invite_zone = 3
	end
	
	while (1) do
		while (1) do
			-- 战
			x, y = round_fight() if x > -1 then tansuo_mark(mark) break end
			-- 一回目
			x, y = round_one() if x > -1 then tansuo_mark(mark) break end
			-- 二回目
			x, y = round_two() if x > -1 then tansuo_mark(mark) break end
			mSleep(500)
			-- 循环通用
			ret = loop_generic() if ret == RET_RECONN then return RET_RECONN end
			-- 超鬼王
			SuperGhost()
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 继续邀请
			x, y = team_invite()
			if x > -1 then
				if quit_end == 1 or quit_con == 1 then
					random_touch(0, 465, 385, 20, 5)
				else
					random_touch(0, x, y, 20, 5)
					quit_sce = 0
					move_cnt = 0
					move_total = get_scene_move(scene_move)
					mSleep(5000)
				end
				break
			end
			-- 探索
			x, y = lct_tansuo()
			if (x > -1) then
				x_, y_ = treasure_box()
				if x_ > -1 then
					break
				end
				if quit_end == 1 then
					stop_buff()
					lua_exit()
				end
				if quit_con == 1 then
					stop_buff()
					return RET_VALID
				end
				if buff_start_en == 1 then
					start_buff()
					buff_start_en = 0
				end
				section_select(section)
				tansuo_time_cnt = idle_at_tansuo(tansuo_time_cnt)
				break
			end
			-- 自动狗粮
			if full_exp == "null" then
				-- 战斗准备
				x, y = fight_ready() if (x > -1) then break end
			else
				if full_exp == "change" then
					-- 更换式神
					x, y = skkm_change_all()
					if x > -1 then
						random_touch(0, 65, 585, 10, 10) -- 全部
						break
					end
					x, y = skkm_change_sel()
					if x > -1 then
						if df_type == "N" then
							random_touch(0, 155, 300, 5, 5) -- N
						elseif df_type == "Egg" then
							random_touch(0, 60, 285, 5, 5) -- 素材
						end
						random_sleep(750)
						break
					end
					-- N卡
					x, y = skkm_change_N()
					if x > -1 then
						if bot_left == 1 or bot_right == 1 then
							skkm_change_scroll(page_jump)
						end
						skkm_change_switch(0, 0, 0, bot_left, bot_right)
						fight_ready()
						bot_right = 0
						bot_left = 0
						break
					end
					-- 素材
					x, y = skkm_change_egg()
					if x > -1 then
						if bot_left == 1 or bot_right == 1 then
							skkm_change_scroll(page_jump)
						end
						skkm_change_switch(0, 0, 0, bot_left, bot_right)
						fight_ready()
						bot_right = 0
						bot_left = 0
						break
					end
				end
				-- 探索预备
				x, y = lct_tansuo_prepare()
				if x > -1 then
					bot_left, bot_right = full_exp_bot(df_pos)
					if bot_left == 1 or bot_right == 1 then
						if full_exp == "change" then
							HUD_show_or_hide(HUD,hud_info,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
							random_touch(0, 350, 420, 30, 30) -- 更换式神
							break
						elseif full_exp == "alarm" then
							ret = alarm("pause")
						end
					end
					random_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 探索场景
			x, y = lct_tansuo_scene()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				-- 退出场景
				if quit_sce == 1 then
					HUD_show_or_hide(HUD,hud_info,"退出场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 45, 60, 10, 10) -- 左上退出
					break
				end
				-- 寻找
				ret = find_target(sel)
				if ret == RET_ERR then
					-- Move
					move_cnt = move_cnt + 1
					HUD_show_or_hide(HUD,hud_info,string.format("场景移动[%d次]", move_cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_move(0 ,950, 400, 200, 400, 30, 30) -- 场景移动
					if move_cnt >= move_total then
						quit_sce = 1
						break
					end
				elseif ret == RET_VALID then
					found_boss = 1
				end
				break
			end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				-- 狗粮普攻
				if nor_attk == 1 then df_normal_attack({df_pos[1], df_pos[3], df_pos[2]}, "group") end
				break
			end
			-- 战斗胜利
			x, y, ret = fight_settle("探索")
			if (x > -1) then
				tingyuan_time_cnt = 0
				tansuo_time_cnt = 0
				if ret == "Success" then
					win_cnt.global = win_cnt.global + 1
					show_win_fail(win_cnt.global, fail_cnt.global)
					win_cnt.tansuo = win_cnt.tansuo + 1
					if count_mode == "战斗" then
						if win_cnt.tansuo >= win_round then
							quit_sce = 1
							quit_end = 1
						end
					end
					if found_boss == 1 then
						found_boss = 0
						quit_sce = 1
						if count_mode == "章节" then
							sec_cnt = sec_cnt + 1
							if sec_cnt >= sec_round then
								quit_end = 1
							end
						end
					end
					-- 智能突破Check
					quit_con = auto_jjtp_time_check()
				elseif ret == "Failed" then
					fail_cnt.global = fail_cnt.global + 1
					show_win_fail(win_cnt.global, fail_cnt.global)
					fail_cnt.tansuo = fail_cnt.tansuo + 1
					if found_boss == 1 then
						found_boss = 0
					end
					break
				end
				break
			end
			-- 探索章节
			x, y = lct_tansuo_portal()
			if x > -1 then
				if quit_end == 1 then
					random_touch(0, 930, 135, 5, 5) -- 退出章节
					mSleep(1000)
					break
				end
				if quit_con == 1 then
					random_touch(0, 930, 135, 5, 5) -- 退出章节
					mSleep(1000)
					break
				end
				degree_select(hard)
				HUD_show_or_hide(HUD,hud_info,"邀请队员",20,"0xff000000","0xffffffff",0,100,0,300,32)
				random_touch(0, 580, 480, 30, 10) -- 组队
				move_total = get_scene_move(scene_move)
				move_cnt = 0
				quit_sce = 0
				mSleep(2000)
				break
			end
			-- 邀请第一个好友
			if (captain_auto_invite ~= "禁用") then
				x, y = captain_room_invite_first(invite_zone)
				if (x > -1) then
					quit_sce = 0
					move_cnt = 0
					move_total = get_scene_move(scene_move)
					mSleep(3000)
					break
				end
			end
			-- 确认退出
			x, y = scene_quit_confirm() if x > -1 then random_touch(0, x, y, 30, 5) break end
			-- 队员档案
			x, y = member_user_profile() if x > -1 then break end
			-- 庭院
			x, y = lct_tingyuan() if (x > -1) then tingyuan_enter_tansuo() tingyuan_time_cnt = idle_at_tingyuan(tingyuan_time_cnt) break end
			-- 神秘商人
			x, y = mysterious_vender() if x > -1 then break end
			-- 体力不足
			x, y = out_of_sushi() if x > -1 then break end
			-- 世界频道
			x, y = lct_channel() if x > -1 then random_touch(0, x, y, 5, 5) mSleep(500) break end
			break
		end
	end
	return RET_ERR
end

function tansuo_member(sel, mark, count_mode, win_round, sec_round, captain_pos, nor_attk, full_exp, page_jump, df_type)
	local unlock = 0
	local ret = RET_ERR
	local quit_sce = 0
	local quit_end = 0
	local quit_con = 0
	local sec_cnt = 0
	local df_pos = {}
	local top_left = 0
	local top_mid = 0
	local top_right = 0
	local tingyuan_time_cnt = 0
	local tansuo_time_cnt = 0
	local x, y, x_, y_
	
	if captain_pos == "左前" then
		df_pos = {0, 1, 1}
	else
		df_pos = {1, 1, 1}
	end
	
	while (1) do
		while (1) do
			-- 战
			x, y = round_fight() if x > -1 then tansuo_mark(mark) break end
			-- 一回目
			x, y = round_one() if x > -1 then tansuo_mark(mark) break end
			-- 二回目
			x, y = round_two() if x > -1 then tansuo_mark(mark) break end
			mSleep(500)
			-- 循环通用
			ret = loop_generic() if ret == RET_RECONN then return RET_RECONN end
			-- 超鬼王
			SuperGhost()
			-- 拒绝邀请
			if quit_con == 1 or quit_end == 1 then
				x, y = member_team_refuse_invite() if (x > -1) then mSleep(1000) break end
			else
				-- 接受邀请
				x, y, auto_grouped = member_team_accept_invite(member_auto_group) if (x > -1) then break end
			end
			-- 探索场景
			x, y = lct_tansuo_scene()
			if x > -1 then
				-- Unlock
				if unlock == 0 then
					lock_or_unlock(0, "探索")
					unlock = 1
					break
				end
				x_, y_ = member_quit()
				if x_ == -1 or quit_sce == 1 then
					HUD_show_or_hide(HUD,hud_info,"退出场景",20,"0xff000000","0xffffffff",0,100,0,300,32)
					random_touch(0, 45, 60, 10, 10) -- 左上退出
					if count_mode == "章节" then
						sec_cnt = sec_cnt + 1
						if sec_cnt >= sec_round then
							quit_end = 1
						end
					end
				end
				break
			end
			-- 探索
			x, y = lct_tansuo()
			if x > -1 then
				x_, y_ = treasure_box()
				if x_ > -1 then
					break
				end
				if quit_end == 1 then
					stop_buff()
					lua_exit()
				end
				-- 智能突破Check
				quit_con = auto_jjtp_time_check()
				if quit_con == 1 then
					stop_buff()
					return RET_VALID
				end
				if buff_start_en == 1 then
					start_buff()
					buff_start_en = 0
				end
				tansuo_time_cnt = idle_at_tansuo(tansuo_time_cnt)
				break
			end
			-- 自动狗粮
			if full_exp == "null" then
				-- 战斗准备
				x, y = fight_ready() if (x > -1) then break end
			else
				-- 更换式神
				x, y = skkm_change_all()
				if x > -1 then
					random_touch(0, 65, 585, 10, 10) -- 全部
					break
				end
				x, y = skkm_change_sel()
				if x > -1 then
					if df_type == "N" then
						random_touch(0, 155, 300, 5, 5) -- N
					elseif df_type == "Egg" then
						random_touch(0, 60, 285, 5, 5) -- 素材
					end
					random_sleep(750)
					break
				end
				-- N卡
				x, y = skkm_change_N()
				if x > -1 then
					if top_left == 1 or top_right == 1 or top_mid == 1 then
						skkm_change_scroll(page_jump)
					end
					skkm_change_switch(top_left, top_mid, top_right, 0, 0)
					fight_ready()
					top_left = 0
					top_mid = 0
					top_right = 0
					break
				end
				-- 素材
				x, y = skkm_change_egg()
				if x > -1 then
					if top_left == 1 or top_right == 1 or top_mid == 1 then
						skkm_change_scroll(page_jump)
					end
					skkm_change_switch(top_left, top_mid, top_right, 0, 0)
					fight_ready()
					top_left = 0
					top_mid = 0
					top_right = 0
					break
				end
				-- 探索预备
				x, y = lct_tansuo_prepare()
				if x > -1 then
					top_left, top_mid, top_right = full_exp_top(df_pos)
					if top_left == 1 or top_mid == 1 or top_right == 1 then
						HUD_show_or_hide(HUD,hud_info,"更换狗粮",20,"0xff000000","0xffffffff",0,100,0,300,32)
						random_touch(0, 350, 420, 30, 30) -- 更换式神
						break
					end
					random_sleep(500)
					x_, y_ = fight_ready() if (x_ > -1) then break end
					break
				end
			end
			-- 战斗进行
			x, y = fight_ongoing()
			if (x > -1) then
				-- 狗粮普攻
				if nor_attk == 1 then df_normal_attack(df_pos, "group") end
				break
			end
			-- 战斗胜利
			x, y, ret = fight_settle("探索")
			if (x > -1) then
				tansuo_time_cnt = 0
				tingyuan_time_cnt = 0
				if ret == "Success" then
					win_cnt.global = win_cnt.global + 1
					show_win_fail(win_cnt.global, fail_cnt.global)
					win_cnt.tansuo = win_cnt.tansuo + 1
					if count_mode == "战斗" then
						if win_cnt.tansuo >= win_round then
							quit_sce = 1
							quit_end = 1
						end
					end
				elseif ret == "Failed" then
					fail_cnt.global = fail_cnt.global + 1
					show_win_fail(win_cnt.global, fail_cnt.global)
					fail_cnt.tansuo = fail_cnt.tansuo + 1
				end
				break
			end
			-- 确认退出
			x, y = scene_quit_confirm() if x > -1 then random_touch(0, x, y, 30, 5) break end
			-- 探索章节
			x, y = lct_tansuo_portal()
			if x > -1 then
				if quit_end == 1 then
					random_touch(0, 930, 135, 5, 5) -- 退出章节
					mSleep(1000)
					break
				end
				-- 智能突破Check
				quit_con = auto_jjtp_time_check()
				if quit_con == 1 then
					random_touch(0, 930, 135, 5, 5) -- 退出章节
					mSleep(1000)
					break
				end
				break
			end
			-- 查看体力
			x, y = sushi_check() if x > -1 then right_lower_click() break end
			-- 队员档案
			x, y = member_user_profile() if x > -1 then break end
			-- 庭院
			x, y = lct_tingyuan()
			if x > -1 then
				if buff_start_en == 1 then
					start_buff()
					buff_start_en = 0
				end
				tingyuan_time_cnt = idle_at_tingyuan(tingyuan_time_cnt)
				break
			end
			-- 神秘商人
			x, y = mysterious_vender() if x > -1 then break end
			-- 体力不足
			x, y = out_of_sushi() if x > -1 then break end
			-- 世界频道
			x, y = lct_channel() if x > -1 then random_touch(0, x, y, 5, 5) mSleep(500) break end
			break
		end
	end
	return RET_ERR
end