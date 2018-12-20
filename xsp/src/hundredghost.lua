require "util"
require "func"

-- Util func

-- Mainfunc
function hundredghost(round, num, invite)
	print(string.format("次数 %d 豆子 %s 邀请 %d", round, num, invite))
	print_global_vars()
	
	local x, y
	
	while (1) do
		while(1) do
			mSleep(500)
            -- 循环通用
            global_loop_func()
			break
		end
	end
end
