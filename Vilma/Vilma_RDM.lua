require('closetCleaner')
include('organizer-lib.lua')
include('Grioavolr.lua')
include('MaurMerlinic.lua')

include('displayBox/displayBox.lua')
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


MPSet = false
EnfeebSet = false
MBSet = false
PDTSet = false
capeLocked = false
weaponLocked = false

-- Start Functions here
-- Gear Sets
function get_sets()

staff1="Raetic Staff +1"
staff2=GrioavolrEnfeeble

MerlinicHoodAcc={name="Merlinic Hood"}
SucellosMND={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Cure" potency +10%','Damage taken-5%',}}
SucellosINT={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+9','"Mag.Atk.Bns."+10',}}

	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}

	sets.desperation = {body="Seidr Cotehardie"}

	sets.aftercast.Idle = {main="Daybreak",sub="Genmei Shield", ammo="Homiliary",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Jhakri Robe +2",hands="Volte Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Crimson Cuisses",feet="Malignance Boots"}
	
	sets.aftercast.PDT = set_combine(sets.aftercast.Idle, {
	    ammo="Homiliary",
	    head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Volte Gloves",
	    legs="Crimson Cuisses",
	    feet="Malignance Boots",
	    neck="Loricate Torque +1",
	    waist="Fucho-no-Obi",
	    left_ear="Etiolation Earring",
	    right_ear="Loquac. Earring",
	    left_ring="Defending Ring",
	    right_ring="Ilabrat Ring",
	    back=SucellosMND,
	})		

	--[[sets.aftercast.Idle = {main="Bolelabunga",sub="Genmei Shield", ammo="Homiliary",
		head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
		body={name="Witching Robe", augments={'MP+5', '"Refresh"+1',}},hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Dark Ring",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="Serpentes Sabots"}]]--

	sets.precast.FastCast = {
			head="Atrophy Chapeau +2",neck="Voltsurge Torque", ear1="Malignance Earring", ear2="Loquacious Earring",
		body="Merlinic Jubbah",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Kishar Ring",
		back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Merlinic Crackows"}

	sets.precast.FastCastImpact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})
	
	sets.precast.FastCure = sets.precast.FastCast

	--sets.Melee = {main="Buramenk'ah",sub="Genmei Shield",
	--	head="Umuthi Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
	--	body="Artsieq Jubbah",hands="Umuthi Gloves", 
	--	back="Atheling Mantle",waist="Cetl Belt", legs="Hagondes Pants",feet="Umbani Boots"}	
		
	sets.midcast.Enfeebling = {
	main="Daybreak",sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Atrophy Chapeau +2",neck="Duelist's Torque +1",ear1="Malignance Earring",ear2="Dignitary's Earring",
		body="Lethargy Sayon +1",hands="Volte bracers",ring1="Stikini Ring +1",ring2="Kishar Ring",
		back=SucellosMND,waist="Rumination Sash",legs="Chironic Hose",feet="Vitiation Boots +1"}

	sets.midcast.Enfeebling.Acc = set_combine(sets.midcast.Enfeebling, {
		main=staff2,
		ranged="Regal Gem",
		ear2="Snotra earring",
		body="Atrophy Tabard +2",
		waist="Luminary Sash",
		ring2="Metamorph Ring +1",
		back=SucellosMND
		})
		
	sets.midcast.ElementalMagic = {main="Daybreak",sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head=MerlinicHoodAcc,neck="Sanctity Necklace",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
		back=SucellosMND,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Vitiation Boots +1"}	

	sets.midcast.ElementalMagicAcc = {main="Daybreak",sub="Ammurapi Shield", ammo="Ghastly Tathlum +1",
		head=MerlinicHoodAcc,neck="Sanctity Necklace",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
		back=SucellosMND,waist="Sacro Cord",legs="Amalric Slops +1",feet="Vitiation Boots +1"}	
	
	sets.midcast.ElementalMagicMP = set_combine(sets.midcast.ElementalMagic, {body = "Seidr Cotehardie"})
		
	sets.midcast.Impact = set_combine(sets.midcast.ElementalMagic, {head=empty, body="Twilight Cloak"})
	
	sets.midcast.Stun = sets.midcast.Enfeebling

	sets.Dispelga = {main="Daybreak",sub="Ammurapi Shield"}
	sets.precast.Dispelga = set_combine(sets.precast.FastCast, sets.Dispelga)
	sets.midcast.Dispelga = set_combine(sets.midcast.Enfeebling.Acc, sets.Dispelga)
		
	sets.midcast.EnhancingMagicComposure = {main="Pukulatmuj", sub="Ammurapi Shield",
		head="Lethargy Chappel +1",neck="Duelist's Torque +1",ear1="Etiolation Earring",ear2="Lethargy Earring +1",
		body="Lethargy Sayon +1",hands="Atrophy Gloves +1",ring1="Stikini Ring +1",ring2="Weatherspoon Ring +1",
		back=SucellosMND,waist="Embla Sash",legs="Lethargy Fuseau +1",feet="Lethargy Houseaux +1"}

		
	sets.midcast.EnhancingMagic = {main="Pukulatmuj", sub="Ammurapi Shield",
		head="Befouled Crown",neck="Duelist's Torque +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Telchine Chasuble",hands="Vitiation Gloves +1",ring1="Stikini Ring +1",ring2="Weatherspoon Ring +1",
		back=SucellosMND,waist="Embla Sash",legs="Atrophy Tights +2",feet="Lethargy Houseaux +1"}

	sets.midcast.EnhancingMagicDuration = set_combine(sets.midcast.EnhancingMagic, {
		neck="Duelist's Torque +1",
		head="Telchine Cap", legs="Telchine Braconi", feet="Lethargy Houseaux +1",
		ear2="Lethargy Earring +1",
		hands="Atrophy Gloves +2"})

	sets.midcast.Refresh = set_combine(sets.precast.FastCast, {
		main="Pukulatmuj", sub="Ammurapi Shield",
		head="Amalric Coif +1", neck="Duelist's Torque +1",
		body="Atrophy Tabard +2",hands="Atrophy Gloves +2",
		back="Sucellos's Cape", waist="Witful Belt", legs="Lethargy Fuseau +1", feet="Lethargy Houseaux +1"})

	--sets.midcast.Cursna = {main="Beneficus",
	--	head="Orison Cap +2",neck="Malison medallion", ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",ring1="Ephedra ring", ring2="Sirona's ring",
	--	back="Mending cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}
		
	--sets.midcast.DebuffRemoval = {
	--	head="Orison Cap +2",neck="Malison medallion",ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",
	--	back="Swith Cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}

	sets.midcast.Cure = {main="Chatoyant Staff",sub="Achaq Grip",ammo="Hydrocera",
			head="Atrophy Chapeau +2",neck="Fylgja Torque",ear1="Novia Earring",
			body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Weatherspoon Ring +1",ring2="Ephedra Ring",
			back=SucellosMND,waist="Cascade Belt",legs="Atrophy Tights +2",feet="Kaykaus Sabots"}
			
			
	sets.Saboteur = {hands="Lethargy Gantherots +1"}
	
	sets.Phalanx = {
		head="Taeon Chapeau", 
		body={ name="Taeon Tabard", augments={'Phalanx +3',}},
    hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
    legs={ name="Taeon Tights", augments={'Phalanx +3',}},
    feet={ name="Taeon Boots", augments={'Phalanx +3',}},
	}
	
	sets.Paralyze = {feet="Vitiation Boots +1"}
	
	sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}
	
	organizer_items = { main="Echo Drops", ranged="Cream Puff", sub="Pear Crepe", ammo="Crepe B. Helene",
			body="Trizek Ring", ear1="Reraise Earring",
			ring1="Warp Ring",ring2="Capacity Ring", ear2="Echad Ring",
			back="Mecistopins Mantle"}

	sets.midcast.MagicBurst = {neck="Mizukage-no-Kubikazari", --10
		head="Merlinic Hood",
		hands="Ea Cuffs", ring1="Mujin Band", ring2="Locus Ring", --9,(5),(5),5 
		back="Seshaw Cape", feet="Merlinic Crackows"} --5, 9	


	sets.WS = {}

	sets.WS.SeraphBlade = {
	    ammo="Pemphredo Tathlum",
	    head="Jhakri Coronal +2",
	    ear1="Ishvara Earring",
	    ear2="Moonshade Earring",
	    body="Jhakri Robe +2",
	    hands="Jhakri Cuffs +2",
	    ring1="Epaminondas's Ring",
	    ring2="Weather. Ring +1",
	    back="Sucellos's Cape",
	    -- waist="Orpheus's Sash",
	    waist="Sacro Cord",
	    legs="Amalric Slops +1",
	    feet="Vitiation Boots +3"
	}

	sets.WS.PhysicalWS = {
	    head={ name="Viti. Chapeau +3"},
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands="Jhakri Cuffs +2",
	    legs="Aya. Cosciales +2",
	    feet="Thereoid Greaves",
	    neck="Caro Necklace",
	    waist="Metalsinger Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Sherida Earring",
	    left_ring="Rufescent Ring",
	    right_ring="Petrov Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+9','"Mag.Atk.Bns."+10',}}
	}

	sets.WS.SavageBlade = {
	    head="Viti. Chapeau +3",
	    neck="Republican platinum medal",
	    ear1="Moonshade Earring",
	    ear2="Malignance Earring",
	    body="Nyame Mail",
	    hands="Nyame Gaunlets",
	    ring1="Epaminondas's Ring",
	    ring2="Sroda Ring",
	    -- back="Sucellos's Cape",
	    waist="Sailfi Belt",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets"
	}

	sets.Melee = {}
	sets.Melee.index = {'Standard', 'Enspell'}
	Melee_Ind = 1

	sets.Melee.Standard = {
		head="Malignance Chapeau",
		body="Malignance Tabard",

		hands="Volte Bracers",
		legs="Atrophy Tights +2",
		feet="Malignance Boots",
		neck="Lissome Necklace",
		ear1="Telos Earring",
		ear2="Sherida Earring",
		ring1="Ilabrat Ring",
		ring2="Petrov Ring",
		waist="Olseni Belt",
		ammo="Coiste Bodhar"

	}

	sets.Melee.Enspell = {
		-- head="Umuthi Hat",
		head="Ayanmo Zucchetto +2",
	    body="Volte Jupon",
	    hands="Aya. Manopolas +2",
	    legs="Aya. Cosciales +2",
	    feet={ name="Taeon Boots", augments={'Phalanx +3',}},
	    -- neck="Anu Torque",
	    neck="Lissome Necklace",
	    waist="Chaac Belt",
	    left_ear="Brutal Earring",
	    right_ear="Sherida Earring",
	    left_ring="Apate Ring",
	    right_ring="Ilabrat Ring",
	    back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +8','Enha.mag. skill +8','Mag. Acc.+7','Enh. Mag. eff. dur. +14',}}
	}

	sets.Enspell = {
		head="Umuthi Hat",
	}

	send_command('bind f10 gs c switch MP')
	send_command('bind f9 gs c switch enf')
	send_command('bind f11 gs c switch mb')
	send_command('bind f12 gs c switch pdt')
	send_command('bind pageup gs c switch tp')
	send_command('bind pagedown gs c lockWeapon')

    text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("PDT", "yellow")
end

function updateTable()
    addToTable("(F9) Enfeebling", EnfeebSet and "Accuracy" or "Potency")
    -- addToTable("Enfeeble Potency", not EnfeebSet)
    addToTable("(F10) MP Body", MPSet)
    addToTable("(F11) MB Set", MBSet)
    addToTable("(F12) Idle Set", PDTSet and "PDT" or "Standard")
    addToTable("(PGUP) TP Set", sets.Melee.index[Melee_Ind])
    addToTable("(PGDN) Weapon Locked", weaponLocked)
    update_message()
end

-- --- Precast ---

function precast(spell)
	if spell.english == 'Impact' then
		equip(sets.precast.FastCastImpact)
	elseif spell.english == "Dispelga" then
		equip(sets.precast.Dispelga)
	elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cur') then 
				equip(sets.precast.FastCure)
				--send_command('input /echo "Cure"')
			else		
				equip(sets.precast.FastCast)
				--send_command('input /echo "FC"')
			end
		else		
			equip(sets.precast.FastCast)
			--send_command('input /echo "FC"')
		end
		if string.find(spell.skill,'Enhancing Magic') then
			equip({waist="Siegel Sash"})
			if string.find(spell.english,'Stoneskin') then
				equip({head="Umuthi Hat"})
			end
		end
	elseif string.find(spell.type,'WeaponSkill') then
		if spell.english == "Seraph Blade"  then
			equip(sets.WS.SeraphBlade)
		elseif spell.english == "Sanguine Blade" then	
			equip(sets.WS.SanguineBlade)
		elseif spell.english == "Savage Blade" then
			equip(sets.WS.SavageBlade)
		else
			equip(sets.WS.PhysicalWS)
		end
	end
	if spell.english == "Chainspell" then
		equip({body="Vitiation Tabard +3"})
	end
end
-- --- MidCast ---
function midcast(spell)
	if spell.english == 'Impact' then
		equip(sets.midcast.Impact)
	elseif spell.english == "Dispelga" then
		equip(sets.midcast.Dispelga)
	elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
				equip(sets.midcast.Cure)
			elseif string.find(spell.english,'Cursna') then
				equip(sets.precast.FastCast)
			elseif string.find(spell.english, 'na') then 
				equip(sets.precast.FastCast)
			elseif string.find(spell.english, 'Erase') then
				equip(sets.precast.FastCast)
			elseif string.find(spell.english, 'Raise') then
				equip(sets.precast.FastCast)			
			else
				equip(sets.precast.FastCast)
			end
			
		elseif string.find(spell.skill,'Enhancing Magic') then
			if string.find(spell.english, 'Erase') then
				equip(sets.precast.FastCast)
			elseif string.find(spell.english,'Phal') then
				add_to_chat(140, "Phalanx")
				equip(set_combine(sets.midcast.EnhancingMagic, sets.Phalanx))
			elseif string.find(spell.english,'Bar') or string.find(spell.english, "Gain") or string.find(spell.english, "Phal") or string.find(spell.english, "Temper") or string.find(spell.english, "En") then
				equip(sets.midcast.EnhancingMagic)
			elseif (string.find(spell.english, "Refresh")) then
				equip(sets.midcast.Refresh)
			elseif buffactive['composure'] and spell.target.type == 'PLAYER' then
				add_to_chat(140,'PLAYER')
				equip(sets.midcast.EnhancingMagicComposure)
			else
				equip(sets.midcast.EnhancingMagicDuration)
			end	
		elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
			setToEquip = {}
			if (spell.name == "Dispel") then
				setToEquip = set_combine(setToEquip, set_combine(sets.midcast.Enfeebling.Acc, {neck="Duelist's Torque +1"}))
			-- elseif (spell.name == "Sleep") or (spell.name == "Sleep II") then
			-- 	setToEquip = set_combine(setToEquip, sets.midcast.Enfeebling.Acc)
			elseif (EnfeebSet) and not ((string.find(spell.english, 'Dia') or string.find(spell.english, 'Bio') or string.find(spell.english, 'Inundation'))) then
				setToEquip = set_combine(setToEquip, sets.midcast.Enfeebling.Acc)
			else
				setToEquip = set_combine(setToEquip, sets.midcast.Enfeebling)
			end
			if buffactive['saboteur'] then
				setToEquip = set_combine(setToEquip, sets.Saboteur)
			end
			equip(setToEquip)
		elseif string.find(spell.skill,'Elemental Magic') then
			if(MPSet) then
				equip(use_MB(use_obi(spell, sets.midcast.ElementalMagicMP)))
			else
				equip(use_MB(use_obi(spell, sets.midcast.ElementalMagic)))
			end
		else
			equip(sets.precast.FastCast)
		end
		
	end
end	

-- --- Aftercast ---

function aftercast(spell)
		if player.status == 'Engaged' then
	        equip_TP()
	    else
	    	equip_Idle()
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

function equip_TP()
	equip(sets.Melee[sets.Melee.index[Melee_Ind]])
end

function equip_Idle()
	if (PDTSet) then
		equip(sets.aftercast.PDT)
	else
		equip(sets.aftercast.Idle)
	end
end


-- Status Change - ie. Resting
function status_change(new,tab)
	if new == 'Engaged' then
		equip_TP()
		--disable("Main")
	else
		equip_Idle()
		-- equip(sets['aftercast.Idle'])
		--enable("Main")
	end
end

function self_command(command)
	if command == 'switch tp' then
        Melee_Ind = Melee_Ind +1
        if Melee_Ind > #sets.Melee.index then Melee_Ind = 1 end
        send_command('@input /echo <----- TP Set changed to '..sets.Melee.index[Melee_Ind]..' ----->')
        equip_TP()
	elseif command == 'switch MP' then
		if (MPSet) then
			MPSet = false
			add_to_chat(140,'Elemental Magic: Damage')
		else
			MPSet = true
			add_to_chat(140,'Elemental Magic: MP')
		end
	elseif command == 'switch enf' then
		EnfeebSet = not EnfeebSet
		add_to_chat(140, 'Enfeebling Magic: '..(EnfeebSet and 'Acc' or 'EnfeebSkill'))
	elseif command == 'switch mb' then
		if (MBSet) then
			MBSet = false
			add_to_chat(140,'Magic Burst: Off')
		else
			MBSet = true
			add_to_chat(140,'Magic Burst: On')
		end
	elseif command == 'switch pdt' then
		if (PDTSet) then
			PDTSet = false
			add_to_chat(140,'PDT Set Off')
			if not buffactive["Mana Wall"] then
				enable("Feet")
			end
			equip(sets.aftercast.Idle)
		else
			PDTSet = true
			add_to_chat(140,'PDT Set On')
			equip(sets.aftercast.PDT)
		end
	elseif command == 'lockCape' then
		if capeLocked == false then
			capeLocked = true
			equip({back="Mecistopins Mantle"})
			disable("back")
			add_to_chat(140,'Back is being locked')
		else
			capeLocked = false
			enable("back")
			add_to_chat(140,'Back is being unlocked')
		end
	elseif command == 'lockWeapon' then
		if weaponLocked == false then
			weaponLocked = true
			--equip{{back="Mecistopins Mantle"}}
			disable("Main")
			disable("Sub")
			disable('Ranged')
			disable('Ammo')
			add_to_chat(140,'Weapon is being locked')
		else
			weaponLocked = false
			enable("Main")
			enable("Sub")
			enable('Ranged')
			enable('Ammo')
			add_to_chat(140,'Weapon is being unlocked')
		end
	end
	updateTable()
end

function use_MB(equip_set)
	if (MBSet) then
		equip_set = set_combine(equip_set, sets.midcast.MagicBurst)
	end
	return equip_set
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
        equip_set = set_combine(equip_set, sets.midcast.ElementalDay)
    end
 
    return equip_set
end
