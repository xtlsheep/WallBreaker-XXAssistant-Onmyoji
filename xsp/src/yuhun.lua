require "util"
require "func"

function lct_yuhun()
	x, y = findColor({57, 487, 60, 489}, -- 左边小路灯
		"0|0|0xffd821,0|-19|0xb24828,-1|-47|0xddd3bf,0|36|0x855021",
		95, 0, 0, 0)
	if x > -1 then
		showHUD_ios_ver(ios_ver,hud_scene,"探索 - 御魂",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function lct_8dashe()
	x, y = findColor({998, 616, 999, 617}, -- 右下鳞片
		"0|0|0xfbe9bc,0|-34|0x040402,-1|-52|0xa46d91,10|-22|0x391f10",
		95, 0, 0, 0)
	if x > -1 then
		showHUD_ios_ver(ios_ver,hud_scene,"御魂 - 八岐大蛇",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

function yuhun_mark(position, multi)
	mSleep(500)
	if (multi == 1) then
		cnt = math.random(4, 6)
	else
		cnt = math.random(2, 4)
	end
	
	for i = 1, cnt do
		ran_interv()
		if (position == "左") then
			ran_touch(0, 290, 150, 10, 10)
		elseif (position == "中") then
			ran_touch(0, 550, 150, 10, 10)
		elseif (position == "右") then
			ran_touch(0, 830, 150, 10, 10)
		end
	end
end

function find_real8dashe()
	x, y = findColor({27, 229, 34, 234}, -- 关闭箭头
		"0|0|0xcf893c,10|-11|0xcc883a,12|16|0xd49248,379|-16|0x847396",
		95, 0, 0, 0)
	if x > -1 then
		ran_touch(0, x, y, 5, 5)
	end
	return x, y
end

function lct_petfind()
	x, y = findColor({829, 207, 831, 209}, -- 右边银色 发 宝
		"0|0|0x7c7371,3|33|0xaea09b,-230|-55|0xf4e4b1,-370|-29|0xdbc788",
		95, 0, 0, 0)
	if x > -1 then
		showHUD_ios_ver(ios_ver,hud_scene,"御魂 - 发现宝藏",20,"0xff000000","0xffffffff",0,100,0,300,32)
	end
	return x, y
end

-- Main func
function yuhun(mode, role, group, mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate)
	print(string.format("八岐大蛇 - 模式：%s，角色：%s，组队：%s，一层标记：%s 二层标记：%s 三层标记：%s，层数：%d，战斗次数：%d", mode, role, group, mark[1], mark[2], mark[3], level, round))
	print(string.format("           悬赏封印：%d (勾玉：%d 体力：%d 樱饼：%d 金币：%d 零食：%d) 锁定出战：%d", offer_arr[1], offer_arr[2], offer_arr[3], offer_arr[4], offer_arr[5], offer_arr[6], lock))
	print(string.format("           队员自动组队：%d，失败重新组队：%d，队员接手队长：%d，队长自动组队：%d，队长自动邀请：%d, 失败重新建队：%d", member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate))
	
	if (mode == "单人") then
		yuhun_solo(mark, level, round, offer_arr, lock)
	elseif (mode == "组队" and role == "队员" and group == "野队") then
		yuhun_group_wild_member(mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain)
	elseif (mode == "组队" and role == "队长" and group == "野队") then
		yuhun_group_wild_captain(mark, level, round, offer_arr, lock, captain_auto_group, fail_and_recreate)
	elseif (mode == "组队" and role == "队员" and group == "固定队") then
		yuhun_group_fix_member(mark, level, round, offer_arr, lock, member_auto_group, member_to_captain)
	elseif (mode == "组队" and role == "队长" and group == "固定队") then
		yuhun_group_fix_captain(mark, level, round, offer_arr, lock, captain_auto_group, auto_invite_first)
	end
end

function yuhun_solo(mark, level, round, offer_arr, lock)
	rd_cnt = 0
	win_cnt = 0
	fail_cnt = 0
	x = -1
	y = -1
	init = 1
	disconn_fin = 1
	real_8dashe = 1
	secret_vender = 1
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 一回目
			x, y = round_one() if (x > -1) then yuhun_mark(mark[1], 0) break end
			-- 二回目
			x, y = round_two() if (x > -1) then yuhun_mark(mark[2], 0) break end
			-- 三回目
			x, y = round_three() if (x > -1) then yuhun_mark(mark[3], 1) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 真八岐大蛇
			x, y = find_real8dashe() if (x > -1) then break end
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
				keep_half_damo(offer_arr)
				break
			end
			-- 八岐大蛇
			x, y = lct_8dashe() if (x > -1) then level_select(level, init, lock, "御魂") init = 0 single_start() break end -- 单人开始
			-- 庭院
			x, y = find_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 180, 590, 20, 20) break end -- 御魂
			-- 御魂
			x, y = lct_yuhun() if (x > -1) then ran_touch(0, 355, 320, 50, 50) break end -- 八岐大蛇
			-- 战斗失败
			x, y = fight_failed("单人") if (x > -1) then
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed(offer_arr)
				break
			end
			-- 发现宝藏
			x, y = lct_petfind() if (x > -1) then break end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end

function yuhun_group_wild_member(mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain)
	rd_cnt = 0
	win_cnt = 0
	fail_cnt = 0
	time_cnt = 0
	x = -1
	y = -1
	init = 1
	wait_invite = 0
	auto_grouped = -1
	disconn_fin = 1
	real_8dashe = 1
	secret_vender = 1
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 一回目
			x, y = round_one() if (x > -1) then yuhun_mark(mark[1], 0) break end
			-- 二回目
			x, y = round_two() if (x > -1) then yuhun_mark(mark[2], 0) break end
			-- 三回目
			x, y = round_three() if (x > -1) then yuhun_mark(mark[3], 1) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 真八岐大蛇
			x, y = find_real8dashe() if (x > -1) then break end
			-- 拒绝邀请
			if (wait_invite == 0) then x, y = member_team_refuse_invite() if (x > -1) then break end end
			-- 探索
			x, y = lct_tansuo()
			if (x > -1) then
				if wait_invite == 0 then
					showHUD_ios_ver(ios_ver,hud_scene,"探索",20,"0xff000000","0xffffffff",0,100,0,300,32)
					ran_touch(0, 180, 590, 20, 20) -- 御魂
				else
					showHUD_ios_ver(ios_ver,hud_scene,"探索 - 等待组队邀请",20,"0xff000000","0xffffffff",0,100,0,300,32)
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
			x, y = fight_success(mode) if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				wait_invite = 1
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo(offer_arr)
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
			-- 八岐大蛇
			x, y = lct_8dashe() if (x > -1) then level_select(level, init, lock, "御魂") init = 0 ran_touch(0, 573, 440, 20, 10) break end -- 组队开始
			-- 庭院
			x, y = find_tansuo_from_tingyuan() if (x > -1) then break end
			-- 御魂
			x, y = lct_yuhun() if (x > -1) then ran_touch(0, 355, 320, 50, 50) break end -- 八岐大蛇
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
				keep_fight_failed(offer_arr)
				break
			end
			-- Error Handle
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end

function yuhun_group_wild_captain(mark, level, round, offer_arr, lock, captain_auto_group, fail_and_recreate)
	rd_cnt = 0
	win_cnt = 0
	fail_cnt = 0
	x = -1
	y = -1
	init = 1
	disconn_fin = 1
	real_8dashe = 1
	secret_vender = 1
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 一回目
			x, y = round_one() if (x > -1) then yuhun_mark(mark[1], 0) break end
			-- 二回目
			x, y = round_two() if (x > -1) then yuhun_mark(mark[2], 0) break end
			-- 三回目
			x, y = round_three() if (x > -1) then yuhun_mark(mark[3], 1) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 真八岐大蛇
			x, y = find_real8dashe() if (x > -1) then break end
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success(mode) if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo(offer_arr)
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
			x, y = captain_room_start_with_2_members() if (x > -1) then break end
			-- 庭院
			x, y = find_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 180, 590, 20, 20) break end -- 御魂
			-- 御魂
			x, y = lct_yuhun() if (x > -1) then ran_touch(0, 355, 320, 50, 50) break end -- 八岐大蛇
			-- 八岐大蛇
			x, y = lct_8dashe() if (x > -1) then level_select(level, init, lock, "御魂") init = 0 ran_touch(0, 573, 440, 20, 10) break end -- 组队开始
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed(offer_arr)
				break
			end
			-- 发现宝藏
			x, y = lct_petfind() if (x > -1) then break end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end

function yuhun_group_fix_member(mark, level, round, offer_arr, member_auto_group, member_to_captain)
	rd_cnt = 0
	win_cnt = 0
	fail_cnt = 0
	x = -1
	y = -1
	init = 1
	auto_grouped = -1
	disconn_fin = 1
	real_8dashe = 1
	secret_vender = 1
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 一回目
			x, y = round_one() if (x > -1) then yuhun_mark(mark[1], 0) break end
			-- 二回目
			x, y = round_two() if (x > -1) then yuhun_mark(mark[2], 0) break end
			-- 三回目
			x, y = round_three() if (x > -1) then yuhun_mark(mark[3], 1) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 真八岐大蛇
			x, y = find_real8dashe() if (x > -1) then break end
			-- 接受邀请
			x, y, auto_grouped = member_team_accept_invite(member_auto_group) if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success(mode) if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				wait_invite = 1
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo(offer_arr)
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
				keep_fight_failed(offer_arr)
				break
			end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end

function yuhun_group_fix_captain(mark, level, round, offer_arr, lock, captain_auto_group, auto_invite_first)
	rd_cnt = 0
	win_cnt = 0
	fail_cnt = 0
	time_cnt = 0
	x = -1
	y = -1
	init = 1
	invite = 1
	disconn_fin = 1
	real_8dashe = 1
	secret_vender = 1
	
	while (1) do
		if (round > 0) then
			if (rd_cnt >= round) then
				return
			end
		end
		
		while (1) do
			-- 一回目
			x, y = round_one() if (x > -1) then yuhun_mark(mark[1], 0) break end
			-- 二回目
			x, y = round_two() if (x > -1) then yuhun_mark(mark[2], 0) break end
			-- 三回目
			x, y = round_three() if (x > -1) then yuhun_mark(mark[3], 1) break end
			mSleep(500)
			-- 悬赏封印
			x, y = find_offer(offer_arr) if (x > -1) then break end
			-- 真八岐大蛇
			x, y = find_real8dashe() if (x > -1) then break end
			-- 拒绝邀请
			x, y = member_team_refuse_invite() if (x > -1) then break end
			-- 战斗进行
			x, y = fight_ongoing() if (x > -1) then break end
			-- 战斗准备
			x, y = fight_ready() if (x > -1) then break end
			-- 战斗胜利
			x, y = fight_success(mode) if (x > -1) then break end
			-- 胜利达摩
			x, y = whole_damo() if (x > -1) then break end
			-- 胜利宝箱
			x, y = half_damo() if (x > -1) then
				rd_cnt = rd_cnt + 1
				win_cnt = win_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_half_damo(offer_arr)
				break
			end
			-- 失败继续邀请
			x, y = captain_team_lost_invite() if (x > -1) then ran_touch(0, 673, 384, 20, 10) invite = 0 time_cnt = 0 break end -- 确定
			-- 自动邀请
			if (captain_auto_group == 1) then x, y = captain_team_set_auto_invite() if (x > -1) then break end end
			-- 邀请队友
			x, y = captain_team_win_invite() 
			if (x > -1) then ran_touch(0, 674, 385, 20, 10) invite = 0 time_cnt = 0 break end -- 确定
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
			x, y = find_tansuo_from_tingyuan() if (x > -1) then break end
			-- 探索
			x, y = lct_tansuo() if (x > -1) then ran_touch(0, 180, 590, 20, 20) break end -- 御魂
			-- 御魂
			x, y = lct_yuhun() if (x > -1) then ran_touch(0, 355, 320, 50, 50) break end -- 八岐大蛇
			-- 八岐大蛇
			x, y = lct_8dashe() if (x > -1) then level_select(level, init, lock, "御魂") init = 0 ran_touch(0, 573, 440, 20, 10) break end -- 组队开始
			-- 战斗失败
			x, y = fight_failed("组队") if (x > -1) then
				rd_cnt = rd_cnt + 1
				fail_cnt = fail_cnt + 1
				show_win_fail(win_cnt, fail_cnt)
				keep_fight_failed(offer_arr)
				break
			end
			-- 退出个人资料
			member_room_user_profile() if (x > -1) then break end
			-- 发现宝藏
			x, y = lct_petfind() if (x > -1) then break end
			-- Handle error
			handle_error(disconn_fin, real_8dashe, secret_vender) if (x > -1) then break end
			break
		end
	end
	return RET_OK
end