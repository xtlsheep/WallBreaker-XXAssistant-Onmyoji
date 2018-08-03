require "util"
require "yuhun"
require "juexing"
require "jjtp"
require "yeyuanhuo"
require "yuling"
require "normalcall"
require "tansuo"

-- Def
local dev_width = 640 -- iPhone 5s: 640 x 1136

-- Util func
function fit_UI(ui, width_in)
	local content
	local value
	local json=require "JSON"
	sf=width/width_in -- 当前分辨率/开发分辨率
	local function split(szFullString, szSeparator) -- split rect
		local nFindStartIndex = 1
		local nSplitIndex = 1
		local nSplitArray = {}
		while true do
			local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
			if not nFindLastIndex then
				nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
				break
			end
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
			nFindStartIndex = nFindLastIndex + string.len(szSeparator)
			nSplitIndex = nSplitIndex + 1
		end
		return nSplitArray
	end
	local function bltb(t) --遍历table修改
		for k,v in pairs(t) do
			if type(v)=='table' then
				bltb(v) --递归调用到所有子table
			else
				if k=='size' then --字体按比例缩放
					t[k]=math.ceil(v*sf)
				elseif k=='rect' then --位置和大小按比例缩放
					local arr={}
					arr=split(v,',')
					arr[1]=math.ceil(arr[1]*sf)
					arr[2]=math.ceil(arr[2]*sf)
					arr[3]=math.ceil(arr[3]*sf)
					arr[4]=math.ceil(arr[4]*sf)
					t[k]=arr[1]..','..arr[2]..','..arr[3]..','..arr[4]
				elseif k=='width' then
					t[k]=math.ceil(v*sf)
				elseif k=='height' then
					t[k]=math.ceil(v*sf)
				end
			end
		end
	end
	content=getUIContent(ui)
	value=json:decode(content)
	bltb(value)
	return json:encode(value)
end

-- Main func
function portal()
	local ui = fit_UI("portal.json", dev_width)
	ret_portal, res_portal = showUI(ui)
	
	if (ret_portal == 0) then
		return RET_ERR
	end
	
	if (res_portal.HUD == "0") then
		return "show"
	elseif (res_portal.HUD == "1") then
		return "hide"
	end
	return RET_OK
end

function mainmenu_UI()
	local ui = fit_UI("mainmenu.json", dev_width)
	ret_mainmenu, res_mainmenu = showUI(ui)
	if (ret_mainmenu == 0) then
		return RET_ERR
	end

	if (res_mainmenu.select == "0") then
		fast_UI()
	elseif (res_mainmenu.select == "1") then
		config_UI()
	elseif (res_mainmenu.select == "2") then
		log_UI()
	elseif (res_mainmenu.select == "3") then
		spec_UI()
	end
end

function fast_UI()
	local ui = fit_UI("fast.json", dev_width)
	ret_fast, res_fast = showUI(ui)
	if (ret_fast == 0) then
		mainmenu_UI()
		return
	end
	local fast_sel = res_fast.select
	if (fast_sel == "0") then
		fast_yuhun_UI()
	elseif (fast_sel == "1") then
		fast_tansuo_UI()
	elseif (fast_sel == "2") then
		fast_jjtp_UI()
	elseif (fast_sel == "3") then
		fast_juexing_UI()
	end
end

function config_UI()
	local ui = fit_UI("config.json", dev_width)
	ret_config, res_config = showUI(ui)
	if (ret_config == 0) then
		mainmenu_UI()
		return
	end
	
	-- 八岐大蛇
	if (res_config.select == "0") 	   then baqidashe_UI()
	-- 探索
	elseif (res_config.select == "3")  then	tansuo_UI()
	-- 结界突破
	elseif (res_config.select == "6")  then jjtp_UI()
	-- 觉醒
	elseif (res_config.select == "9")  then juexing_UI()
	-- 妖气
	elseif (res_config.select == "12") then yqfy_UI()
	-- 一键每日
	elseif (res_config.select == "1")  then multimission_UI()
	-- 业原火
	elseif (res_config.select == "4")  then yeyuanhuo_UI()
	-- 御灵
	elseif (res_config.select == "7")  then yuling_UI()
	-- 百鬼
	elseif (res_config.select == "10") then hundredghost_UI()
	-- 副本组合
	elseif (res_config.select == "13") then audition_UI()
	-- 世界喊话
	elseif (res_config.select == "2")  then worldchannel_UI()
	-- 普通召唤
	elseif (res_config.select == "5")  then normalcall_UI()
	-- 斗技荣耀
	elseif (res_config.select == "8")  then arena_UI()
	-- 悬赏查询
	elseif (res_config.select == "11") then offerquery_UI()
	-- 劲舞团
	elseif (res_config.select == "14") then superghost_UI()
	end
end

function log_UI()
	local ui = fit_UI("log.json", dev_width)
	ret_log, res_log = showUI(ui)
	if (ret_log == 0) then
		mainmenu_UI()
		return
	end
end

function spec_UI()
	local ui = fit_UI("spec.json", dev_width)
	ret_spec, res_spec = showUI(ui)
	if (ret_spec == 0) then
		mainmenu_UI()
		return
	end
end

function global_UI()
	local ui = fit_UI("global.json", dev_width)
	ret_global, res_global = showUI(ui)
	
	if (ret_global == 0) then
		return RET_ERR, offer_arr
	end
	
	local offer_arr = {0, 0, 0, 0, 0, 0}
	local offer_sel = {}
	
	if res_global.offer_en == "0" then
		offer_arr[0] = 1
		for w in string.gmatch(res_global.offer_sel,"([^'@']+)") do
			table.insert(offer_sel,w)
		end
		for i = 1, table.getn(offer_sel), 1 do
			if (offer_sel[i] == "0") then
				offer_arr[2] = 1 -- 勾玉
			elseif (offer_sel[i] == "1") then
				offer_arr[3] = 1 -- 体力
			elseif (offer_sel[i] == "2") then
				offer_arr[4] = 1 -- 樱饼
			elseif (offer_sel[i] == "3") then
				offer_arr[5] = 1 -- 金币
			elseif (offer_sel[i] == "3") then
				offer_arr[5] = 1 -- 零食
			end
		end
	end
	
	return RET_OK, offer_arr
end

-- Fast
function fast_yuhun_UI()
	local ui = fit_UI("fast_yuhun.json", dev_width)
	ret_fast_yh, res_fast_yh = showUI(ui)
	if (ret_fast_yh == 0) then
		fast_UI()
		return
	end
	local mode, role, group
	
	if (res_fast_yh.mode == "0") then
		mode = "单人"
		role = "无"
		group = "无"
	elseif (res_fast_yh.mode == "1") then
		mode = "组队"
		role = "队长"
		group = "野队"
	elseif (res_fast_yh.mode == "2") then
		mode = "组队"
		role = "队长"
		group = "固定队"
	elseif (res_fast_yh.mode == "3") then
		mode = "组队"
		role = "队员"
		group = "野队"
	elseif (res_fast_yh.mode == "4") then
		mode = "组队"
		role = "队员"
		group = "固定队"
	end
	
	local mark = {}
	mark[1] = res_fast_yh.round1
	mark[2] = res_fast_yh.round2
	mark[3] = res_fast_yh.round3
	
	for i = 1, 3  do
		if (mark[i] == "0") then
			mark[i] = "左"
		elseif (mark[i] == "1") then
			mark[i] = "中"
		elseif (mark[i] == "2") then
			mark[i] = "右"
		elseif (mark[i] == "3") then
			mark[i] = "无"
		end
	end
	
	local level = 10
	local round = 0
	local offer_en = 0
	local gouyu = 0
	local tili = 0
	local jinbi = 0
	local lingshi = 0
	local lock = 1
	local member_auto_group = 1
	local fail_and_group = 1
	local member_to_captain = 0
	local captain_auto_group = 1
	local auto_invite_first = 0
	local fail_and_recreate = 1
	local offer_arr = {0, 0, 0, 0, 0, 0}
	yuhun(mode, role, group, mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate)
end

function fast_tansuo_UI()
	local ui = fit_UI("fast_tansuo.json", dev_width)
	ret_fast_ts, res_fast_ts = showUI(ui)
	if (ret_fast_ts == 0) then
		fast_UI()
		return
	end
	
	offer_arr = {0, 0, 0, 0, 0, 0}
end

function fast_jjtp_UI()
	local ui = fit_UI("fast_jjtp.json", dev_width)
	ret_fast_jjtp, res_fast_jjtp = showUI(ui)
	if (ret_fast_jjtp == 0) then
		fast_UI()
		return
	end
	
	local mode
	if (res_fast_jjtp.mode == "0") then
		mode = "个人"
	elseif (res_fast_jjtp.mode == "1") then
		mode = "阴阳寮"
	elseif (res_fast_jjtp.mode == "2") then
		mode = "个人+阴阳寮"
	end
	
	local whr_out = {0, 0, 0, 0}
	local whr = {}
	for w in string.gmatch(res_fast_jjtp.whr,"([^'@']+)") do
		table.insert(whr,w)
	end
	for i = 1, table.getn(whr), 1 do
		if (whr[i] == "0") then
			whr_out[1] = 1 -- 彼岸花
		elseif (whr[i] == "1") then
			whr_out[2] = 1 -- 小僧
		elseif (whr[i] == "2") then
			whr_out[3] = 1 -- 日和坊
		elseif (whr[i] == "3") then
			whr_out[4] = 1 -- 御馔津
		end
	end
	
	local round_time = 5
	local lock = 1
	local refresh = 3
	local solo_sel = "5_to_0"
	local pub_sel = 5
	local offer_arr = {0, 0, 0, 0, 0, 0}
	jjtp(mode, whr_out, whr_out, round_time, refresh, solo_sel, pub_sel, lock, offer_arr)
end

function fast_juexing_UI()
	local ui = fit_UI("fast_juexing.json", dev_width)
	ret_fast_jx, res_fast_jx = showUI(ui)
	if (ret_fast_jx == 0) then
		fast_UI()
		return
	end
	
	local element
	if (res_fast_jx.element == "0") then
		element = "火"
	elseif (res_fast_jx.element == "1") then
		element = "风"
	elseif (res_fast_jx.element == "2") then
		element = "水"
	elseif (res_fast_jx.element == "3") then
		element = "雷"
	end
	
	local mode, role, group
	if (res_fast_jx.mode == "0") then
		mode = "单人"
		role = "无"
		group = "无"
	elseif (res_fast_jx.mode == "1") then
		mode = "组队"
		role = "队长"
		group = "野队"
	elseif (res_fast_jx.mode == "2") then
		mode = "组队"
		role = "队长"
		group = "固定队"
	elseif (res_fast_jx.mode == "3") then
		mode = "组队"
		role = "队员"
		group = "野队"
	elseif (res_fast_jx.mode == "4") then
		mode = "组队"
		role = "队员"
		group = "固定队"
	end
	
	local mark
	if (res_fast_jx.mark == "0") then
		mark = "小怪"
	elseif (res_fast_jx.mark == "1") then
		mark = "大怪"
	elseif (res_fast_jx.mark == "2") then
		mark = "无"
	end
	
	local level = 10
	local round = 0
	local lock = 1
	local member_auto_group = 1
	local fail_and_group = 1
	local member_to_captain = 0
	local captain_auto_group = 1
	local auto_invite_first = 0
	local fail_and_recreate = 1
	local offer_arr = {0, 0, 0, 0, 0, 0}
	juexing(mode, role, group, element, mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate)
end

-- Config
function baqidashe_UI()
	local ui = fit_UI("baqidashe.json", dev_width)
	ret_baqi, res_baqi = showUI(ui)
	if (ret_baqi == 0) then
		config_UI()
		return
	end
	
	local mode, role, group
	if (res_baqi.mode == "0") then
		mode = "单人"
		role = "无"
		group = "无"
	elseif (res_baqi.mode == "1") then
		mode = "组队"
		role = "队长"
		group = "野队"
	elseif (res_baqi.mode == "2") then
		mode = "组队"
		role = "队长"
		group = "固定队"
	elseif (res_baqi.mode == "3") then
		mode = "组队"
		role = "队员"
		group = "野队"
	elseif (res_baqi.mode == "4") then
		mode = "组队"
		role = "队员"
		group = "固定队"
	end
	
	local mark = {}
	mark[1] = res_baqi.round1
	mark[2] = res_baqi.round2
	mark[3] = res_baqi.round3
	for i = 1, 3  do
		if (mark[i] == "0") then
			mark[i] = "左"
		elseif (mark[i] == "1") then
			mark[i] = "中"
		elseif (mark[i] == "2") then
			mark[i] = "右"
		elseif (mark[i] == "3") then
			mark[i] = "无"
		end
	end
	
	local level = tonumber(res_baqi.level_select) + 1
	
	local round
	if (res_baqi.round_times == "0") then
		round = 10
	elseif (res_baqi.round_times == "1") then
		round = 20
	elseif (res_baqi.round_times == "2") then
		round = 30
	elseif (res_baqi.round_times == "3") then
		round = 50
	elseif (res_baqi.round_times == "4") then
		round = 100
	elseif (res_baqi.round_times == "5") then
		round = 0
	end
	
	local lock
	if (res_baqi.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	local member_auto_group
	if (res_baqi.member_auto_group == "0") then
		member_auto_group = 1
	else
		member_auto_group = 0
	end
	
	local fail_and_group
	if (res_baqi.fail_and_group == "0") then
		fail_and_group = 1
	else
		fail_and_group = 0
	end
	
	local member_to_captain
	if (res_baqi.member_to_captain == "0") then
		member_to_captain = 0
	else
		member_to_captain = 1
	end
	
	local captain_auto_group
	if (res_baqi.captain_auto_group == "0") then
		captain_auto_group = 1
	else
		captain_auto_group = 0
	end
	
	local auto_invite_first
	if (res_baqi.auto_invite_first == "0") then
		auto_invite_first = 1
	else
		auto_invite_first = 0
	end
	
	local fail_and_recreate
	if (res_baqi.fail_and_recreate == "0") then
		fail_and_recreate = 1
	else
		fail_and_recreate = 0
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	yuhun(mode, role, group, mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate)
end

function tansuo_UI()
local ui = fit_UI("tansuo.json", dev_width)
	ret_tansuo, res_tansuo = showUI(ui)
	if (ret_tansuo == 0) then
		config_UI()
		return
	end

	local mode, mark, hard, section, count_mode, win_round, sec_round
	if res_tansuo.mode == "0" then
		mode = "单人"
	elseif res_tansuo.mode == "1" then
		mode = "队长"
	elseif res_tansuo.mode == "2" then
		mode = "队员"
	end
	
	local sel_tmp = {}
	local sel = {0, 0, 0, 0}
	for w in string.gmatch(res_tansuo.select,"([^'@']+)") do
		table.insert(sel_tmp,w)
	end
	for i = 1, table.getn(sel_tmp), 1 do
		if (sel_tmp[i] == "0") then
			sel[1] = 1
		elseif (sel_tmp[i] == "1") then
			sel[2] = 1
		elseif (sel_tmp[i] == "2") then
			sel[3] = 1
		elseif (sel_tmp[i] == "3") then
			sel[4] = 1
		end
	end
	
	if res_tansuo.mark == "0" then
		mark = "小怪"
	elseif res_tansuo.mark == "1" then
		mark = "大怪"
	elseif res_tansuo.mark == "2" then
		mark = "无"
	end
	
	if res_tansuo.hard == "0" then
		hard = "普通"
	elseif res_tansuo.hard == "1" then
		hard = "困难"
	end
	
	section = tonumber(res_tansuo.section) + 1
	
	if res_tansuo.count_mode == "0" then
		count_mode = "战斗"
	elseif res_tansuo.count_mode == "1" then
		coutn_mode = "章节"
	end
	
	if res_tansuo.win_round == "0" then
		win_round = 10
	elseif res_tansuo.win_round == "1" then
		win_round = 20
	elseif res_tansuo.win_round == "2" then
		win_round = 30
	elseif res_tansuo.win_round == "3" then
		win_round = 50
	elseif res_tansuo.win_round == "4" then
		win_round = 100
	elseif res_tansuo.win_round == "5" then
		win_round = 99999
	end

	if res_tansuo.sec_round == "0" then
		sec_round = 1
	elseif res_tansuo.sec_round == "1" then
		sec_round = 2
	elseif res_tansuo.sec_round == "2" then
		sec_round = 3
	elseif res_tansuo.sec_round == "3" then
		sec_round = 5
	elseif res_tansuo.sec_round == "4" then
		sec_round = 10
	elseif res_tansuo.sec_round == "5" then
		sec_round = 50
	elseif res_tansuo.sec_round == "6" then
		sec_round = 99999
	end

	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	tansuo(mode, sel, mark, hard, section, count_mode, win_round, sec_round, offer_arr)
end

function jjtp_UI()
	local ui = fit_UI("jjtp.json", dev_width)
	ret_jjtp, res_jjtp = showUI(ui)
	if (ret_jjtp == 0) then
		config_UI()
		return
	end
	
	local mode
	if (res_jjtp.mode == "0") then
		mode = "个人"
	elseif (res_jjtp.mode == "1") then
		mode = "阴阳寮"
	elseif (res_jjtp.mode == "2") then
		mode = "个人+阴阳寮"
	end
	
	local whr_solo_out = {0, 0, 0, 0}
	local whr_solo = {}
	for w in string.gmatch(res_jjtp.whr_solo,"([^'@']+)") do
		table.insert(whr_solo,w)
	end
	for i = 1, table.getn(whr_solo), 1 do
		if (whr_solo[i] == "0") then
			whr_solo_out[1] = 1 -- 彼岸花
		elseif (whr_solo[i] == "1") then
			whr_solo_out[2] = 1 -- 小僧
		elseif (whr_solo[i] == "2") then
			whr_solo_out[3] = 1 -- 日和坊
		elseif (whr_solo[i] == "3") then
			whr_solo_out[4] = 1 -- 御馔津
		end
	end
	
	local whr_pub_out = {0, 0, 0, 0}
	local whr_pub = {}
	for w in string.gmatch(res_jjtp.whr_pub,"([^'@']+)") do
		table.insert(whr_pub,w)
	end
	for i = 1, table.getn(whr_pub), 1 do
		if (whr_pub[i] == "0") then
			whr_pub_out[1] = 1 -- 彼岸花
		elseif (whr_pub[i] == "1") then
			whr_pub_out[2] = 1 -- 小僧
		elseif (whr_pub[i] == "2") then
			whr_pub_out[3] = 1 -- 日和坊
		elseif (whr_pub[i] == "3") then
			whr_pub_out[4] = 1 -- 御馔津
		end
	end
	
	local round_time
	if (res_jjtp.round_time == "0") then
		round_time = 3
	elseif (res_jjtp.round_time == "1") then
		round_time = 5
	elseif (res_jjtp.round_time == "2") then
		round_time = 10
	elseif (res_jjtp.round_time == "3") then
		round_time = 0
	end
	
	local lock
	if (res_jjtp.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	local refresh
	if (res_jjtp.refresh == "0") then
		refresh = 3
	elseif (res_jjtp.refresh == "1") then
		refresh = 6
	elseif (res_jjtp.refresh == "2") then
		refresh = 9
	end
	
	local solo_sel, pub_sel
	if (res_jjtp.solo_sel == "0") then
		solo_sel = "0_to_5"
	elseif (res_jjtp.solo_sel == "1") then
		solo_sel = "3_to_5"
	elseif (res_jjtp.solo_sel == "2") then
		solo_sel = "5_to_0"
	elseif (res_jjtp.solo_sel == "3") then
		solo_sel = "3_to_0"
	elseif (res_jjtp.solo_sel == "4") then
		solo_sel = "random"
	end
	
	if (res_jjtp.pub_sel == "0") then
		pub_sel = 5
	elseif (res_jjtp.pub_sel == "1") then
		pub_sel = 4
	elseif (res_jjtp.pub_sel == "2") then
		pub_sel = 3
	elseif (res_jjtp.pub_sel == "3") then
		pub_sel = 2
	elseif (res_jjtp.pub_sel == "4") then
		pub_sel = 1
	elseif (res_jjtp.pub_sel == "5") then
		pub_sel = 0
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	jjtp(mode, whr_solo_out, whr_pub_out, round_time, refresh, solo_sel, pub_sel, lock, offer_arr)
end

function juexing_UI()
	local ui = fit_UI("juexing.json", dev_width)
	ret_juexing, res_juexing = showUI(ui)
	if (ret_juexing == 0) then
		config_UI()
		return
	end
	
	local element
	if (res_juexing.element == "0") then
		element = "火"
	elseif (res_juexing.element == "1") then
		element = "风"
	elseif (res_juexing.element == "2") then
		element = "水"
	elseif (res_juexing.element == "3") then
		element = "雷"
	end
	
	local mode, role, group
	if (res_juexing.mode == "0") then
		mode = "单人"
		role = "无"
		group = "无"
	elseif (res_juexing.mode == "1") then
		mode = "组队"
		role = "队长"
		group = "野队"
	elseif (res_juexing.mode == "2") then
		mode = "组队"
		role = "队长"
		group = "固定队"
	elseif (res_juexing.mode == "3") then
		mode = "组队"
		role = "队员"
		group = "野队"
	elseif (res_juexing.mode == "4") then
		mode = "组队"
		role = "队员"
		group = "固定队"
	end
	
	local mark
	if (res_juexing.mark == "0") then
		mark = "小怪"
	elseif (res_juexing.mark == "1") then
		mark = "大怪"
	elseif (res_juexing.mark == "2") then
		mark = "无"
	end
	
	local level = tonumber(res_juexing.level_select) + 1
	
	local round
	if (res_juexing.round_times == "0") then
		round = 10
	elseif (res_juexing.round_times == "1") then
		round = 20
	elseif (res_juexing.round_times == "2") then
		round = 30
	elseif (res_juexing.round_times == "3") then
		round = 50
	elseif (res_juexing.round_times == "4") then
		round = 100
	elseif (res_juexing.round_times == "5") then
		round = 0
	end
	
	local lock
	if (res_juexing.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	local member_auto_group
	if (res_juexing.member_auto_group == "0") then
		member_auto_group = 1
	else
		member_auto_group = 0
	end
	
	local fail_and_group
	if (res_juexing.fail_and_group == "0") then
		fail_and_group = 1
	else
		fail_and_group = 0
	end
	
	local member_to_captain
	if (res_juexing.member_to_captain == "0") then
		member_to_captain = 0
	else
		member_to_captain = 1
	end
	
	local captain_auto_group
	if (res_juexing.captain_auto_group == "0") then
		captain_auto_group = 1
	else
		captain_auto_group = 0
	end
	
	local auto_invite_first
	if (res_juexing.auto_invite_first == "0") then
		auto_invite_first = 1
	else
		auto_invite_first = 0
	end
	
	local fail_and_recreate
	if (res_juexing.fail_and_recreate == "0") then
		fail_and_recreate = 1
	else
		fail_and_recreate = 0
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	juexing(mode, role, group, element, mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate)
end

function yqfy_UI()
	local ui = fit_UI("yqfy.json", dev_width)
	ret_yqfy, res_yqfy = showUI(ui)
	if (ret_yqfy == 0) then
		config_UI()
		return
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function multimission_UI()
	local ui = fit_UI("multimission.json", dev_width)
	ret_multimission, res_multimission = showUI(ui)
	if (ret_multimission == 0) then
		config_UI()
		return
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function yeyuanhuo_UI()
	local ui = fit_UI("yeyuanhuo.json", dev_width)
	ret_yeyuanhuo, res_yeyuanhuo = showUI(ui)
	if (ret_yeyuanhuo == 0) then
		config_UI()
		return
	end
	
	local round_tan = 0
	local round_chen = 0
	local round_chi = 0
	
	if (res_yeyuanhuo.round_tan == "0") then
		round_tan = 0
	elseif (res_yeyuanhuo.round_tan == "1") then
		round_tan = 10
	elseif (res_yeyuanhuo.round_tan == "2") then
		round_tan = 20
	elseif (res_yeyuanhuo.round_tan == "3") then
		round_tan = 30
	elseif (res_yeyuanhuo.round_tan == "4") then
		round_tan = 50
	elseif (res_yeyuanhuo.round_tan == "5") then
		round_tan = 100
	elseif (res_yeyuanhuo.round_tan == "6") then
		round_tan = 99999
	end
	
	if (res_yeyuanhuo.round_chen == "0") then
		round_chen = 0
	elseif (res_yeyuanhuo.round_chen == "1") then
		round_chen = 10
	elseif (res_yeyuanhuo.round_chen == "2") then
		round_chen = 20
	elseif (res_yeyuanhuo.round_chen == "3") then
		round_chen = 30
	elseif (res_yeyuanhuo.round_chen == "4") then
		round_chen = 50
	elseif (res_yeyuanhuo.round_chen == "5") then
		round_chen = 100
	elseif (res_yeyuanhuo.round_chen == "6") then
		round_chen = 99999
	end
	
	if (res_yeyuanhuo.round_chi == "0") then
		round_chi = 0
	elseif (res_yeyuanhuo.round_chi == "1") then
		round_chi = 10
	elseif (res_yeyuanhuo.round_chi == "2") then
		round_chi = 20
	elseif (res_yeyuanhuo.round_chi == "3") then
		round_chi = 30
	elseif (res_yeyuanhuo.round_chi == "4") then
		round_chi = 50
	elseif (res_yeyuanhuo.round_chi == "5") then
		round_chi = 100
	elseif (res_yeyuanhuo.round_chi == "6") then
		round_chi = 99999
	end
	
	local lock
	if (res_yeyuanhuo.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	yeyuanhuo(round_tan, round_chen, round_chi, lock, offer_arr)
end

function yuling_UI()
	local ui = fit_UI("yuling.json", dev_width)
	ret_yuling, res_yuling = showUI(ui)
	if (ret_yuling == 0) then
		config_UI()
		return
	end
	
	local sel = -1
	local level = -1
	local round = -1
	local lock = -1
	
	if (res_yuling.select == "0") then
		sel = "神龙"
	elseif (res_yuling.select == "1") then
		sel = "白藏主"
	elseif (res_yuling.select == "2") then
		sel = "黑豹"
	elseif (res_yuling.select == "3") then
		sel = "孔雀"
	end
	
	if (res_yuling.level == "0") then
		level = 1
	elseif (res_yuling.level == "1") then
		level = 2
	elseif (res_yuling.level == "2") then
		level = 3
	end
	
	if (res_yuling.round == "0") then
		round = 0
	elseif (res_yuling.round == "1") then
		round = 10
	elseif (res_yuling.round == "2") then
		round = 20
	elseif (res_yuling.round == "3") then
		round = 30
	elseif (res_yuling.round == "4") then
		round = 50
	elseif (res_yuling.round == "5") then
		round = 100
	elseif (res_yuling.round == "6") then
		round = 99999
	end
	
	if (res_yuling.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end

	yuling(sel, level, round, lock, offer_arr)
end

function hundredghost_UI()
	local ui = fit_UI("hundredghost.json", dev_width)
	ret_hundredghost, res_hundredghost = showUI(ui)
	if (ret_hundredghost == 0) then
		config_UI()
		return
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function audition_UI()
	local ui = fit_UI("audition.json", dev_width)
	ret_audition, res_audition = showUI(ui)
	if (ret_audition == 0) then
		config_UI()
		return
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function worldchannel_UI()
	local ui = fit_UI("worldchannel.json", dev_width)
	ret_worldchannel, res_worldchannel = showUI(ui)
	if (ret_worldchannel == 0) then
		config_UI()
		return
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function normalcall_UI()
	local ui = fit_UI("normalcall.json", dev_width)
	ret_normalcall, res_normalcall = showUI(ui)
	if (ret_normalcall == 0) then
		config_UI()
		return
	end
	
	local tickets
	if res_normalcall.tickets == "0" then
		tickets = 10
	elseif res_normalcall.tickets == "1" then
		tickets = 20
	elseif res_normalcall.tickets == "2" then
		tickets = 30
	elseif res_normalcall.tickets == "3" then
		tickets = 50
	elseif res_normalcall.tickets == "4" then
		tickets = 100
	elseif res_normalcall.tickets == "5" then
		tickets = 200
	elseif res_normalcall.tickets == "6" then
		tickets = 500
	elseif res_normalcall.tickets == "7" then
		tickets = 99999
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end

	normalcall(tickets, offer_arr)
end

function arena_UI()
	local ui = fit_UI("arena.json", dev_width)
	ret_arena, res_arena = showUI(ui)
	if (ret_arena == 0) then
		config_UI()
		return
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function offerquery_UI()
	local ui = fit_UI("offerquery.json", dev_width)
	ret_offerquery, res_offerquery = showUI(ui)
	if (ret_offerquery == 0) then
		config_UI()
		return
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function superghost_UI()
	local ui = fit_UI("superghost.json", dev_width)
	ret_superghost, res_superghost = showUI(ui)
	if (ret_superghost == 0) then
		config_UI()
		return
	end
	
	local ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end