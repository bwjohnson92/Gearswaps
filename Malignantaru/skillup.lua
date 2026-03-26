include('displayBox/displayBox.lua')
include('organizer-lib.lua')

go = false

function get_sets()

	sets.Idle = {
        sub="Genmei Shield", ranged="Dunna", 
		head="Befouled Crown", neck="Sibyl Scarf", ear1="Etiolation Earring", ear2="Odnowa Earring +1", 
		body="Artsieq Jubbah", hands="Volte Gloves", ring1="Defending Ring", ring2="Gelatinous Ring +1",
		waist="Fucho-no-obi", legs="Assiduity Pants +1", feet="Geomancy Sandals +4"
    }

	sets.precast = { 
		-- main="Solstice", 
        ranged="Eminent Bell",
		head="Nahtirah Hat",
		neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Merlinic Jubbah",hands="Volte Gloves",ring1="Kishar Ring",ring2="Rahab Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Regal Pumps +1"
    }

    sets.midcast = set_combine(sets.precast, {
        main=empty,
        body="Temachtiani Shirt",
        hands="Temachtiani Gloves",
        legs=empty,
        feet=empty,
        head=empty
    })

	send_command('bind f12 gs c switch pdt')

	text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()

end

function updateTable()

end
-- --- Precast ---

function precast(spell)
    equip(sets.precast)
end
-- --- MidCast ---
function midcast(spell)
    equip(sets.midcast)
end	

-- --- Aftercast ---

function aftercast(spell)
	equip(sets.Idle)
    send_command('wait 3;gs c next_action')
end

function next_action()
    -- elemental_magic()
    enfeebling_magic()
    -- dark_magic()
    -- geomancy()
end

function elemental_magic()
    if not buffactive["Food"] then
        send_command('input /item "B.E.W. Pitaru" <me>')
    elseif not buffactive["Colure Active"] then
        queue("Indi-Refresh")
    else
        queue("Stone")
    end
end

function enfeebling_magic()
    if not buffactive["Food"] then
        send_command('input /item "B.E.W. Pitaru" <me>')
    elseif not buffactive["Colure Active"] then
        queue("Indi-Refresh")
    else
        queue("Dia")
    end
end

function dark_magic()
    if not buffactive["Food"] then
        send_command('input /item "B.E.W. Pitaru" <me>')
    elseif not buffactive["Colure Active"] then
        queue("Indi-Refresh")
    else
        queue("Bio II")
    end
end

function geomancy()
    if not buffactive["Food"] then
        send_command('input /item "B.E.W. Pitaru" <me>')
    elseif not buffactive["Colure Active"] then
        queue("Indi-Refresh")
    elseif (hasPet) then
        full_circle()
    else
        local spell_recasts = windower.ffxi.get_spell_recasts()
        if spell_recasts[814] == 0 then
            queue("Geo-Voidance August")
        else
            queue("Geo-Precision August")
        end
    end
end

function full_circle()
    send_command('input /ma "Full Circle" <me>')
end

function queue(spell)
    if (go) then
        send_command(spell)
    end
end

function self_command(command)
    if (command == "start") then
        go = true
        add_to_chat(123, 'Starting skillup loop')
        aftercast()
    elseif (command == "stop") then
        go = false
        add_to_chat(123, 'Stopping skillup loop')
    elseif (command == "next_action") then
        next_action()
    end
end
    
function pet_change(pet,gain_or_loss)
	hasPet = gain_or_loss
	if not gain_or_loss then
		add_to_chat(123,'Your luopan has vanished.')
		windower.play_sound('C:/Filepath/Filename.wav') --must be a .wav--
	end
end

function equip_idle()

	if (not hasPet and sets.Idle.index[Idle_Index] == "PetRegen") then
		add_to_chat(123, 'Equipping '..sets.Idle.index[1])
		equip(sets.Idle[sets.Idle.index[1]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_Index]])
		add_to_chat(123, 'Equipping '..sets.Idle.index[Idle_Index])

	end
end
