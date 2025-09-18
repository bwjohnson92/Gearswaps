require('ClosetCleaner')
include('displayBox/displayBox.lua')
include('organizeritems.lua')
-- Local Settings, setting the zones prior to use
toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}


-- Start Functions here
-- Gear Sets
Idle_Index = 1
Cure_Index = 1
allowWeaponSwap = true

caressFlag = false;

function get_sets()

	sets.precast = {};
	sets.midcast = {};
	sets.aftercast = {};

	sets.Idle = {}
	sets.Idle.index = {"Standard", "DT", "Move"}
	sets.Idle.Standard = {
    main={ name="Queller Rod", augments={'Healing magic skill +14','"Cure" potency +9%','"Cure" spellcasting time -7%',}},
    sub="Ammurapi Shield",
    ammo="Homiliary",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+5','"Refresh"+1',}},
    hands="Aya. Manopolas +2",
    legs="Assid. Pants +1",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Enervating Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back="Repulse Mantle",
}

	sets.Idle.DT = {
	    main="Daybreak",
	    sub="Ammurapi Shield",
	    ammo="Staunch Tathlum",
	    head="Inyanga Tiara +1",
	    body="Ayanmo Corazza +2",
	    hands="Inyan. Dastanas +1",
	    legs="Inyanga Shalwar +1",
	    feet="Inyan. Crackows +1",
	    neck="Loricate Torque +1",
	    waist="Lieutenant's sash",
	    left_ear="Etiolation Earring",
	    right_ear="Genmei Earring",
	    left_ring="Defending Ring",
	    right_ring="Warden's Ring",
	    back={ name="Alaunus's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
	}

	sets.Idle.Move = set_combine(sets.Idle.Standard,{feet="Herald's Gaiters"})
	
	sets.precast.FastCast = {
	    main={ name="Queller Rod", augments={'Healing magic skill +14','"Cure" potency +9%','"Cure" spellcasting time -7%',}},
	    sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -8%',}},
	    ammo="Incantor Stone",
	    head="Nahtirah Hat",
	    body="Shango Robe",
	    hands="Volte Gloves",
	    legs="Aya. Cosciales +2",
	    feet={ name="Medium's Sabots", augments={'MP+35','MND+7','"Cure" potency +1%',}},
	    neck="Voltsurge Torque",
	    left_ear="Nourish. Earring",
	    right_ear="Loquac. Earring",
	    right_ring="Weather. Ring +1",
	    back="Swith Cape",
	}
	
	sets.precast.FastCure = set_combine(sets.precast.FastCast, {
		legs="Orison Pantaloons +2",feet="Kaykaus Boots"}
	)

	sets.midcast.EnfeeblingMagic = {main="Grioavolr",sub="Enki Strap", ammo="Pemphredo Tathlum",
		head="Theophany Cap +2",neck="Erra Pendant",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Theophany Briault +2",hands="Inyanga Dastanas +1",ring1="Kishar Ring",ring2="Sangoma Ring",
		back="Alaunus's Cape",waist="Rumination Sash", legs="Theophany Pantaloons +2",feet="Skaoi Boots"}

	sets.midcast.BarSpells_Solace = {main="Beneficus",
		head="Orison Cap +2",neck="Colossus's Torque",
		body="Orison Bliaud +2",hands="Orison Mitts +1",ring1="Kishar Ring",ring2="Stikini Ring",
		waist="Cascade Belt",legs="Piety Pantaloons +1",feet="Orison Duckbills +2"}
	--sets.midcast.Barspells_noSolace = set_combine(sets.midcast.BarSpells_Solace,{body="Blessed Briault"})

	sets.midcast.EnhancingMagic = {main="Gada", sub="Ammurapi Shield", ammo="Incantor Stone",
		head="Telchine Cap",neck="Colossus's Torque",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Telchine Gloves",ring2="Prolix Ring",
		back="Swith Cape",waist="Cascade Belt",legs="Telchine Braconi",feet="Telchine Pigaches"}

	sets.midcast.Regen = set_combine(sets.midcast.EnhancingMagic, {
		main="Daybreak", sub="Ammurapi Shield",
		head="Inyanga Tiara +1",body="Piety Briault +1",
		hands="Orison Mitts +1",legs="Theophany pantaloons +2"})
	
	sets.midcast.Auspice = {feet="Orison Duckbills +2"}
	
	sets.midcast.Cursna = {main="Yagrush",
		head="Nahtirah Hat",neck="debilis medallion", ear1= "Healing Earring", ear2="Beatific Earring",
		body="Orison Bliaud +2",hands="Fanatic Gloves",ring1="Menelaus's ring", ring2="Haoma's ring",
		back="Mending cape",waist="Bishop's Sash",legs="Theophany Pantaloons +2",feet="Gendewitha Galoshes"	}
		
	sets.midcast.DebuffRemoval = {
		main="Yagrush",
		head="Nahtirah Hat", neck="Cleric's Torque",ear2="Loquacious Earring",
		body="Orison Bliaud +2",hands="Orison Mitts +1",
		back="Swith Cape",waist="Witful Belt",legs="Theophany Pantaloons +2",feet='Gendewitha Galoshes'	}

	sets.midcast.DivineCaress = set_combine(sets.midcast.DebuffRemoval, {
		hands="Orison Mitts +1",
		back="Mending Cape"
	})

	sets.Cure = {}
	sets.Curaga = {}
	sets.Cure.index = {"Standard", "DT"}

	sets.baseCureDT = {
		sub="Genbu's Shield",
		neck="Loricate Torque", 
		left_ring="Defending Ring"
	}

	sets.Cure.Standard = {
	    main={ name="Queller Rod", augments={'Healing magic skill +14','"Cure" potency +9%','"Cure" spellcasting time -7%',}},
	    ammo="Pemphredo Tathlum",
	    head="Orison Cap +2",
	    body="Orison Bliaud +2",
	    hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
	    legs="Ebers Pantaloons",
	    feet={ name="Medium's Sabots", augments={'MP+35','MND+7','"Cure" potency +1%',}},
	    neck="Cleric's Torque",
	    waist="Cascade Belt",
	    left_ear="Glorious Earring",
	    right_ear="Nourish. Earring",
	    back="Oretania's Cape",
	}

	sets.Curaga.Standard = {main="Queller Rod",sub="Sors Shield", ammo="Pemphredo Tathlum",
			head="Orison Cap +2",neck="Nuna Gorget +1",ear1="Glorious Earring",ear2="Sortiarius Earring",--10% 3%--
			body="Theophany briault +2",hands="Theophany Mitts +2",ring1="Aquasoul Ring",ring2="Sirona's Ring", --13%--
			back="Alaunus's Cape",waist="Cascade Belt",legs="Orison Pantaloons +2",feet="Kaykaus Boots"}

	sets.Cure.DT = set_combine(sets.Cure.Standard, sets.baseCureDT)

	sets.Curaga.DT = set_combine(sets.Curaga.Standard, sets.baseCureDT)
			
	sets.midcast.Stoneskin = {main="Kirin's Pole",neck="Stone Gorget",waist="Siegel Sash",legs="Shedir Seraweels"}

	sets.midcast.Shellra = sets.midcast.EnhancingMagic
	
	sets.midcast.Recast = {head="Nahtirah Hat",ear2="Loquacious Earring",
	hands="Fanatic Gloves",ring2="Prolix Ring",
	back="Swith Cape",waist="Witful Belt",legs="Blessed Trousers",feet="Gendewitha Galoshes"}
	
	sets.cureWeather =  {back="Twilight Cape", waist="Hachirin-no-obi"}
	
	organizer_items = {
		HiElixir="Hi-Elixir",
		echos="Echo Drops",
		holy="Holy Water",
		remedy="remedy",
		Prism="Prism Powder",
		Oils="Silent Oil",
		Puffs="Cream Puffs",
		Crepe="Pear Crepe",
		Vile="Vile Elixir",
		VileP1="Vile Elixir +1",
		InstRR="Instant Reraise",
		WarpItem="Instant Warp",
		RRHair="Reraise Hairpin",
		RREar="Reraise Earring",
		Warp="Warp Ring",
		CP="Trizek Ring",
		Exp="Echad Ring",
		CPMantle="Mecistopins Mantle",
	}

	send_command('bind f10 gs c toggle cure')
	send_command('bind f12 gs c toggle pdt')
	-- send_command('exec mulera.txt')
	text_setup()
    addNewColors()
    updateTable()
end

function addNewColors()
    addTextColorPair("DT", "yellow")
    addTextColorPair("Standard", "green")
end

function updateTable()
    addToTable("(F10) Cure Set", sets.Cure.index[Cure_Index])
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    update_message()
end
-- --- Precast ---

function precast(spell)
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cur') then 
				equip(sets.precast.FastCure)
			else		
				equip(sets.precast.FastCast)
			end
		else		
			equip(sets.precast.FastCast)
		end
		if string.find(spell.skill,'Enhancing Magic') then
			equip({waist="Siegel Sash"})
		end
	end
end
-- --- MidCast ---
function midcast(spell)
if string.find(spell.type,'Magic') then
	if string.find(spell.skill,'Healing Magic') then
		if string.find(spell.english, 'Cura') then
			equip(use_obi(spell, return_curaga_set(sets1)))
		elseif string.find(spell.english, 'Cure') then 
			equip(use_obi(spell, return_cure_set(sets)))
		elseif string.find(spell.english,'Cursna') then
			equip(sets.midcast.Cursna)
		elseif string.find(spell.english, 'na') then
			if (caressFlag) then
				equip(sets.midcast.DivineCaress)
				caressFlag = false
			else
				equip(sets.midcast.DebuffRemoval)
			end
		elseif string.find(spell.english, 'Raise') then
			equip(sets.midcast.Recast)
		elseif spell.english == 'Erase' then
			equip(sets.midcast.DebuffRemoval)
		end
		
	elseif spell.english == 'Erase' then
		equip(sets.midcast.DebuffRemoval)

	elseif string.find(spell.english,'Stoneskin') then
		equip(sets['midcast_Stoneskin'])
		
	elseif string.find(spell.skill,'Enhancing Magic') then
		if string.find(spell.english,'Bar') then
			equip(sets.midcast.BarSpells_Solace)
		elseif string.find(spell.english, 'Regen') then 
			equip(sets.midcast.Regen)
		elseif string.find(spell.english, 'Shellra') then
			equip(sets.midcast.Shellra)
		elseif string.find(spell.english, 'Boost') then
			equip(sets.midcast.EnhancingMagic)
		else
			equip(sets.midcast.EnhancingMagic)
		end
		
	elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
		equip(sets.midcast.EnfeeblingMagic)	
	else
		equip(sets.midcast.Recast)
	end
end		
end

-- --- Aftercast ---

function aftercast(spell)
	if (spell.english == 'Divine Caress') then
		caressFlag = true
	end
	equip(sets.Idle[sets.Idle.index[Idle_Index]])
	
	if spell.english == 'Repose' then
		send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	end
end

-- Status Change - ie. Resting

function self_command(command)
	if command == 'toggle pdt' then
		Idle_Index = Idle_Index +1
		if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
		add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_Index]])
	elseif command == 'toggle cure' then
		allowWeaponSwap = false
		Cure_Index = Cure_Index +1
		if Cure_Index > #sets.Cure.index then 
			allowWeaponSwap = true
			Cure_Index = 1
		end
		add_to_chat(140, '<----- Cure Set changed to '..sets.Cure.index[Cure_Index]..' ----->')
	end
	updateTable()
end

function return_cure_set()
	return sets.Cure[sets.Cure.index[Cure_Index]]
end

function return_curaga_set()
	return sets.Curaga[sets.Cure.index[Cure_Index]]
end

function status_change(new,tab)
end

function return_true_false_string(flag)
	if (flag) then
		return "true"
	end
	return "false"
end

function use_obi(spell, equip_set)
    local use_obi = false
    -- first check to see if any elemental obi rule matches
    if(S{world.weather_element}:contains(spell.element)) then
		use_obi = true
	end
 
    if (use_obi) then
        equip_set = set_combine(equip_set, sets.cureWeather)
        if (allowWeaponSwap) then
        	equip_set = set_combine(equip_set, {
        		main="Chatoyant Staff", sub="Achaq Strap"
        	})
        end
    end
 
    return equip_set
end