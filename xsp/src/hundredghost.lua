require "util"
require "func"

-- Util func

-- Mainfunc
function hundredghost(round, num, invite)
	print(string.format("次数 %d 豆子 %s 邀请 %d", round, num, invite))
	print_offer_arr()
	
	local disconn_fin = 1
	local real_8dashe = 0
	local secret_vender = 0
	local x, y
	
	while (1) do
		while(1) do
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if x > -1 then break end
			-- Error Handle
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
end
