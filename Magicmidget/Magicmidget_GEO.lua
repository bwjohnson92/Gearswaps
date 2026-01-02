include('displayBox/displayBox.lua')
include('organizer-lib.lua')
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
nextTH = false
hasPet = false
Idle_Index = 1
-- Start Functions here
-- Gear Sets

capeDT={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Phys. dmg. taken-10%',}}

nukingStaff = "Raetic"

function get_sets()

	sets.Reive = {neck="Arciela's Grace +1"}
	
	sets.Melee = {
	    main="Maxentius",
	    sub="Genmei Shield",
	    range="Dunna",
	    head="Nyame Helm",
	    -- body="Jhakri Robe",
	    body="Nyame Mail",
	    hands="Nyame Gauntlets",
	    -- legs="Querkening Brais",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets",
	    neck="Bagua Charm +1",
		waist="Grunfeld Rope",
	    -- waist="Cetl Belt",
	    left_ear="Digni. Earring",
	    right_ear="Telos Earring",
	    left_ring="Petrov Ring",
	    right_ring="Chirich Ring +1",
	    back={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.WS = {
		head="Nyame Helm",
	    body="Nyame Mail",
	    hands="Nyame Gauntlets",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets",
		neck="Republican Platinum Medal",
		waist="Grunfeld Rope",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		ring1="Petrov Ring",
		ring2="Apate Ring",
		ammo="Oshasha's Treatise",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}}
	}

	sets.Realmrazer = {
	    main="Idris",
	    sub="Genmei Shield",
	    range="Dunna",
	    head="Jhakri Coronal +2",
	    -- body="Jhakri Robe +2",
		body="Nyame Mail",
	    hands="Jhakri Cuffs +2",
	    legs="Jhakri Slops +1",
	    feet="Jhakri Pigaches +2",
	    neck="Imbodla Necklace",
	    waist="Luminary Sash",
	    left_ear="Digni. Earring",
	    right_ear="Ishvara Earring",
	    left_ring="Rajas Ring",
	    right_ring="K'ayres Ring",
	    back={ name="Lifestream Cape", augments={'Geomancy Skill +7','Indi. eff. dur. +17','Pet: Damage taken -4%',}},
	}

	sets.Idle = {}
    sets.Idle.index = {"Standard", "DamageTaken", "PetRegen"}

	sets.Idle.Standard = {main="Idris", sub="Genmei Shield", ranged="Dunna", 
		head="Azimuth Hood +3", neck="Sibyl Scarf", ear1="Etiolation Earring", ear2="Odnowa Earring +1", 
		body="Azimuth Coat +3", hands="Geomancy Mitaines +4", ring1="Defending Ring", ring2="Gelatinous Ring +1",
	    back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},	
		waist="Fucho-no-obi", legs="Assiduity Pants +1", feet="Geomancy Sandals +4"}

	sets.Idle.DamageTaken = set_combine(sets.Idle.Standard, {
	    range="Dunna",
	    head="Nyame Helm",
	    body="Nyame Mail",
	    hands="Geo. Mitaines +4",
	    legs="Nyame Flanchard",
		feet="Bagua Sandals +3",
	    neck={ name="Bagua Charm +1", augments={'Path: A',}},
	    waist="Isa Belt",
	    left_ear="Etiolation Earring",
	    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
	    left_ring="Defending Ring",
	    right_ring="Murky Ring",
	    back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Phys. dmg. taken-10%',}},
	})

	sets.Idle.PetRegen = set_combine(sets.Idle.DamageTaken, {
		main="Idris", sub="Genmei Shield",
		head="Azimuth Hood +3",
		neck="Bagua Charm +1",
		body="Nyame Mail",
		hands="Telchine Gloves",
	    back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},	
		waist="Isa Belt", 
		legs="Telchine Braconi", 
		feet="Bagua Sandals +3",
		lear="Etiolation Earring",
		rear="Odnowa Earring +1"
	})

	sets.Speed = {feet="Geomancy Sandals +4"}	
	
	sets.precast = {}
	sets.midcast = {}

	sets.precast.FastCast = { 
		-- main="Solstice", 
		main="Marin Staff +1",
		sub="Clerisy Strap +1",
		-- sub="Genmei Shield", 
		-- head="Merlinic Hood", 
		head="Nahtirah Hat",
		neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Merlinic Jubbah",hands="Merlinic Dastanas",ring1="Kishar Ring",ring2="Rahab Ring",
		back={ name="Nantosuelta's Cape", augments={'"Fast Cast"+10',}},waist="Witful Belt",legs="Geomancy Pants +3",feet="Merlinic Crackows"}
	
	sets.precast.Dispelga = set_combine(sets.precast.FastCast, {main="Daybreak"})
		
	sets.midcast.EnfeeblingMagic = {
	    main="Daybreak",
	    sub="Ammurapi Shield",
	    ammo="Pemphredo Tathlum",
	    head="Azimuth Hood +3",
	    body="Azimuth Coat +3",
	    hands="Azimuth Gloves +3",
	    legs="Azimuth Tights +3",
	    feet="Bagua Sandals +3",
	    neck="Null Loop",
	    waist="Luminary Sash",
	    left_ear="Digni. Earring",
		right_ear="Regal Earring",
	    left_ring="Kishar Ring",
	    right_ring="Metamorph Ring +1",
	    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast.Dispelga = set_combine(sets.midcast.EnfeeblingMagic, {
		main="Daybreak",
		sub="Ammurapi Shield"
	})

	sets.midcast.ElementalMagic = {
	    main="Marin Staff +1",
	    sub="Enki Strap",
	    ammo="Sroda Tathlum",
	    head="Azimuth Hood +3",
	    body="Azimuth Coat +3",
	    hands="Azimuth Gloves +3",
	    legs="Azimuth Tights +3",
	    feet="Azimuth Gaiters +3",
		neck="Sibyl Scarf",
		waist="Sacro Cord",
	    left_ear="Malignance Earring",
		right_ear="Regal Earring",
	    left_ring="Freke Ring",
	    right_ring="Metamorph Ring +1",
	    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
		
	sets.midcast.EnhancingMagic = {
		head="Befouled Crown",
		ear2="Loquacious Earring",
		-- waist="Cascade Belt"
	}
		
	sets.midcast.IndiSpells = {
	head="Azimuth Hood +3", neck="Bagua Charm +1",
	body="Azimuth Coat +3",	hands="Azimuth Gloves +3", 
	back="Lifestream Cape", legs="Bagua Pants +3",feet="Azimuth Gaiters +3"}
	
	sets.midcast.IndiSelf = set_combine(sets.midcast.IndiSpells, {
		main="Idris"
	})

	sets.midcast.GeoSpells = set_combine(sets.midcast.IndiSelf, {head="Bagua Galero +2",legs="Azimuth Tights +3"})

	sets.midcast.Cure = {main="Tamaxchi",sub="Genmei Shield",ammo="Hydrocera",
			-- head="Gendewitha Caubeen",
			neck="Fylgja Torque",lear="Novia Earring",
			body="Annointed Kalasiris",hands="Telchine Gloves",
			-- ring1="Sirona's Ring",
			ring2="Ephedra Ring",
			-- back="Pahtli Cape",
			waist="Porous Rope",legs="Gyve Trousers",feet="Medium's Sabots"}
		
	sets.TH = {waist="Chaac Belt"}

	sets.MendingHalation = {
		legs="Bagua Pants +3"
	}

	sets.RadialArcana = {
		feet="Bagua Sandals +3"
	}

	sets.LifeCycle = {
	back="Nantosuelta's Cape"
	}
		
	organizer_items = { main="Echo Drops",
			ear1="Reraise Earring",
			ring1="Warp Ring",ring2="Capacity Ring",
			back="Mecistopins Mantle"}

	send_command('bind f9 gs c nextTH')
	send_command('bind f10 gs c changeStaff')

	windower.register_event('zone change', function()
		hasPet = false
		equip(sets.Idle.Standard)
		end)

	sets.Aspir = set_combine(sets.midcast.EnfeeblingMagic, {ring1="Archon Ring"})

	send_command('bind f12 gs c switch pdt')

	text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("DamageTaken", "yellow")
end

function updateTable()
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    update_message()
end
-- --- Precast ---

function precast(spell)
	if (spell.name == "Dispelga") then
		equip(sets.precast.Dispelga)
		return
	end
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') or string.find(spell.type, 'Geomancy') then
		equip(sets.precast['FastCast'])
	end
	if (string.find(spell.type,'Trust')) then
		equip(sets.precast['FastCast'])
	end
	if (string.find(spell.name,'Bolster')) then
		equip({body="Bagua Tunic +2"})
	end
	if (spell.english == "Life Cycle") then 
		equip(sets.LifeCycle)
	end
	if (spell.english == "Mending Halation") then
		equip(sets.MendingHalation)
	end
	if (spell.english == "Radial Arcana") then
		equip(sets.RadialArcana)
	end
	if ( spell.type:lower() == 'weaponskill') then
		equip(sets.WS)
	end
end
-- --- MidCast ---
function midcast(spell)
	set = {}
	if (spell.name == "Dispelga") then
		equip(sets.midcast.Dispelga)
		return
	end
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
				set = set_combine(sets.midcast.Cure, {})
			elseif string.find(spell.english,'Cursna') then
				set = set_combine(sets.precast.FastCast, {})
			elseif string.find(spell.english, 'na') then 
				set = set_combine(sets.precast.FastCast, {})
			elseif string.find(spell.english, 'Erase') then
				set = set_combine(sets.precast.FastCast, {})
			elseif string.find(spell.english, 'Raise') then
				set = set_combine(sets.precast.FastCast	, {})
			else
				set = set_combine(sets.precast.FastCast, {})
			end
		
		elseif string.find(spell.skill,'Enhancing Magic') then
			set = set_combine(sets.midcast.EnhancingMagic, {})

		elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
			set = set_combine(sets.midcast.EnfeeblingMagic, {})
			
		elseif string.find(spell.skill,'Elemental Magic') then
			set = use_obi(spell, sets.midcast.ElementalMagic)
		elseif string.find(spell.skill,'Dark Magic') then
			set = use_obi(spell, sets.Aspir, {})
		else
			set = set_combine(sets.precast.FastCast, {})
		end
	elseif string.find(spell.type, 'Geomancy') then
		if string.find(spell.english, 'Indi') then
			if (spell.target.type == "SELF") then
				set = sets.midcast.IndiSelf
			else 
				set = set_combine(sets.midcast.IndiSpells, {})
			end
		else
			set = set_combine(sets.midcast.GeoSpells, {})
		end
		
	end
	if nextTH then
		equip(set_combine(set, {waist="Chaac Belt"}))
		nextTH = false
	else
		equip(set)
	end
end	

-- --- Aftercast ---

function aftercast(spell)

    if player.status == 'Engaged' then
           equip(sets.Melee)
	else 
		equip_idle()    
	end
	if spell.english == 'Sleep' or spell.english == 'Sleepga' then
		send_command('@wait 50;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
		send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	elseif spell.english == 'Break' or spell.english == 'Breakga' then
		send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	elseif spell.english == 'Repose' then
		send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	end
end

-- Status Change - ie. Resting

function status_change(new,tab)
	if new == 'Engaged' then
		equip(sets['Melee'])
		--disable("Main")
	else
		equip(sets.Idle['Standard'])
		--enable("Main")
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

function pet_change(pet,gain_or_loss)
	status_change(player.status)
	hasPet = gain_or_loss
	if not gain_or_loss then
		add_to_chat(123,'Your luopan has vanished.')
		windower.play_sound('C:/Filepath/Filename.wav') --must be a .wav--
	end
end

function self_command(command)
	if command == 'switch pdt' then
		Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip_idle()
	end
    updateTable()
end

function buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Reive Mark" and gain then
        equip(sets.Reive)
		disable("neck")
	elseif buff == "Reive Mark" and not gain then
		enable("neck")
    end
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
