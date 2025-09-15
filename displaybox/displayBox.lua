frame_time = 0
config = require('config')


-- COLOURS --

function make_colour(colour)
	return "\\cs("..tostring(colour.R)..","..tostring(colour.G)..","..tostring(colour.B)..")"
end
colour_maps = {}

textColourKeys = {}
textColourPairs = {}

function setup_colours()
	colour_maps["yellow"] = make_colour({R=255,G=255,B=0})
	colour_maps["green"] = make_colour({R=0,G=255,B=0})
	colour_maps["red"] = make_colour({R=255,G=0,B=0})
	colour_maps["blue"] = make_colour({R=0,G=0,B=255})
	colour_maps["bluelite"] = make_colour({R=120,G=120,B=255})
	colour_maps["white"] = make_colour({R=255,G=255,B=255})
end

function default_colours()
	add_text_colour_pair("true", "green")
	add_text_colour_pair("false", "red")
	add_text_colour_pair("HighMP", "bluelite")
	add_text_colour_pair("PDT", "yellow")
	add_text_colour_pair("DT", "yellow")
	add_text_colour_pair("Standard", "green")
end


-- SETTINGS --

default_settings = {}
default_settings.interval = .2
default_settings.pos = {}
default_settings.pos.x = 1850
default_settings.pos.y = 750
default_settings.text = {}
default_settings.text.font = "Consolas"
default_settings.text.size = 11
default_settings.flags = {} --bottom/right needed if negative pos? Unable to drag if so

settings = config.load("./data/displayBox/settings.xml", default_settings)

msg_box = texts.new('displayBox', settings)
msg_box:show()

-- INTERNALS --

msg_keys = {}
msg_table = {}

-- LOGIC --

function addToTable(k, v) 
	return add_to_table(k,v)
end

function add_to_table(key, value)
	if value == nil then
		value = ""
	end
	if (no_value(key, msg_keys)) then
		table.insert(msg_keys, key)
	end
	msg_table[key] = value
end

function clearTable()
	clear_table()
end

function clear_table()
	for k in pairs (msg_keys) do
	    msg_keys[k] = nil
	end
end

function addTextColorPair(key, colour)
	return add_text_colour_pair(key, colour)
end

function addTextColourPair(key, colour)
	return add_text_colour_pair(key, colour)
end

function add_text_colour_pair(key, colour)
	if (no_value(key, textColourKeys)) then
		table.insert(textColourKeys, key)
		textColourPairs[key] = colour
	end
end

function no_value(key, inputTable)
	for _, k in ipairs(inputTable) do
		if (k == key) then
			return false
		end
	end
	return true
end

function text_setup()
	setup_colours()
	default_colours()

	create_message_box()

	update_message()
end

function create_message_box()
	msg_settings = {}
	msg_settings.pos = {}
	msg_settings.pos.x = settings.pos.x
	msg_settings.pos.y = settings.pos.y
	msg_settings.text = {}
	msg_settings.text.font = "Consolas"
	msg_settings.text.size = 11
	msg_settings.flags = {}

	if (msg_settings.pos.x < 0) then
		msg_settings.flags.right = true
	end
	if (msg_settings.pos.y < 0) then
		msg_settings.flags.bottom = true
	end

	msg_box = texts.new('displayBox', msg_settings)
	msg_box:show()
end

function update_message()
	msg = ""
	for _, k in ipairs(msg_keys) do
		val = msg_table[k]
		msg = msg..k
		if (val ~= "") then
			msg = msg..": "..colourMsg(val)..'\n'
		end
	end
	msg_box:text(msg)
end

function colourMsg(msg)
	if (type(msg) == "boolean") then
		msg = string.format(msg and 'true' or 'false')
	end
	if (no_value(msg, textColourKeys) == false) then
		return colour_maps[textColourPairs[msg]]..msg..colour_maps["white"]
 	end
	return msg
end

windower.register_event('prerender', function()
    local curr = os.clock()
    if curr > frame_time + settings.interval then
        frame_time = curr
        update_message()
    end
end)

function save_settings()
	config.save(settings, "all")
end

text_setup()