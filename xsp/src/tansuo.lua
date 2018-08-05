require "util"
require "func"

-- Util func

-- Main func
function tansuo(mode, sel, mark, hard, section, count_mode, win_round, sec_round, offer_arr)
	print(string.format("模式: %s, 选择: 物品-%d,金币-%d,经验-%d,Boss-%d, 标记: %s, 难度: %s, 章节: %d, 限定: %s, 胜利: %s, 通关: %s", 
						mode, sel[1], sel[2], sel[3], sel[4], mark, hard, section, count_mode, win_round, sec_round))
	print_offer_arr(offer_arr)
	
end