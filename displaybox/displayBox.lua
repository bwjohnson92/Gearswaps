frame_time = 0
json = require "displaybox/json_lib"
files = require 'files'

-- SETTINGS --

default_settings = {}
default_settings.interval = 5
default_settings.pos = {}
default_settings.pos.x = 1850
default_settings.pos.y = 750
default_settings.text = {}
default_settings.text.font = "Consolas"
default_settings.text.size = 11
default_settings.flags = {} --bottom/right needed if negative pos? Unable to drag if so

char_settings = {}
settings = {}
local_x = 0
local_y = 0

player = windower.ffxi.get_player()
name = windower.ffxi.get_player().name
job = player.main_job
file_name = ""
should_update = false
setup = false

function write_file_if_not_present()
	job = player.main_job

	file_name = "./data/displayBox/"..name..".json"
	f = files.exists(file_name)
	if not f then
		add_to_chat(140, "File not found")
		f = files.new(file_name)
		char_settings[job] = default_settings
		f:write(json.encode(char_settings))
	end
end

function read_settings()
	job = player.main_job

	f = files.read(file_name)
	if not f then
		settings = default_settings
		return
	end
	char_settings = json.decode(f)

	if not char_settings[job] then
		settings = default_settings
		write_settings(job)
	else
		add_to_chat(140, "Found display box settings for "..job)
	end

	settings = char_settings[job]
	local_x = settings.pos.x
	local_y = settings.pos.y
end

function write_settings()
	job = player.main_job

	add_to_chat(140, "Writing settings")
	char_settings[job] = settings
	files.write(file_name, json.encode(char_settings))
end

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

-- INTERNALS --

msg_box = {}

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
	setup = false
	job = player.main_job
	coroutine.schedule(function ()
		add_to_chat(140, "Setting up")
		setup = true
		job = windower.ffxi.get_player().main_job
		write_file_if_not_present()
		read_settings()	
	
		msg_box = texts.new('displayBox', settings)
		msg_box:show()
	
		setup_colours()
		default_colours()
	
		update_message()
	end, 2)
end


function update_message()
	if (setup == false) then return end
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


function prerender_func()
	local curr = os.clock()

	--Definitely don't want to try and save when we're not setup
	if (setup == false) then 
		frame_time = curr
		return 
	end
	
	pos_x, pos_y = texts.pos(msg_box)
	if not (pos_x == local_x and pos_y == local_y) then 
		local_x = pos_x
		local_y = pos_y
		should_update = true
	end
    if curr > frame_time + settings.interval then
        frame_time = curr
		if (should_update) then
			write_settings(player.main_job)
			should_update = false
		end
    end
end

windower.register_event('prerender', prerender_func)

text_setup()