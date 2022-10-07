require('closetCleaner')
include('organizer-lib.lua')
include('displayBox.lua')

-- Local Settings, setting the zones prior to use
toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

capeLocked = false
weaponLocked = false
Weapon_Index = 1



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
	    body="Valorous Mail",
--	    hands={ name="Odyssean Gauntlets", augments={'Accuracy+25 Attack+25','Weapon Skill Acc.+3','DEX+5','Accuracy+1','Attack+12',}},
--		hands="Emicho Gauntlets",
		hands="Sulevia's Gauntlets +2",
	    legs="Pummeler's Cuisses +3",
	    feet="Pummeler's Calligae +3",
	    -- neck="Lissome Necklace",
	    neck="Warrior's Bead Necklace +1",
	    right_ear="Brutal Earring",
	    left_ear="Cessance Earring",
	    left_ring="Flamma Ring",
	    right_ring="Niqmaddu Ring",
	    back=CapeTP,
	    waist="Ioskeha Belt +1"
	}

	sets.DT = {
		ammo="Coiste Bodhar",
	    head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    -- legs="Sakpata's Cuisses",
	    legs="Pummeler's Cuisses +3",
	    feet="Sakpata's Leggings",
	    neck="War. Beads +1",
	    waist="Ioskeha Belt +1",
	    left_ear="Cessance Earring",
	    right_ear="Brutal Earring",
	    left_ring="Defending Ring",
	    -- right_ring="Regal Ring",
	    right_ring="Niqmaddu Ring",
	    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	}

	-- sets.TP.DT = sets.DT

	sets.TP.DT = set_combine(sets.DT, {
		ammo="Coiste Bodhar",
		legs="Sakpata's Cuisses",
		ammo="Seething Bomblet +1"
		-- feet="Pummeler's Calligae +3"
	})

	sets.TP.TH = set_combine(sets.DT, {
		body="Volte Jupon",
		legs="Volte Hose",
		waist="Chaac Belt"
	})


	sets.WS = {
	    ammo="Knobkierrie",
	    -- head="Sulevia's Mask +2",
	    head="Nyame Helm",
	    body="Dagon Breastplate",
	    hands="Sulevia's Gauntlets +2",
	    -- legs="Sulevia's Cuisses +2",
	    -- feet="Sulevia's Leggings +2",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Thrud Earring",
	    right_ring="Regal Ring",
	    left_ring="Niqmaddu Ring",
	}

	sets.WS["Impulse Drive"] = {
	    main="Shining One",
	    sub="Utu Grip",
	    ammo="Knobkierrie",
	    -- head={ name="Agoge Mask +2", augments={'Enhances "Savagery" effect',}},
	    head="Nyame Helm",
	    -- body="Pumm. Lorica +3",
	    body="Hjarrandi Breastplate",
	    -- hands={ name="Odyssean Gauntlets", augments={'Attack+27','Accuracy+8','Weapon skill damage +6%','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
	    hands="Nyame Gauntlets",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets",
	    neck="War. Beads +1",
	    -- waist="Metalsinger Belt",
	    waist="Sailfi Belt +1",
	    left_ear="Thrud Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Regal Ring",
	    right_ring="Niqmaddu Ring",
	    back=CapeWS
	}

	sets.WS["Upheaval"] = {
	    ammo="Knobkierrie",
	    -- head="Agoge Mask +2",
	    head="Nyame Helm",
	    -- neck="Fotia Gorget",
	    neck="Warrior's Bead Necklace +1",
	    ear1="Moonshade Earring",
	    ear2="Telos Earring",
		-- body="Sakpata's Plate",		
		body="Pummeler's Lorica +3",
	    hands="Sakpata's Gauntlets",
	    -- legs="Sakpata's Cuisses",
	    legs="Nyame Flanchard",
	    ring1="Niqmaddu Ring",
	    ring2="Regal Ring",
	    back=CapeWS,
	    -- waist="Fotia Belt",
	    waist="Sailfi Belt +1",
	    -- feet="Pumm. Calligae +3"
	    feet="Sulevia's Leggings +2"
	}

	sets.WS.Upheaval.HighTP = set_combine(sets.WS.Upheaval, {
		neck="War. Beads +1",
		-- hands="Odyssean Gauntlets",
		-- legs="Odyssean Cuisses",
		feet="Sulevia's Leggings +2",
		ear2="Thrud Earring"
	})

	sets.WS.Upheaval.Mid = set_combine(sets.WS.Upheaval, {
		right_ear="Telos Earring",
		legs="Pummeler's Cuisses +3",
		feet="Pummeler's Calligae +3"
	})

	sets.WS["Savage Blade"] = {

	    ammo="Knobkierrie",
	    -- head="Sakpata's Helm",
	    -- head="Agoge Mask +2",
	    neck="War. Beads +1",
	    ear1="Telos Earring",
	    ear2="Moonshade Earring",
	    head="Nyame Helm",
	    body="Sakpata's Breastplate",
	    hands="Sakpata's Gauntlets",
	    legs="Sakpata's Cuisses",
	    -- feet="Sulev. Leggings +2",
	    feet="Nyame Sollerets",
	    ring1="Epaminondas's Ring",
	    ring2="Regal Ring",
	    back=CapeWS,
	    -- back="Cichol's Mantle",
	    waist="Sailfi Belt +1",
	    -- waist="Prosilio Belt +1"
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
		feet="Agoge Calligae +1"
	} 

	sets.JA["Mighty Strikes"] = {
		hands="Agoge Mufflers"
	}

	sets.JA["Warcry"] = {
		head="Agoge Mask +2"
	}

	sets.JA["Tomahawk"] = {
		ammo="Throwing Tomahawk"
	}

	sets.Reraise = {
		head="Twilight Helm",
		body="Twilight Mail"
	}


	sets.Idle = set_combine(sets.TP.DT, {
		-- feet="Hermes' Sandals"
	})

	windower.register_event('zone change', function()
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

		if spell.english == 'Upheaval' then
			if (player.tp < 1250) then 
				equip(sets.WS.Upheaval)
			else
				equip(sets.WS.Upheaval.HighTP)
			end
		
		elseif (sets.WS[spell.english]) then
			equip(sets.WS[spell.english])
		
		else
			equip(sets.WS)
		
		end

	elseif sets.JA[spell.english] then
        equip(sets.JA[spell.english])
    end
end
-- --- MidCast ---
function midcast(spell)
end	

-- --- Aftercast ---



function aftercast(spell)
	equip_current()
end

function equip_current()
    if player.status == 'Engaged' then
        equip_TP()
    else
        equip_idle()
    end
end

function equip_TP()
	equip(sets.Weapons[sets.Weapons.index[Weapon_Index]])
	equip(sets.TP[sets.TP.index[TP_ind]])
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
        idleSet = set_combine(idleSet, {body="Councilor's Garb"})
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

function use_obi(spell, equip_set)
    local use_obi = false
    -- first check to see if any elemental obi rule matches
    if(S{world.day_element, world.weather_element}:contains(spell.element)) then
            -- If at least one matches, try to find out if there is also a weak element involved
            if (world.weather_element == elements.weak_against[spell.element] ) then
                -- If weak weather is involved, but it is only single weather, check to see if use_on_single_conflict is set to true
                if (world.weather_id % 2 == 0 and elements.use_on_single_conflict) then
                    use_obi = true
                end
            elseif (world.day_element == elements.weak_against[spell.element]) then
                -- If weak day is involved check for double weather or single weather + use_on_single_conflict set to true
                if (world.weather_id % 2 == 1 or ( elements[use_on_single_conflict] and world.weather_id % 2 == 0) ) then
                    use_obi = true
                end
            else
				use_obi = true
			end
    end
 
    if (use_obi) then
        equip_set = set_combine(equip_set, { waist = "Hachirin-No-Obi"})
    end
 
    return equip_set
end