require('ClosetCleaner')
include('VilMerlinic.lua')
include('displayBox.lua')
include('organizeritems.lua')
-- Local Settings, setting the zones prior to use
Nuke_Index = 1
Idle_Index = 1

--currentWeapon = { name="Grioavolr", augments={'Magic burst dmg.+6%','INT+6','Mag. Acc.+14','"Mag.Atk.Bns."+30',}}

TaranusINT = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}
TaranusMP = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

MPBodyEquipToggle = false
MBSet = false
AccuracySet = false
PDTSet = false

capeLocked = false

weaponLocked = false

toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

DotDebuffs = S{"Burn", "Choke", "Shock", "Drown", "Frost", "Rasp"}

weaponLathi = { name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}}
weaponRaetic = { name="Raetic Staff +1" }
weaponMarin = { name="Marin Staff +1" }

currentWeapon = weaponRaetic

-- Start Functions here
-- Gear Sets
function get_sets()

	send_command('bind f10 gs c switch MP')
	send_command('bind f11 gs c switch mb')
	send_command('bind f12 gs c switch pdt')
	send_command('bind end gs c lockWeapon')
	send_command('bind f9 gs c acc')

	sets.Idle = {}
	sets.precast = {}
	sets.midcast = {}
	sets.JA = {}
	sets.WS = {}
	sets.Idle.index = {"Standard", "PDT", "HighMP"}

	sets.Idle.Standard = {main="Bolelabunga",sub="Genbu's Shield",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Witching Robe",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Dark Ring",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Herald's Gaiters"}
		
	sets.Idle.PDT = set_combine(sets.Idle.Standard, {ammo="Staunch Tathlum +1", neck="Loricate Torque +1", ring1="defending Ring", ring2="Dark Ring", 
		body="Vrikodara Jupon", feet="Wicce Sabots +1"  })
	
	sets.Idle.HighMP = set_combine(sets.Idle.Standard, { ammo="Strobilus",
		head="Pixie Hairpin +1", body="Amalric Doublet +1", hands="Amalric Gages +1", legs="Spaekona's Tonban +3", feet="Amalric Nails +1",
		neck="Sanctity Necklace", ear1="Etiolation Earring", ear2="Loquacious Earring", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
		back=TaranusMP, waist="Yamabuki-no-obi"})

	sets.precast.FastCast = {
		head="Nahtirah Hat",neck="Orunmila's Torque", ear1="Etiolation Earring", ear2="Loquacious Earring",
		body=MerlinicBody, hands="Amalric Gages +1", ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",feet=MerlinicFeet}
	
	sets.Dispelga = { main="Daybreak", sub="Ammurapi Shield"}

	sets.precast.Dispelga = set_combine(sets.precast.FastCast, sets.Dispelga)

	sets.precast.FastCure = set_combine(sets.precast.FastCast, {})
	
	sets.precast.FastCastImpact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})
	
	sets.precast.FastCastHighMP = set_combine(sets.precast.FastCast, {
		hands="Amalric Gages +1", feet="Amalric Nails +1", ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",back=TaranusMP,})
		
	sets.midcast.EnfeeblingMagic = {
	-- main=currentWeapon,sub="Enki Strap",
		ammo="pemphredo tathlum",
		head="Archmage's Petasos +3",neck="Sorcerer's Stole",ear1="Barkarole Earring",ear2="Digni. Earring",
		body="Spaekona's Coat +3",hands="Spaekona's Gloves +3",ring1="Sangoma Ring",ring2="Kishar Ring",
		back=TaranusINT,waist="Rumination Sash",legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}},feet="Spaekona's Sabots +3"}

	sets.midcast.Dispelga = set_combine(sets.midcast.EnfeeblingMagic, sets.Dispelga)

	sets.midcast.MagicBurst = { 
		ammo="Ghastly Tathlum +1",
		head="Ea hat +1",
		body="Ea Houppelande +1",
		legs="Ea Slops +1",
		neck="Sorcerer's Stole",

		



		feet="Amalric Nails +1", --+50MAB
		ring1="Locus Ring", 

		-- feet="Spaekona's Sabots +3", --+50 MAcc
		ear1="Regal Earring",
		ring1="Freke Ring",

		-- ring2="Mujin Band",
		back=TaranusINT
		-- ear2="Static Earring",
		-- neck="Mizukage-no-Kubikazari", 
	}

	sets.midcast.ElementalMagic = {
		-- main=currentWeapon,sub="Niobid Strap", 
		ammo="Pemphredo Tathlum",
		head="Archmage's Petasos +3",neck="Sorcerer's Stole",ear1="Barkarole Earring",ear2="Malignance Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
		back=TaranusINT,waist="Sacro Cord",legs="Amalric slops +1",feet="Amalric Nails +1"}
		
	sets.midcast.ElementalMagic.HighMP = {
		-- main=currentWeapon,sub="Niobid Strap", 
		ammo="Strobilus",
		head=MerlinicHead, neck="Sorcerer's Stole",ear1="Etiolation Earring",ear2="Barkarole Earring",
		body="Spaekona's Coat +3",hands="Spaekona's gloves +3",ring1="Mephitas's Ring +1",ring2="Sangoma Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}

	sets.midcast.ElementalMagic.Acc = {
	    -- main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+6','Mag. Acc.+14','"Mag.Atk.Bns."+30',}}, <-- Marin
	    -- sub="Enki Strap",
	    ammo="Pemphredo Tathlum",
	    head="Archmage's Petasos +3",
	    body="Spaekona's Coat +3",
	    hands="Spaekona's Gloves +3",
	    legs="Spaekona's Tonban +3",
	    feet="Spaekona's Sabots +3",
	    neck="Sorcerer's Stole",
	    waist="Sacro Cord",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Jhakri Ring",
	    right_ring="Sangoma Ring",
	    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast.ElementalMagic.Burst = set_combine(sets.midcast.ElementalMagic, sets.midcast.MagicBurst)

	sets.ElementalMagicMPBody = {body="Spaekona's Coat +3"}
		
	sets.midcast.Impact = set_combine(sets.midcast.ElementalMagicAcc, {head=empty, body="Twilight Cloak", feet="Archmage's Sabots +2"})	
	-- sets.midcast.Impact = set_combine(sets.midcast.OccultAcumen, {head=empty, body="Twilight Cloak"})	
		
	sets.midcast.Stun = {
	-- main=currentWeapon,sub="Enki Strap",
	ammo="pemphredo tathlum",
		head=MerlinicHead,neck="Voltsurge Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
		body="Spaekona's Coat +3",hands="Spaekona's gloves +3",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Spaekona's Tonban +3",feet="Spaekona's Sabots +3"}
		

		
	sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}

			
	sets.midcast.Death = {
	-- main=currentWeapon,sub="Niobid Strap", 
		ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Sorcerer's Stole",ear1="Barkarole Earring",ear2="Static Earring",
		body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Spaekona's Tonban +3",feet="Amalric Nails +1"}
	
	sets.midcast.DeathHighMP = {
	-- main=currentWeapon,sub="Niobid Strap", 
		ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Sorcerer's Stole",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Spaekona's Tonban +3",feet="Amalric Nails +1"}
	
	sets.midcast.DeathHighMPMB = {
	-- main=currentWeapon,sub="Niobid Strap", 
		ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Sorcerer's Stole",ear1="Barkarole Earring",ear2="Static Earring",
		body="Ea Houppelande",hands="Spaekona's Gloves +3",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Spaekona's Tonban +3",feet="Spaekona's Sabots +3"}
	
	sets.midcast.DrainAspir = set_combine(sets.midcast.ElementalMagic, {
	head="Pixie Hairpin +1",neck="Voltsurge Torque",  ear1="Gwati Earring", ear2="Barkarole Earring",	
	ring2="Archon Ring",back="Taranus's Cape", waist="Fucho-no-obi",feet=MerlinicFeet})
	
	sets.midcast.OccultAcumen = {
	    -- main="Khatvanga",
	    -- sub="Clerisy Strap",
	    ammo="Pemphredo Tathlum",
	    body="Spaekona's Coat +3",
	    hands="Ea Cuffs",
	    legs="Perdition Slops",
	    feet={ name="Helios Boots", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Occult Acumen"+9','Magic burst dmg.+9%',}},
	    neck="Lissome Necklace",
	    waist="Oneiros Rope",
	    left_ear="Telos Earring",
	    right_ear="Dedition Earring",
	    left_ring="K'ayres Ring",
	    right_ring="Petrov Ring",
	}

	sets.midcast.Cure = {
		-- main="Chatoyant Staff",sub="Achaq Grip",
		ammo="pemphredo tathlum",
		neck="Fylgja Torque +1",
		body="Merlinic Jubbah",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Haoma's Ring",
		waist="Cascade Belt",legs="Nares Trews",feet="Vanya Clogs"
	}

	sets.WS.Myrkr = set_combine(sets.Idle.HighMP, {})
	sets.JA.ManaWall = {back=TaranusMP, feet="Wicce Sabots +1"}
	sets.extra = {neck="Sorcerer's Stole"}
	sets.ElementalDebuff = {feet="Archmage's Sabots +2"}
	organizer_items = organizerItems()

	text_setup()
	addNewColors()
	updateTable()

	enable("main")
	enable("sub")
end

function addNewColors()
	addTextColorPair("HighMP", "blue")
	addTextColorPair("PDT", "yellow")
	addTextColorPair("Standard", "green")
end

function updateTable()
	addToTable("(F9) Nuking Accuracy", AccuracySet)
	addToTable("(F10) MP Body", MPBodyEquipToggle)
	addToTable("(F11) MB Set", MBSet)
	addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
	addToTable("(END) Weapon Locked", weaponLocked)
	update_message()
end

-- --- Precast ---

function precast(spell)
if spell.english == "Dispelga" then
	equip(sets.precast.Dispelga)
	return
end
if (Idle_Index == 3) then
	if spell.english == 'Myrkr' then
		equip(sets.WS.Myrkr)
	else 
		equip(sets.precast.FastCastHighMP)
	end
else
	if spell.english == 'Impact' then
		equip(sets.precast.FastCastImpact)
	elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		equip(sets.precast.FastCast)
		if string.find(spell.skill,'Enhancing Magic') then
			equip({waist="Siegel Sash"})
			if string.find(spell.english,'Stoneskin') then
				equip({head="Umuthi Hat"})
			end
		end
	end
	if spell.english == 'Myrkr' then
		equip(sets.WS.Myrkr)
	end
	if spell.english == 'Mana Wall' then
        equip(sets.JA.ManaWall)
    end
end
end

function handleHighMP(spell)
	if spell.english == 'Death' then
		if (MBSet == true) then
			return(use_obi(spell, sets.midcast.DeathHighMPMB))
		else
			return(use_obi(spell, sets.midcast.DeathHighMP))
		end
	elseif spell.english == 'Myrkr' then
		return(sets.WS.Myrkr)
	elseif string.find(spell.type,'BlackMagic') then
		return(sets.midcast.ElementalMagicHighMP)
	else
		return(sets.precast.FastCastHighMP)
	end
	return
end

function handleNuke(spell)
	add_to_chat(140, "nuke")

	set = sets.midcast.ElementalMagic

	if(MBSet) then
		set = sets.midcast.ElementalMagic.Burst
	elseif(AccuracySet) then
		set = sets.midcast.ElementalMagic.Acc
	end

	if (MPBodyEquipToggle) then
		set = set_combine(set, sets.ElementalMagicMPBody)
	end
	-- add_to_chat(140, ..set)
	return(use_obi(spell, set))
	

end

-- --- MidCast ---
function midcast(spell)
	if (spell.type == "JobAbility") then
		return
	end
	if spell.english == "Dispelga" then
		equip(sets.precast.Dispelga)
		return
	end
	if (Idle_Index == 3) then
		equip(handleHighMP(spell))
	end

	if spell.english == 'Impact' then
		equip(sets.midcast.Impact)
		return
	end
	
	if spell.english == 'Death' then
		equip(set_combine(use_MB(use_obi(spell, sets.midcast.Death))), {head="Pixie Hairpin +1"})
		return
	end

	if DotDebuffs:contains(spell.english) then 
		equip(set_combine(sets.midcast.EnfeeblingMagic, sets.ElementalDebuff))
		return
	end
	
	if (string.find(spell.skill,'Healing Magic')) then
        if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
            equip(sets.midcast.Cure)
        else
            equip(sets.precast.FastCast)
        end
	elseif string.find(spell.skill,'Enhancing Magic') then
		equip(sets.midcast.EnhancingMagic)
						
	elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
		equip(sets.midcast.EnfeeblingMagic)	
	
	elseif string.find(spell.skill,'Elemental Magic') then

		equip(handleNuke(spell))
	
	elseif string.find(spell.skill, 'Dark Magic') then
		if spell.english ~= 'Stun' then
			equip(sets.midcast.DrainAspir)
		else
			equip(sets.midcast.Stun)
		end
	else
		equip(sets.precast.FastCast)
	end	
end	

-- --- Aftercast ---

function aftercast(spell)
	if spell.english == 'Mana Wall' then
		disable("Feet")
		disable("back")
    end
	equip(sets.Idle[sets.Idle.index[Idle_Index]])
	check_spell(spell)
end

-- Status Change - ie. Resting

function check_spell(spell)
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

end

function job_buff_change(buff, gain)
	if buff == "Mana Wall" and gain == false then
		enable("feet")
		enable("back")
	end
end

function self_command(command)
	if command == 'test' then
		-- print_table()
		add_to_chat(140, Idle_Index)
	end
	if command == 'switch MP' then
		MPBodyEquipToggle = not MPBodyEquipToggle
		add_to_chat(140, '<-- Nuking using '..(MPBodyEquipToggle and 'MP Recovery' or 'Damage')..' Body -->')

	elseif command == 'acc' then
        AccuracySet = not AccuracySet
        add_to_chat(140, 'Elemental Magic: '..(AccuracySet and 'Acc' or 'Damage'))

	elseif command == 'switch mb' then
		MBSet = not MBSet
		add_to_chat(140, '<-- Magic Burst Set: '..(MBSet and 'ON' or 'OFF')..'-->')

	elseif command == 'switch pdt' then
		Idle_Index = Idle_Index +1
		if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
		add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_Index]])

	elseif command == 'lockWeapon' then
		weaponLocked = not weaponLocked
		if weaponLocked == true then
			equip({main=currentWeapon, sub="Enki Strap"})
			disable("Main")
			disable("Sub")
		else
			enable("Main")
			enable("Sub")
		end
		add_to_chat(140, '<----- Weapon is now '..(weaponLocked and 'locked' or 'unlocked')..' ----->')
	end
	updateTable()
end

function use_MB(equip_set)
	if (MBSet) then
		equip_set = set_combine(equip_set, sets.midcast.MagicBurst)
	end
	return equip_set
end

function use_acc(equip_set)
    if (AccuracySet) then
        equip_set = set_combine(equip_set, sets.midcast.ElementalMagicAcc)
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