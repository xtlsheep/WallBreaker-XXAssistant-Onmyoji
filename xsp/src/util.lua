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

function showHUD_ios_ver(ios_ver,id,text,size,color,bg,pos,x,y,width,height)
	if ios_ver == "ios_other" then
		showHUD(id,text,size,color,bg,pos,x,y,width,height)
	end
end

function ran_interv()
	t = math.random(100, 150)
	mSleep(t)
end

function ran_sleep(t)
	t = t + 0.25*math.random(-t, t)
	mSleep(t)
end

function show_point(x, y)
	debug_button = createHUD()
	if x and y then
		showHUD_ios_ver(ios_ver,debug_button, "", 1, "0xff000000", "button.png", 0, x-s, y-s, s*2, s*2)
	end
	mSleep(200)
	hideHUD(debug_button)
	ran_interv()
end

function ran_touch(id, x, y, ran_x, ran_y)
	if ((x == nil) or (y == nil)) then
		return
	end
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
	if ((x == nil) or (y == nil)) then
		print("ran move: nil x or y")
		return
	end	
	x1_r = x + math.random(0, ran)
	y1_r = y + math.random(0, ran)
	x2_r = x + x_l + math.random(0, ran)
	y2_r = y + y_l + math.random(0, ran)

	ran_interv()
	touchDown(id, x1_r, y1_r)
	ran_interv()
	touchMove(id, x2_r, y2_r)
	ran_interv()
	touchUp(id, x2_r, y2_r)
	ran_interv()
end