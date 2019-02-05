require "X_ui"
require "yuhun"
require "juexing"
require "jjtp"
require "yeyuanhuo"
require "yuling"
require "normalcall"
require "tansuo"
require "autostory"
require "yqfy"
require "hundredghost"
require "autocake"
require "LBSGhostDriving"
require "autojjtp"
require "superghost"

-- UI init
local width_UI = 1000
local height_UI = 550

-- Func
function portal_UI()
	-- Portal
	portal_ui = UI:new("portal.dat", width_UI, height_UI, "继续", "退出", "backGround.jpg")
	UI:Image(portal_ui, "title.png", "30,0,940,80")
	UI:Label(portal_ui, "left", "0,0,0", 30, "功能选择 - ", "30,90,300,55")
	UI:RadioGroup(portal_ui, "select", "高级选项    ,数据统计","0",30,"0,0,0","500,90,450,55")
	UI:Label(portal_ui, "left", "0,0,0", 30, "实时公告 - ", "30,140,300,55")
	UI:Image(portal_ui, "notice.png", "20,200,970,250")
	-- 公告
	local content, err = getCloudContent("WALL_BREAKER_ANNOUNCEMENT", "", "没有正确获取到公告信息")
	if err == 0 then
		UI:Label(portal_ui, "left", "0,0,0", 29, tostring(content), "110,250,800,180")
	end
	UI:fit(portal_ui)
	
	ret_portal, res_portal = UI:show(portal_ui)
	if (ret_portal == 0) then
		return RET_ERR
	end
	
	if (res_portal.select == "0") then
		config_UI()
	elseif (res_portal.select == "1") then
		stats_UI()
	end
	
	if win_cnt.global > 0 or fail_cnt.global > 0 then
		settlement_UI()
	end
end

function config_UI()
	-- Config
	config_ui = UI:new("config.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(config_ui, "center", "0,0,0", 30, "高级选项", "20,20,960,55")
	UI:RadioGroup(config_ui, "select", "八岐大蛇    ,探索章节    ,结界突破    ,觉醒麒麟    ,业原火        ,御灵之境    ,妖气封印    ,百鬼夜行    ,自动樱饼    ,副本组合    ,世界喊话    ,普通召唤    ,悬赏查询    ,劲舞团        ,自动剧情    ,特殊活动","0",30,"0,0,0","30,150,960,300")
	UI:fit(config_ui)
	
	ret_config, res_config = UI:show(config_ui)
	if (ret_config == 0) then
		portal_UI()
		return
	end
	
	-- 八岐大蛇
	if (res_config.select == "0") 	   then baqidashe_UI()
		-- 探索
	elseif (res_config.select == "1")  then	tansuo_UI()
		-- 结界突破
	elseif (res_config.select == "2")  then jjtp_UI()
		-- 觉醒麒麟
	elseif (res_config.select == "3")  then juexing_UI()
		-- 业原火
	elseif (res_config.select == "4")  then yeyuanhuo_UI()
		-- 御灵之境
	elseif (res_config.select == "5")  then yuling_UI()
		-- 妖气封印
	elseif (res_config.select == "6")  then yqfy_UI()
		-- 百鬼夜行
	elseif (res_config.select == "7")  then hundredghost_UI()
		-- 一键每日
	elseif (res_config.select == "8")  then autocake_UI()
		-- 副本组合
	elseif (res_config.select == "9")  then multimission_UI()
		-- 世界喊话
	elseif (res_config.select == "10")  then publicity_UI()
		-- 普通召唤
	elseif (res_config.select == "11")  then normalcall_UI()
		-- 超鬼王
	elseif (res_config.select == "12")  then offerinquire_UI()
		-- 劲舞团
	elseif (res_config.select == "13")  then audition_UI()
		-- 自动剧情
	elseif (res_config.select == "14")  then autostory_UI()
		-- 特殊活动
	elseif (res_config.select == "15")  then activityreserve_UI()
		--elseif (res_config.select == "15")  then LBSGhostDriving_UI()
		--elseif (res_config.select == "15")  then superghost_UI()
	end
end

function stats_UI()
	local stats_time, win_cnt_last, fail_cnt_last, win_cnt_total, fail_cnt_total = stats_read()
	
	local total_dura_hour = (stats_time.total_dura % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
	local total_dura_min = (stats_time.total_dura % (1000 * 60 * 60)) / (1000 * 60)
	local total_dura_sec = (stats_time.total_dura % (1000 * 60)) / 1000
	local last_dura_hour = (stats_time.last_dura % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
	local last_dura_min = (stats_time.last_dura % (1000 * 60 * 60)) / (1000 * 60)
	local last_dura_sec = (stats_time.last_dura % (1000 * 60)) / 1000
	
	-- Stats
	stats_ui = UI:new("stats.dat", width_UI, height_UI, "返回", "退出", "backGround.jpg")
	UI:Label(stats_ui, "center", "0,0,0", 30, "数据统计", "20,20,960,55")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("[破壁者]首次启动日期 - %s", stats_time.first_date), "30,100,960,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("[破壁者]总计运行时间 - %d小时, %d分钟, %d秒", total_dura_hour, total_dura_min, total_dura_sec), "30,160,960,60")
	UI:Line(stats_ui, "line_common", "100,100,100", 2, 960, "20,220,960,2")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("上一次有效启动日期 - %s", stats_time.last_date), "30,230,960,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("上一次有效运行时间 - %d小时, %d分钟, %d秒", last_dura_hour, last_dura_min, last_dura_sec), "30,290,960,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "上一次战斗结算 - ", "30,350,960,55")
	UI:Label(stats_ui, "left", "0,0,0", 30, "御魂:", "30,410,200,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", win_cnt_last.yuhun), "220,410,80,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "300,410,10,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt_last.yuhun), "365,410,135,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "探索:", "500,410,200,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", win_cnt_last.tansuo), "700,410,80,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "780,410,10,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt_last.tansuo), "865,410,135,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "突破:", "30,470,200,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", win_cnt_last.jjtp), "220,470,80,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "300,470,10,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt_last.jjtp), "365,470,135,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "觉醒:", "500,470,200,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", win_cnt_last.juexing), "700,470,80,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "780,470,10,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt_last.juexing), "865,470,135,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "业原火:", "30,530,200,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", win_cnt_last.yyh), "220,530,80,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "300,530,10,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt_last.yyh), "365,530,135,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "御灵:", "500,530,200,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", win_cnt_last.yuling), "700,530,80,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "780,530,10,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt_last.yuling), "865,530,135,60")
	UI:Line(stats_ui, "line_common", "100,100,100", 2, 960, "20,590,960,2")
	UI:Label(stats_ui, "left", "0,0,0", 30, "历史战斗结算 - ", "30,600,960,55")
	UI:Label(stats_ui, "left", "0,0,0", 30, "御魂:", "30,660,100,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", win_cnt_total.yuhun), "160,660,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "300,660,10,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", fail_cnt_total.yuhun), "360,660,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "探索:", "500,660,100,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", win_cnt_total.tansuo), "640,660,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "780,660,10,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", fail_cnt_total.tansuo), "830,660,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "突破:", "30,720,100,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", win_cnt_total.jjtp), "160,720,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "300,720,10,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", fail_cnt_total.jjtp), "360,720,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "觉醒:", "500,720,100,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", win_cnt_total.juexing), "640,720,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "780,720,10,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", fail_cnt_total.juexing), "830,720,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "业原火:", "30,780,100,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", win_cnt_total.yyh), "160,780,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "300,780,10,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", fail_cnt_total.yyh), "360,780,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "御灵:", "500,780,100,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", win_cnt_total.yuling), "640,780,140,60")
	UI:Label(stats_ui, "left", "0,0,0", 30, "-", "780,780,10,60")
	UI:Label(stats_ui, "center", "0,0,0", 30, string.format("%d", fail_cnt_total.yuling), "830,780,140,60")
	UI:fit(stats_ui)
	
	ret_stats, res_stats = UI:show(stats_ui)
	if (ret_stats == 1) then
		portal_UI()
		return
	end
end

function global_UI()
	-- 全局设置
	global_ui = UI:new("global.dat", width_UI, height_UI, "开始", "退出", "backGround.jpg")
	global_basic_page = UI:Page(global_ui, "全局设置")
	UI:CheckBoxGroup(global_basic_page, "offer_en","悬赏封印 - ","0",30,"0,0,0","20,20,300,60")
	UI:CheckBoxGroup(global_basic_page, "offer_sel","勾玉,体力,金币,猫粮,狗粮","0@1@2@3@4",30,"0,0,0","280,20,720,60")
	UI:CheckBoxGroup(global_basic_page, "auto_jjtp_en","智能突破","",30,"0,0,0","20,80,960,60")
	--UI:CheckBoxGroup(global_basic_page, "sg_en","超鬼王","",30,"0,0,0","20,140,960,60")
	--UI:Label(global_basic_page, "left", "0,0,0", 30, "鬼王选择 - ", "500,140,180,60")
	--UI:ComboBox(global_basic_page, "sg_fight_sel", "所有公开的超鬼王,自己发现的超鬼王","1",23,"680,140,300,50")
	UI:Line(global_basic_page, "line_common", "100,100,100", 2, 960, "20,140,960,2")
	UI:CheckBoxGroup(global_basic_page, "skill","自动关闭技能特写","0",30,"0,0,0","20,150,980,60")
	UI:CheckBoxGroup(global_basic_page, "reconn","自动断线重新连接","0",30,"0,0,0","20,210,980,60")
	UI:CheckBoxGroup(global_basic_page, "buff_stop_useup","体力用尽关闭所有Buff","0",30,"0,0,0","20,270,700,60")
	UI:CheckBoxGroup(global_basic_page, "buff_stop_idle","庭院探索停留过久关闭所有Buff","0",30,"0,0,0","20,330,700,60")
	UI:ComboBox(global_basic_page, "buff_stop_idle_time", "15秒,30秒,45秒,1分钟,2分钟,5分钟","3",23,"750,330,230,50")
	UI:CheckBoxGroup(global_basic_page, "HUD","可视化点击手势与运行辅助描述","0",30,"0,0,0","20,390,980,60")
	
	global_auto_jjtp_page = UI:Page(global_ui, "智能突破")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "开启间隔 - ", "20,20,300,60")
	UI:ComboBox(global_auto_jjtp_page, "auto_jjtp_interv", "15分钟,30分钟,45分钟,60分钟,120分钟","3",23,"600,20,380,50")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "突破模式 - ", "20,80,300,60")
	UI:ComboBox(global_auto_jjtp_page, "auto_jjtp_mode", "个人突破,阴阳寮突破,个人突破 + 阴阳寮突破", "2", 23, "600,80,380,50")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "战斗限时 - ", "20,140,300,60")
	UI:ComboBox(global_auto_jjtp_page, "auto_jjtp_round_time", "3分钟,5分钟,10分钟,不限时","1",23,"600,140,380,50")
	UI:CheckBoxGroup(global_auto_jjtp_page, "auto_jjtp_lock","锁定出战阵容","0",30,"0,0,0","20,200,900,60")
	UI:Line(global_auto_jjtp_page, "line_common", "100,100,100", 2, 960, "20,260,960,2")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "个人突破设置 - ", "20,270,300,60")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "跳过特殊式神 - ", "20,330,300,60")
	UI:CheckBoxGroup(global_auto_jjtp_page, "auto_jjtp_whr_solo","彼岸花,小僧,日和坊,御馔津","0@1@2",30,"0,0,0","330,330,670,60")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "勋章选择 - ", "20,390,300,60")
	UI:ComboBox(global_auto_jjtp_page, "auto_jjtp_solo_sel", "0 - 5 勋章,3 - 5 勋章,5 - 0 勋章,3 - 0 勋章,随机选择","2",23,"700,390,280,50")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "胜场刷新 - ", "20,450,300,60")
	UI:ComboBox(global_auto_jjtp_page, "auto_jjtp_refresh", "3次,6次,9次","0",23,"700,450,280,50")
	UI:Line(global_auto_jjtp_page, "line_common", "100,100,100", 2, 960, "20,510,960,2")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "阴阳寮突破设置 - ", "20,520,300,60")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "跳过特殊式神 - ", "20,580,300,60")
	UI:CheckBoxGroup(global_auto_jjtp_page, "auto_jjtp_whr_pub","彼岸花,小僧,日和坊,御馔津","0@1@2",30,"0,0,0","330,580,670,60")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "勋章选择 - ", "20,640,300,60")
	UI:ComboBox(global_auto_jjtp_page, "auto_jjtp_pub_sel", "5 - 0 勋章,4 - 0 勋章,3 - 0 勋章,2 - 0 勋章,1 - 0 勋章,0勋章","0",23,"700,640,280,50")
	UI:Line(global_auto_jjtp_page, "line_common", "100,100,100", 2, 960, "20,700,960,2")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "Tips - ", "20,710,300,60")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "适用于御魂/觉醒/探索/业原火的所有模式, 间隔时间后暂停活动清理突破", "20,770,960,60")
	UI:Label(global_auto_jjtp_page, "left", "0,0,0", 30, "", "20,830,960,60")
	
	--	global_super_ghost_page = UI:Page(global_ui, "超鬼王")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "战斗标记 - ", "20,20,300,60")
	--	UI:CheckBoxGroup(global_super_ghost_page, "sg_mark", "Boss      ,草人","2",30,"0,0,0","600,20,400,60")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "强力追击 - ", "20,80,300,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_force", ">= 1星,>= 2星,>= 3星,>= 4星,>= 5星,      6星,不开启","4",23,"600,80,380,50")
	--	-- 6星
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "6星设置 - ", "20,140,140,60")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "血量[>50%", "160,140,160,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_high_6", "默认,①队,②队,③队,响铃,公开","0",23,"330,140,150,50")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "<50%", "470,140,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_low_6", "默认,①队,②队,③队,响铃,公开","0",23,"570,140,150,50")
	--	UI:Label(global_super_ghost_page, "center", "0,0,0", 30, "]   疲劳", "720,140,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_tired_6", "公开,等待,喝茶,响铃","2",23,"820,140,150,50")
	--	-- 5星
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "5星设置 - ", "20,200,140,60")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "血量[>50%", "160,200,160,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_high_5", "默认,①队,②队,③队,响铃,公开","0",23,"330,200,150,50")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "<50%", "470,200,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_low_5", "默认,①队,②队,③队,响铃,公开","0",23,"570,200,150,50")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "]   疲劳", "720,200,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_tired_5", "公开,等待,喝茶,响铃","2",23,"820,200,150,50")
	--	-- 4星
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "4星设置 - ", "20,260,140,60")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "血量[>50%", "160,260,160,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_high_4", "默认,①队,②队,③队,响铃,集结","0",23,"330,260,150,50")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "<50%", "470,260,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_low_4", "默认,①队,②队,③队,响铃,集结","0",23,"570,260,150,50")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "]   疲劳", "720,260,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_tired_4", "集结,等待,喝茶,响铃","0",23,"820,260,150,50")
	--	-- 3星
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "3星设置 - ", "20,320,140,60")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "血量[>50%", "160,320,160,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_high_3", "默认,①队,②队,③队,响铃,集结","0",23,"330,320,150,50")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "<50%", "470,320,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_low_3", "默认,①队,②队,③队,响铃,集结","0",23,"570,320,150,50")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "]   疲劳", "720,320,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_tired_3", "集结,等待,喝茶,响铃","0",23,"820,320,150,50")
	--	-- 2星
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "2星设置 - ", "20,380,140,60")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "血量[>50%", "160,380,160,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_high_2", "默认,①队,②队,③队,响铃,集结","0",23,"330,380,150,50")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "<50%", "470,380,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_low_2", "默认,①队,②队,③队,响铃,集结","0",23,"570,380,150,50")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "]   疲劳", "720,380,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_tired_2", "集结,等待,喝茶,响铃","1",23,"820,380,150,50")
	--	-- 1星
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "1星设置 - ", "20,440,140,60")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "血量[>50%", "160,440,160,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_high_1", "默认,①队,②队,③队,响铃,集结","0",23,"330,440,150,50")
	--	UI:Label(global_super_ghost_page, "right", "0,0,0", 30, "<50%", "470,440,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_low_1", "默认,①队,②队,③队,响铃,集结","0",23,"570,440,150,50")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "]   疲劳", "720,440,100,60")
	--	UI:ComboBox(global_super_ghost_page, "sg_tired_1", "集结,等待,喝茶,响铃","1",23,"820,440,150,50")
	--	UI:Line(global_super_ghost_page, "line_common", "100,100,100", 2, 960, "20,500,960,2")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "Tips - ", "20,510,300,60")
	--	UI:Label(global_super_ghost_page, "left", "0,0,0", 30, "适用于御魂/觉醒/探索的所有模式, 队长队员将会自动禁用自动组队", "20,570,960,60")
	
	UI:fit(global_ui)
	ret_global, res_global = UI:show(global_ui)
	
	if (ret_global == 0) then
		return RET_ERR
	end
	
	-- Enable战斗结算
	settlement_en = 1
	
	-- HUD
	if res_global.HUD == "0" then
		HUD = "show"
		hud_info = createHUD()
	end
	
	-- 关闭特效
	if res_global.skill == "0" then
		disable_skill_feature()
	end
	
	-- 悬赏封印
	local offer_sel = {}
	if res_global.offer_en == "0" then
		offer_arr[1] = 1
		for w in string.gmatch(res_global.offer_sel,"([^'@']+)") do
			table.insert(offer_sel,w)
		end
		for i = 1, table.getn(offer_sel), 1 do
			if (offer_sel[i] == "0") then
				offer_arr[2] = 1 -- 勾玉
			elseif (offer_sel[i] == "1") then
				offer_arr[3] = 1 -- 体力
			elseif (offer_sel[i] == "2") then
				offer_arr[4] = 1 -- 金币
			elseif (offer_sel[i] == "3") then
				offer_arr[5] = 1 -- 猫粮
			elseif (offer_sel[i] == "4") then
				offer_arr[6] = 1 -- 狗粮
			end
		end
	end
	
	-- 断线闪退
	if res_global.reconn == "0" then
		reconn = 1
	else
		reconn = 0
	end
	
	-- Idle关闭buff
	if res_global.buff_stop_idle_time == "0" then
		buff_stop_idle_time = 15
	elseif res_global.buff_stop_idle_time == "1" then
		buff_stop_idle_time = 30
	elseif res_global.buff_stop_idle_time == "2" then
		buff_stop_idle_time = 45
	elseif res_global.buff_stop_idle_time == "3" then
		buff_stop_idle_time = 60
	elseif res_global.buff_stop_idle_time == "4" then
		buff_stop_idle_time = 120
	elseif res_global.buff_stop_idle_time == "5" then
		buff_stop_idle_time = 300
	end
	
	if res_global.buff_stop_idle == "0" then
		buff_stop_idle = 1
	else
		buff_stop_idle = 0
		buff_stop_idle_time = 99999
	end
	
	-- Usup关闭buff
	if res_global.buff_stop_useup == "0" then
		buff_stop_useup = 1
	else
		buff_stop_useup = 0
	end
	
	-- 智能突破
	if res_global.auto_jjtp_en == "0" then
		auto_jjtp_en = 1
	else
		auto_jjtp_en = 0
	end
	
	if res_global.auto_jjtp_interv == "0" then
		auto_jjtp_interv = 15
	elseif res_global.auto_jjtp_interv == "1" then
		auto_jjtp_interv = 30
	elseif res_global.auto_jjtp_interv == "2" then
		auto_jjtp_interv = 45
	elseif res_global.auto_jjtp_interv == "3" then
		auto_jjtp_interv = 60
	elseif res_global.auto_jjtp_interv == "4" then
		auto_jjtp_interv = 120
	end
	
	if (res_global.auto_jjtp_mode == "0") then
		auto_jjtp_mode = "个人"
	elseif (res_global.auto_jjtp_mode == "1") then
		auto_jjtp_mode = "阴阳寮"
	elseif (res_global.auto_jjtp_mode == "2") then
		auto_jjtp_mode = "个人+阴阳寮"
	end
	
	local whr_solo = {}
	for w in string.gmatch(res_global.auto_jjtp_whr_solo,"([^'@']+)") do
		table.insert(whr_solo,w)
	end
	for i = 1, table.getn(whr_solo), 1 do
		if (whr_solo[i] == "0") then
			auto_jjtp_whr_solo[1] = 1 -- 彼岸花
		elseif (whr_solo[i] == "1") then
			auto_jjtp_whr_solo[2] = 1 -- 小僧
		elseif (whr_solo[i] == "2") then
			auto_jjtp_whr_solo[3] = 1 -- 日和坊
		elseif (whr_solo[i] == "3") then
			auto_jjtp_whr_solo[4] = 1 -- 御馔津
		end
	end
	
	local whr_pub = {}
	for w in string.gmatch(res_global.auto_jjtp_whr_pub,"([^'@']+)") do
		table.insert(whr_pub,w)
	end
	for i = 1, table.getn(whr_pub), 1 do
		if (whr_pub[i] == "0") then
			auto_jjtp_whr_pub[1] = 1 -- 彼岸花
		elseif (whr_pub[i] == "1") then
			auto_jjtp_whr_pub[2] = 1 -- 小僧
		elseif (whr_pub[i] == "2") then
			auto_jjtp_whr_pub[3] = 1 -- 日和坊
		elseif (whr_pub[i] == "3") then
			auto_jjtp_whr_pub[4] = 1 -- 御馔津
		end
	end
	
	if (res_global.auto_jjtp_round_time == "0") then
		auto_jjtp_round_time = 3
	elseif (res_global.auto_jjtp_round_time == "1") then
		auto_jjtp_round_time = 5
	elseif (res_global.auto_jjtp_round_time == "2") then
		auto_jjtp_round_time = 10
	elseif (res_global.auto_jjtp_round_time == "3") then
		auto_jjtp_round_time = 99999
	end
	
	if (res_global.auto_jjtp_lock == "0") then
		auto_jjtp_lock = 1
	else
		auto_jjtp_lock = 0
	end
	
	if (res_global.auto_jjtp_refresh == "0") then
		auto_jjtp_refresh = 3
	elseif (res_global.auto_jjtp_refresh == "1") then
		auto_jjtp_refresh = 6
	elseif (res_global.auto_jjtp_refresh == "2") then
		auto_jjtp_refresh = 9
	end
	
	if (res_global.auto_jjtp_solo_sel == "0") then
		auto_jjtp_solo_sel = "0_to_5"
	elseif (res_global.auto_jjtp_solo_sel == "1") then
		auto_jjtp_solo_sel = "3_to_5"
	elseif (res_global.auto_jjtp_solo_sel == "2") then
		auto_jjtp_solo_sel = "5_to_0"
	elseif (res_global.auto_jjtp_solo_sel == "3") then
		auto_jjtp_solo_sel = "3_to_0"
	elseif (res_global.auto_jjtp_solo_sel == "4") then
		auto_jjtp_solo_sel = "random"
	end
	
	if (res_global.auto_jjtp_pub_sel == "0") then
		auto_jjtp_pub_sel = 5
	elseif (res_global.auto_jjtp_pub_sel == "1") then
		auto_jjtp_pub_sel = 4
	elseif (res_global.auto_jjtp_pub_sel == "2") then
		auto_jjtp_pub_sel = 3
	elseif (res_global.auto_jjtp_pub_sel == "3") then
		auto_jjtp_pub_sel = 2
	elseif (res_global.auto_jjtp_pub_sel == "4") then
		auto_jjtp_pub_sel = 1
	elseif (res_global.auto_jjtp_pub_sel == "5") then
		auto_jjtp_pub_sel = 0
	end
	
	-- 超鬼王
	sg_en = 0
	--	if res_global.sg_en == "0" then
	--		sg_en = 1
	--	else
	--		sg_en = 0
	--	end
	
	--	if res_global.sg_fight_sel == "0" then
	--		sg_fight_sel = "Public"
	--	else
	--		sg_fight_sel = "Private"
	--	end
	
	--	sg_force = tonumber(res_global.sg_force) + 1
	
	--	local sg_mark_ = {}
	--	for w in string.gmatch(res_global.sg_mark,"([^'@']+)") do
	--		table.insert(sg_mark_,w)
	--	end
	--	for i = 1, table.getn(sg_mark_), 1 do
	--		if (sg_mark_[i] == "0") then
	--			sg_mark_sel[1] = 1 -- Boss
	--		elseif (sg_mark_[i] == "1") then
	--			sg_mark_sel[2] = 1 -- 草人
	--		end
	--	end
	
	--	-- >50%
	--	if res_global.sg_high_6 == "0" then sg_high[6] = "默认"
	--	elseif res_global.sg_high_6 == "1" then sg_high[6] = "预设1"
	--	elseif res_global.sg_high_6 == "2" then sg_high[6] = "预设2"
	--	elseif res_global.sg_high_6 == "3" then sg_high[6] = "预设3"
	--	elseif res_global.sg_high_6 == "4" then sg_high[6] = "响铃"
	--	elseif res_global.sg_high_6 == "5" then sg_high[6] = "集结" end
	
	--	if res_global.sg_high_5 == "0" then sg_high[5] = "默认"
	--	elseif res_global.sg_high_5 == "1" then sg_high[5] = "预设1"
	--	elseif res_global.sg_high_5 == "2" then sg_high[5] = "预设2"
	--	elseif res_global.sg_high_5 == "3" then sg_high[5] = "预设3"
	--	elseif res_global.sg_high_5 == "4" then sg_high[5] = "响铃"
	--	elseif res_global.sg_high_5 == "5" then sg_high[5] = "集结" end
	
	--	if res_global.sg_high_4 == "0" then sg_high[4] = "默认"
	--	elseif res_global.sg_high_4 == "1" then sg_high[4] = "预设1"
	--	elseif res_global.sg_high_4 == "2" then sg_high[4] = "预设2"
	--	elseif res_global.sg_high_4 == "3" then sg_high[4] = "预设3"
	--	elseif res_global.sg_high_4 == "4" then sg_high[4] = "响铃"
	--	elseif res_global.sg_high_4 == "5" then sg_high[4] = "集结" end
	
	--	if res_global.sg_high_3 == "0" then sg_high[3] = "默认"
	--	elseif res_global.sg_high_3 == "1" then sg_high[3] = "预设1"
	--	elseif res_global.sg_high_3 == "2" then sg_high[3] = "预设2"
	--	elseif res_global.sg_high_3 == "3" then sg_high[3] = "预设3"
	--	elseif res_global.sg_high_3 == "4" then sg_high[3] = "响铃"
	--	elseif res_global.sg_high_3 == "5" then sg_high[3] = "集结" end
	
	--	if res_global.sg_high_2 == "0" then sg_high[2] = "默认"
	--	elseif res_global.sg_high_2 == "1" then sg_high[2] = "预设1"
	--	elseif res_global.sg_high_2 == "2" then sg_high[2] = "预设2"
	--	elseif res_global.sg_high_2 == "3" then sg_high[2] = "预设3"
	--	elseif res_global.sg_high_2 == "4" then sg_high[2] = "响铃"
	--	elseif res_global.sg_high_2 == "5" then sg_high[2] = "集结" end
	
	--	if res_global.sg_high_1 == "0" then sg_high[1] = "默认"
	--	elseif res_global.sg_high_1 == "1" then sg_high[1] = "预设1"
	--	elseif res_global.sg_high_1 == "2" then sg_high[1] = "预设2"
	--	elseif res_global.sg_high_1 == "3" then sg_high[1] = "预设3"
	--	elseif res_global.sg_high_1 == "4" then sg_high[1] = "响铃"
	--	elseif res_global.sg_high_1 == "5" then sg_high[1] = "集结" end
	
	--	-- <50%
	--	if res_global.sg_low_6 == "0" then sg_low[6] = "默认"
	--	elseif res_global.sg_low_6 == "1" then sg_low[6] = "预设1"
	--	elseif res_global.sg_low_6 == "2" then sg_low[6] = "预设2"
	--	elseif res_global.sg_low_6 == "3" then sg_low[6] = "预设3"
	--	elseif res_global.sg_low_6 == "4" then sg_low[6] = "响铃"
	--	elseif res_global.sg_low_6 == "5" then sg_low[6] = "集结" end
	
	--	if res_global.sg_low_5 == "0" then sg_low[5] = "默认"
	--	elseif res_global.sg_low_5 == "1" then sg_low[5] = "预设1"
	--	elseif res_global.sg_low_5 == "2" then sg_low[5] = "预设2"
	--	elseif res_global.sg_low_5 == "3" then sg_low[5] = "预设3"
	--	elseif res_global.sg_low_5 == "4" then sg_low[5] = "响铃"
	--	elseif res_global.sg_low_5 == "5" then sg_low[5] = "集结" end
	
	--	if res_global.sg_low_4 == "0" then sg_low[4] = "默认"
	--	elseif res_global.sg_low_4 == "1" then sg_low[4] = "预设1"
	--	elseif res_global.sg_low_4 == "2" then sg_low[4] = "预设2"
	--	elseif res_global.sg_low_4 == "3" then sg_low[4] = "预设3"
	--	elseif res_global.sg_low_4 == "4" then sg_low[4] = "响铃"
	--	elseif res_global.sg_low_4 == "5" then sg_low[4] = "集结" end
	
	--	if res_global.sg_low_3 == "0" then sg_low[3] = "默认"
	--	elseif res_global.sg_low_3 == "1" then sg_low[3] = "预设1"
	--	elseif res_global.sg_low_3 == "2" then sg_low[3] = "预设2"
	--	elseif res_global.sg_low_3 == "3" then sg_low[3] = "预设3"
	--	elseif res_global.sg_low_3 == "4" then sg_low[3] = "响铃"
	--	elseif res_global.sg_low_3 == "5" then sg_low[3] = "集结" end
	
	--	if res_global.sg_low_2 == "0" then sg_low[2] = "默认"
	--	elseif res_global.sg_low_2 == "1" then sg_low[2] = "预设1"
	--	elseif res_global.sg_low_2 == "2" then sg_low[2] = "预设2"
	--	elseif res_global.sg_low_2 == "3" then sg_low[2] = "预设3"
	--	elseif res_global.sg_low_2 == "4" then sg_low[2] = "响铃"
	--	elseif res_global.sg_low_2 == "5" then sg_low[2] = "集结" end
	
	--	if res_global.sg_low_1 == "0" then sg_low[1] = "默认"
	--	elseif res_global.sg_low_1 == "1" then sg_low[1] = "预设1"
	--	elseif res_global.sg_low_1 == "2" then sg_low[1] = "预设2"
	--	elseif res_global.sg_low_1 == "3" then sg_low[1] = "预设3"
	--	elseif res_global.sg_low_1 == "4" then sg_low[1] = "响铃"
	--	elseif res_global.sg_low_1 == "5" then sg_low[1] = "集结" end
	
	--	-- 疲劳
	--	if res_global.sg_tired_6 == "0" then sg_tired[6] = "集结"
	--	elseif res_global.sg_tired_6 == "1" then sg_tired[6] = "等待"
	--	elseif res_global.sg_tired_6 == "2" then sg_tired[6] = "喝茶"
	--	elseif res_global.sg_tired_6 == "3" then sg_tired[6] = "响铃" end
	
	--	if res_global.sg_tired_5 == "0" then sg_tired[5] = "集结"
	--	elseif res_global.sg_tired_5 == "1" then sg_tired[5] = "等待"
	--	elseif res_global.sg_tired_5 == "2" then sg_tired[5] = "喝茶"
	--	elseif res_global.sg_tired_5 == "3" then sg_tired[5] = "响铃" end
	
	--	if res_global.sg_tired_4 == "0" then sg_tired[4] = "集结"
	--	elseif res_global.sg_tired_4 == "1" then sg_tired[4] = "等待"
	--	elseif res_global.sg_tired_4 == "2" then sg_tired[4] = "喝茶"
	--	elseif res_global.sg_tired_4 == "3" then sg_tired[4] = "响铃" end
	
	--	if res_global.sg_tired_3 == "0" then sg_tired[3] = "集结"
	--	elseif res_global.sg_tired_3 == "1" then sg_tired[3] = "等待"
	--	elseif res_global.sg_tired_3 == "2" then sg_tired[3] = "喝茶"
	--	elseif res_global.sg_tired_3 == "3" then sg_tired[3] = "响铃" end
	
	--	if res_global.sg_tired_2 == "0" then sg_tired[2] = "集结"
	--	elseif res_global.sg_tired_2 == "1" then sg_tired[2] = "等待"
	--	elseif res_global.sg_tired_2 == "2" then sg_tired[2] = "喝茶"
	--	elseif res_global.sg_tired_2 == "3" then sg_tired[2] = "响铃" end
	
	--	if res_global.sg_tired_1 == "0" then sg_tired[1] = "集结"
	--	elseif res_global.sg_tired_1 == "1" then sg_tired[1] = "等待"
	--	elseif res_global.sg_tired_1 == "2" then sg_tired[1] = "喝茶"
	--	elseif res_global.sg_tired_1 == "3" then sg_tired[1] = "响铃" end
	
	return RET_OK
end

function settlement_UI()
	if settlement_en == 0 then
		return
	end
	
	local end_time = mTime()
	local dura_time = end_time - start_time
	local dura_hour = (dura_time % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
	local dura_min = (dura_time % (1000 * 60 * 60)) / (1000 * 60)
	local dura_sec = (dura_time % (1000 * 60)) / 1000
	stats_write()
	
	settlement_ui = UI:new("settlement.dat", width_UI, height_UI, "退出", "重新启动", "backGround.jpg")
	UI:Label(settlement_ui, "center", "0,0,0", 30, "战斗结算", "20,20,960,55")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("[破壁者]启动日期 - %s", system_date), "30,100,960,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("[破壁者]运行时间 - %d小时, %d分钟, %d秒", dura_hour, dura_min, dura_sec), "30,160,960,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "御魂:", "30,220,200,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", win_cnt.yuhun), "220,220,80,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "-", "300,220,10,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt.yuhun), "365,220,135,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "探索:", "500,220,200,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", win_cnt.tansuo), "700,220,80,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "-", "780,220,10,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt.tansuo), "865,220,135,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "突破:", "30,280,200,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", win_cnt.jjtp), "220,280,80,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "-", "300,280,10,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt.jjtp), "365,280,135,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "觉醒:", "500,280,200,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", win_cnt.juexing), "700,280,80,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "-", "780,280,10,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt.juexing), "865,280,135,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "业原火:", "30,340,200,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", win_cnt.yyh), "220,340,80,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "-", "300,340,10,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt.yyh), "365,340,135,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "御灵:", "500,340,200,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", win_cnt.yuling), "700,340,80,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, "-", "780,340,10,60")
	UI:Label(settlement_ui, "left", "0,0,0", 30, string.format("%d", fail_cnt.yuling), "865,340,135,60")
	UI:fit(settlement_ui)
	
	ret_settlement, res_settlement = UI:show(settlement_ui)
	
	if (ret_settlement == 0) then
		lua_restart()
	end
	
	return
end

-- Config
function baqidashe_UI()
	-- 八岐大蛇
	bqds_ui = UI:new("bqds.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(bqds_ui, "center", "0,0,0", 30, "八岐大蛇", "20,20,960,55")
	UI:ComboBox(bqds_ui, "mode", "单人模式,队长 - 野队 2人队伍,队长 - 野队 3人队伍,队长 - 固定队 2人队伍,队长 - 固定队 3人队伍,队员 - 野队,队员 - 固定队", "0", 30, "20,100,960,60")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "公共设置 - ", "20,180,300,60")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "请选择御魂层数 - ", "20,240,300,60")
	UI:ComboBox(bqds_ui, "level", "一层,二层,三层,四层,五层,六层,七层,八层,九层,十层","9",23,"700,240,280,50")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "请选择战斗次数 - ", "20,300,300,60")
	UI:ComboBox(bqds_ui, "round", "3次,10次,20次,30次,50次,100次,无限次数","6",23,"700,300,280,50")
	UI:CheckBoxGroup(bqds_ui, "lock","锁定出战阵容","0",30,"0,0,0","20,360,900,60")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "标记 - ", "20,420,300,60")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "第一回合 ~ ", "20,480,300,60")
	UI:RadioGroup(bqds_ui, "round1", "左  ,中  ,右  ,无","3",30,"0,0,0","500,480,500,60")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "第二回合 ~ ", "20,540,300,60")
	UI:RadioGroup(bqds_ui, "round2", "左  ,中  ,右  ,无","3",30,"0,0,0","500,540,500,60")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "第三回合 ~ ", "20,600,300,60")
	UI:RadioGroup(bqds_ui, "round3", "左  ,中  ,右  ,无","3",30,"0,0,0","500,600,500,60")
	UI:Line(bqds_ui, "line_common", "100,100,100", 2, 960, "20,660,960,2")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "队员设置 - ", "20,670,900,60")
	UI:CheckBoxGroup(bqds_ui, "member_auto_group","接受自动组队","0",30,"0,0,0","20,730,900,60")
	UI:CheckBoxGroup(bqds_ui, "fail_and_group","失败后重新寻找队伍","0",30,"0,0,0","20,790,900,60")
	UI:CheckBoxGroup(bqds_ui, "member_to_captain","禁止队员接手队长","0",30,"0,0,0","20,850,900,60")
	UI:Line(bqds_ui, "line_common", "100,100,100", 2, 960, "20,910,960,2")
	UI:Label(bqds_ui, "left", "0,0,0", 30, "队长设置 - ", "20,920,900,60")
	UI:CheckBoxGroup(bqds_ui, "captain_auto_group","开启自动组队","0",30,"0,0,0","20,980,900,60")
	UI:CheckBoxGroup(bqds_ui, "captain_auto_invite","固定队伍自动邀请第一位","0",30,"0,0,0","20,1040,500,60")
	UI:ComboBox(bqds_ui, "auto_invite_zone", "本区好友,最近组队,跨区好友","0",23,"700,1040,280,50")
	UI:CheckBoxGroup(bqds_ui, "fail_and_recreate","失败后重新建立房间","0",30,"0,0,0","20,1100,900,60")
	UI:fit(bqds_ui)
	
	ret_baqi, res_baqi = UI:show(bqds_ui)
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
		group = "野队2人"
	elseif (res_baqi.mode == "2") then
		mode = "组队"
		role = "队长"
		group = "野队3人"
	elseif (res_baqi.mode == "3") then
		mode = "组队"
		role = "队长"
		group = "固定队2人"
	elseif (res_baqi.mode == "4") then
		mode = "组队"
		role = "队长"
		group = "固定队3人"
	elseif (res_baqi.mode == "5") then
		mode = "组队"
		role = "队员"
		group = "野队"
	elseif (res_baqi.mode == "6") then
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
	
	local level = tonumber(res_baqi.level) + 1
	
	local round
	if (res_baqi.round == "0") then
		round = 3
	elseif (res_baqi.round == "1") then
		round = 10
	elseif (res_baqi.round == "2") then
		round = 20
	elseif (res_baqi.round == "3") then
		round = 30
	elseif (res_baqi.round == "4") then
		round = 50
	elseif (res_baqi.round == "5") then
		round = 100
	elseif (res_baqi.round == "6") then
		round = 99999
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
	
	local captain_auto_invite
	if (res_baqi.captain_auto_invite == "0") then
		captain_auto_invite = 1
	else
		captain_auto_invite = 0
	end
	
	local auto_invite_zone
	if (res_baqi.auto_invite_zone == "0") then
		auto_invite_zone = "好友"
	elseif (res_baqi.auto_invite_zone == "1") then
		auto_invite_zone = "最近"
	elseif(res_baqi.auto_invite_zone == "2") then
		auto_invite_zone = "跨区"
	end
	
	local fail_and_recreate
	if (res_baqi.fail_and_recreate == "0") then
		fail_and_recreate = 1
	else
		fail_and_recreate = 0
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	while (1) do
		if (auto_jjtp_en == 1) then
			yuhun_auto_jjtp(mode, role, group, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
		else
			yuhun(mode, role, group, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
		end
	end
end

function tansuo_UI()
	-- 探索章节
	tansuo_ui = UI:new("tansuo.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(tansuo_ui, "center", "0,0,0", 30, "探索章节", "20,20,960,55")
	UI:ComboBox(tansuo_ui, "mode", "单人模式,组队 - 队长,组队 - 队员", "0", 30, "20,100,960,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "战斗设置 - ", "20,180,300,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "加成识别 : ", "20,240,300,60")
	UI:CheckBoxGroup(tansuo_ui, "select","物品,金币,经验,Boss","2@3",30,"0,0,0","400,240,580,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "自动标记 - ", "20,300,300,60")
	UI:RadioGroup(tansuo_ui, "mark", "随机小怪  ,中间大怪  ,无","2",30,"0,0,0","420,300,580,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "难度选择 - ", "20,360,300,60")
	UI:RadioGroup(tansuo_ui, "hard", "普通                ,困难[队长强制]","1",30,"0,0,0","420,360,580,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "场景移动 - ", "20,420,300,60")
	UI:RadioGroup(tansuo_ui, "scene_move", "2 - 3次  ,3 - 4次  ,4 - 5次","2",30,"0,0,0","420,420,580,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "目标章节 - ", "20,480,500,60")
	UI:ComboBox(tansuo_ui, "section", "章节第一栏[手动调整位置],章节第四栏[手动调整位置],第一章,第二章,第三章,第四章,第五章,第六章,第七章,第八章,第九章,第十章,第十一章,第十二章,第十三章,第十四章,第十五章,第十六章,第十七章,第十八章,第十九章,第二十章,第二十一章,第二十二章,第二十三章,第二十四章,第二十五章,第二十六章,第二十七章,第二十八章","29",23,"600,480,380,50")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "限定方式 - ", "20,540,500,60")
	UI:ComboBox(tansuo_ui, "count_mode", "战斗胜利次数,章节通关次数[强制Boss]","0",23,"600,540,380,50")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "战斗胜利次数 - ", "20,600,500,60")
	UI:ComboBox(tansuo_ui, "win_round", "3次,10次,20次,30次[组队寮任务],50次,100次,无限次","6",23,"600,600,380,50")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "章节通关次数 - ", "20,660,500,60")
	UI:ComboBox(tansuo_ui, "sec_round", "1次,2次,3次,5次,10次,50次,无限次","2",23,"600,660,380,50")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "队长自动邀请 - ", "20,720,500,60")
	UI:ComboBox(tansuo_ui, "captain_auto_invite", "不使用自动邀请,第一位阴阳寮寮友,第一位本区好友,第一位跨区好友","0",23,"600,720,380,50")
	UI:Line(tansuo_ui, "line_common", "100,100,100", 2, 960, "20,780,960,2")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "狗粮设置 : ", "20,790,900,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "狗粮队长 - ", "20,850,300,60")
	UI:ComboBox(tansuo_ui, "captain_pos", "阴阳师左手边斜前方[第一排],阴阳师正左手边[第二排],无","0",23,"600,850,380,50")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "狗粮普攻 - ", "20,910,300,60")
	UI:RadioGroup(tansuo_ui, "nor_attk", "开启            ,关闭","0",30,"0,0,0","600,910,400,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "满级操作 - ", "20,970,300,60")
	UI:ComboBox(tansuo_ui, "full_exp", "铃声提醒,自动更换,无","1",23,"600,970,380,50")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "初始翻页 - ", "20,1030,300,60")
	UI:ComboBox(tansuo_ui, "page_jump", "第一页,第五页,第十页,百分之10,百分之30,百分之50,百分之70,百分之90","4",23,"600,1030,380,50")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "狗粮类型 - ", "20,1090,300,60")
	UI:RadioGroup(tansuo_ui, "df_type", "N卡             ,素材","0",30,"0,0,0","600,1090,400,60")
	UI:Label(tansuo_ui, "left", "0,0,0", 30, "素材类型[暂时无效] - ", "20,1150,300,60")
	UI:CheckBoxGroup(tansuo_ui, "egg_color","红蛋,白蛋,蓝蛋,黑蛋","1@2",30,"0,0,0","400,1150,580,60")
	UI:fit(tansuo_ui)
	
	ret_tansuo, res_tansuo = UI:show(tansuo_ui)
	if (ret_tansuo == 0) then
		config_UI()
		return
	end
	
	local mode, mark, hard, secne_move, section, count_mode, win_round, sec_round
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
	if sel[1] == 0 and sel[2] == 0 and sel[3] == 0 then
		sel[1] = 1
		sel[2] = 1
		sel[3] = 1
	end
	
	if res_tansuo.mark == "0" then
		mark = "小怪"
	elseif res_tansuo.mark == "1" then
		mark = "Boss"
	elseif res_tansuo.mark == "2" then
		mark = "无"
	end
	
	if res_tansuo.hard == "0" then
		hard = "普通"
	elseif res_tansuo.hard == "1" then
		hard = "困难"
	end
	
	if mode == "队长" then
		hard = "困难"
	end
	
	if res_tansuo.scene_move == "0" then
		scene_move = "2-3"
	elseif res_tansuo.scene_move == "1" then
		scene_move = "3-4"
	elseif res_tansuo.scene_move == "2" then
		scene_move = "4-5"
	end
	
	section = tonumber(res_tansuo.section) - 1
	
	if res_tansuo.count_mode == "0" then
		count_mode = "战斗"
	elseif res_tansuo.count_mode == "1" then
		count_mode = "章节"
	end
	
	if count_mode == "章节" then
		sel[4] = 1 -- 强制boss
	end
	
	if res_tansuo.win_round == "0" then
		win_round = 3
	elseif res_tansuo.win_round == "1" then
		win_round = 10
	elseif res_tansuo.win_round == "2" then
		win_round = 20
	elseif res_tansuo.win_round == "3" then
		win_round = 30
	elseif res_tansuo.win_round == "4" then
		win_round = 50
	elseif res_tansuo.win_round == "5" then
		win_round = 100
	elseif res_tansuo.win_round == "6" then
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
	
	local captain_auto_invite
	if res_tansuo.captain_auto_invite == "0" then
		captain_auto_invite = "禁用"
	elseif res_tansuo.captain_auto_invite == "1" then
		captain_auto_invite = "寮友"
	elseif res_tansuo.captain_auto_invite == "2" then
		captain_auto_invite = "好友"
	elseif res_tansuo.captain_auto_invite == "3" then
		captain_auto_invite = "跨区"
	end
	
	local captain_pos, nor_attk, full_exp, page_jump, df_type, egg_color
	if res_tansuo.captain_pos == "0" then
		captain_pos = "左前"
	elseif res_tansuo.captain_pos == "1" then
		captain_pos = "正左"
	elseif res_tansuo.captain_pos == "2" then
		captain_pos = "无"
	end
	
	if res_tansuo.nor_attk == "0" then
		nor_attk = 1
	elseif res_tansuo.nor_attk == "1" then
		nor_attk = 0
	end
	
	if res_tansuo.full_exp == "0" then
		full_exp = "alarm"
	elseif res_tansuo.full_exp == "1" then
		full_exp = "change"
	elseif res_tansuo.full_exp == "2" then
		full_exp = "null"
	end
	
	if res_tansuo.page_jump == "0" then
		page_jump = "page1"
	elseif res_tansuo.page_jump == "1" then
		page_jump = "page5"
	elseif res_tansuo.page_jump == "2" then
		page_jump = "page10"
	elseif res_tansuo.page_jump == "3" then
		page_jump = "percent10"
	elseif res_tansuo.page_jump == "4" then
		page_jump = "percent30"
	elseif res_tansuo.page_jump == "5" then
		page_jump = "percent50"
	elseif res_tansuo.page_jump == "6" then
		page_jump = "percent70"
	elseif res_tansuo.page_jump == "7" then
		page_jump = "percent90"
	end
	
	if res_tansuo.df_type == "0" then
		df_type = "N"
	elseif res_tansuo.df_type == "1" then
		df_type = "Egg"
	end
	
	local egg_color_ = {}
	local egg_color = {0, 0, 0, 0}
	for w in string.gmatch(res_tansuo.egg_color,"([^'@']+)") do
		table.insert(egg_color_,w)
	end
	for i = 1, table.getn(egg_color_), 1 do
		if (egg_color_[i] == "0") then
			egg_color[1] = 1
		elseif (egg_color_[i] == "1") then
			egg_color[2] = 1
		elseif (egg_color_[i] == "2") then
			egg_color[3] = 1
		elseif (egg_color_[i] == "3") then
			egg_color[4] = 1
		end
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	while (1) do
		if auto_jjtp_en == 1 then
			tansuo_auto_jjtp(mode, sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type, egg_color)
		else
			tansuo(mode, sel, mark, hard, scene_move, section, count_mode, win_round, sec_round, captain_auto_invite, captain_pos, nor_attk, full_exp, page_jump, df_type, egg_color)
		end
	end
end

function jjtp_UI()
	-- 结界突破
	jjtp_ui = UI:new("jjtp.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(jjtp_ui, "center", "0,0,0", 30, "结界突破", "20,20,960,55")
	UI:ComboBox(jjtp_ui, "mode", "个人突破,阴阳寮突破,个人突破 + 阴阳寮突破", "2", 30, "20,100,960,60")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "公共设置 - ", "20,180,300,60")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "战斗限时 - ", "20,240,300,60")
	UI:ComboBox(jjtp_ui, "round_time", "3分钟,5分钟,10分钟,不限时","1",23,"700,240,280,50")
	UI:CheckBoxGroup(jjtp_ui, "lock","锁定出战阵容","0",30,"0,0,0","20,300,900,60")
	UI:Line(jjtp_ui, "line_common", "100,100,100", 2, 960, "20,360,960,2")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "个人突破设置 - ", "20,370,300,60")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "跳过特殊式神 - ", "20,430,300,60")
	UI:CheckBoxGroup(jjtp_ui, "whr_solo","彼岸花,小僧,日和坊,御馔津","0@1@2",30,"0,0,0","330,430,670,60")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "勋章选择 - ", "20,490,300,60")
	UI:ComboBox(jjtp_ui, "solo_sel", "0 - 5 勋章,3 - 5 勋章,5 - 0 勋章,3 - 0 勋章,随机选择","2",23,"700,490,280,50")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "胜场刷新 - ", "20,550,300,60")
	UI:ComboBox(jjtp_ui, "refresh", "3次,6次,9次","0",23,"700,550,280,50")
	UI:Line(jjtp_ui, "line_common", "100,100,100", 2, 960, "20,610,960,2")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "阴阳寮突破设置 - ", "20,620,300,60")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "跳过特殊式神 - ", "20,680,300,60")
	UI:CheckBoxGroup(jjtp_ui, "whr_pub","彼岸花,小僧,日和坊,御馔津","0@1@2",30,"0,0,0","330,680,670,60")
	UI:Label(jjtp_ui, "left", "0,0,0", 30, "勋章选择 - ", "20,740,300,60")
	UI:ComboBox(jjtp_ui, "pub_sel", "5 - 0 勋章,4 - 0 勋章,3 - 0 勋章,2 - 0 勋章,1 - 0 勋章,0 - 0 勋章","0",23,"700,740,280,50")
	UI:fit(jjtp_ui)
	
	ret_jjtp, res_jjtp = UI:show(jjtp_ui)
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
		round_time = 99999
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
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	-- Disable智能突破
	auto_jjtp_en = 0
	
	while (1) do
		jjtp(mode, whr_solo_out, whr_pub_out, round_time, refresh, solo_sel, pub_sel, lock)
	end
end

function juexing_UI()
	-- 觉醒麒麟
	juexing_ui = UI:new("juexing.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(juexing_ui, "center", "0,0,0", 30, "觉醒麒麟", "20,20,960,55")
	UI:ComboBox(juexing_ui, "mode", "单人模式,队长 - 野队 2人队伍,队长 - 野队 3人队伍,队长 - 固定队 2人队伍,队长 - 固定队 3人队伍,队员 - 野队,队员 - 固定队", "0", 30, "20,100,960,60")
	UI:ComboBox(juexing_ui, "element", "业火轮,风转符,水灵鲤,天雷鼓", "3", 30, "20,180,960,60")
	UI:Label(juexing_ui, "left", "0,0,0", 30, "公共设置 - ", "20,260,300,60")
	UI:Label(juexing_ui, "left", "0,0,0", 30, "请选择觉醒层数 - ", "20,320,300,60")
	UI:ComboBox(juexing_ui, "level", "一层,二层,三层,四层,五层,六层,七层,八层,九层,十层","9",23,"700,320,280,50")
	UI:Label(juexing_ui, "left", "0,0,0", 30, "请选择战斗次数 - ", "20,380,300,60")
	UI:ComboBox(juexing_ui, "round", "3次,10次,20次,30次,50次,100次,无限次数","6",23,"700,380,280,50")
	UI:Label(juexing_ui, "left", "0,0,0", 30, "标记 - ", "20,440,300,60")
	UI:RadioGroup(juexing_ui, "mark", "随机小怪,麒麟Boss,无","2",30,"0,0,0","450,440,550,60")
	UI:CheckBoxGroup(juexing_ui, "lock","锁定出战阵容","0",30,"0,0,0","20,500,900,60")
	UI:Line(juexing_ui, "line_common", "100,100,100", 2, 960, "20,560,960,2")
	UI:Label(juexing_ui, "left", "0,0,0", 30, "队员设置 - ", "20,570,900,60")
	UI:CheckBoxGroup(juexing_ui, "member_auto_group","接受自动组队","0",30,"0,0,0","20,630,900,60")
	UI:CheckBoxGroup(juexing_ui, "fail_and_group","失败后重新寻找队伍","0",30,"0,0,0","20,690,900,60")
	UI:CheckBoxGroup(juexing_ui, "member_to_captain","禁止队员接手队长","0",30,"0,0,0","20,750,900,60")
	UI:Line(juexing_ui, "line_common", "100,100,100", 2, 960, "20,810,960,2")
	UI:Label(juexing_ui, "left", "0,0,0", 30, "队长设置 - ", "20,820,900,60")
	UI:CheckBoxGroup(juexing_ui, "captain_auto_group","开启自动组队","0",30,"0,0,0","20,880,900,60")
	UI:CheckBoxGroup(juexing_ui, "captain_auto_invite","固定队伍自动邀请第一位","0",30,"0,0,0","20,940,500,60")
	UI:ComboBox(juexing_ui, "auto_invite_zone", "本区好友,最近组队,跨区好友","0",23,"700,940,280,50")
	UI:CheckBoxGroup(juexing_ui, "fail_and_recreate","失败后重新建立房间","0",30,"0,0,0","20,1000,900,60")
	UI:fit(juexing_ui)
	
	
	ret_juexing, res_juexing = UI:show(juexing_ui)
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
		group = "野队2人"
	elseif (res_juexing.mode == "2") then
		mode = "组队"
		role = "队长"
		group = "野队3人"
	elseif (res_juexing.mode == "3") then
		mode = "组队"
		role = "队长"
		group = "固定队2人"
	elseif (res_juexing.mode == "4") then
		mode = "组队"
		role = "队长"
		group = "固定队3人"
	elseif (res_juexing.mode == "5") then
		mode = "组队"
		role = "队员"
		group = "野队"
	elseif (res_juexing.mode == "6") then
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
	
	local level = tonumber(res_juexing.level) + 1
	
	local round
	if (res_juexing.round == "0") then
		round = 3
	elseif (res_juexing.round == "1") then
		round = 10
	elseif (res_juexing.round == "2") then
		round = 20
	elseif (res_juexing.round == "3") then
		round = 30
	elseif (res_juexing.round == "4") then
		round = 50
	elseif (res_juexing.round == "5") then
		round = 100
	elseif (res_juexing.round == "6") then
		round = 99999
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
	
	local captain_auto_invite
	if (res_juexing.captain_auto_invite == "0") then
		captain_auto_invite = 1
	else
		captain_auto_invite = 0
	end
	
	local auto_invite_zone
	if (res_juexing.auto_invite_zone == "0") then
		auto_invite_zone = "好友"
	elseif (res_juexing.auto_invite_zone == "1") then
		auto_invite_zone = "最近"
	elseif(res_juexing.auto_invite_zone == "2") then
		auto_invite_zone = "跨区"
	end
	
	local fail_and_recreate
	if (res_juexing.fail_and_recreate == "0") then
		fail_and_recreate = 1
	else
		fail_and_recreate = 0
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	while (1) do
		if (auto_jjtp_en == 1) then
			juexing_auto_jjtp(mode, role, group, element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
		else
			juexing(mode, role, group, element, mark, level, round, lock, member_auto_group, fail_and_group, member_to_captain, captain_auto_group, captain_auto_invite, auto_invite_zone, fail_and_recreate)
		end
	end
end

function yeyuanhuo_UI()
	-- 业原火
	yeyuanhuo_ui = UI:new("yeyuanhuo.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(yeyuanhuo_ui, "center", "0,0,0", 30, "业原火", "20,20,960,55")
	UI:Label(yeyuanhuo_ui, "left", "0,0,0", 30, "贪之阵 - ", "20,100,300,60")
	UI:ComboBox(yeyuanhuo_ui, "round_tan", "0次,10次,20次,30次,50次,100次,全部贪券","0",23,"700,100,280,50")
	UI:Label(yeyuanhuo_ui, "left", "0,0,0", 30, "嗔之阵 - ", "20,160,300,60")
	UI:ComboBox(yeyuanhuo_ui, "round_chen", "0次,10次,20次,30次,50次,100次,全部嗔券","0",23,"700,160,280,50")
	UI:Label(yeyuanhuo_ui, "left", "0,0,0", 30, "痴之阵 - ", "20,220,300,60")
	UI:ComboBox(yeyuanhuo_ui, "round_chi", "0次,10次,20次,30次,50次,100次,全部痴券","6",23,"700,220,280,50")
	UI:CheckBoxGroup(yeyuanhuo_ui, "lock","锁定出战阵容","0",30,"0,0,0","20,280,900,60")
	UI:fit(yeyuanhuo_ui)
	
	ret_yeyuanhuo, res_yeyuanhuo = UI:show(yeyuanhuo_ui)
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
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	while (1) do
		if auto_jjtp_en == 1 then
			yeyuanhuo_auto_jjtp(round_tan, round_chen, round_chi, lock)
		else
			yeyuanhuo(round_tan, round_chen, round_chi, lock)
		end
	end
end

function yuling_UI()
	-- 御灵之境
	yuling_ui = UI:new("yuling.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(yuling_ui, "center", "0,0,0", 30, "御灵之境", "20,20,960,55")
	UI:Label(yuling_ui, "left", "0,0,0", 30, "御灵选择 - ", "20,100,300,60")
	UI:ComboBox(yuling_ui, "select", "暗·神龙       [星期二],暗·白藏主    [星期三],暗·黑豹       [星期四],暗·孔雀       [星期五]","0",23,"650,100,330,50")
	UI:Label(yuling_ui, "left", "0,0,0", 30, "层数选择 - ", "20,160,300,60")
	UI:ComboBox(yuling_ui, "level", "一层,二层,三层","2",23,"650,160,330,50")
	UI:Label(yuling_ui, "left", "0,0,0", 30, "战斗次数 - ", "20,220,300,60")
	UI:ComboBox(yuling_ui, "round", "10次,20次,30次,50次,100次,全部御灵境之钥","5",23,"650,220,330,50")
	UI:CheckBoxGroup(yuling_ui, "doll","自动标记草人","0",30,"0,0,0","20,280,900,60")
	UI:CheckBoxGroup(yuling_ui, "lock","锁定出战阵容","0",30,"0,0,0","20,340,900,60")
	UI:fit(yuling_ui)
	
	
	ret_yuling, res_yuling = UI:show(yuling_ui)
	if (ret_yuling == 0) then
		config_UI()
		return
	end
	
	local sel = -1
	local level = -1
	local round = -1
	local doll = -1
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
		round = 10
	elseif (res_yuling.round == "1") then
		round = 20
	elseif (res_yuling.round == "2") then
		round = 30
	elseif (res_yuling.round == "3") then
		round = 50
	elseif (res_yuling.round == "4") then
		round = 100
	elseif (res_yuling.round == "5") then
		round = 99999
	end
	
	if (res_yuling.doll == "0") then
		doll = 1
	else
		doll = 0
	end
	
	if (res_yuling.lock == "0") then
		lock = 1
	else
		lock = 0
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	while (1) do
		yuling(sel, level, round, doll, lock)
	end
end

function yqfy_UI()
	-- 妖气封印
	yqfy_ui = UI:new("yqfy.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(yqfy_ui, "center", "0,0,0", 30, "妖气封印", "20,20,960,55")
	UI:Label(yqfy_ui, "left", "0,0,0", 30, "妖气选择 - ", "20,100,300,60")
	UI:ComboBox(yqfy_ui, "sel", "跳跳哥哥,椒图,骨女,饿鬼,二口女,海坊主,鬼使黑,小松丸,日和坊","8",23,"650,100,330,50")
	UI:Label(yqfy_ui, "left", "0,0,0", 30, "战斗次数 - ", "20,160,300,60")
	UI:ComboBox(yqfy_ui, "round", "3次,5次,10次,20次,30次,50次,无限次","2",23,"650,160,330,50")
	UI:Label(yqfy_ui, "left", "0,0,0", 30, "战斗标记 - ", "20,220,300,60")
	UI:RadioGroup(yqfy_ui, "mark", "随机小怪,中间大怪,无","2",30,"0,0,0","450,220,550,60")
	UI:fit(yqfy_ui)
	
	ret_yqfy, res_yqfy = UI:show(yqfy_ui)
	if (ret_yqfy == 0) then
		config_UI()
		return
	end
	
	local round, sel, mark
	if res_yqfy.round == "0" then
		round = 3
	elseif res_yqfy.round == "1" then
		round = 5
	elseif res_yqfy.round == "2" then
		round = 10
	elseif res_yqfy.round == "3" then
		round = 20
	elseif res_yqfy.round == "4" then
		round = 30
	elseif res_yqfy.round == "5" then
		round = 50
	elseif res_yqfy.round == "6" then
		round = 99999
	end
	
	if res_yqfy.sel == "0" then
		sel = "跳跳哥哥"
	elseif res_yqfy.sel == "1" then
		sel = "椒图"
	elseif res_yqfy.sel == "2" then
		sel = "骨女"
	elseif res_yqfy.sel == "3" then
		sel = "饿鬼"
	elseif res_yqfy.sel == "4" then
		sel = "二口女"
	elseif res_yqfy.sel == "5" then
		sel = "海坊主"
	elseif res_yqfy.sel == "6" then
		sel = "鬼使黑"
	elseif res_yqfy.sel == "7" then
		sel = "小松丸"
	elseif res_yqfy.sel == "8" then
		sel = "日和坊"
	end
	
	if (res_yqfy.mark == "0") then
		mark = "小怪"
	elseif (res_yqfy.mark == "1") then
		mark = "大怪"
	elseif (res_yqfy.mark == "2") then
		mark = "无"
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	while (1) do
		yqfy(round, sel, mark)
	end
end

function hundredghost_UI()
	-- 百鬼夜行
	hundredghost_ui = UI:new("hundredghost.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(hundredghost_ui, "center", "0,0,0", 30, "百鬼夜行", "20,20,960,55")
	UI:Label(hundredghost_ui, "left", "0,0,0", 30, "战斗次数 - ", "20,100,300,60")
	UI:ComboBox(hundredghost_ui, "round", "3次,5次,10次,20次,30次,50次","4",23,"650,100,330,50")
	UI:Label(hundredghost_ui, "left", "0,0,0", 30, "豆子数量 - ", "20,160,300,60")
	UI:RadioGroup(hundredghost_ui, "num", "5 ~ 7,8 ~ 10","1",30,"0,0,0","650,160,330,60")
	UI:CheckBoxGroup(hundredghost_ui, "invite","自动邀请好友","0",30,"0,0,0","20,220,900,60")
	UI:fit(hundredghost_ui)
	
	ret_hundredghost, res_hundredghost = UI:show(hundredghost_ui)
	if (ret_hundredghost == 0) then
		config_UI()
		return
	end
	
	local round, num, invite
	if res_hundredghost.round == "0" then
		round = 3
	elseif res_hundredghost.round == "1" then
		round = 5
	elseif res_hundredghost.round == "2" then
		round = 10
	elseif res_hundredghost.round == "3" then
		round = 20
	elseif res_hundredghost.round == "4" then
		round = 30
	elseif res_hundredghost.round == "5" then
		round = 50
	end
	
	if res_hundredghost.num == "0" then
		num = "5-7"
	elseif res_hundredghost.num == "1" then
		num = "8-10"
	end
	
	if res_hundredghost.invite == "0" then
		invite = 1
	else
		invite = 0
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	while (1) do
		hundredghost(round, num, invite)
	end
end

function autocake_UI()
	-- 一键每日
	autocake_ui = UI:new("autocake.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(autocake_ui, "center", "0,0,0", 30, "自动樱饼", "20,20,960,55")
	UI:Label(autocake_ui, "left", "0,0,0", 30, "喂食次数 - ", "20,100,300,60")
	UI:ComboBox(autocake_ui, "feed_times", "1次,2次,3次,4次,5次","4",23,"650,100,330,50")
	UI:Line(autocake_ui, "line_common", "100,100,100", 2, 960, "20,160,960,2")
	UI:Label(autocake_ui, "left", "0,0,0", 30, "Tips - ", "20,170,300,60")
	UI:Label(autocake_ui, "left", "0,0,0", 30, "请手动开启[自动挑战], 进入战斗后使用此功能", "20,230,960,60")
	
	UI:fit(autocake_ui)
	
	ret_autocake, res_autocake = UI:show(autocake_ui)
	if (ret_autocake == 0) then
		config_UI()
		return
	end
	
	local feed_times = tonumber(res_autocake.feed_times) + 1
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	settlement_en = 0
	autocake(feed_times)
end

function multimission_UI()
	-- 副本组合
	multimission_ui = UI:new("multimission.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(multimission_ui, "center", "0,0,0", 30, "副本组合", "20,20,960,55")
	UI:fit(multimission_ui)
	
	ret_multimission, res_multimission = UI:show(multimission_ui)
	if (ret_multimission == 0) then
		config_UI()
		return
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function publicity_UI()
	-- 世界喊话
	publicity_ui = UI:new("publicity.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(publicity_ui, "center", "0,0,0", 30, "世界喊话", "20,20,960,55")
	UI:fit(publicity_ui)
	
	ret_publicity, res_publicity = UI:show(publicity_ui)
	if (ret_publicity == 0) then
		config_UI()
		return
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function normalcall_UI()
	-- 普通召唤
	normalcall_ui = UI:new("normalcall.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(normalcall_ui, "center", "0,0,0", 30, "普通召唤", "20,20,960,55")
	UI:Label(normalcall_ui, "left", "0,0,0", 30, "召唤次数 - ", "20,100,300,60")
	UI:ComboBox(normalcall_ui, "tickets", "10,20,30,50,100,200,500,全部召唤","7",23,"700,100,280,50")
	UI:Line(normalcall_ui, "line_common", "100,100,100", 2, 960, "20,160,960,2")
	UI:Label(normalcall_ui, "left", "0,0,0", 30, "Tips - ", "20,170,300,60")
	UI:Label(normalcall_ui, "left", "0,0,0", 30, "请从庭院手动进入召唤界面", "20,230,960,60")
	UI:fit(normalcall_ui)
	
	ret_normalcall, res_normalcall = UI:show(normalcall_ui)
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
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	normalcall(tickets)
end

function offerinquire_UI()
	-- 悬赏查询
	offerinquire_ui = UI:new("offerinquire.dat", width_UI, height_UI, "退出", "返回", "backGround.jpg")
	UI:Label(offerinquire_ui, "center", "0,0,0", 30, "悬赏查询", "20,20,960,55")
	UI:WebView(offerinquire_ui, "offerinquire", "http://m.news.4399.com/yyssy/xsrw", "20, 32, 920, 400")
	UI:fit(offerinquire_ui)
	
	ret_offerinquire, res_offerinquire = UI:show(offerinquire_ui)
	if (ret_offerinquire == 0) then
		config_UI()
		return
	else
		lua_exit()
	end
	return
end

function audition_UI()
	-- 劲舞团
	audition_ui = UI:new("audition.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(audition_ui, "center", "0,0,0", 30, "劲舞团", "20,20,960,55")
	UI:fit(audition_ui)
	
	ret_audition, res_audition = UI:show(audition_ui)
	if (ret_audition == 0) then
		config_UI()
		return
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
end

function autostory_UI()
	-- 自动剧情
	autostory_ui = UI:new("autostory.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(autostory_ui, "center", "0,0,0", 30, "自动剧情", "20,20,960,55")
	UI:Label(autostory_ui, "left", "0,0,0", 30, "Tips - ", "30,100,960,60")
	UI:Label(autostory_ui, "left", "0,0,0", 30, "请在庭院或剧情中使用, 停顿10s+会自动移动场景", "30,160,960,60")
	UI:fit(autostory_ui)
	
	ret_arena, res_arena = UI:show(autostory_ui)
	if (ret_arena == 0) then
		config_UI()
		return
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	autostory()
end

function activityreserve_UI()
	-- 劲舞团
	activityreserve_ui = UI:new("activityreserve.dat", width_UI, height_UI, "退出", "返回", "backGround.jpg")
	UI:Label(activityreserve_ui, "center", "0,0,0", 30, "特殊活动", "20,20,960,55")
	UI:Label(activityreserve_ui, "left", "0,0,0", 30, "活动预留页面, 请返回上一级菜单使用其他功能或退出", "30,100,960,60")
	UI:fit(activityreserve_ui)
	
	ret_activityreserve, res_activityreserve = UI:show(activityreserve_ui)
	if (ret_activityreserve == 0) then
		config_UI()
		return
	else
		lua_exit()
	end
	return
end

function LBSGhostDriving_UI()
	-- 漫展漂移
	LBSGhostDriving_ui = UI:new("LBSGhostDriving.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(LBSGhostDriving_ui, "center", "0,0,0", 30, "漫展漂移", "20,20,960,55")
	UI:Label(LBSGhostDriving_ui, "left", "0,0,0", 30, "Tips - ", "30,100,960,60")
	UI:Label(LBSGhostDriving_ui, "left", "0,0,0", 30, "请在漫展界面中使用", "30,160,960,60")
	UI:fit(LBSGhostDriving_ui)
	
	ret_offerquery, res_offerquery = UI:show(LBSGhostDriving_ui)
	if (ret_offerquery == 0) then
		config_UI()
		return
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	LBSGhostDriving()
end

function superghost_UI()
	-- 超鬼王
	superghost_ui = UI:new("superghost.dat", width_UI, height_UI, "继续", "返回", "backGround.jpg")
	UI:Label(superghost_ui, "center", "0,0,0", 30, "超鬼王", "20,20,960,55")
	UI:Label(superghost_ui, "left", "0,0,0", 30, "Tips - ", "30,100,960,60")
	UI:Label(superghost_ui, "left", "0,0,0", 30, "请在超鬼王界面运行, 详细设置位于[全局设置]-[超鬼王]页面", "30,160,960,60")
	UI:fit(superghost_ui)
	
	ret_offerquery, res_offerquery = UI:show(superghost_ui)
	if (ret_offerquery == 0) then
		config_UI()
		return
	end
	
	local ret_global = global_UI()
	if (ret_global == RET_ERR) then
		return
	end
	
	sg_en = 1
	sg_keep = 1
	sg_fight_sel = "Public"
	mSleep(500)
	superghost()
end
