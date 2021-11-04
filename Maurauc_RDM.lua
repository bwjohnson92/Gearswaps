require('closetCleaner')
include('organizer-lib.lua')
include('Grioavolr.lua')
include('MaurMerlinic.lua')

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


MPSet = false
EnfeebSet = false
MBSet = false
PDTSet = false
capeLocked = false
weaponLocked = false

    Idle_ind = 1   

-- Start Functions here
-- Gear Sets
function get_sets()

staff1="Raetic Staff +1"
staff2="Contemplator +1"

MerlinicHoodAcc={name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+4%','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+14',}}
SucellosMND={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Cure" potency +10%','Damage taken-5%',}}
SucellosINT={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+9','"Mag.Atk.Bns."+10',}}
SucellosTP={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}}
SucellosWS={ name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+5','Weapon skill damage +10%',}}

	sets.precast = {}
	sets.midcast = {}
	sets.Idle = {}


    sets.Idle.index = {'Idle','PDT', 'PDT_Move'}
    
	sets.desperation = {body="Seidr Cotehardie"}

	sets.Idle.Idle = {main="Daybreak",sub="Sacro Bulwark", ammo="Homiliary",
		head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Atrophy Tabard +3",hands="Volte Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Carmine Cuisses +1",feet=RefreshFeet}
	
	sets.Idle.PDT = set_combine(sets.Idle.Idle, {
	    ammo="Homiliary",
	    head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Loricate Torque +1",
	    waist="Fucho-no-Obi",
	    left_ear="Etiolation Earring",
	    right_ear="Loquac. Earring",
	    left_ring="Defending Ring",
	    right_ring="Ilabrat Ring",
	    back=SucellosMND,
	})

	sets.Idle.PDT_Move = set_combine(sets.Idle.PDT, {
		legs="Carmine Cuisses +1"
	})

	--[[sets.Idle.Idle = {main="Bolelabunga",sub="Genbu's Shield", ammo="Homiliary",
		head="Vitiation Chapeau +3",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
		body={name="Witching Robe", augments={'MP+5', '"Refresh"+1',}},hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Dark Ring",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="Serpentes Sabots"}]]--

	sets.precast.FastCast = {
		head={name="Atrophy Chapeau +3",priority=1},
		neck="Voltsurge Torque",
		ear2="Loquacious Earring",
		body={name="Vitiation Tabard +3",priority=1},
		hands="Leyline Gloves",
		ring1="Kishar Ring",
		ring2="Weatherspoon Ring +1",
		back={name="Swith Cape",priority=15},
		legs="Psycloth Lappas",
		feet="Merlinic Crackows"
	}
	
	sets.precast.FastCastImpact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})
	
	sets.precast.FastCure = sets.precast.FastCast

	--sets.Melee = {main="Buramenk'ah",sub="Genbu's Shield",
	--	head="Umuthi Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
	--	body="Artsieq Jubbah",hands="Umuthi Gloves", 
	--	back="Atheling Mantle",waist="Cetl Belt", legs="Hagondes Pants",feet="Umbani Boots"}	
		
	sets.midcast.Enfeebling = {main=staff2,sub="Enki Strap",ammo="Regal Gem",
		head="Vitiation Chapeau +3",neck="Duelist's Torque +1",ear1="Malignance Earring",ear2="Snotra Earring",
		body="Lethargy Sayon +1",hands="Kaykaus Cuffs +1",ring1="Stikini Ring",ring2="Kishar Ring",
		back=SucellosINT,waist="Rumination Sash",legs="Chironic Hose",feet="Vitiation Boots +3"}

	sets.midcast.Enfeebling.Acc = set_combine(sets.midcast.Enfeebling, {
		main=staff2,
		ammo="",
		ranged="Kaja Bow",
		body="Atrophy Tabard +3",
		waist="Luminary Sash",
		ring2="Weatherspoon Ring +1",
		ear1="Regal Earring",
		back=SucellosMND
		})

	sets.midcast.Sleepga = set_combine(sets.midcast.Enfeebling, {
		body="Lethargy Sayon +1",
		hands="Lethargy Gantherots +1",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1",
		neck="Duelist's Torque +1",
		ring2="Kishar Ring",
		ammo="Regal Gem"
	})
		
	sets.midcast.ElementalMagic = {main="Marin Staff +1",sub="Enki Strap", ammo="Ghastly Tathlum +1",
		head=MerlinicHoodAcc,neck="Eddy Necklace",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
		back=SucellosINT,waist="Sacro Cord",legs="Merlinic Shalwar",feet="Vitiation Boots +3"}	

	sets.midcast.ElementalMagicAcc = {main="Daybreak",sub="Ammurapi Shield", ammo="Ghastly Tathlum +1",
		head=MerlinicHoodAcc,neck="Eddy Necklace",ear1="Malignance Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Shiva Ring +1",
		back=SucellosINT,waist="Sacro Cord",legs="Amalric Slops +1",feet="Vitiation Boots +3"}	
	
	sets.midcast.ElementalMagicMP = set_combine(sets.midcast.ElementalMagic, {body = "Seidr Cotehardie"})
		
	sets.midcast.Impact = set_combine(sets.midcast.ElementalMagic, {head=empty, body="Twilight Cloak"})
	
	sets.midcast.Stun = sets.midcast.Enfeebling

	sets.Dispelga = {main="Daybreak",sub="Ammurapi Shield"}
	sets.precast.Dispelga = set_combine(sets.precast.FastCast, sets.Dispelga)
	sets.midcast.Dispelga = set_combine(sets.midcast.Enfeebling.Acc, sets.Dispelga)
		
	sets.midcast.EnhancingMagicComposure = {main="Pukulatmuj +1", sub="Ammurapi Shield",
		head="Lethargy Chappel +1",neck="Duelist's Torque +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Lethargy Sayon +1",hands="Atrophy Gloves +3",ring1="Stikini Ring",ring2="Weatherspoon Ring +1",
		back=SucellosMND,waist="Cascade Belt",legs="Lethargy Fuseau +1",feet="Lethargy Houseaux +1"}

		
	sets.midcast.EnhancingMagic = {main="Pukulatmuj +1", sub="Ammurapi Shield",
		head="Befouled Crown",neck="Duelist's Torque +1",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Vitiation Tabard +3",hands="Vitiation Gloves +2",ring1="Stikini Ring",ring2="Weatherspoon Ring +1",
		back=SucellosMND,waist="Gishdubar Sash",legs="Carmine Cuisses +1",feet="Lethargy Houseaux +1"}

	sets.midcast.EnhancingMagicDuration = set_combine(sets.midcast.EnhancingMagic, {
		neck="Duelist's Torque +1",
		head="Telchine Cap", legs="Telchine Braconi", feet="Lethargy Houseaux +1",
		hands="Atrophy Gloves +3"})

	sets.midcast.Refresh = set_combine(sets.precast.FastCast, {
		main="Pukulatmuj +1", sub="Ammurapi Shield",
		head="Amalric Coif +1", neck="Duelist's Torque +1",
		body="Atrophy Tabard +3",hands="Atrophy Gloves +3",
		back="Sucellos's Cape", waist="Gishdubar Sash", legs="Lethargy Fuseau +1", feet="Lethargy Houseaux +1"})

	--sets.midcast.Cursna = {main="Beneficus",
	--	head="Orison Cap +2",neck="Malison medallion", ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",ring1="Ephedra ring", ring2="Sirona's ring",
	--	back="Mending cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}
		
	--sets.midcast.DebuffRemoval = {
	--	head="Orison Cap +2",neck="Malison medallion",ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",
	--	back="Swith Cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}

	sets.midcast.Cure = {main="Daybreak",sub="Sacro Bulwark",ammo="Hydrocera",
			head="Amalric Coif +1",neck="Fylgja Torque",ear1="Novia Earring",
			body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Weatherspoon Ring +1",ring2="Ephedra Ring",
			back="Oretania's Cape",waist="Cascade Belt",legs="Atrophy Tights +1",feet="Medium's Sabots"}
			
			
	sets.Saboteur = {hands="Lethargy Gantherots +1"}
	
	sets.Phalanx = {
		head="Taeon Chapeau",
		body="Taeon Tabard",
		legs="Taeon Tights",
		feet="Taeon Boots",
		hands="Taeon Gloves"
	}
	
	sets.Paralyze = {feet="Vitiation Boots +3"}
	
	sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}
	
	organizer_items = { 
		echo="Echo Drops", 
		food="Tropical Crepe",
		holy="Holy Water",
		remedy="Remedy",
		panacea="Panacea",
		antacid="Antacid"
	}

	sets.midcast.MagicBurst = {neck="Mizukage-no-Kubikazari", --10
		head="Merlinic Hood",
		hands="Ea Cuffs", ring1="Mujin Band", ring2="Locus Ring", --9,(5),(5),5 
		back="Seshaw Cape", feet="Merlinic Crackows"} --5, 9	


	sets.WS = {}

	sets.WS.SeraphBlade = {
	    ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    ear1="Ishvara Earring",
	    ear2="Moonshade Earring",
	    body="Amalric Doublet +1",
	    hands="Jhakri Cuffs +2",
	    ring1="Freke Ring",
	    ring2="Weather. Ring +1",
	    back=SucellosWS,
	    -- waist="Orpheus's Sash"
	    neck="Sanctity Necklace",
	    waist="Sacro Cord",
	    legs="Amalric Slops +1",
	    feet="Nyame Sollerets"
	}

	sets.WS.SanguineBlade = set_combine(sets.WS.SeraphBlade, {

		ear1="Malignance Earring",
		head="Pixie Hairpin +1",
		ring2="Archon Ring",
		back=SucellosWS,
		-- feet="Amalric Nails +1",
	})

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
	    neck="Caro Necklace",
	    ear1="Moonshade Earring",
	    ear2="Malignance Earring",
	    body="Viti. Tabard +3",
	    hands="Atrophy Gloves +3",
	    ring1="Apate Ring",
	    ring2="Rufescent Ring",
	    back=SucellosWS,
	    waist="Metalsinger Belt",
	    legs="Jhakri Slops +2",
	    feet="Jhakri Pigaches +2"
	}

	sets.WS.BlackHalo = {
	    ammo="Regal Gem",
	    head="Viti. Chapeau +3",
	    neck="Dls. Torque +1",
	    ear1="Moonshade Earring",
	    ear2="Sherida Earring",
	    body="Viti. Tabard +3",
	    hands="Atrophy Gloves +3",
	    ring1="Rufescent Ring",
	    ring2="Apate Ring",
	    back=SucellosWS,
	    waist="Luminary Sash",
	    legs="Viti. Tights +3",
	    feet="Jhakri Pigaches +2"
	}

	sets.WS.Evisceration = {
	    -- ammo="Yetshila +1",
	    head="Malignance Chapeau",
	    neck="Fotia Gorget",
	    ear2="Moonshade Earring",
	    ear1="Sherida Earring",
	    body="Ayanmo Corazza +2",
	    hands="Atrophy Gloves +3",
	    ring1="Begrudging Ring",
	    ring2="Ilabrat Ring",
	    back=SucellosWS,
	    waist="Fotia Belt",
	    legs="Vitiation Tights +3",
	    feet="Thereoid Greaves"
	}

	sets.Melee = {}
	sets.Melee.index = {'Standard', 'SingleWieldSB', 'Enspell'}
	Melee_Ind = 1

	sets.Melee.Standard = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Lissome Necklace",
		back=SucellosTP,
		ear1="Telos Earring",
		ear2="Sherida Earring",
		ring1="Ilabrat Ring",
		ring2="Petrov Ring",
		waist="Windbuffet Belt +1",
		ammo="Ginsen"

	}

	sets.Melee.SingleWieldSB = {
		main="Vitiation Sword",
		sub="Ammurapi Shield",
		ammo="Hasty Pinion +1",
	    head="Umuthi Hat",
	    neck="Bathy Choker",
	    ear1="Digni. Earring",
	    ear2="Andoaa Earring",
	    hands="Aya. Manopolas +2",
	    ring1="Chirich Ring +1",
	    ring2="Chirich Ring +1",
	    back="Ghostfyre Cape",
	    waist="Orpheus's Sash",
	    -- waist="Hachirin-no-obi",
	    legs="Vitiation Tights +3",
	    --body="Vitiation Tabard +3",
	    -- feet="Malignance Boots",
	    body="Malignance Tabard",
	    feet="Lethargy Houseaux +1"
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

	sets.Bio = {
		body="Volte Jupon",
		waist="Chaac Belt",
		legs="Volte Hose"
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
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_ind])
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
	elseif string.find(spell.type,'Magic') or string.find(spell.type,'Trust') then
		equip(sets.precast.FastCast)
			--send_command('input /echo "FC"')
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
		elseif  spell.english == "Black Halo" then
			equip(sets.WS.BlackHalo)
		elseif spell.english == "Evisceration" then
			equip(sets.WS.Evisceration)
		elseif spell.english == "Chant du Cygne" then
			equip(sets.Melee.Standard)
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
	elseif spell.english == "Dia" or spell.english == "Bio" then
		equip(set_combine(sets.midcast.Enfeebling, sets.Bio))
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
			elseif string.find(spell.english,'Phalanx') and spell.target.name == player.name then
				add_to_chat(140, "Phalanx")
				equip(set_combine(sets.midcast.EnhancingMagic, sets.Phalanx))
			elseif string.find(spell.english,'Bar') or string.find(spell.english, "Gain") or string.find(spell.english, "Temper") or string.find(spell.english, "En") then
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
			elseif (spell.name == "Sleepga") then
				add_to_chat(140, "Sleepga")
				setToEquip = set_combine(setToEquip, sets.midcast.Sleepga)
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
		elseif string.find(spell.name, "Stun") then
			equip(sets.midcast.Stun)
		else
			equip(sets.precast.FastCast)
		end
		
	end
end	

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

    equip(sets.Idle[sets.Idle.index[Idle_ind]])
end


-- Status Change - ie. Resting
function status_change(new,tab)
	if new == 'Engaged' then
		equip_TP()
		--disable("Main")
	else
		equip_Idle()
		-- equip(sets['idle.Idle'])
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
        Idle_ind = Idle_ind +1
        if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
        send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
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

function buff_change(buff, gain)
    if (gain) then
        add_to_chat(140, "Gained "..buff)
    else
        add_to_chat(140, "Lost "..buff)
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
        equip_set = set_combine(equip_set, sets.midcast.ElementalDay)
    end
 
    return equip_set
end