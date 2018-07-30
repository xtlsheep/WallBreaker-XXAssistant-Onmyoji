require "util"
require "func"

-- Util func
function lct_sgcm()
	x, y = findColor({668, 352, 675, 358}, -- 当前积分
		"0|0|0xdfba67,-1|25|0xe2bd6c,-101|25|0xdfb564,-95|-11|0xfffded",
		95, 0, 0, 0)
	if x > -1 then
		showHUD_ios_ver(ios_ver,hud_scene,"超鬼王 - 猫掌柜",20,"0xff000000","0xffffffff",0,100,0,228,32)
	end
	return x, y
end

function find_guiwang()
	x, y = findColor({291, 188, 295, 192}, -- 鬼王中部
		"0|0|0xcec5bd,-37|-21|0xb1372a",
		95, 0, 0, 0)
	if x > -1 then
		x_b, y_b = findColor({104, 223, 106, 225}, -- 血条0刻度
			"0|0|0x6f6054,0|16|0x6f6054",
			95, 0, 0, 0)
		if x_b > -1 then
			return RET_ERR
		end
		ran_touch(0, x, y, 50, 10)
		ran_touch(0, 528, 466, 3, 3) -- 普通追击
		ran_touch(0, 1029, 510, 10, 10) -- 挑战
	end
	return x
end

function lct_tired()
	x, y = findColor({461, 325, 464, 327}, -- 茶
		"0|0|0x9cd52b,-19|-22|0x404354,26|-20|0x414457,-17|26|0x41445d",
		95, 0, 0, 0)
	if x > -1 then
		showHUD_ios_ver(ios_ver,hud_scene,"疲劳度过高",20,"0xff000000","0xffffffff",0,100,0,228,32)
		ran_touch(0, 833, 171, 5, 5) -- ×
	end
	return x, y
end

function sgcm_broadcast(friend, house)
	x, y = findColor({108, 42, 116, 49}, --  集结邀请窗口
		"0|0|0x2f0606,553|63|0x9f876d,552|103|0xcbb59c",
		95, 0, 0, 0)
	str = nil
	if x > -1 then
		pos = {}
		pos[1] = math.random(1, 2)
		pos[2] = math.random(3, 4)
		pos[3] = math.random(5, 6)
		pos[4] = math.random(7, 8)
		
		if friend == 0 then
			showHUD_ios_ver(ios_ver,hud_scene,"集结好友",20,"0xff000000","0xffffffff",0,100,0,228,32)
			ran_touch(0, 362, 114, 20, 10) -- 好友
			str = "friend"
		elseif house == 0 then
			showHUD_ios_ver(ios_ver,hud_scene,"集结寮友",20,"0xff000000","0xffffffff",0,100,0,228,32)
			ran_touch(0, 464, 115, 20, 10) -- 寮友
			str = "house"
		end
		
		mSleep(3000)
		
		if pos[1] == 1 then ran_touch(0, 438, 208, 30, 10) else ran_touch(0, 710, 208, 30, 10) end ran_sleep(250) -- 第一排
		if pos[2] == 3 then ran_touch(0, 438, 297, 30, 10) else ran_touch(0, 710, 297, 30, 10) end ran_sleep(250)
		if pos[3] == 5 then ran_touch(0, 438, 377, 30, 10) else ran_touch(0, 710, 377, 30, 10) end ran_sleep(250)
		if pos[4] == 7 then ran_touch(0, 438, 457, 30, 10) else ran_touch(0, 710, 457, 30, 10) end ran_sleep(250) -- 第四排
		
		ran_touch(0, 691, 511, 20, 10) -- 邀请
	end
	return x, y, str
end

function sgcm_mark()
	-- 标记猫掌柜和草人
	x, y = findColor({605, 145, 660, 197},
		"0|0|0xbc1b3f,0|-25|0xd90d4f,-18|-25|0xef45aa,19|-26|0xf556b6",
		95, 0, 0, 0)
	if x > -1 then
		return
	end
	
	ran = math.random(1, 100)
	if (ran < 10) then
		ran_touch(0, 530, 120, 3, 3) -- 猫掌柜
	end
	if (ran > 90) then
		ran_touch(0, 630, 274, 3, 3) -- 草人
	end
end



-- Main func
function super_ghost_cat_manager(direct_go)
	if (direct_go == 0) then
		x, y = findColor({192, 239, 197, 500}, -- 弹窗中部
			"0|0|0xd7b19e,-2|-23|0xd7c0ab,-1|26|0xd5a892,87|-12|0xd47c63",
			95, 0, 0, 0)
		if x == -1 then
			return RET_ERR
		end
		
		showHUD_ios_ver(ios_ver,hud_scene,"发现 超鬼王 - 猫掌柜",20,"0xff000000","0xffffffff",0,100,0,228,32)
		x_enter = -1
		while (x_enter == -1) do
			-- 悬赏封印
			x_offer, y_offer = find_offer(offer) if (x_offer > -1) then break end
			-- 进入超鬼王
			x_enter, y_enter = findColor({192, 239, 197, 500}, -- 弹窗中部
				"0|0|0xd7b19e,-2|-23|0xd7c0ab,-1|26|0xd5a892,87|-12|0xd47c63",
				95, 0, 0, 0)
			ran_touch(0, x_enter, y_enter, 100, 20)
		end
		mSleep(3000)
	end
	
	quit = 0
	tired = 0
	friend = 0
	house = 0
	while (1) do
		while (1) do
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer("拒绝") if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then sgcm_mark() break end
			-- 超鬼王界面
			x, y = lct_sgcm()
			if x > -1 then
				if (tired == 1) then
					ran_touch(0, 877, 525, 5, 5) -- 集结
					mSleep(3000)
					break
				end
				if (quit == 1) then
					showHUD_ios_ver(ios_ver,hud_scene,"退出超鬼王",20,"0xff000000","0xffffffff",0,100,0,228,32)
					ran_touch(0, 1043, 68, 5, 5) -- ×
					ran_sleep(1000)
					return RET_OK
				end
				x = find_guiwang()
				if x == -1 then
					quit = 1
					break
				end
			end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then mSleep(3000) ran_touch(0, 530, 120, 3, 3) break end -- 猫掌柜
			-- 战斗失败
			x, y = fight_failed() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 疲劳过高
			x, y = lct_tired() if (x > -1) then tired = 1 break end
			-- 集结
			x, y, str = sgcm_broadcast(friend, house)
			if (x > -1) then
				if (str == "friend") then
					friend = 1
				end
				if (str == "house") then
					house = 1
				end
				if (friend == 1 and house == 1) then
					tired = 0
					quit = 1
				end
				break
			end
			-- 断线期间结束战斗
			x, y = disconnect_end_fight() if (x > -1) then break end
			-- 探索返回
			x, y = lct_tansuo() if (x > -1) then return RET_OK end
			break
		end
	end
	return RET_OK
end