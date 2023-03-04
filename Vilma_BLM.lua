require('ClosetCleaner')
include('VilMerlinic.lua')
include('displayBox.lua')
include('organizeritems.lua')


Nuke_Index = 1
Idle_Index = 1
Accuracy_Index = 1
Weapon_Index = 0


MPSet = false
PDTSet = false
capeLocked = false
-- weaponLocked = false


naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

DotDebuffs = S{"Burn", "Choke", "Shock", "Drown", "Frost", "Rasp"}


sets.Weapons = {
	-- Lathi = { name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
	Raetic = {main={ name="Raetic Staff +1"},sub="Enki Strap"},
	Marin = {main={ name="Marin Staff +1"},sub="Enki Strap"}
}

sets.Weapons.index = {"Raetic", "Marin"}

currentWeapon = sets.Weapons.Marin.main

TaranusINT = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}
TaranusMP = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

-- Start Functions here
-- Gear Sets
function get_sets()
	sets.Idle = {}
	sets.precast = {}
	sets.midcast = {}
	sets.JA = {}
	sets.WS = {}
	sets.Idle.index = {"Standard", "DT", "HighMP"}

	sets.Idle.Standard = {main="Bolelabunga",sub="Genmei Shield",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1={name="Stikini Ring +1", bag="Wardrobe4"},ring2={name="Stikini Ring +1", bag="Wardrobe5"},
		back=TaranusINT,waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Herald's Gaiters"}
		
	sets.Idle.DT = set_combine(sets.Idle.Standard, {
		ammo="Staunch Tathlum +1", neck="Loricate Torque +1", 
		head="Nyame Helm", body="Nyame Mail", hands="Nyame Gauntlets",
		legs="Nyame Flanchard", feet="Nyame Sollerets",
	})
	
	sets.Idle.HighMP = set_combine(sets.Idle.Standard, { ammo="Strobilus",
		head="Pixie Hairpin +1", body="Amalric Doublet +1", hands="Amalric Gages +1", legs="Spaekona's Tonban +3", feet="Amalric Nails +1",
		neck="Sanctity Necklace", ear1="Etiolation Earring", ear2="Loquacious Earring", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
		back=TaranusMP, waist="Yamabuki-no-obi"})

	-- PRECAST

	sets.precast.FastCast = {
		head="Nahtirah Hat",neck="Orunmila's Torque", ear1="Malignance Earring", ear2="Loquacious Earring",
		body=MerlinicBody, hands="Telchine Gloves", ring1="Kishar Ring", ring2="Prolix Ring",
		back="Swith Cape",waist="Embla Sash",legs="Psycloth Lappas",feet="Amalric Nails +1"}
	
	sets.Dispelga = { main="Daybreak", sub="Ammurapi Shield"}

	sets.precast.Dispelga = set_combine(sets.precast.FastCast, sets.Dispelga)

	sets.precast.FastCure = set_combine(sets.precast.FastCast, {})
	
	sets.precast.FastCastImpact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})
	
	sets.precast.FastCastHighMP = set_combine(sets.precast.FastCast, {
		hands="Amalric Gages +1", feet="Amalric Nails +1", ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",back=TaranusMP,})
		

	-- MIDCAST
	
	sets.midcast.EnfeeblingMagic = {
		ammo="pemphredo tathlum",
		head="Wicce Petasos +3",neck="Sorcerer's Stole +1",ear1="Barkarole Earring",ear2="Digni. Earring",
		body="Spaekona's Coat +3",hands="Spaekona's Gloves +3",ring1="Sangoma Ring",ring2="Kishar Ring",
		back=TaranusINT,waist="Rumination Sash",legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}},feet="Spaekona's Sabots +3"}

	sets.midcast.Dispelga = set_combine(sets.midcast.EnfeeblingMagic, sets.Dispelga)

	--NUKING SETS

	sets.midcast.ElementalMagic = {
		main=currentWeapon,sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Archmage's Petasos +3",neck="Sorcerer's Stole +1",ear1="Barkarole Earring",ear2="Malignance Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamorph Ring +1",
		back=TaranusINT,waist="Sacro Cord",legs="Amalric slops +1",feet="Amalric Nails +1"}
		
	sets.midcast.ElementalMagic.index = {'Standard', 'Burst'}
	sets.midcast.ElementalMagic.Acc = {}
	sets.midcast.ElementalMagic.Acc.index = {'Damage', 'Accuracy'}

	sets.midcast.ElementalMagic.Standard = sets.midcast.ElementalMagic

	sets.midcast.ElementalMagic.Standard.Damage = sets.midcast.ElementalMagic.Standard

	sets.midcast.ElementalMagic.Standard.Accuracy = set_combine(sets.midcast.ElementalMagic.Standard.Damage, {
	    ammo="Pemphredo Tathlum",
	    head="Wicce Petasos +3",
	    body="Spaekona's Coat +3",
	    hands="Spaekona's Gloves +3",
	    legs="Wicce Chausses +3",
	    feet="Wicce Sabots +2",
	    neck="Sorcerer's Stole +1",
	    waist="Sacro Cord",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Jhakri Ring",
	    right_ring="Sangoma Ring",
	    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	})

	sets.Burst = { 
		ammo="Ghastly Tathlum +1",
		head="Ea hat +1",
		body="Ea Houppelande +1",
		legs="Ea Slops +1",
		neck="Sorcerer's Stole +1",
		feet="Amalric Nails +1", --+50MAB
		ring1="Locus Ring", 
		feet="Spaekona's Sabots +3", --+50 MAcc
		ear1="Regal Earring",
		ring1="Freke Ring",
		-- ring2="Mujin Band",
		back=TaranusINT
		-- ear2="Static Earring",
		-- neck="Mizukage-no-Kubikazari", 
	}

	sets.midcast.MagicBurst = set_combine(sets.midcast.ElementalMagic, sets.Burst)

	sets.midcast.ElementalMagic.Burst = set_combine(sets.midcast.ElementalMagic.Standard, sets.midcast.MagicBurst)

    sets.midcast.ElementalMagic.Burst.Damage = sets.midcast.ElementalMagic.Burst
    
    sets.midcast.ElementalMagic.Burst.Accuracy = set_combine(sets.midcast.ElementalMagic.Burst.Damage, {
        
    })

	--DEBUFFY BITS

	sets.midcast.Impact = set_combine(sets.midcast.ElementalMagicAcc, {head=empty, body="Twilight Cloak", feet="Archmage's Sabots +3"})	
	-- sets.midcast.Impact = set_combine(sets.midcast.OccultAcumen, {head=empty, body="Twilight Cloak"})	
		
	sets.midcast.Stun = {
		ammo="pemphredo tathlum",
		head=MerlinicHead,neck="Voltsurge Torque",ear1="Barkarole Earring",ear2="Crepuscular Earring",
		body="Spaekona's Coat +3",hands="Spaekona's gloves +3",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Spaekona's Tonban +3",feet="Spaekona's Sabots +3"
	}
		

	--DEATH SETS

	sets.midcast.ElementalMagic.HighMP = {
		ammo="Strobilus",
		head=MerlinicHead, neck="Sorcerer's Stole +1",ear1="Etiolation Earring",ear2="Barkarole Earring",
		body="Spaekona's Coat +3",hands="Spaekona's gloves +3",ring1="Mephitas's Ring +1",ring2="Sangoma Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}
	
	sets.midcast.Death = {
		ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Sorcerer's Stole +1",ear1="Barkarole Earring",ear2="Static Earring",
		body="Ea Houppelande +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Spaekona's Tonban +3",feet="Amalric Nails +1"}
	
	sets.midcast.DeathHighMP = {
		ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Sorcerer's Stole +1",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Spaekona's Tonban +3",feet="Amalric Nails +1"}
	
	sets.midcast.DeathHighMPMB = {
		ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Sorcerer's Stole +1",ear1="Barkarole Earring",ear2="Static Earring",
		body="Ea Houppelande +1",hands="Spaekona's Gloves +3",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Spaekona's Tonban +3",feet="Spaekona's Sabots +3"}

	
	
	sets.midcast.DrainAspir = set_combine(sets.midcast.ElementalMagic, {
		head="Pixie Hairpin +1",neck="Voltsurge Torque",  ear1="Crepuscular Earring", ear2="Barkarole Earring",	
		ring2="Archon Ring",back="Taranus's Cape", waist="Fucho-no-obi",feet=MerlinicFeet}
	)
	
	sets.midcast.OccultAcumen = {
	    ammo="Pemphredo Tathlum",
	    body="Spaekona's Coat +3",
	    hands="Ea Cuffs",
	    legs="Perdition Slops",
	    neck="Lissome Necklace",
	    waist="Oneiros Rope",
	    left_ear="Telos Earring",
	    right_ear="Dedition Earring",
	    left_ring="K'ayres Ring",
	    right_ring="Petrov Ring",
	}

	sets.midcast.Cure = {
		ammo="Pemphredo Tathlum",
		neck="Fylgja Torque +1",
		body="Merlinic Jubbah",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Haoma's Ring",
		waist="Cascade Belt",legs="Nares Trews",feet="Vanya Clogs"
	}

	sets.WS.Myrkr = set_combine(sets.Idle.HighMP, {})
	
	-- UTILITY PIECES 

	sets.JA.ManaWall = {back=TaranusMP, feet="Wicce Sabots +3"}
	sets.ElementalDebuff = {legs="Archmage's Tonban +3",feet="Archmage's Sabots +3"}
	sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}
	sets.ElementalMagicMPBody = {body="Spaekona's Coat +3"}

	sets.midcast.Ja = {
		legs="Wicce Chausses +3"
	}


	organizer_items = organizerItems()

    send_command('bind f9 gs c switch MP')
    send_command('bind f10 gs c acc')
    send_command('bind f11 gs c switch mb')
    send_command('bind f12 gs c switch pdt')
    send_command('bind pause gs c nuke')
	send_command('bind end gs c lockWeapon')

	updateTable()

	enable("main")
	enable("sub")
end

function updateTable()
    addToTable("(F9) MP Body", MPSet)
    addToTable("(F10) Dmg or Acc", sets.midcast.ElementalMagic.Acc.index[Accuracy_Index])
    addToTable("(F11) MB Set", sets.midcast.ElementalMagic.index[Nuke_Index])
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    addToTable("(END) Weapon Locked", sets.Weapons.index[Weapon_Index] or "Off")
	addToTable("(PAUSE) Equip Nuke Set     ")
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
		elseif spell.type:contains('WhiteMagic') or spell.type:contains('BlackMagic') then
			equip(sets.precast.FastCast)
			if spell.skill:contains('Enhancing Magic') then
				equip({waist="Siegel Sash"})
				if spell.english:contains('Stoneskin') then
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
	elseif spell.type:contains('BlackMagic') then
		return(sets.midcast.ElementalMagicHighMP)
	else
		return(sets.precast.FastCastHighMP)
	end
	return
end

function getNukeSet()
    set = {}
    if (sets.midcast.ElementalMagic[sets.midcast.ElementalMagic.index[Nuke_Index]][sets.midcast.ElementalMagic.Acc.index[Accuracy_Index]]) then
        set = sets.midcast.ElementalMagic[sets.midcast.ElementalMagic.index[Nuke_Index]][sets.midcast.ElementalMagic.Acc.index[Accuracy_Index]]
    else 
        set = sets.midcast.ElementalMagic[sets.midcast.ElementalMagic.index[Nuke_Index]]
    end
    return set
end

function handleNuke(spell)

	set = getNukeSet()
	set = use_obi(spell, set)

	if (MPSet) then
		set = set_combine(set, {
			body="Spaekona's Coat +3"
		})
	end

	if(spell.english:contains('ja')) then
		set = set_combine(set, sets.midcast.Ja)
	end
	equip(set)
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
	
	if (spell.skill == nil) then
		return
	end

	if (spell.skill == 'Healing Magic') then
        if spell.english:contains('Cura') or spell.english:contains('Cure') then 
            equip(sets.midcast.Cure)
        else
            equip(sets.precast.FastCast)
        end
	elseif spell.skill:contains('Enhancing Magic') then
		equip(sets.midcast.EnhancingMagic)
						
	elseif spell.skill:contains('Enfeebling Magic') or spell.skill:contains('Divine Magic') then
		equip(sets.midcast.EnfeeblingMagic)	
	
	elseif spell.skill:contains('Elemental Magic') then

		equip(handleNuke(spell))
	
	elseif spell.skill:contains('Dark Magic') then
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
        equip(set_combine(sets.Idle[sets.Idle.index[Idle_Index]], sets.JA.ManaWall))
        return
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
    if (buff == "Mana Wall") then
        if (gain) then
            add_to_chat(140, "Disabling feet & back for Mana Wall")
            disable("feet")
            disable("back")
        else
            add_to_chat(140, "Enabling feet & back - Mana Wall Lost")
            enable("feet")
            enable("back")
        end
    end
end

function self_command(command)
    if command == 'switch MP' then
        MPSet = not MPSet
        add_to_chat(140, '<-- Nuking using '..(MPSet and 'MP Recovery' or 'Damage')..' Body -->')
    
    elseif command == 'acc' then
        Accuracy_Index = Accuracy_Index +1
        if Accuracy_Index > #sets.midcast.ElementalMagic.Acc.index then
            Accuracy_Index = 1
        end
    
    elseif command == 'switch mb' then
        Nuke_Index = Nuke_Index +1
        if Nuke_Index > #sets.midcast.ElementalMagic.index then
            Nuke_Index = 1
        end
    
    elseif command == 'switch pdt' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_Index]])

    elseif command == 'nuke' then
        equip(getNukeSet())
    elseif command == 'lockWeapon' then
		enable("Main")
		enable("Sub")
		Weapon_Index = Weapon_Index + 1
		if (Weapon_Index > #sets.Weapons.index) then
			Weapon_Index = 0
		end
        if (Weapon_Index > 0) then
			equip(sets.Weapons[sets.Weapons.index[Weapon_Index]])
			disable("Main")
			disable("Sub")
		end
		str = "Weapon is now "..(Weapon_Index>0 and 'locked' or 'unlocked')
		if (Weapon_Index > 0) then
			str = str..": "..sets.Weapons.index[Weapon_Index]
		end
        add_to_chat(140, '<----- '..str..' ----->')

    elseif command == 'melee' then
        equip(sets.Melee)
        add_to_chat(140, "Equipping Melee set")
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