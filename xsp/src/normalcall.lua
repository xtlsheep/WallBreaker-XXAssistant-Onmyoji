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
	local x = 270
	local y = 240
	local x_ran = 20
	local y_ran	= 10
	local x_interv = 40
	local y_interv = math.random(-3, 3)
	local steps = 15

	ran_move_steps(0, x, y, x_ran, y_ran, x_interv, y_interv, steps)
end

-- Main func
function normalcall(tickets)
	print(string.format("召唤次数: %d", tickets))
	print_global_vars()
	
	local cnt = 0
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y, x_, y_
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
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