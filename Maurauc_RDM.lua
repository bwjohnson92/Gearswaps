require('closetCleaner')
include('organizer-lib.lua')
include('Grioavolr.lua')

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

staff="Raetic Staff +1"
-- staff=GrioavolrEnfeeble


MerlinicHoodAcc={name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+4%','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+14',}}
SucellosMND={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Cure" potency +10%',}}
SucellosINT={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+9','"Mag.Atk.Bns."+10',}}
-- Start Functions here
-- Gear Sets
function get_sets()

	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}

	sets.Reive = {neck="Arciela's Grace +1"}

	sets.desperation = {body="Seidr Cotehardie"}

	sets.aftercast.Idle = {main="Bolelabunga",sub="Genmei Shield", ammo="Homiliary",
		head="Vitiation Chapeau +1",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Atrophy Tabard +3",hands="Leyline Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Carmine Cuisses +1",feet="Carmine Greaves"}
	
	sets.aftercast.PDT = set_combine(sets.aftercast.Idle, {
	    ammo="Homiliary",
	    head="Aya. Zucchetto +2",
	    body="Ayanmo Corazza +2",
	    hands="Aya. Manopolas +1",
	    legs="Aya. Cosciales +2",
	    feet={ name="Carmine Greaves", augments={'HP+60','MP+60','Phys. dmg. taken -3',}},
	    neck="Loricate Torque +1",
	    waist="Fucho-no-Obi",
	    left_ear="Etiolation Earring",
	    right_ear="Loquac. Earring",
	    left_ring="Defending Ring",
	    right_ring="Gelatinous Ring +1",
	    back="Repulse Mantle",
	})		

	--[[sets.aftercast.Idle = {main="Bolelabunga",sub="Genbu's Shield", ammo="Homiliary",
		head="Vitiation Chapeau +1",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
		body={name="Witching Robe", augments={'MP+5', '"Refresh"+1',}},hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Dark Ring",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="Serpentes Sabots"}]]--

	sets.precast.FastCast = { main="Oranyan",sub="Clerisy Strap",
		head="Atrophy Chapeau +3",neck="Voltsurge Torque", ear2="Loquacious Earring",
		body="Vitiation Tabard",hands="Gendewitha Gages",ring2="Weatherspoon Ring +1",
		back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Merlinic Crackows"}
	
	sets.precast.FastCastImpact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})
	
	sets.precast.FastCure = {
		head="Atrophy Chapeau +3",neck="Voltsurge Torque",ear2="Loquacious Earring",
		body="Vitiation Tabard",hands="Gendewitha Gages",ring2="Weatherspoon Ring +1",
		back="Pahtli Cape",waist="Witful Belt",legs="Psycloth Lappas"}

	--sets.Melee = {main="Buramenk'ah",sub="Genbu's Shield",
	--	head="Umuthi Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
	--	body="Artsieq Jubbah",hands="Umuthi Gloves", 
	--	back="Atheling Mantle",waist="Cetl Belt", legs="Hagondes Pants",feet="Umbani Boots"}	
		
	sets.midcast.Enfeebling = {main=staff,sub="Enki Strap",ammo="Regal Gem",
		head="Vitiation Chapeau +1",neck="Duelist's Torque",ear1="Gwati Earring",ear2="Dignitary's Earring",
		body="Lethargy Sayon +1",hands="Lethargy Gantherots +1",ring1="Stikini Ring",ring2="Kishar Ring",
		back=SucellosINT,waist="Rumination Sash",legs="Chironic Hose",feet="Skaoi Boots"}

	sets.midcast.Enfeebling.Acc = set_combine(sets.midcast.Enfeebling, {
		ammo="",
		ranged="Kaja Bow",
		main=staff,
		head="Atrophy Chapeau +3",
		body="Atrophy Tabard +3",
		waist="Luminary Sash",
		ring2="Weatherspoon Ring +1",
		back=SucellosMND
		})
		
	sets.midcast.ElementalMagic = {main=staff,sub="Niobid Strap", ammo="Ghastly Tathlum +1",
		head=MerlinicHoodAcc,neck="Eddy Necklace",ear1="Novio Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=SucellosINT,waist="Yamabuki-no-obi",legs="Merlinic Shalwar",feet="Merlinic Crackows"}	

	sets.midcast.ElementalMagicAcc = {main=staff,sub="Niobid Strap", ammo="Ghastly Tathlum +1",
		head=MerlinicHoodAcc,neck="Eddy Necklace",ear1="Novio Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=SucellosINT,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}	
	
	sets.midcast.ElementalMagicMP = set_combine(sets.midcast.ElementalMagic, {body = "Seidr Cotehardie"})
		
	sets.midcast.Impact = set_combine(sets.midcast.ElementalMagic, {head=empty, body="Twilight Cloak"})
	
	sets.midcast.Stun = {main=GrioavolrEnfeeble,sub="Clerisy Strap",ammo="Hydrocera",
		head="Atrophy Chapeau +3",neck="Voltsurge Torque",ear1="Gwati Earring",ear2="Psystorm Earring",
		body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Stikini Ring",ring2="Weatherspoon Ring +1",
		back="Sucellos's Cape",waist="Cetl Belt",legs="Psycloth Lappas",feet="Merlinic Crackows"}
		
	sets.midcast.EnhancingMagicComposure = {main="Oranyan", sub="Clerisy Strap",
		head="Lethargy Chappel +1",neck="Duelist's Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Lethargy Sayon +1",hands="Atrophy Gloves +1",ring1="Stikini Ring",ring2="Weatherspoon Ring +1",
		back=SucellosMND,waist="Cascade Belt",legs="Lethargy Fuseau +1",feet="Lethargy Houseaux +1"}

		
	sets.midcast.EnhancingMagic = {main="Oranyan", sub="Clerisy Strap",
		head="Befouled Crown",neck="Duelist's Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Vitiation Tabard",hands="Vitiation Gloves",ring1="Stikini Ring",ring2="Weatherspoon Ring +1",
		back=SucellosMND,waist="Gishdubar Sash",legs="Carmine Cuisses +1",feet="Lethargy Houseaux +1"}

	sets.midcast.EnhancingMagicDuration = set_combine(sets.midcast.EnhancingMagic, {
		neck="Duelist's Torque",
		head="Telchine Cap", legs="Telchine Braconi", feet="Lethargy Houseaux +1",
		hands="Atrophy Gloves +1"})

	sets.midcast.Refresh = set_combine(sets.precast.FastCast, {
		main="Oranyan",
		head="Amalric Coif +1", neck="Duelist's Torque",
		body="Atrophy Tabard +3",hands="Atrophy Gloves +1",
		back="Sucellos's Cape", waist="Gishdubar Sash", legs="Lethargy Fuseau +1", feet="Lethargy Houseaux +1"})

	--sets.midcast.Cursna = {main="Beneficus",
	--	head="Orison Cap +2",neck="Malison medallion", ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",ring1="Ephedra ring", ring2="Sirona's ring",
	--	back="Mending cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}
		
	--sets.midcast.DebuffRemoval = {
	--	head="Orison Cap +2",neck="Malison medallion",ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",
	--	back="Swith Cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}

	sets.midcast.Cure = {main="Tamaxchi",sub="Genmei Shield",ammo="Hydrocera",
			head="Amalric Coif +1",neck="Fylgja Torque",ear1="Novia Earring",
			body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Weatherspoon Ring +1",ring2="Ephedra Ring",
			back="Oretania's Cape",waist="Cascade Belt",legs="Atrophy Tights",feet="Medium's Sabots"}
			
			
	sets.Saboteur = {hands="Lethargy Gantherots +1"}
	
	sets.Phalanx = {hands="Vitiation Gloves"}
	
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

	send_command('bind f10 gs c switch MP')
	send_command('bind f9 gs c switch enf')
	send_command('bind f11 gs c switch mb')
	send_command('bind f12 gs c switch pdt')

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
    addToTable("(END) Weapon Locked", weaponLocked)
    update_message()
end

-- --- Precast ---

function precast(spell)
	if spell.english == 'Impact' then
		equip(sets.precast.FastCastImpact)
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
	end
end
-- --- MidCast ---
function midcast(spell)
	if spell.english == 'Impact' then
		equip(sets.midcast.Impact)
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
			elseif string.find(spell.english,'Bar') or string.find(spell.english, "Gain") or string.find(spell.english, "Phal") or string.find(spell.english, "Temper") then
				equip(sets.midcast.EnhancingMagic)
			elseif (string.find(spell.english, "Refresh")) then
				equip(sets.midcast.Refresh)
			elseif buffactive['composure'] and spell.target.type == 'PLAYER' then
				add_to_chat(140,'PLAYER')
				equip(sets.midcast.EnhancingMagicComposure)
			else
				equip(sets.midcast.EnhancingMagicDuration)
			end
			if string.find(spell.english,'Phal') then
				equip({hands="Vitiation Gloves"})
			end
			
		elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
			if (spell.name == "Dispel") then
				equip(set_combine(sets.midcast.Enfeebling.Acc, {neck="Duelist's Torque"}))
			-- elseif (spell.name == "Sleep") or (spell.name == "Sleep II") then
			-- 	equip(sets.midcast.Enfeebling.Acc)
			elseif (EnfeebSet) and not ((string.find(spell.english, 'Dia') or string.find(spell.english, 'Bio') or string.find(spell.english, 'Inundation'))) then
				equip(sets.midcast.Enfeebling.Acc)
			else
				equip(sets.midcast.Enfeebling)
			end
			if buffactive['saboteur'] then
				equip({hand="Lethargy Gantherots"})
			end
			
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
		if toau_zones:contains(zone) then
			equip(sets.aftercast.Idle,{ring1="Balrahn's Ring"})
		elseif (PDTSet) then
			equip(sets.aftercast.PDT)
		else
			equip(sets.aftercast.Idle)
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
		equip(sets['aftercast.Idle'])
		--enable("Main")
	end
end

function self_command(command)
	if command == 'switch MP' then
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
			add_to_chat(140,'Weapon is being locked')
		else
			weaponLocked = false
			enable("Main")
			enable("Sub")
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
        equip_set = set_combine(equip_set, sets.midcast.ElementalDay)
    end
 
    return equip_set
end