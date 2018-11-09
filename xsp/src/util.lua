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
	local t = t + 0.2*math.random(-t, t)
	mSleep(t)
end

function show_point(x, y, interv)
	HUD_show_or_hide(HUD,hud_button, "", 1, "0xff000000", "button.png", 0, x-s, y-s, s*2, s*2)
	mSleep(interv)
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
	
	hud_button = createHUD()
	show_point(x_r, y_r, 250)
	hideHUD(hud_button)
	ran_interv()
	touchDown(id, x_r, y_r)
	ran_sleep(200)
	touchUp(id, x_r, y_r)
end

function ran_move_curve(id, start_point_X, start_point_Y, end_point_X, end_point_Y, ran)
	local function bezier_interpolation(t, init_points, init_points_num)
		local curve_X_tmp = {}
		local curve_Y_tmp = {}
		
		for i = 1, init_points_num - 1 do
			for j = 0, init_points_num - i - 1 do
				if i == 1 then
					curve_X_tmp[j+1] = init_points[j+1].X*(1-t) + init_points[j+2].X*t
					curve_Y_tmp[j+1] = init_points[j+1].Y*(1-t) + init_points[j+2].Y*t
				else
					curve_X_tmp[j+1] = curve_X_tmp[j+1]*(1-t) + curve_X_tmp[j+2]*t
					curve_Y_tmp[j+1] = curve_Y_tmp[j+1]*(1-t) + curve_Y_tmp[j+2]*t
				end
			end
		end
		return math.floor(curve_X_tmp[1]), math.floor(curve_Y_tmp[1])
	end
	
	local start_X_ran, start_Y_ran, end_X_ran, end_Y_ran
	local step, t
	local curve_X = {}
	local curve_Y = {}
	local init_points
	local mid_point_X, mid_point_Y
	local control_point_X, control_point_Y
	local ran_X, ran_Y
	local distance, distance_X, distance_Y
	local curve_points
	
	start_X_ran = start_point_X + math.random(-ran, ran)
	start_Y_ran = start_point_Y + math.random(-ran, ran)
	end_X_ran = end_point_X + math.random(-ran, ran)
	end_Y_ran = end_point_Y + math.random(-ran, ran)
	print(string.format("start point (%d, %d) - end point (%d, %d)", start_X_ran, start_Y_ran, end_X_ran, end_Y_ran))
	
	mid_point_X = math.abs(start_X_ran + end_X_ran)/2
	mid_point_Y = math.abs(start_Y_ran + end_Y_ran)/2
	print(string.format("mid point (%d, %d)", mid_point_X, mid_point_Y))
	
	distance_X = math.abs(start_X_ran - end_X_ran)
	distance_Y = math.abs(start_Y_ran - end_Y_ran)
	distance = math.sqrt(distance_X^2 + distance_Y^2)
	print(string.format("distance %d(X - %d, Y - %d)", distance, distance_X, distance_Y))
	
	ran_control = distance/6
	control_point_X = math.floor(mid_point_X + math.random(-ran_control, ran_control))
	control_point_Y = math.floor(mid_point_Y + math.random(-ran_control, ran_control))
	print(string.format("control point (%d, %d)", control_point_X, control_point_Y))
	
	init_points = {{X = start_X_ran, Y = start_Y_ran}, {X = control_point_X, Y = control_point_Y}, {X = end_X_ran, Y = end_Y_ran}}
	
	curve_points = math.floor(distance/25)
	step = 1/curve_points
	t = 0
	
	for i = 0, curve_points - 1 do
		curve_X[i+1], curve_Y[i+1] = bezier_interpolation(t, init_points, 3)
		t = t + step
	end
	
	hud_button = createHUD()
	touchDown(id, curve_X[1], curve_Y[1])
	show_point(curve_X[1], curve_Y[1], 150)
	for i = 2, curve_points - 1 do
		show_point(curve_X[i], curve_Y[i], 10)
		touchMove(id, curve_X[i], curve_Y[i])
	end
	show_point(curve_X[curve_points], curve_Y[curve_points], 150)
	touchUp(id, curve_X[curve_points], curve_Y[curve_points])
	hideHUD(hud_button)
end