require "util"
require "yuhun"
require "juexing"
require "jjtp"
require "yeyuanhuo"
require "yuling"

function fit_UI(ui, width)
	local content
	local value
	local json=require "JSON"
	local w, h= getScreenSize() -- 获取设备分辨率
	sf=w/width -- 当前分辨率/开发分辨率
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

function ios_ver()
	local ui = fit_UI("ios_ver.json", dev_width)
	ret_ios_ver, res_ios_ver = showUI(ui)
	
	if (ret_ios_ver == 0) then
		return RET_ERR
	end
	
	if (res_ios_ver.ios_ver == "1") then
		return "ios_other"
	elseif (res_ios_ver.ios_ver == "0") then
		return "ios_11"
	end
	return RET_OK
end

function portal_UI()
	local ui = fit_UI("portal.json", dev_width)
	ret_portal, res_portal = showUI(ui)
	if (ret_portal == 0) then
		return RET_ERR
	end
	portal_sel = res_portal.select
	if (portal_sel == "0") then
		fast_UI()
	elseif (portal_sel == "1") then
		config_UI()
	elseif (portal_sel == "2") then
		log_UI()
	elseif (portal_sel == "3") then
		spec_UI()
	end
end

function fast_UI()
	local ui = fit_UI("fast.json", dev_width)
	ret_fast, res_fast = showUI(ui)
	if (ret_fast == 0) then
		portal_UI()
		return
	end
	fast_sel = res_fast.select
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
		portal_UI()
		return
	end
	
	if (res_config.select == "0") then
		-- 八岐大蛇
		baqidashe_UI()
	elseif (res_config.select == "6") then
		-- 结界突破
		jjtp_UI()
	elseif (res_config.select == "9") then
		-- 觉醒
		juexing_UI()
	elseif (res_config.select == "4") then
		yeyuanhuo_UI()
	elseif (res_config.select == "7") then
		yuling_UI()
	end
end

function log_UI()
	local ui = fit_UI("log.json", dev_width)
	ret_log, res_log = showUI(ui)
	if (ret_log == 0) then
		portal_UI()
		return
	end
end

function spec_UI()
	local ui = fit_UI("spec.json", dev_width)
	ret_spec, res_spec = showUI(ui)
	if (ret_spec == 0) then
		portal_UI()
		return
	end
end

function global_UI()
	local ui = fit_UI("global.json", dev_width)
	ret_global, res_global = showUI(ui)
	
	if (ret_global == 0) then
		return RET_ERR, offer_arr
	end
	
	offer_arr = {0, 0, 0, 0, 0, 0}
	offer_sel = {}
	
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
	
	mark = {}
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
	offer_arr = {0, 0, 0, 0, 0, 0}
	level = 10
	round = 0
	offer_en = 0
	gouyu = 0
	tili = 0
	jinbi = 0
	lingshi = 0
	lock = 1
	member_auto_group = 1
	fail_and_group = 1
	member_to_captain = 0
	captain_auto_group = 1
	auto_invite_first = 0
	fail_and_recreate = 1
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
	
	offer_arr = {0, 0, 0, 0, 0, 0}
	
	jjtp(mode, whr, round_time, refresh, solo_select, house_select, offer_arr)
end

function fast_juexing_UI()
	local ui = fit_UI("fast_juexing.json", dev_width)
	ret_fast_jx, res_fast_jx = showUI(ui)
	if (ret_fast_jx == 0) then
		fast_UI()
		return
	end
	
	if (res_fast_jx.element == "0") then
		element = "火"
	elseif (res_fast_jx.element == "1") then
		element = "风"
	elseif (res_fast_jx.element == "2") then
		element = "水"
	elseif (res_fast_jx.element == "3") then
		element = "雷"
	end
	
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
	
	if (res_fast_jx.mark == "0") then
		mark = "小怪"
	elseif (res_fast_jx.mark == "1") then
		mark = "大怪"
	elseif (res_fast_jx.mark == "2") then
		mark = "无"
	end
	
	level = 10
	round = 0
	offer_arr = {0, 0, 0, 0, 0, 0}
	lock = 1
	member_auto_group = 1
	fail_and_group = 1
	member_to_captain = 0
	captain_auto_group = 1
	auto_invite_first = 0
	fail_and_recreate = 1
	
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
	
	mark = {}
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
	
	level = tonumber(res_baqi.level_select) + 1
	
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
	
	if (res_baqi.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	if (res_baqi.member_auto_group == "0") then
		member_auto_group = 1
	else
		member_auto_group = 0
	end
	
	if (res_baqi.fail_and_group == "0") then
		fail_and_group = 1
	else
		fail_and_group = 0
	end
	
	if (res_baqi.member_to_captain == "0") then
		member_to_captain = 0
	else
		member_to_captain = 1
	end
	
	if (res_baqi.captain_auto_group == "0") then
		captain_auto_group = 1
	else
		captain_auto_group = 0
	end
	
	if (res_baqi.auto_invite_first == "0") then
		auto_invite_first = 1
	else
		auto_invite_first = 0
	end
	
	if (res_baqi.fail_and_recreate == "0") then
		fail_and_recreate = 1
	else
		fail_and_recreate = 0
	end
	
	offer_arr = {}
	ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	yuhun(mode, role, group, mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate)
end

function jjtp_UI()
	local ui = fit_UI("jjtp.json", dev_width)
	ret_jjtp, res_jjtp = showUI(ui)
	if (ret_jjtp == 0) then
		config_UI()
		return
	end
	
	if (res_jjtp.mode == "0") then
		mode = "个人"
	elseif (res_jjtp.mode == "1") then
		mode = "阴阳寮"
	elseif (res_jjtp.mode == "2") then
		mode = "个人+阴阳寮"
	end
	
	whr = {0, 0, 0, 0}
	whr_sel = {}
	for w in string.gmatch(res_jjtp.whr,"([^'@']+)") do
		table.insert(whr_sel,w)
	end
	for i = 1, table.getn(whr_sel), 1 do
		if (whr_sel[i] == "0") then
			whr[1] = 1 -- 彼岸花
		elseif (whr_sel[i] == "1") then
			whr[2] = 1 -- 小僧
		elseif (whr_sel[i] == "2") then
			whr[3] = 1 -- 日和坊
		elseif (whr_sel[i] == "3") then
			whr[4] = 1 -- 御馔津
		end
	end
	
	if (res_jjtp.round_time == "0") then
		round_time = 3
	elseif (res_jjtp.round_time == "1") then
		round_time = 5
	elseif (res_jjtp.round_time == "2") then
		round_time = 10
	elseif (res_jjtp.round_time == "3") then
		round_time = 0
	end
	
	if (res_jjtp.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	if (res_jjtp.refresh == "0") then
		refresh = 3
	elseif (res_jjtp.refresh == "1") then
		refresh = 6
	elseif (res_jjtp.refresh == "2") then
		refresh = 9
	end
	
	if (res_jjtp.solo_select == "0") then
		solo_select = "0_to_5"
	elseif (res_jjtp.solo_select == "1") then
		solo_select = "3_to_5"
	elseif (res_jjtp.solo_select == "2") then
		solo_select = "5_to_0"
	elseif (res_jjtp.solo_select == "3") then
		solo_select = "3_to_0"
	elseif (res_jjtp.solo_select == "4") then
		solo_select = "random"
	end
	
	if (res_jjtp.house_select == "0") then
		house_select = "5_to_0"
	elseif (res_jjtp.house_select == "1") then
		house_select = "3_to_0"
	elseif (res_jjtp.house_select == "2") then
		house_select = "1_to_0"
	elseif (res_jjtp.house_select == "2") then
		house_select = "random"
	end
	
	offer_arr = {}
	ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	jjtp(mode, whr, round_time, refresh, solo_select, house_select, lock, offer_arr)
end

function juexing_UI()
	local ui = fit_UI("juexing.json", dev_width)
	ret_juexing, res_juexing = showUI(ui)
	if (ret_juexing == 0) then
		config_UI()
		return
	end
	
	if (res_juexing.element == "0") then
		element = "火"
	elseif (res_juexing.element == "1") then
		element = "风"
	elseif (res_juexing.element == "2") then
		element = "水"
	elseif (res_juexing.element == "3") then
		element = "雷"
	end
	
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
	
	if (res_juexing.mark == "0") then
		mark = "小怪"
	elseif (res_juexing.mark == "1") then
		mark = "大怪"
	elseif (res_juexing.mark == "2") then
		mark = "无"
	end
	
	level = tonumber(res_juexing.level_select) + 1
	
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
	
	if (res_juexing.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	if (res_juexing.member_auto_group == "0") then
		member_auto_group = 1
	else
		member_auto_group = 0
	end
	
	if (res_juexing.fail_and_group == "0") then
		fail_and_group = 1
	else
		fail_and_group = 0
	end
	
	if (res_juexing.member_to_captain == "0") then
		member_to_captain = 0
	else
		member_to_captain = 1
	end
	
	if (res_juexing.captain_auto_group == "0") then
		captain_auto_group = 1
	else
		captain_auto_group = 0
	end
	
	if (res_juexing.auto_invite_first == "0") then
		auto_invite_first = 1
	else
		auto_invite_first = 0
	end
	
	if (res_juexing.fail_and_recreate == "0") then
		fail_and_recreate = 1
	else
		fail_and_recreate = 0
	end
	
	offer_arr = {}
	ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	juexing(mode, role, group, element, mark, level, round, offer_arr, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, auto_invite_first, fail_and_recreate)
end

function yeyuanhuo_UI()
	local ui = fit_UI("yeyuanhuo.json", dev_width)
	ret_yeyuanhuo, res_yeyuanhuo = showUI(ui)
	if (ret_yeyuanhuo == 0) then
		config_UI()
		return
	end
	
	round_tan = 0
	round_chen = 0
	round_chi = 0
	
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
	
	if (res_yeyuanhuo.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	offer_arr = {}
	ret_global, offer_arr = global_UI()
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
	
	sel = -1
	level = -1
	round = -1
	lock = -1
	
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
	
	offer_arr = {}
	ret_global, offer_arr = global_UI()
	if (ret_global == RET_ERR) then
		return
	end

	yuling(sel, level, round, lock, offer_arr)
end