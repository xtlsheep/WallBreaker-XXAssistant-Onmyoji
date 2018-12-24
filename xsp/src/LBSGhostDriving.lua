require "util"
require "func"

-- Util func
function main_page()
	local x, y = findColor({902, 486, 904, 488},
		"0|0|0xe4d9c2,124|-375|0xe9d7d1,123|-391|0x673039,96|-406|0xe1d9d1,-363|-37|0xc4b2a3",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 20, 20)
	end
	return x, y
end

function create_team()
	local x, y = findColor({566, 452, 568, 454},
		"0|0|0xf3b25e,125|-1|0xcbb59c,337|37|0xe5dac4,462|-340|0xe9d7d1",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 20, 20)
		
	end
	return x, y
end

function leave_team()
	local x, y = findColor({199, 536, 201, 538},
		"0|0|0xdf6851,724|-13|0xf3b25e,116|-4|0xc7bdb4,-11|-275|0xcec6bc",
		95, 0, 0, 0)
	if x > -1 then
		mSleep(2*1000)
		random_touch(0, x, y, 20, 20)
	end
	return x, y
end

function leave_confirm()
	local x, y = findColor({672, 381, 674, 383},
		"0|0|0xf3b25e,-64|-4|0xf3b25e,53|-2|0xf3b25e,-165|-2|0xdf6851",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 20, 20)
	end
	return x, y
end

function cancel_invite()
	local x, y = findColor({445, 509, 447, 511},
		"0|0|0xdf6851,240|1|0xf3b25e,118|1|0xcbb59c",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 20, 20)
	end
	return x, y
end

function pop_up()
	local x, y = findColor({902, 488, 904, 490},
		"0|0|0xa19a8a,-453|-133|0xcbb59c,-462|-7|0xcbb59c,124|-377|0xa49894",
		95, 0, 0, 0)
	if x > -1 then
		random_touch(0, x, y, 20, 20)
	end
	return x, y
end

-- Main func
function LBSGhostDriving()
	print_global_vars()
	local x, y
	
	while (1) do
		while (1) do
			mSleep(500)
			-- 主页
			x, y = main_page() if x > -1 then break end
			-- 创建
			x, y = create_team() if x > -1 then break end
			-- 离开队伍
			x, y = leave_team() if x > -1 then break end
			-- 确认离开
			x, y = leave_confirm() if x > -1 then break end
			-- 取消邀请
			x, y = cancel_invite() if x > -1 then break end
			-- 退出资料
			x, y = member_room_user_profile() if x > -1 then break end
			-- 掉落弹出
			x, y = pop_up() if x > -1 then break end
			break
		end
	end
end