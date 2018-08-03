require "util"
require "func"

-- Util func

-- Main func
function tansuo(mode, sel, mark, hard, section, count_mode, win_round, sec_round, offer_arr)
	print(string.format("悬赏封印：%d (勾玉：%d 体力：%d 樱饼：%d 金币：%d 零食：%d)", offer_arr[1], offer_arr[2], offer_arr[3], offer_arr[4], offer_arr[5], offer_arr[6]))
	print(string.format("模式: %s, 选择: 物品-%d,金币-%d,经验-%d,Boss-%d, 标记: %s, 难度: %s, 章节: %d, 限定: %s, 胜利: %s, 通关: %s", mode, sel[1], sel[2], sel[3], sel[4], mark, hard, section, count_mode, win_round, sec_round))
	
end