
defaults = T{}
cols = {}
cols.white = {R=255,G=255,B=255}
cols.green = {R=0,G=255,B=0}
cols.red = {R=255,G=0,B=0}
cols.yellow = {R=255,G=255,B=0}
cols.blue = {R=0,G=0,B=255}
cols.bluelite = {R=60,G=60,B=255}

defaults.pos_x = -300
defaults.pos_y = -300
defaults.font_size = 11
defaults.bg_alpha = 255

function makeColour(colour)
	return "\\cs("..tostring(colour.R)..","..tostring(colour.G)..","..tostring(colour.B)..")"
end

green_col = makeColour(cols.green)
red_col = makeColour(cols.red)
yellow_col = makeColour(cols.yellow)
blue_col = makeColour(cols.blue)
bluelite_col = makeColour(cols.bluelite)

white_col = makeColour(cols.white)


msgKeys = {}
msgTable = {}

textColourKeys = {}
textColourPairs = {}

colourMaps = {}

function setupColours()
	colourMaps["yellow"] = yellow_col
	colourMaps["green"] = green_col
	colourMaps["red"] = red_col
	colourMaps["blue"] = blue_col
	colourMaps["bluelite"] = bluelite_col
	colourMaps["white"] = white_col
end

function addToTable(key, value)
	if value == nil then
		value = ""
	end
	if (noValue(key, msgKeys)) then
		table.insert(msgKeys, key)
	end
	msgTable[key] = value
end

function clearTable()
	clear_table()
end

function clear_table()
	for k in pairs (msgKeys) do
	    msgKeys[k] = nil
	end
end

function addTextColorPair(key, colour)
	return addTextColourPair(key, colour)
end

function addTextColourPair(key, colour)
	if (noValue(key, textColourKeys)) then
		table.insert(textColourKeys, key)
		textColourPairs[key] = colour
	end
end

function noValue(key, inputTable)
	for _, k in ipairs(inputTable) do
		if (k == key) then
			return false
		end
	end
	return true
end

function text_setup(settings)
	setupColours()
	addTextColourPair("true", "green")
	addTextColourPair("false", "red")
	addTextColorPair("HighMP", "blue")
	addTextColorPair("PDT", "yellow")
	addTextColorPair("DT", "yellow")
	addTextColorPair("Standard", "green")


	msg_settings = {}
	msg_settings.pos = {}
	msg_settings.pos.x = defaults.pos_x
	msg_settings.pos.y = defaults.pos_y
	msg_settings.text = {}
	msg_settings.text.font = "Consolas"
	msg_settings.text.size = 11
	msg_settings.flags = {}

	if (settings ~= nil) then
		for k,v in pairs(settings) do
			msg_settings[k] = v
		end
	end

	if (msg_settings.pos.x < 0) then
		msg_settings.flags.right = true
	end
	if (msg_settings.pos.y < 0) then
		msg_settings.flags.bottom = true
	end

	msg_box = texts.new('displayBox', msg_settings)
	msg_box:show()
	update_message()
end

function update_message()
	msg = ""
	for _, k in ipairs(msgKeys) do
		val = msgTable[k]
		msg = msg..k
		if (val ~= "") then
			msg = msg..": "..colourMsg(val)..'\n'
		end
	end
	msg_box:text(msg)

	msg_box:show()
end

function print_table() 
	for _, k in ipairs(msgKeys) do
		add_to_chat(140,k.." "..string.format(msgTable[k] and 'true' or 'false'))
	end
end

function colourMsg(msg)
	if (type(msg) == "boolean") then
		msg = string.format(msg and 'true' or 'false')
	end
	if (noValue(msg, textColourKeys) == false) then
		return colourMaps[textColourPairs[msg]]..msg..colourMaps["white"]
 	end
	return msg
end

text_setup()