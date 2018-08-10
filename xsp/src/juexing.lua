require "util"
require "func"

-- Util func
function lct_juexingtower()
	local x, y = findColor({233, 162, 235, 165}, -- 4个麒麟头部
		"0|0|0xb17880,238|12|0x56b083,478|30|0x358fe5,718|40|0xd378d5",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"探索 - 觉醒之塔",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function lct_juexingelement()
	local x, y = findColor({226, 540, 228, 542}, -- 4个麒麟头部
		"0|0|0xb17684,187|10|0xbcedb5,385|2|0x3090e2,576|7|0xfcbbce",
		95, 0, 0, 0)
	if x > -1 then
		HUD_show_or_hide(HUD,hud_scene,"探索 - 觉醒材料",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function juexing_mark(mark)
	mSleep(500)
	local cnt = math.random(2, 3)
	local pos_x = {488, 560, 653, 823, 1016}
	local pos_y = {140, 170, 210, 230, 240}
	local pos
	if (mark == "小怪") then
		pos = math.random(1, 5)
	end
	
	for i = 1, cnt do
		ran_interv()
		if (mark == "大怪") then
			ran_touch(0, 722, 148, 10, 10)
		elseif (mark == "小怪") then
			ran_touch(0, pos_x[pos], pos_y[pos], 5, 5)
		end
	end
end

function juexing_element(element)
	if (element == "火") then
		ran_touch(0, 225, 300, 20, 20)
	elseif (element == "风") then
		ran_touch(0, 465, 300, 20, 20)
	elseif (element == "水") then
		ran_touch(0, 700, 300, 20, 20)
	elseif (element == "雷") then
		ran_touch(0, 950, 300, 20, 20)
	end
end

-- Main func
function juexing(mode, role, group, element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate)
	print(string.format("觉醒材料 - 模式：%s，角色：%s，组队：%s，类型：%s，标记：%s ，层数：%d，战斗次数：%d, 锁定出战：%d", 
						mode, role, group, element, mark, level, round, lock))
	print(string.format("队员自动组队：%d，失败重新组队：%d，队员接手队长：%d，队长自动组队：%d，队长自动邀请：%d, 失败重新建队：%d", 
						member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate))
	print_offer_arr()
	
	if (mode == "单人") then
		juexing_solo(element, mark, level, round, lock)
	elseif (mode == "组队" and role == "队员" and group == "野队") then
		juexing_group_wild_member(element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain)
	elseif (mode == "组队" and role == "队长" and group == "野队") then
		juexing_group_wild_captain(element, mark, level, round, lock, captain_auto_group, fail_and_recreate)
	elseif (mode == "组队" and role == "队员" and group == "固定队") then
		juexing_group_fix_member(element, mark, level, round, lock, member_auto_group, member_to_captain)
	elseif (mode == "组队" and role == "队长" and group == "固定队") then
		juexing_group_fix_captain(element, mark, level, round, lock, captain_auto_group, auto_invite_first)
	end
end

function juexing_solo(element, mark, level, round, lock)
	local rd_cnt = 0
	local init = 1
	local disconn_fin = 1
	local real_8dashe = 1
	local secret_vender = 1
	local x, y
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 超鬼王
			lct_sg_jiutun_window()
			-- 战
			x, y = round_fight() if (x > -1) then juexing_mark(mark) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 拒绝组队
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("单人") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo()
				break
			end
			-- 觉醒材料
			x, y = lct_juexingelement() if (x > -1) then level_select(level, init, lock, "觉醒") init = 0 solo_start() break end -- 单人开始
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 90, 590, 20, 20) break end -- 觉醒
			-- 觉醒之塔
			x, y = lct_juexingtower() if (x > -1) then juexing_element(element) break end
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("单人")
				break
			end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end

function juexing_group_wild_member(element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain)
	local rd_cnt = 0
	local time_cnt = 0
	local init = 1
	local wait_invite = 0
	local auto_grouped = -1
	local ret = -1
	local disconn_fin = 1
	local real_8dashe = 1
	local secret_vender = 1
	local x, y
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 超鬼王
			ret = lct_sg_jiutun_window() if ret == RET_OK then wait_invite = 0 end
			-- 战
			x, y = round_fight() if (x > -1) then juexing_mark(mark) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 拒绝邀请
			if (wait_invite == 0) then x, y = member_team_refuse_invite() if (x > -1) then break end end
			-- 探索
			x, y = lct_tansuo()
			if (x > -1) then
				-- 超鬼王
				ret = lct_sg_jiutun_window() if ret == RET_OK then wait_invite = 0 end
				if wait_invite == 0 then
					HUD_show_or_hide(HUD,hud_scene,"探索",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 90, 590, 20, 20) -- 觉醒
				else
					HUD_show_or_hide(HUD,hud_scene,"探索 - 等待组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
					x, y, auto_grouped = member_team_accept_invite(member_auto_group)
					if x > -1 then
						wait_invite = 0
						time_cnt = 0
					else
						time_cnt = time_cnt + 1
						if time_cnt > math.random(18, 22) then
							wait_invite = 0
							time_cnt = 0
						end
					end
				end
				break
			end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				wait_invite = 1
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo()
				break
			end
			-- 组队寻找
			x, y = member_room_init() if (x > -1) then member_room_find() break end
			-- 队员接手队长
			if (member_to_captain == 1) then
				x, y = member_room_find_start() if (x > -1) then ran_touch(0, 925, 535, 20, 10) break end -- 开始战斗
			else
				x, y = member_room_find_start() if (x > -1) then ran_touch(0, 205, 535, 20, 10) break end -- 离开队伍
			end
			-- 离开确认
			x, y = member_room_quit() if (x > -1) then wait_invite = 0 break end
			-- 觉醒材料
			x, y = lct_juexingelement() if (x > -1) then level_select(level, init, lock, "觉醒") init = 0 ran_touch(0, 573, 440, 20, 10) break end -- 组队开始
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 觉醒之塔
			x, y = lct_juexingtower() if (x > -1) then juexing_element(element) break end
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				if (fail_and_group == 1) then
					wait_invite = 0
				else
					wait_invite = 1
				end
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("组队")
				break
			end
			-- Error Handle
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end

function juexing_group_wild_captain(element, mark, level, round, lock, captain_auto_group, fail_and_recreate)
	local rd_cnt = 0
	local init = 1
	local disconn_fin = 1
	local real_8dashe = 1
	local secret_vender = 1
	local x, y
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 战
			x, y = round_fight() if (x > -1) then juexing_mark(mark) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo()
				break
			end
			-- 失败继续邀请
			x, y = captain_team_lost_invite()
			if (x > -1) then
				if (fail_and_recreate == 1) then
					ran_touch(0, 462, 383, 20, 10) -- 取消
				else
					ran_touch(0, 673, 384, 20, 10) -- 确定
				end
				break
			end
			-- 自动邀请
			if (captain_auto_group == 1) then x, y = captain_team_set_auto_invite() if (x > -1) then break end end
			-- 邀请队友
			x, y = captain_team_win_invite() if (x > -1) then ran_touch(0, 674, 385, 20, 10) break end -- 确定
			-- 创建初始化
			x, y = captain_room_init() if (x > -1) then break end -- 创建队伍
			-- 创建公共队伍
			x, y = captain_room_create_public() if (x > -1) then break end
			-- 开始战斗
			x, y = captain_room_start_with_1_members() if (x > -1) then break end
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 90, 590, 20, 20) break end -- 觉醒
			-- 觉醒之塔
			x, y = lct_juexingtower() if (x > -1) then juexing_element(element) break end
			-- 觉醒材料
			x, y = lct_juexingelement() if (x > -1) then level_select(level, init, lock, "觉醒") init = 0 ran_touch(0, 573, 440, 20, 10) break end -- 组队开始
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("组队")
				break
			end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end

function juexing_group_fix_member(element, mark, level, round, member_auto_group, member_to_captain)
	local rd_cnt = 0
	local init = 1
	local auto_grouped = -1
	local disconn_fin = 1
	local real_8dashe = 1
	local secret_vender = 1
	local x, y
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 超鬼王
			lct_sg_jiutun_window()
			-- 战
			x, y = round_fight() if (x > -1) then juexing_mark(mark) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 接受邀请
			x, y, auto_grouped = member_team_accept_invite(member_auto_group) if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				wait_invite = 1
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo()
				break
			end
			if (member_to_captain == 1) then
				x, y = member_room_find_start() if (x > -1) then ran_touch(0, 925, 535, 20, 10) break end -- 开始战斗
			else
				x, y = member_room_find_start() if (x > -1) then ran_touch(0, 205, 535, 20, 10) break end -- 离开队伍
			end
			-- 离开队伍
			x, y = member_room_find_start() if (x > -1) then ran_touch(0, 205, 535, 20, 10) break end -- 离开队伍
			-- 离开确认
			x, y = member_room_quit() if (x > -1) then break end
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("组队")
				break
			end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end

function juexing_group_fix_captain(element, mark, level, round, lock, captain_auto_group, auto_invite_first)
	local rd_cnt = 0
	local time_cnt = 0
	local init = 1
	local invite = 1
	local disconn_fin = 1
	local real_8dashe = 1
	local secret_vender = 1
	local x, y
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 战
			x, y = round_fight() if (x > -1) then juexing_mark(mark) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer() if (x > -1) then break end
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success("组队") if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo()
				break
			end
			-- 失败继续邀请
			x, y = captain_team_lost_invite() if (x > -1) then ran_touch(0, 673, 384, 20, 10) invite = 0 time_cnt = 0 break end -- 确定
			-- 自动邀请
			if (captain_auto_group == 1) then x, y = captain_team_set_auto_invite() if (x > -1) then break end end
			-- 邀请队友
			x, y = captain_team_win_invite() if (x > -1) then ran_touch(0, 674, 385, 20, 10) invite = 0 time_cnt = 0 break end -- 确定
			-- 创建初始化
			x, y = captain_room_init()
			-- 创建私人队伍
			x, y = captain_room_create_private()
			-- 邀请初始化
			x, y = captain_room_invite_init()
			if (x > -1) then
				time_cnt = time_cnt + 1
				mSleep(500)
				if (time_cnt > math.random(8, 12)) then
					invite = 1
				end
				if (auto_invite_first == 1 and invite == 1) then
					ran_touch(0, 565, 320, 50, 50) -- 邀请初始化
					x, y = captain_room_invite_init() if (x > -1) then break end
				end
				break
			end
			-- 邀请第一个好友
			if (auto_invite_first == 1 and invite == 1) then
				x, y = captain_room_invite_first() if (x > -1) then invite = 0 time_cnt = 0 break end
			end
			-- 开始战斗
			x, y = captain_room_start_with_1_members() if (x > -1) then invite = 0 time_cnt = 0 break end
			-- 庭院
			x, y = enter_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 90, 590, 20, 20) break end -- 觉醒
			-- 觉醒之塔
			x, y = lct_juexingtower() if (x > -1) then juexing_element(element) break end
			-- 觉醒材料
			x, y = lct_juexingelement() if (x > -1) then level_select(level, init, lock, "觉醒") init = 0 ran_touch(0, 573, 440, 20, 10) break end -- 组队开始
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed("组队")
				break
			end
			-- 退出个人资料
			member_room_user_profile() if (x > -1) then break end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end
