require('closetCleaner')
include('organizer-lib.lua')
include('Grioavolr.lua')
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
AccuracySet = false
MBSet = false
MPBodyEquipToggle = false
perpOn = false

capeFastCast = { name="Lugh's Cape", augments={'"Fast Cast"+10','Phys. dmg. taken-10%',}}
capeNuke = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}

skillchains = {}
skillchains.Index = 1
skillchains.SC = {"Fusion", "Fragmentation", "Distortion", "Gravitation"}

skillchains.Fusion = {"Fire", "Thunder"}
skillchains.Fragmentation = {"Blizzard", "Water"}
skillchains.Distortion = {"Luminohelix", "Stone"}
skillchains.Gravitation = {"Aero", "Noctohelix"}

skillchains.Elements = {}
skillchains.Elements.Fusion = {"Fire", "Light"}
skillchains.Elements.Fragmentation = {"Thunder", "Aero"}
skillchains.Elements.Distortion = {"Ice", "Water"}
skillchains.Elements.Gravitation = {"Stone", "Darkness"}

Idle_Index = 1

function get_sets()

    sets.precast = {}
    sets.midcast = {}
    sets.aftercast = {}

    sets.Idle = {}

    -- AFTERCAST

    sets.Idle.Standard = {main="Bolelabunga",sub="Genmei Shield", ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Amalric Gages +1",ring1={name="Stikini Ring +1", bag="Wardrobe4"},ring2={name="Stikini Ring +1", bag="Wardrobe5"},
        back=capeFastCast,waist="Embla Sash",legs="Assid. Pants +1",feet="Herald's Gaiters"}

    sets.Idle.PDT = {main="Malignance pole",sub="Mensch strap", ammo="Homiliary",
        head="Nyame Helm", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Genmei Earring",
        body="Jhakri Robe +2", hands="Nyame Gauntlets",ring1={name="Stikini Ring +1", bag="Wardrobe4"},ring2={name="Stikini Ring +1", bag="Wardrobe5"},
        back=capeNuke, waist="Embla Sash", legs="Nyame Flanchard", feet="Nyame Sollerets"}
        
    sets.Idle.Index = {"Standard", "PDT"}
    -- PRECAST

    sets.precast.FastCast = {main="Grioavolr",sub="Clerisy Strap",ammo="Incantor Stone",
        head="Nahtirah Hat" ,neck="Voltsurge Torque", ear1="Malignance Earring", ear2="Loquacious Earring",
        body="Merlinic Jubbah", hands="Academic's Bracers +2", ring1="Kishar Ring", ring2="Medada's Ring",
        back=capeFastCast,waist="Embla Sash",legs="Psycloth Lappas", feet="Regal Pumps +1"}
    
     sets.precast.Grimoire = set_combine(sets.precast.FastCast, {
     	head="Pedagogy Mortarboard +2",
     	feet="Academic's Loafers +2"
     	})

    sets.precast.FastCure = set_combine(sets.precast.FastCast, {})
        
    -- MIDCAST

    -- BLACK MAGIC / ENFEEBLING

    sets.midcast.EnfeeblingMagic = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo tathlum",
        head="",neck="Argute Stole +1",ear1="Malignance Earring",ear2="Dignitary's Earring",
        body="Cohort Cloak +1",hands="Jhakri Cuffs +2", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
        back=capeNuke,waist="Luminary Sash",legs="Chironic hose",feet="Nyame sollerets"}

    
    sets.midcast.ElementalMagic = { 
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Merlinic Hood",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands={ name="Amalric Gages +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        legs="Merlinic Shalwar", 
        feet="Merlinic Crackows",
        neck="Sanctity Necklace",
        waist="Sacro Cord",
        left_ear="Regal Earring",
        right_ear="Malignance Earring",
        left_ring="Freke Ring",
        right_ring="Medada's Ring",
        back=capeNuke
    }      

    sets.midcast.Helix = set_combine(sets.midcast.ElementalMagic, {
    	neck="Argute Stole +1" -- When aug'd
    })

    sets.midcast.Luminohelix = set_combine(sets.midcast.Helix, {
    	main="Daybreak", sub="Ammurapi Shield"
    })

    sets.midcast.ElementalMagicAcc = set_combine(sets.midcast.ElementalMagic, {

    })

    sets.midcast.ElementalMagicMP = set_combine(sets.midcast.ElementalMagic, {body = "Witching Robe"})
        
    sets.midcast.Stun = {main="Akademos",sub="Clerisy Strap",ammo="Hydrocera",
        head=MerlinicHoodNuke,neck="Voltsurge Torque",ear1="Dignitary's Earring",ear2="Barkarole Earring",
        body="Merlinic Jubbah",hands="Agwu's Gages",ring1="Sangoma Ring",
        waist="Witful Belt",legs="Psycloth Lappas",feet="Merlinic Crackows"}
        
    sets.midcast.MagicBurst = {
    	neck="Mizukage-no-Kubikazari", --10
        hands="Amalric Gages +1", ring1="Mujin Band", ring2="Locus Ring", --9,(5),(5),5 
        } --5, 9 
        
    sets.precast.Impact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})
    sets.midcast.Impact = set_combine(sets.midcast.ElementalMagic, {head=empty, body="Twilight Cloak"}) 


    -- WHITE MAGIC / ENHANCING


    sets.midcast.EnhancingMagic = {
        main="Bolelabunga", sub="Ammurapi Shield",
        head="Telchine Cap",neck="Incanter's Torque",ear1="Dignitary's Earring",ear2="Loquacious Earring",
        hands="Telchine Gloves",hands="Telchine Gloves",
        back=capeFastCast,waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}

    sets.midcast.Cure = {
	    main="Bunzi's Rod",
	    -- sub="Ammurapi Shield",
        sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
	    -- ammo="Homiliary",
	    -- head="Vanya Hood",
        head="Kaykaus Mitra +1",
	    -- body="Vrikodara Jupon",
        body="Nyame Mail",
	    hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +7',}},
	    -- legs={ name="Chironic Hose", augments={'Mag. Acc.+25','"Fast Cast"+5','CHR+1',}},
        legs="Nyame Flanchard",
        feet="Kaykaus Boots +1",
	    -- neck="Orunmila's Torque",
        neck="Loricate Torque +1",
	    waist="Bishop's Sash",
	    left_ear="Beatific Earring",
	    right_ear="Healing Earring",
	    -- left_ring="Naji's Loop",
        left_ring="Defending Ring",
	    right_ring="Janniston Ring +1"
	}

	-- REGEN CAST

    sets.Regen = {
    	main="Bolelabunga",
    	sub="Ammurapi Shield",
    	ammo="Staunch Tathlum +1",
	    head="Arbatel Bonnet +3",
	    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
	    hands="Arbatel Bracers +3",
	    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
	    neck="Voltsurge Torque",
	    waist="Embla Sash",
	    left_ear="Augment. Earring",
	    right_ear="Mimir Earring",
	    left_ring="Stikini Ring +1",
	    right_ring="Prolix Ring",
	    back=capeFastCast

	}

	sets.Cursna = set_combine(sets.precast.FastCast, {
		ring1="Menelaus's Ring",
		ring2="Haoma's Ring",
		feet="Vanya Clogs",
		neck="Debilis Medallion"
	})
    
	sets.Chatoyant ={
		main="Chatoyant Staff",
		sub="Enki Strap"
	}

    sets.JA = {}

    sets.JA["Tabula Rasa"] = {legs="Pedagogy Pants +1"}
    
    sets.Perpetuance = {hands="Arbatel Bracers +3"}
    
    sets.Klimaform = {feet="Arbatel Loafers +3"}

    sets.Ebullience={head="Arbatel Bonnet +3"}
    
    sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}
    
    sets.Sublimation = {head="Academic's Mortarboard +2", body="Pedagogy Gown +2", waist="Embla Sash"}
    
    send_command('bind f9 gs c switch sc')
    send_command('bind f11 gs c switch mb')
    send_command('bind f10 gs c switch MP')
    send_command('bind f12 gs c switch dt')

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
	addToTable("(F9) Skillchain", getSkillchainString())
	-- addToTable("(F10) MP Body", MPBodyEquipToggle)
	addToTable("(F11) MB Set", MBSet)
	addToTable("(F12) Idle Set", sets.Idle.Index[Idle_Index])
	-- addToTable("(END) Weapon Locked", weaponLocked)
	update_message()
end

function getSkillchainString()
    length = 30
    scType = skillchains.SC[skillchains.Index]
    -- add_to_chat(140, scType)
    scElements = skillchains.Elements[scType]
    -- add_to_chat(140, scElements)
    -- finalString = scType + " " + scElements[0] + "/" scElements r[1]
    finalString = scType .. " (" .. scElements[1] .. "/" .. scElements[2] .. ")"
    while (string.len(finalString) < length) do
        finalString = finalString .. " "
    end
    return finalString

end

-- --- Precast ---

function precast(spell)
    if (spell.name == "Impact") then
        equip(sets.precast.Impact)

    elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') or string.find(spell.type, 'Trust') then
    	if (string.find(spell.type,'WhiteMagic') and (buffactive['light arts'] or buffactive['addendum: white'])) then
    		equip(sets.precast.Grimoire)
    	elseif (string.find(spell.type,'BlackMagic') and (buffactive['dark arts'] or buffactive['addendum: black'])) then
			equip(sets.precast.Grimoire)
    	else
        	equip(sets.precast.FastCast)
        end

    elseif sets.JA[spell.english] then
        equip(sets.JA[spell.english])
    end
    
end

function handleNuke(spell, set)

	if (set == nil or set == '' or set == {}) then
		set = sets.midcast.ElementalMagic
	end

	if(MBSet) then
		set = set_combine(set, sets.midcast.MagicBurst)
	elseif(AccuracySet) then
		set = set_combine(set, sets.midcast.ElementalMagic.Acc)
	end

	if (MPBodyEquipToggle) then
		set = set_combine(set, sets.ElementalMagicMPBody)
	end
	equip (use_obi(spell, set))
end

-- --- MidCast ---
function midcast(spell)
    if (spell.name == "Impact") then
        equip(sets.midcast.Impact)
        return
    end
    
    if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        if string.find(spell.skill,'Healing Magic') then
            if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
                equip(sets.midcast.Cure)
                if (weather_check(spell)) then
                	equip(sets.Chatoyant)
                end
            elseif string.find(spell.english, 'Regen') then
                equip(set_combine(sets.precast.FastCast, sets.Regen))
            elseif string.find(spell.english, 'Cursna') then
            	equip(sets.Cursna)
            else
                equip(sets.precast.FastCast)    
            end
            
        elseif string.find(spell.skill,'Enhancing Magic') then
            if(buffactive["Perpetuance"]) then
                equip(set_combine(sets.midcast.EnhancingMagic, sets.Perpetuance))
            else
                equip(sets.midcast.EnhancingMagic)
            end
            
        elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
            equip(sets.midcast.EnfeeblingMagic) 
            
        elseif string.find(spell.skill,'Elemental Magic') then
        	if (spell.english:endswith('helix')) then
        		if (string.find(spell.english, 'Lumino')) then
        			handleNuke(spell, sets.midcast.Lumino)
        		else
        			handleNuke(spell, sets.midcast.Helix)
        		end
        	else
            	handleNuke(spell, sets.midcast.ElementalMagic)
            end
        else
            equip(sets.precast.FastCast)
        end
    end
end 

-- --- Aftercast ---

function aftercast(spell)
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

function equip_idle()
    equip(sets.Idle[sets.Idle.Index[Idle_Index]])
end

-- Status Change - ie. Resting

function status_change(new,tab)

end

function self_command(command)
	if command == 'switch MP' then
		MPBodyEquipToggle = not MPBodyEquipToggle
		add_to_chat(140, '<-- Nuking using '..(MPBodyEquipToggle and 'MP Recovery' or 'Damage')..' Body -->')
	end

    if command == 'switch dt' then
        Idle_Index = Idle_Index + 1
        if Idle_Index > #sets.Idle.Index then Idle_Index = 1 end
        equip_idle()
    end

	if command == 'switch mb' then
        if (MBSet) then
            MBSet = false
            add_to_chat(140,'Magic Burst: Off')
        else
            MBSet = true
            add_to_chat(140,'Magic Burst: On')
        end
    end
    if command == 'switch MP' then
        MPSet = not MPSet
        add_to_chat(140, 'Elemental Magic: '..(MPSet and 'MP' or 'Damage'))
    end

    if command == 'switch sc' then
    	skillchains.Index = skillchains.Index +1
    	if skillchains.Index > #skillchains.SC then skillchains.Index = 1 end
    end

    if string.find(command,'scnuke') then
    	local nuke
    	if (string.find(command, '1')) then
    		nuke = skillchains[skillchains.SC[skillchains.Index]][1]
    	elseif (string.find(command, '2')) then
    		nuke = skillchains[skillchains.SC[skillchains.Index]][2]
    	else
    		return
    	end
    	send_command('@input /ma "'..nuke..'" <t>')    	
    end

    updateTable()
end

function use_MB(equip_set)
    if (MBSet) then
        equip_set = set_combine(equip_set, sets.midcast.MagicBurst)
    end
    return equip_set
end

function weather_check(spell)

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
    return use_obi
end

function use_obi(spell, equip_set)
    
 	local use_obi = weather_check(spell)
    if (use_obi) then
        equip_set = set_combine(equip_set, sets.midcast.ElementalDay)
        if(buffactive['Klimaform']) then
            equip_set = set_combine(equip_set, sets.Klimaform)
        else
            add_to_chat(140, 'Where\'s your Klimaform!')
        end
    end
 
    return equip_set
end