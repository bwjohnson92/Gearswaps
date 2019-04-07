require('ClosetCleaner')
include('Merlinic.lua')
include('displayBox.lua')
include('organizeritems.lua')
-- Local Settings, setting the zones prior to use
Nuke_Index = 1
Idle_Index = 1

--currentWeapon = { name="Grioavolr", augments={'Magic burst dmg.+6%','INT+6','Mag. Acc.+14','"Mag.Atk.Bns."+30',}}
currentWeapon = { name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}}
TaranusINT = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}
TaranusMP = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

MPSet = false
MBSet = false
AccSet = false
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

-- Start Functions here
-- Gear Sets
function get_sets()

	send_command('bind f10 gs c switch MP')
	send_command('bind f11 gs c switch mb')
	send_command('bind f12 gs c switch pdt')
	send_command('bind end gs c lockWeapon')
	send_command('bind ^f11 gs c acc')

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
		
	sets.Idle.PDT = set_combine(sets.Idle.Standard, {ammo="Staunch Tathlum", neck="Loricate Torque +1", ring1="defending Ring", ring2="Dark Ring", 
		body="Vrikodara Jupon", feet="Wicce Sabots +1"  })
	
	sets.Idle.HighMP = set_combine(sets.Idle.Standard, { ammo="Strobilus",
		head="Pixie Hairpin +1", body="Amalric Doublet +1", hands="Amalric Gages +1", legs="Amalric Slops +1", feet="Amalric Nails +1",
		neck="Sanctity Necklace", ear1="Etiolation Earring", ear2="Loquacious Earring", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
		back=TaranusMP, waist="Yamabuki-no-obi"})

	sets.precast.FastCast = {
		head="Nahtirah Hat",neck="Orunmila's Torque", ear1="Etiolation Earring", ear2="Loquacious Earring",
		body=MerlinicBody, hands="Amalric Gages +1", ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",feet=MerlinicFeet}
	
	sets.precast.FastCure = set_combine(sets.precast.FastCast, {})
	
	sets.precast.FastCastImpact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})
	
	sets.precast.FastCastHighMP = set_combine(sets.precast.FastCast, {
		hands="Amalric Gages +1", feet="Amalric Nails +1", ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",back=TaranusMP,})
		
	sets.midcast.EnfeeblingMagic = {main=currentWeapon,sub="Enki Strap",ammo="pemphredo tathlum",
		head="Archmage's Petasos +3",neck="Sorcerer's Stole",ear1="Barkarole Earring",ear2="Digni. Earring",
		body="Spaekona's Coat +2",hands="Spaekona's Gloves +3",ring1="Sangoma Ring",ring2="Kishar Ring",
		back=TaranusINT,waist="Rumination Sash",legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}},feet="Spaekona's Sabots +2"}

	sets.midcast.ElementalMagic = {main=currentWeapon,sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head="Archmage's Petasos +3",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=TaranusINT,waist="Refoccilation Stone",legs="Amalric slops +1",feet="Amalric Nails +1"}
		
	sets.midcast.ElementalMagicHighMP = {main=currentWeapon,sub="Niobid Strap", ammo="Strobilus",
		head=MerlinicHead, neck="Eddy Necklace",ear1="Etiolation Earring",ear2="Barkarole Earring",
		body="Spaekona's Coat +2",hands="Spaekona's gloves +3",ring1="Mephitas's Ring +1",ring2="Sangoma Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}

	sets.midcast.ElementalMagicAcc = {
	    main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+6','Mag. Acc.+14','"Mag.Atk.Bns."+30',}},
	    sub="Enki Strap",
	    ammo="Pemphredo Tathlum",
	    head="Archmage's Petasos +3",
	    body="Amalric Doublet +1",
	    hands="Jhakri Cuffs +2",
	    legs=MerlinicLegs,
	    feet="Archmage's Sabots +2",
	    neck="Sanctity Necklace",
	    waist="Refoccilation Stone",
	    left_ear="Barkaro. Earring",
	    right_ear="Digni. Earring",
	    left_ring="Jhakri Ring",
	    right_ring="Sangoma Ring",
	    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast.ElementalMagicMP = set_combine(sets.midcast.ElementalMagic, {body="Spaekona's Coat +2"})
		
	sets.midcast.Impact = set_combine(sets.midcast.ElementalMagicAcc, {head=empty, body="Twilight Cloak", feet="Archmage's Sabots +2"})	
	-- sets.midcast.Impact = set_combine(sets.midcast.OccultAcumen, {head=empty, body="Twilight Cloak"})	
		
	sets.midcast.Stun = {main=currentWeapon,sub="Enki Strap",ammo="pemphredo tathlum",
		head=MerlinicHead,neck="Voltsurge Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
		body="Vanir Cotehardie",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet=MerlinicFeet}
		
	sets.midcast.EnhancingMagic = {
		head="Befouled Crown",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		waist="Cascade Belt",}

	sets.midcast.MagicBurst = { 
		head="Merlinic Hood",neck="Mizukage-no-Kubikazari", ear2="Static Earring",
		ring1="Locus Ring", ring2="Mujin Band",
		legs="Merlinic Shalwar",
		back=TaranusINT
	}
		
	sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}
		
	sets.midcast.Cure = {main="Chatoyant Staff",sub="Achaq Grip",ammo="pemphredo tathlum",
			neck="Lasaia Pendant",
			body="Vanir Cotehardie",ring1="Sirona's Ring",ring2="Haoma's Ring",
			waist="Cascade Belt",feet="Umbani Boots"}
			
	sets.JA.ManaWall = {back=TaranusMP, feet="Wicce Sabots +1"}
	
	sets.midcast.Death = {main=currentWeapon,sub="Niobid Strap", ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Static Earring",
		body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric slops +1",feet="Amalric Nails +1"}
	
	sets.midcast.DeathHighMP = {main=currentWeapon,sub="Niobid Strap", ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}
	
	sets.midcast.DeathHighMPMB = {main=currentWeapon,sub="Niobid Strap", ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Sorcerer's Stole",ear1="Barkarole Earring",ear2="Static Earring",
		body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric slops +1",feet="Amalric Nails +1"}
	
	sets.midcast.DrainAspir = set_combine(sets.midcast.ElementalMagic, {
	head="Pixie Hairpin +1",neck="Voltsurge Torque",  ear1="Gwati Earring", ear2="Barkarole Earring",	
	ring2="Archon Ring",back="Taranus's Cape", waist="Fucho-no-obi",feet=MerlinicFeet})
	
	sets.midcast.OccultAcumen = {
	    main="Khatvanga",
	    sub="Clerisy Strap",
	    ammo="Pemphredo Tathlum",
	    body="Spaekona's Coat +2",
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
	sets.WS.Myrkr = set_combine(sets.Idle.HighMP, {})

	organizer_items = organizerItems()

	sets.ElementalDebuff = {feet="Archmage's Sabots +2"}

	sets.extra = {neck="Sorcerer's Stole"}

	text_setup()
	addNewColors()
	updateTable()
end

function addNewColors()
	addTextColorPair("HighMP", "blue")
	addTextColorPair("PDT", "yellow")
	addTextColorPair("Standard", "green")
end

function updateTable()
	addToTable("(F10) MP Body", MPSet)
	addToTable("(F11) MB Set", MBSet)
	addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
	addToTable("(END) Weapon Locked", weaponLocked)
	update_message()
end

-- --- Precast ---

function precast(spell)
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
		disable("Feet")
		disable("back")
    end
end
end
-- --- MidCast ---
function midcast(spell)
	if (Idle_Index == 3) then
		if spell.english == 'Death' then
			if (MBSet == true) then
				equip(use_obi(spell, sets.midcast.DeathHighMPMB))
			else
				equip(use_obi(spell, sets.midcast.DeathHighMP))
			end
		elseif spell.english == 'Myrkr' then
			equip(sets.WS.Myrkr)
		elseif string.find(spell.type,'BlackMagic') then
			equip(sets.midcast.ElementalMagicHighMP)
		else
			equip(sets.precast.FastCastHighMP)
		end
		return
	end
		

	if spell.english == 'Impact' then
		equip(sets.midcast.Impact)
	elseif spell.english == 'Death' then
		equip(set_combine(use_MB(use_obi(spell, sets.midcast.Death))), {head="Pixie Hairpin +1"})
	elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
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
			-- equip(sets.midcast.OccultAcumen)
			if DotDebuffs:contains(spell.english) then 
				equip(set_combine(sets.midcast.EnfeeblingMagic, sets.ElementalDebuff))
			elseif (MPSet) then
                equip(use_MB(use_acc(use_obi(spell, sets.midcast.ElementalMagicMP))))
            else
                equip(use_MB(use_acc(use_obi(spell, sets.midcast.ElementalMagic))))
            end
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
end	

-- --- Aftercast ---

function aftercast(spell)
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
		MPSet = not MPSet
		add_to_chat(140, '<-- Nuking using '..(MPSet and 'MP Recovery' or 'Damage')..' Body -->')
	elseif command == 'acc' then
        AccSet = not AccSet
        add_to_chat(140, 'Elemental Magic: '..(AccSet and 'Acc' or 'Damage'))
	elseif command == 'switch mb' then
		MBSet = not MBSet
		add_to_chat(140, '<-- Magic Burst Set: '..(MBSet and 'ON' or 'OFF')..'-->')
	elseif command == 'switch pdt' then
		Idle_Index = Idle_Index +1
		if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
		add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_Index]])
	elseif command == 'lockCape' then
		capeLocked = not capeLocked
		if capeLocked == true then
			disable("Back")
		else
			enable("Back")
		end
		add_to_chat(140, '<----- Cape is now '..(capeLocked and 'locked' or 'unlocked')..' ----->')
	elseif command == 'lockWeapon' then
		weaponLocked = not weaponLocked
		if weaponLocked == true then
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
    if (AccSet) then
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