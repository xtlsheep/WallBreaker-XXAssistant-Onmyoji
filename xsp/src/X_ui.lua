-- by xtlsheep
local bb = require("badboy")
local json = bb.json
local width_dev, height_dev, width_cur, height_cur

-- iPhone 5s: 640 x 1136
width_dev = 640 
height_dev = 1136
dpi_dev = 320
width_cur, height_cur = getScreenSize()
dpi_cur = getScreenDPI()

UI = {
}

-- Func
function UI:fit(ui)
	local content
	local value
	local json=require "JSON"
	sf=width_cur/width_dev -- 当前分辨率/开发分辨率
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
	bltb(ui)
end

function UI:new(config, width, height, okname, cancelname, bg)
	local ui = {
		["style"] = "custom",
		["config"] = config,
		["bg"] = bg,
		["width"] = width,
		["height"] = height,
		["cancelname"] = cancelname,
		["okname"] = okname,
		["cancelscroll"] = true,
		["views"] = {
		}
	}
	return ui
end

function UI:insert(ui, control)
	table.insert(ui.views, control)
end

function UI:Label(ui, align, color, size, text, rect)
	local label = {
		["type"] = "Label",
		["align"] = align,
		["color"] = color,
		["size"] = size,
		["text"] = text,
		["rect"] = rect
	}
	UI:insert(ui, label)
end

function UI:RadioGroup(ui, id, list, sel, size, color, rect)
	local radiogroup = {
		["type"] = "RadioGroup",
		["orientation"] = "horizontal",
		["id"] = id,
		["list"] = list,
		["select"] = sel,
		["size"] = size,
		["color"] = color,
		["rect"] = rect
	}
	UI:insert(ui, radiogroup)
end

function UI:Edit(ui, id, align, color, kbtype, prompt, size, text, rect)
	local edit = {
		["type"] = "Edit",
		["id"] = id,
		["align"] = align,
		["color"] = color,
		["kbtype"] = kbtype,
		["prompt"] = prompt,
		["size"] = size,
		["text"] = text,
		["rect"] = rect
	}
	UI:insert(ui, edit)
end

function UI:CheckBoxGroup(ui, id, list, sel, size, color, rect)
	local checkboxgroup = {
		["type"] = "CheckBoxGroup",
		["orientation"] = "horizontal",
		["id"] = id,
		["list"] = list,
		["select"] = sel,
		["size"] = size,
		["color"] = color,
		["rect"] = rect
	}
	UI:insert(ui, checkboxgroup)
end

function UI:ComboBox(ui, id, list, sel, size, rect)
	local combobox = {
		["type"] = "ComboBox",
		["id"] = id,
		["list"] = list,
		["select"] = sel,
		["size"] = size,
		["rect"] = rect
	}
	UI:insert(ui, combobox)
end

function UI:Image(ui, src, rect)
	local image = {
		["type"] = "Image",
		["src"] = src,
		["rect"] = rect
	}
	UI:insert(ui, image)
end

function UI:WebView(ui, id, url, height, witdh, rect)
	local web = {
		["type"] = "Web",
		["id"] = id,
		["url"] = url,
		["height"] = height,
		["width"] = witdh,
		["rect"] = rect
	}
	UI:insert(ui, web)
end

function UI:Line(ui, id, color, height, width, rect)
	local line = {
		["type"] = "Line",
		["id"] = id,
		["color"] = color,
		["height"] = height,
		["width"] = width,
		["rect"] = rect
	}
	UI:insert(ui, line)
end

function UI:show(ui)
	return showUI(json.encode(ui))
end