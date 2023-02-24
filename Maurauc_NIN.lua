require('closetCleaner')
include('organizer-lib.lua')
include('displayBox.lua')

capeLocked = false
weaponLocked = false

-- Start Functions here
-- Gear Sets

wsProcs = S{'Cyclone', 'Energy Drain', 'Red Lotus Blade', 'Seraph Blade', 'Freezebite', 'Shadow of Death', 'Raiden Thrust', 'Blade: Ei', 'Tachi: Jinpu', 'Tachi: Koki', 'Seraph Strike', 'Earth Crusher', 'Sunburst'}
MABWS = S{'Sanguine Blade'}

function get_sets()

	Ragnarok = "Ragnarok"
	Chango = "Chango"
	Grip = "Utu Grip"

	CapeTP = {name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	CapeWS = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}


	organizer_items = {
		grape="Grape Daifuku"
	}

	areas = {}
	areas.AdoulinCity = S{'Eastern Adoulin','Western Adoulin','Mog Garden','Celennia Memorial Library'}

	sets.TP  ={};
	sets.TP.index = {'Standard'}
	TP_ind = 1
	sets.TP.Standard = {
	    ammo="Hasty Pinion +1",
	    head="Malignance Chapeau",
	    body="Volte Jupon",
		hands={ name="Herculean Gloves", augments={'Magic Damage +5','Crit.hit rate+1','"Treasure Hunter"+2','Accuracy+15 Attack+15','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Loricate Torque +1",
	    left_ear="Cessance Earring",
	    right_ear="Crepuscular Earring",
	    left_ring="Petrov Ring",
	    right_ring="Rajas Ring",
	    -- back=CapeTP,
	    waist="Ioskeha Belt +1"
	}

	-- sets.TP.DT = sets.DT


	sets.Crit = {
		feet="Boii Calligae +2"
	}

	sets.WS = {
	    ammo="Knobkierrie",
	    head="Nyame Helm",
	    -- body="Nyame Mail",
		body="Mummu Jacket +2",
	    hands="Nyame Gauntlets",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Thrud Earring",
	    right_ring="Regal Ring",
	    left_ring="Niqmaddu Ring"
	}

	sets.WS.MAB = set_combine(sets.WS, {
		head=empty,
		body=empty,
		hands=empty,
		legs=empty,
		feet=empty
	})

	sets.WS.MABGood = set_combine(sets. WS, {
		head="Pixie Hairpin +1",
		right_ear="Friomisi Earring",
		right_ring="Archon Ring",
		left_ring="Dingir Ring"
	})

	sets.JA = {}

	sets.JA["Aggressor"] = {
		head="Pummeler's Mask +1"
	}

	sets.JA["Berserk"] = {
		body="Pummeler's Lorica +3",
		feet="Agoge Calligae +3"
	} 

	sets.JA["Mighty Strikes"] = {
		hands="Agoge Mufflers"
	}

	sets.JA["Warcry"] = {
		head="Agoge Mask +3"
	}

	sets.JA["Tomahawk"] = {
		ammo="Throwing Tomahawk"
	}

	sets.JA["Blood Rage"] = {
		body="Boii Lorica +1"
	}

	sets.Reraise = {
		head="Twilight Helm",
		body="Twilight Mail"
	}

	sets.Restraint = {
		-- hands="Boii Mufflers +2"
	}


	sets.Idle = set_combine(sets.TP, {
		-- feet="Hermes' Sandals"
	})

	sets.FC = {
		head="Herculean Helm",
		body="Rawhide Vest",
		hands="Leyline Gloves",
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		right_ear="Loquacious Earring"
	}

	windower.register_event('zone change', function()
		enable("feet")
		equip(customize_idle_set(sets.Idle))
	end)

	send_command('bind f9 gs c toggle weapon')
    send_command('bind f10 gs c toggle TP set')
    send_command('bind f12 gs c equip current')

 	text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("DT", "yellow")
end

function updateTable()
    addToTable("(F10) TP Set", sets.TP.index[TP_ind])
    addToTable("(F12)", "Reset Gear")
    update_message()
end

-- --- Precast ---

function precast(spell)
	if (spell.type:lower() == 'Ninjutsu') then
		equip(sets.FC)
	elseif spell.type:lower() == 'weaponskill' then
		set = {}
		if (sets.WS[spell.english]) then
			set = sets.WS[spell.english]
		
		elseif wsProcs:contains(spell.name) then
			add_to_chat(140, "Magic Set")
			set = sets.WS.MAB
		elseif MABWS:contains(spell.name) then
			set = sets.WS.MABGood
		else
			set = sets.WS
		end

		equip(set)
	elseif sets.JA[spell.english] then
        equip(sets.JA[spell.english])
    end
end
-- --- MidCast ---
function midcast(spell)
end	

-- --- Aftercast ---



function aftercast(spell)
	equip_current(spell)
end

function equip_current(spell)
    if player.status == 'Engaged' then
        equip_TP()
    else
        equip_idle()
    end
end

function equip_TP()
	tp_set = sets.TP[sets.TP.index[TP_ind]]
	equip(tp_set)
end

function equip_idle()
	equip(customize_idle_set(sets.Idle))
end

function status_change(new,tab)
	if new == 'Engaged' then
		equip_TP()
	else
		equip_idle()
	end
end

function customize_idle_set(idleSet)
    if areas.AdoulinCity:contains(world.area) then
        idleSet = set_combine(idleSet, {
			-- body="Councilor's Garb"
		})
    end
 
    return idleSet
end

function self_command(command)
	 if command == 'toggle TP set' then
        TP_ind = TP_ind + 1
        if TP_ind > #sets.TP.index then TP_ind = 1 end
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'equip_current' then
    	equip_current()
    end
    equip_current()
    updateTable()
end