require "util"
require "func"

-- Util func
function lct_call_house()
	local x, y = findColor({201, 488, 203, 490}, -- 四种颜色的票
		"0|0|0xd2d5d3,227|1|0x98daf1,459|3|0x626262,702|21|0xbd69dc",
		95, 0, 0, 0)
	return x, y
end

function five_tickets()
	local x, y = findColor({269, 176, 271, 178}, -- 白票&红色&柱子
		"0|0|0xffffff,-1|12|0xd8dbd9,512|-48|0x782025,561|-47|0x3d1514",
		95, 0, 0, 0)
	return x, y
end

function finish_call()
	local x, y = findColor({565, 591, 567, 593},
		"0|0|0x46372a,-2|-34|0x332a36,-64|-15|0xf3b25e,61|-16|0xf3b25e,241|23|0x87715f",
		95, 0, 0, 0)
	return x, y
end

function tickets_call()
	local x = 270 + math.random(-20, 20) -- to 870 +-20
	local y = 240 -- to 240 +-60(4*15)
	local x_interv = 40
	local y_interv = math.random(-4, 4)
	local steps = 15
	
	touchDown(0, x, y)
	for i = 1, steps do
		touchMove(0, x+i*x_interv, y+i*y_interv)
		mSleep(25)
	end
	touchUp(0, x+steps*x_interv, y+steps*y_interv)
end

-- Main func
function normalcall(tickets, offer_arr)
	print(string.format("tickets: %d, 悬赏封印: %d(勾玉: %d 体力：%d 樱饼：%d 金币：%d 零食：%d)", tickets,
			offer_arr[1], offer_arr[2], offer_arr[3], offer_arr[4], offer_arr[5], offer_arr[6]))
	
	local cnt = 0
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y, x_, y_
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 完成召唤
			if cnt >= tickets then
				x, y = finish_call()
				if x > -1 then
					ran_touch(0, 448, 576, 30, 10) -- 确定
					break
				end
				x, y = lct_call_house()
				if x > -1 then
					ran_touch(0, 52, 27, 10, 10) -- 返回
					return
				end
			else
				-- 召唤小屋
				x, y = lct_call_house()
				if x > -1 then
					ran_touch(0, 230, 543, 20, 20) -- 点击白票
					mSleep(1000)
					x_, y_ = lct_call_house()
					if x_ > -1 then
						ran_touch(0, 52, 27, 10, 10) -- 返回
						return
					end
					break
				end
				-- 五张白票
				x, y = five_tickets()
				if x > -1 then
					cnt = cnt + 5
					HUD_show_or_hide(HUD,hud_scene,string.format("召唤票数 ~= %d", cnt),20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_interv()
					tickets_call()
					break
				end
				-- 完成召唤
				x, y = finish_call() if x > -1 then ran_touch(0, 688, 576, 30, 10) break end -- 再次召唤
			end
			break
		end
	end
end