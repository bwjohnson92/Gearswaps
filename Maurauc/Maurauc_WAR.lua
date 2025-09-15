require('closetCleaner')
include('organizer-lib.lua')
include('displayBox/displayBox.lua')

capeLocked = false
weaponLocked = false
Weapon_Index = 4

-- Start Functions here
-- Gear Sets
function get_sets()

	Ragnarok = "Ragnarok"
	Chango = "Chango"
	Grip = "Utu Grip"

	CapeTP = {name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	CapeWS = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}


	organizer_items = {
		grape="Grape Daifuku"
	}

	sets.Weapons = {}
	sets.Weapons.index = { "Naegling","Chango", "Montante", "Shining One", "Loxotic"}

	sets.Weapons["Chango"] = {
		main="Chango",
		sub="Utu Grip"
	}

	sets.Weapons["Montante"] = {
		main="Montante +1",
		sub="Utu Grip"
	}

	sets.Weapons["Naegling"] = {
		main="Naegling",
		sub="Blurred Shield +1"
	}

	sets.Weapons["Shining One"] = {
		main="Shining One",
		sub="Utu Grip"
	}

	sets.Weapons["Loxotic"] = {
		main="Loxotic Mace +1",
		sub="Blurred Shield +1"
	}

	areas = {}
	areas.AdoulinCity = S{'Eastern Adoulin','Western Adoulin','Mog Garden','Celennia Memorial Library'}

	sets.TP  ={};
	sets.TP.index = {'Standard', 'DT', 'TH', 'Subtle Blow'}
	TP_ind = 2
	sets.TP.Standard = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Boii Lorica +3",
		hands="Sakpata's Gauntlets",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		ear1="Telos Earring",
		ear2="Boii Earring +1",
		ring1="Petrov Ring",
		ring2="Niqmaddu Ring",
	    back=CapeTP,
	}

	sets.DT = {
		-- ammo="Coiste Bodhar",
		ammo="Seething Bomblet +1",
	    head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Sakpata's Cuisses",
	    -- legs="Pummeler's Cuisses +3",
	    feet="Sakpata's Leggings",
	    neck="War. Beads +2",
	    waist="Ioskeha Belt +1",
	    left_ear="Cessance Earring",
	    right_ear="Boii Earring +1",
	    -- left_ring="Moonlight Ring",
		left_ring="Defending Ring",
	    -- right_ring="Regal Ring",
	    right_ring="Niqmaddu Ring",
	    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	}

	-- sets.TP.DT = sets.DT

	sets.TP.DT = set_combine(sets.DT, {
		legs="Sakpata's Cuisses"
	})

	sets.TP.TH = set_combine(sets.DT, {
		body="Volte Jupon",
		legs="Volte Hose",
		waist="Chaac Belt"
	})


	sets.Crit = {
		feet="Boii Calligae +2"
	}

	sets.WS = {
	    ammo="Knobkierrie",
	    -- head="Sulevia's Mask +2",
	    head="Nyame Helm",
	    body="Dagon Breastplate",
	    hands="Boii Mufflers +3",
	    -- legs="Sulevia's Cuisses +2",
	    -- feet="Sulevia's Leggings +2",
	    legs="Nyame Flanchard",
	    feet="Boii Calligae +2",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Thrud Earring",
	    right_ring="Regal Ring",
	    left_ring="Niqmaddu Ring",
	}

	sets.WS["Impulse Drive"] = {
		ammo="Yetshila +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Boii Calligae +3",
		neck="War. Beads +2",
		waist="Sailfi Belt +1",
		ear1="Moonshade Earring",
		ear2="Boii Earring +1",
		ring1="Niqmaddu Ring",
		ring2="Cornelia's ring",
		back=CapeWS,		
	}

	sets.WS["Impulse Drive"].HighTP = { --2000 TP
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		body="Sakpata's Plate",
		hands="Boii Mufflers +3",
		legs="Sakpata's Cuisses",
		feet="Boii Calligae +3",
		neck="War. Beads +2",
		waist="Sailfi Belt +1",
		ear1="Moonshade Earring",
		ear2="Boii Earring +1",
		ring1="Cornelia's ring",
		ring2="Niqmaddu Ring",
		back=CapeWS
	}

	sets.WS["Upheaval"] = {
		ammo="Knobkierrie",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Boii Mufflers +3",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="War. Beads +2",
		waist="Sailfi Belt +1",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		ring1="Niqmaddu Ring",
		ring2="Cornelia's ring",
		back=CapeWS
		
	}

	sets.WS.Upheaval.HighTP = set_combine(sets.WS.Upheaval, {
		ammo="Knobkierrie",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Boii Mufflers +3",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="War. Beads +2",
		waist="Sailfi Belt +1",
		ear1="Thrud Earring",
		ear2="Boii Earring +1",
		ring1="Niqmaddu Ring",
		ring2="Cornelia's ring",
		back=CapeWS
		
	})

	sets.WS.Upheaval.Mid = set_combine(sets.WS.Upheaval, {
		right_ear="Telos Earring",
		legs="Pummeler's Cuisses +3",
		feet="Pummeler's Calligae +3"
	})

	sets.WS["Savage Blade"] = {

		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Boii Mufflers +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Cornelia's Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.WS["Judgment"] = sets.WS["Savage Blade"]

	sets.WS["Resolution"] = {
		ammo="Seeth. Bomblet +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=CapeWS,
		waist="Fotia Belt",
		head="Sakpata's Helm",
		body="Sakpata's Plate",		
	    hands="Sakpata's Gauntlets",
	    legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
	}

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
		body="Boii Lorica +2"
	}

	sets.Reraise = {
		head="Twilight Helm",
		body="Twilight Mail"
	}

	sets.Restraint = {
		-- hands="Boii Mufflers +3"
	}


	sets.Idle = set_combine(sets.TP.DT, {
		-- feet="Hermes' Sandals"
	})

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
	addToTable("(F9)  Weapon", sets.Weapons.index[Weapon_Index])
    addToTable("(F10) TP Set", sets.TP.index[TP_ind])
    addToTable("(F12)", "Reset Gear")
    update_message()
end

-- --- Precast ---

function precast(spell)
	if spell.type:lower() == 'weaponskill' then
		set = {}
		if spell.english == 'Upheaval' then
			if (player.tp < 1250) then 
				set = sets.WS.Upheaval
			else
				set = sets.WS.Upheaval.HighTP
			end
		
		elseif spell.english == "Impulse Drive" then
			if (player.tp < 1750) then
				set = sets.WS["Impulse Drive"]
			else
				set = sets.WS["Impulse Drive"].HighTP
			end


		elseif (sets.WS[spell.english]) then
			set = sets.WS[spell.english]
		
		else
			set = sets.WS
		end

		-- if buffactive["Warcry"] then
			-- set = set_combine(set, {head="Agoge Mask +3"})
		-- end
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
	crit_set_check(spell)
    if player.status == 'Engaged' then
        equip_TP()
    else
        equip_idle()
    end
end

function crit_set_check(spell)
	-- return
	-- add_to_chat(140, spell.english)
	if buffactive['blood rage'] or 
		buffactive['mighty strikes'] or 
		(spell ~= nil and 
		(spell.english:lower() == "blood rage" or 
		spell.english:lower() == "mighty strikes"))
		then
		add_to_chat(140, "locking feet because crit")
		equip(sets.Crit)
		disable("feet")
	else
		enable("feet")
	end
end

function equip_TP()
	equip(sets.Weapons[sets.Weapons.index[Weapon_Index]])
	tp_set = sets.TP[sets.TP.index[TP_ind]]
	if buffactive["restraint"] then
		tp_set = set_combine(tp_set, sets.Restraint)
	end
	equip(tp_set)
end

function equip_idle()
	equip(sets.Weapons[sets.Weapons.index[Weapon_Index]])
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
    elseif command == 'toggle weapon' then
        Weapon_Index = Weapon_Index +1
        if Weapon_Index > #sets.Weapons.index then Weapon_Index = 1 end
        add_to_chat(141, 'Weapon now set to: !!!       '..sets.Weapons.index[Weapon_Index]..'     !!!')
    elseif command == 'equip_current' then
    	equip_current()
    end
    equip_current()
    updateTable()
end