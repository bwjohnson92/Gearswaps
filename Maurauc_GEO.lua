include('displayBox.lua')
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

-- capeDT={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Phys. dmg. taken-10%',}}
capeRegen ={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}}

AF = {}
AF.Head = "Geomancy Galero +2"
AF.Body = "Geomancy Tunic +1"
AF.Hands = "Geomancy Mitaines"
AF.Legs = "Geomancy Pants"
AF.Feet = "Geomancy Sandals +2"

Relic = {}
Relic.Head = "Bagua Galero +2"
Relic.Body = "Bagua Tunic +2"
Relic.Hands = "Bagua Mitaines +2"
Relic.Legs = "Bagua Pants +2"
Relic.Feet = "Bagua Sandals +3"

Empyrean = {}
Empyrean.Head = "Azimuth Hood"
Empyrean.Body = "Azimuth Coat"
Empyrean.Hands = "Azimuth Gloves"
Empyrean.Legs = "Azimuth Tights"
Empyrean.Feet = "Azimuth Gaiters"

nukingStaff = "Raetic"

function get_sets()

	sets.nukingStaves = {}
	sets.nukingStaves.Raetic = "Raetic Staff +1"
	sets.nukingStaves.Grioavolr = { name="Grioavolr", augments={'INT+9','Mag. Acc.+20','"Mag.Atk.Bns."+28','Magic Damage +8',}}

	sets.Reive = {neck="Arciela's Grace +1"}
	
	sets.Melee = {
	    head="Nyame Helm",
	    body="Jhakri Robe +2",
	    hands="Nyame Gauntlets",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets",
	    neck="Clotharius Torque",
	    waist="Cetl Belt",
	    left_ear="Digni. Earring",
	    right_ear="Ishvara Earring",
	    left_ring="Rajas Ring",
	    right_ring="K'ayres Ring",
	    back={ name="Lifestream Cape", augments={'Geomancy Skill +7','Indi. eff. dur. +17','Pet: Damage taken -4%',}},
	}

	sets.WS = {
		head="Nyame Helm",
	    body="Jhakri Robe +2",
	    hands="Nyame Gauntlets",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Cessance Earring",
		left_ring="Metamorph Ring +1",
		right_ring="Epaminondas's Ring"
	}

	sets.Idle = {}
    sets.Idle.index = {"Standard", "DamageTaken", "PetRegen"}

	sets.Idle.Standard = {    
		main="Idris",
	    sub="Genmei Shield",
		range="Dunna",
	    head="Telchine Cap",
	    body="Jhakri Robe +2",
	    hands="Volte Gloves",
	    legs="Assid. Pants +1",
	    feet="Telchine Pigaches",
	    neck="Loricate Torque +1",
	    waist="Sacro Cord",
	    left_ear="Malignance Earring",
	    right_ear="Barkaro. Earring",
		ring1="Defending Ring", 
		ring2="Gelatinous Ring +1",
	    back="Nantosuelta's Cape"
	}

	sets.Idle.DamageTaken = set_combine(sets.Idle.Standard, {
		main="Malignance Pole",
		head="Nyame Helm",
		sub="Alber Strap",
		hands="Nyame Gauntlets",
		waist="Slipor Sash",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		back=capeRegen,
		waist="Gishdubar Sash",
	})

	sets.Idle.PetRegen = set_combine(sets.Idle.DamageTaken, {
		main="Idris", sub="Genmei Shield",
		-- head="Azimuth Hood +1",
		head="Telchine Cap",
		neck="Bagua Charm +1",
		body="Telchine Chasuble", 
		hands="Telchine Gloves",
    	back="Nantosuelta's Cape",
		waist="Isa Belt", 
		legs="Telchine Braconi", 
		feet=Relic.Feet,
		feet="Telchine Pigaches",
		lear="Handler's Earring +1",
		rear="Handler's Earring"
	})

	sets.Speed = {feet=AF.Feet}	
	
	sets.precast = {}
	sets.midcast = {}

	sets.precast.FastCast = { main="Idris", sub="Genmei Shield", 
		head="Nahtirah Hat", neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Shango Robe",hands="Volte Gloves",ring1="Kishar Ring",ring2="Weatherspoon Ring +1",
		back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Merlinic Crackows"}
	
	sets.precast.FastCure = set_combine(sets.precast.FastCast, {	ear2="Loquacious Earring",
		ring2="Rahab Ring",	back="Disperser's Cape",waist="Witful Belt",legs=AF.Legs})

	--sets.Melee = {main="Buramenk'ah",sub="Genmei Shield",
	--	head="Umuthi Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
	--	body="Artsieq Jubbah",hands="Umuthi Gloves", 
	--	back="Atheling Mantle",waist="Cetl Belt", legs="Hagondes Pants",feet="Umbani Boots"}	
		
	sets.midcast.EnfeeblingMagic = {
	    main="Contemplator +1",
	    sub="Niobid Strap",
	    ammo="Pemphredo Tathlum",
	    head="Amalric Coif +1",
	    body="Amalric Doublet +1",
	    legs="Psycloth Lappas",
	    feet="Jhakri Pigaches +2",
	    neck="Erra Pendant",
	    waist="Luminary Sash",
	    left_ear="Digni. Earring",
	    right_ear="Barkaro. Earring",
	    left_ring="Kishar Ring",
	    right_ring="Weatherspoon Ring +1",
	    back="Pahtli Cape"
	}

	sets.midcast.ElementalMagic = {main="Marin Staff +1",sub="Enki Strap",
		head=MerlinicHoodAcc,neck="Eddy Necklace",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
		back=SucellosINT,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Amalric Nails +1"
	}
	--sets.midcast.Stun = {main="Twebuliij",sub="Benthos Grip",ammo="Plumose Sachet",
		--head="Atrophy Chapeau +1",neck="Voltsurge Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		--body="Vanir Cotehardie",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Rahab Ring",
		--back="Ogapepo Cape",waist="Ovate Rope",legs="Artsieq Hose",feet="Helios Boots"}
		
	sets.midcast.EnhancingMagic = {
		head="Befouled Crown",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		ring2="Rahab Ring",
		waist="Cascade Belt"}

		
	sets.midcast.IndiSpells = {
		main="Idris",range="Dunna",
		head=Empyrean.Head, neck="Bagua Charm +1",
		body=Empyrean.Body,	hands=Empyrean.Hands, 
		back="Lifestream Cape", legs=Relic.Legs,feet=Empyrean.Feet
	}
	
	sets.midcast.GeoSpells = set_combine(sets.midcast.IndiSpells, {legs=Empyrean.Legs})

	sets.midcast.Cure = {main="Tamaxchi",sub="Genmei Shield",ammo="Hydrocera",
			head="Gendewitha Caubeen",neck="Fylgja Torque",lear="Novia Earring",
			body="Annointed Kalasiris",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Ephedra Ring",
			back="Pahtli Cape",waist="Porous Rope",legs="Gyve Trousers",feet="Medium's Sabot"}
		
	sets.TH = {waist="Chaac Belt"}

	sets.JA = {}
	sets.JA["Bolster"] = {body=Relic.Body}
	sets.JA["Radial Arcana"] = {feet=Relic.Feet}
	sets.JA["Mending Halation"] = {legs=Relic.Legs}
	sets.JA["Full Circle"] = {hands=Relic.Hands} --Curative Recantation
	sets.JA["Life Cycle"] = {back=capeRegen}


	sets.WS = {
		head="Nyame Helm",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		ring1="Chirich Ring +1",
		ring2="Rajas Ring",
		ear1="Dignitary's Earring",
		ear2="Telos Earring"
	}
		
	organizer_items = { main="Echo Drops", ranged="Cream Puff",
			body="Trizek Ring", ear1="Reraise Earring",
			ring1="Warp Ring",ring2="Capacity Ring", ear2="Echad Ring",
			back="Mecistopins Mantle"}


	send_command('bind f9 gs c nextTH')
	send_command('bind end send @others "input /follow Maurauc"')
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
	if (spell.english == "Dispelga") then
		equip(set_combine(sets.precast.FastCast, {main="Daybreak"}))
	elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') or string.find(spell.type, 'Geomancy') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cur') then 
				equip(sets.precast.FastCure)
				--send_command('input /echo "Cure"')
			else		
				equip(sets.precast['FastCast'])
				--send_command('input /echo "FC"')
			end
		else		
			equip(sets.precast['FastCast'])
			--send_command('input /echo "FC"')
		end
		if string.find(spell.skill,'Enhancing Magic') then
			equip({waist="Siegel Sash"})
			if string.find(spell.english,'Stoneskin') then
				equip({head="Umuthi Hat"})
			end
		end
	end
	if (string.find(spell.type,'Trust')) then
		equip(sets.precast['FastCast'])
	end
	if (string.find(spell.type:lower(), 'ability')) then
		equip(sets.JA[spell.name])
	end
	if (spell.type:lower() == 'weaponskill') then
		if (sets.WS[spell.english]) then
			equip(sets.WS[spell.english])
		else
			equip(sets.WS)
		end
	end
end
-- --- MidCast ---
function midcast(spell)
	set = {}
	if (spell.english == "Dispelga") then
		equip(set_combine(sets.midcast.EnfeeblingMagic, {main="Daybreak"}))
	elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
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
			set = set_combine(sets.midcast.IndiSpells, {})
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

    --if player.status == 'Engaged' then
    --        equip(sets.Melee)
    equip_idle()    
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
	else
		equip_idle()
	end
end

function equip_idle()
	equip(sets.Idle[sets.Idle.index[Idle_Index]])
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