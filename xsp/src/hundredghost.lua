require "util"
require "func"

-- Util func
function lct_hg()
	local x, y
	
	x, y = findColor({33, 51, 35, 53},
		"0|0|0xf0f5fb,59|536|0xefe9be,61|546|0xb1701d,70|542|0x271818,165|542|0xf2cd4a",
		95, 0, 0, 0)
	
	return x, y
end

function hg_portal_uninvited(invite)
	local x, y = findColor({270, 466, 272, 268},
		"0|0|0xf4ebe0,18|-11|0x473a39,-16|12|0x473a39,618|-322|0xe8d4cf,-39|-113|0x6b1830",
		95, 0, 0, 0)
	if x > -1 then
		if invite == 1 then
			random_touch(0, x, y, 10, 10) -- 邀请
			random_sleep(1000)
		end
	end
	return x, y
end

function hg_portal_invited(invite_cnt)
	local x, y
	
	if ver == "iOS" then
		x, y = findColor({823, 468, 825, 470},
			"0|0|0xf3b25e,-517|-33|0xe8d4cf,-503|-31|0x952f7c,-449|8|0xd3ab83,65|-325|0xe8d4cf",
			95, 0, 0, 0)
	elseif ver == "android" then
		x, y = findColor({823, 468, 825, 470},
			"0|0|0xf4b25f,64|-322|0xf3d2d2,-518|-31|0xe5d4cf,-622|-112|0xefefe7,-599|-121|0x621329",
			95, 0, 0, 0)
	end
	
	if x > -1 then
		if invite_cnt < 3 then
			random_touch(0, x, y, 20, 10) -- 进入
			return invite_cnt + 1
		else
			random_touch(0, 310, 435, 5, 5) -- x
			return 0
		end
	end
	return invite_cnt
end

function hg_invite(invite)
	local x_ = {450, 700}
	local y_ = {230, 305, 380, 455}
	local pos = math.random(1, 8)
	local x, y
	
	x, y = findColor({888, 144, 890, 146},
		"0|0|0xb2a29e,-686|207|0xb7b7b2,-622|-22|0xe3758c,-42|-48|0xf5e0da",
		95, 0, 0, 0)
	if x > -1 and invite == 1 then
		HUD_show_or_hide(HUD,hud_info,string.format("邀请第%d位好友", pos),20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_touch(0, x_[2 - pos%2], y_[math.floor((pos - 1)/2) + 1], 30, 10) -- 随机选择1-8
		random_sleep(1000)
	end
	return x, y
end

function hg_master_sel()
	local pos = math.random(1, 3)
	local x_ = {270, 570, 870}
	local x, y = findColor({1046, 544, 1048, 546},
		"0|0|0xfffeef,-72|5|0xdddfdc,20|-36|0xa86a4e,-1011|-490|0xecf3fb,-959|-366|0x881521",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,string.format("选择%d号鬼王", pos),20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_sleep(1000)
		random_touch(0, x_[pos], 425, 20, 20) -- 随机选择1-3
		random_sleep(1000)
		random_touch(0, x, y, 30, 30) -- 开始
		random_sleep(1000)
	end
	return x, y
end

function hg_bean_sel(num)
	local pos = math.random(1, 3)
	local x_6_7 = {374, 403}
	local x_8_10 = {441, 466, 490}
	
	function hg_bean_move(x1, y1 ,x2, y2)
		local ran_x, ran_ys
		ran_x = math.random(-5, 5)
		ran_y = math.random(-10, 10)
		touchDown(0, x1 + ran_x, y1 + ran_y)
		ran_x = math.random(-5, 5)
		ran_y = math.random(-10, 10)
		touchMove(0, x2 + ran_x, y2 + ran_y)
		random_sleep(100)
		touchUp(0, x2 + ran_x, y2 + ran_y)
		return
	end
	
	if num == "5-7" then
		if pos == 1 then
			HUD_show_or_hide(HUD,hud_info,"豆子数量设定为5",20,"0xff000000","0xffffffff",0,100,0,300,32)
			return
		elseif pos == 2 then
			HUD_show_or_hide(HUD,hud_info,"豆子数量设定为6",20,"0xff000000","0xffffffff",0,100,0,300,32)
			hg_bean_move(338, 590, x_6_7[1], 590)
		else
			HUD_show_or_hide(HUD,hud_info,"豆子数量设定为7",20,"0xff000000","0xffffffff",0,100,0,300,32)
			hg_bean_move(338, 590, x_6_7[2], 590)
		end
	elseif num == "8-10" then
		if pos == 1 then
			HUD_show_or_hide(HUD,hud_info,"豆子数量设定为8",20,"0xff000000","0xffffffff",0,100,0,300,32)
			hg_bean_move(338, 590, x_8_10[1], 590)
		elseif pos == 2 then
			HUD_show_or_hide(HUD,hud_info,"豆子数量设定为9",20,"0xff000000","0xffffffff",0,100,0,300,32)
			hg_bean_move(338, 590, x_8_10[2], 590)
		else
			HUD_show_or_hide(HUD,hud_info,"豆子数量设定为10",20,"0xff000000","0xffffffff",0,100,0,300,32)
			hg_bean_move(338, 590, x_8_10[3], 590)
		end
	end
end

function hg_fight()
	-- 150, 400 - 950, 400
	local cnt = math.random(3, 4)
	local x_interv = 800/cnt
	local x, y
	
	for i = 1, cnt + 1 do
		random_sleep(500)
		random_touch(0, 1000 - x_interv*(i - 1), 400, 30, 30)
	end
end

function hg_get_frag()
	local x, y
	
	if ver == "iOS" then
		x, y = findColor({86, 126, 88, 128},
			"0|0|0xc6a3d8,-6|-8|0xae6cc9,46|31|0xf0eae1,-13|360|0x8b55a6,11|350|0x60648e",
			95, 0, 0, 0)
	elseif ver == "android" then
		x, y = findColor({84, 115, 86, 117},
			"0|0|0xb473cf,7|7|0xcaa6dd,15|-7|0x8485ad,50|42|0xece6df,33|24|0xacabcf",
			95, 0, 0, 0)
	end
	
	if x > -1 then
		HUD_show_or_hide(HUD,hud_info,"百鬼契约书",20,"0xff000000","0xffffffff",0,100,0,300,32)
		random_sleep(500)
		random_touch(0, 800, 600, 100, 20) -- 底部空白
		random_sleep(1000)
	end
	return x, y
end

-- Main func
function hundredghost(round, num, invite)
	print(string.format("次数 %d 豆子 %s 邀请 %d", round, num, invite))
	print_global_config()
	local ret
	
	while (1) do
		ret = hundredghost_(round, num, invite)
		if ret ~= RET_RECONN then
			return ret
		end
	end
	
	return RET_ERR
end

function hundredghost_(round, num, invite)
	local bean_sel = 0
	local invite_cnt = 0
	local ret = 0
	local x, y

	while (1) do
		while(1) do
			mSleep(500)
			-- 循环通用
			ret = loop_generic() if ret == RET_RECONN then return RET_RECONN end
			-- 百鬼夜行
			x, y = lct_hg()
			if x > -1 then
				-- 豆子数量
				if bean_sel == 0 then
					hg_bean_sel(num)
					bean_sel = 1
				end
				-- 砸百鬼
				hg_fight()
				break
			end
			-- 百鬼Portal-未邀请
			x, y = hg_portal_uninvited(invite)
			if x > -1 then
				bean_sel = 0
				invite_cnt = 0
				if win_cnt.hundgho >= round then
					random_touch(0, 890, 150, 5, 5) -- 右上退出
					lua_exit()
				end
				break
			end
			-- 邀请好友
			x, y = hg_invite(invite) if x > -1 then break end
			-- 百鬼Portal-已邀请
			invite_cnt = hg_portal_invited(invite_cnt)
			-- 鬼王选择
			x, y = hg_master_sel() if x > -1 then win_cnt.hundgho = win_cnt.hundgho + 1 break end
			-- 领取奖励
			x, y = hg_get_frag() if x > -1 then break end
			-- 町中
			x, y = lct_dingzhong() if x > -1 then random_touch(0, x, y, 5, 5) mSleep(500) break end
			-- 庭院
			x, y = lct_tingyuan() if x > -1 then tingyuan_enter_dingzhong() break end
			break
		end
	end
	return RET_ERR
end