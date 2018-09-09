function print(data, lastCount)
	if type(data) ~= "table" then
		--Value
		if type(data) == "string" then
			sysLog(string.format("\"%s\"", data))
		else
			sysLog(tostring(data))
		end
	else
		sysLog(tostring(data))
		local count = lastCount or 0
		count = count + 1
		sysLog("{")
		--Table
		for key,value in pairs(data) do
			if type(key) == "string" then
				sysLog(string.format("\"%s\" = %s", key, tostring(value)))
			elseif type(key) == "number" then
				sysLog(string.format("[%d] = %s", key, tostring(value)))
			else
				sysLog(tostring(key))
			end
			--嵌套表格print
			print(value, count)
		end
		sysLog("}")
	end
end

function getRandomList(length)
	local temp = {}
	local chosen_list = {}
	
	for i = 1, length do
		table.insert(chosen_list, i)
	end
	for i = 1, length do
		local r = math.random(1, #chosen_list)
		temp[i] = chosen_list[r]
		table.remove(chosen_list, r)
	end
	return temp
end

function HUD_show_or_hide(HUD,id,text,size,color,bg,pos,x,y,width,height)
	if HUD == "show" then
		showHUD(id,text,size*(1/ratio),color,bg,pos,x,y,width,height)
	end
end

function ran_interv()
	local t = math.random(100, 150)
	mSleep(t)
end

function ran_sleep(t)
	local t = t + 0.25*math.random(-t, t)
	mSleep(t)
end

function show_point(x, y)
	local dbg_button = createHUD()
	if x and y then
		HUD_show_or_hide(HUD,dbg_button, "", 1, "0xff000000", "button.png", 0, x-s, y-s, s*2, s*2)
	end
	mSleep(250)
	hideHUD(dbg_button)
	ran_interv()
end

function ran_touch(id, x, y, ran_x, ran_y)
	local x_r, y_r
	if ((x == nil) or (y == nil)) then
		return
	end
	x_r = x
	y_r = y
	if (ran_x ~= 0 and ran_y ~=0) then
		x_r = x + math.random(-ran_x, ran_x)
		y_r = y + math.random(-ran_y, ran_y)
	end
	ran_interv()
	show_point(x_r, y_r)
	touchDown(id, x_r, y_r)
	ran_interv()
	touchUp(id, x_r, y_r)
	ran_interv()
end

function ran_move(id ,x, y, x_l, y_l, ran)
	local x1_r, y1_r, x2_r, y2_r
	if ((x == nil) or (y == nil)) then
		print("ran move: nil x or y")
		return
	end
	x1_r = x + math.random(-ran, ran)
	y1_r = y + math.random(-ran, ran)
	x2_r = x + x_l + math.random(-ran, ran)
	y2_r = y + y_l + math.random(-ran, ran)
	
	ran_interv()
	touchDown(id, x1_r, y1_r)
	ran_interv()
	touchMove(id, x2_r, y2_r)
	ran_interv()
	touchUp(id, x2_r, y2_r)
	ran_interv()
end

function ran_move_steps(id ,x, y, x_ran, y_ran, x_interv, y_interv, steps)
	x_ = x + math.random(-x_ran, x_ran)
	y_ = y + math.random(-y_ran, y_ran)
	touchDown(0, x_, y_)
	for i = 1, steps do
		touchMove(0, x_+i*x_interv, y_+i*y_interv)
		mSleep(25)
	end
	touchUp(0, x_+steps*x_interv, y_+steps*y_interv)
end