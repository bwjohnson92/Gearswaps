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
weapon = ""
shield = ""

-- Start Functions here
-- Gear Sets
function get_sets()

	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}

	sets.other = {
		sub="Ochain"
	}

	sets.aftercast.Idle = {
		head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Carmine Cuisses +1",
	    feet="Sakpata's Leggings",
	    left_ring="Murky Ring",
	    right_ring="Gelatinous Ring +1",
	    waist="Flume Belt +1"

	}

	sets.precast.FastCast = {
		ammo="Incantor Stone",
		head="Carmine Mask",
		neck="Voltsurge Torque", ear1="Etiolation Earring", ear2="Loquacious Earring",
		hands="Leyline Gloves",ring1="Kishar Ring",ring2="Weatherspoon Ring +1",
		legs="Psycloth Lappas",feet="Carmine Greaves"
	}

	sets.Enmity = {
		body="Chevalier's Cuirass +1",
		legs="Caballarius Cuisses",
		back="Agema Cape"
	}

	sets.Phalanx = {
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		legs = "Sakpata's Cuisses",
		feet = "Souveran Schuhs",
		back="Weard Mantle",
		waist="Rumination Sash",
	}

	sets.PhalanxIdle = set_combine(sets.Phalanx, {
		main="Sakpata's Sword",
		sub="Priwen"
	})

	sets.Engaged = {
	    ammo="Eluder's Sachet",
	    head={ name="Sakpata's Helm", augments={'Path: A',}},
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Sakpata's Cuisses",
	    feet="Sakpata's Leggings",
	    -- neck="Asperity Necklace",
	    neck="Loricate Torque +1",
	    -- waist="Sailfi Belt +1",
	    waist="Flume Belt +1",
	    left_ear="Cessance Earring",
	    right_ear="Telos Earring",
	    left_ring="Petrov Ring",
	    right_ring="Apate Ring",
	    back={ name="Mecisto. Mantle", augments={'Cap. Point+48%','HP+28','DEF+10',}},
	}

	sets.Engaged.Standard = set_combine(sets.Engaged)

	sets.Engaged.Tank = set_combine(sets.Engaged, {
		left_ring="Murky Ring",
		right_ring="Defending Ring"
	})

	sets.WS = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		neck="Fotia Gorget",
		waist="Fotia Belt"
	}

	sets.WS["Savage Blade"] = set_combine(sets.WS, {
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		neck="Fotia Gorget",
		waist="Fotia Belt"
	})

	sets.WS["Aeolian Edge"] = set_combine(sets.WS, {
		ammo="Oshasha's Treatise",
    	neck="Sibyl Scarf",
		ring1={name="Shiva Ring +1",bag="Wardrobe"},
		ring2={name="Shiva Ring +1",bag="Wardrobe4"},

	})
	
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("PDT", "yellow")
end

function updateTable()
    -- addToTable("(F9) Enfeebling", EnfeebSet and "Accuracy" or "Potency")
    -- addToTable("Enfeeble Potency", not EnfeebSet)
    -- addToTable("(F10) MP Body", MPSet)
    -- addToTable("(F11) MB Set", MBSet)
    -- addToTable("(F12) Idle Set", PDTSet and "PDT" or "Standard")
    addToTable("(PGUP) TP Set", sets.Engaged.index[Melee_Ind])
    -- addToTable("(PGDN) Weapon Locked", weaponLocked)
    update_message()
end

-- --- Precast ---

function precast(spell)
	if string.find(spell.type,'White') or string.find(spell.type,'Black') then
		equip(sets.precast.FastCast)
	elseif string.find(spell.type,'Ability') then
		equip(sets.Enmity)
	end

	if spell.type:lower() == 'weaponskill' then
        if (sets.WS[spell.english]) then
                set = sets.WS[spell.english]
        else
            set = sets.WS
        end
    end

end
-- --- MidCast ---
function midcast(spell)
	if (spell.name == "Phalanx") then
		if player.in_combat then
			equip(sets.Phalanx)
		else
			weapon = player.equipment.main
			shield = player.equipment.sub
			equip(sets.PhalanxIdle)
		end
	end
	if string.find(spell.type,'White') then
		equip(set_combine(sets.aftercast.Idle, sets.Enmity))
	end
end	

-- --- Aftercast ---

function aftercast(spell)
	if player.status == 'Engaged' then
	    equip_TP()
	else
		equip_Idle()
	end
	if (weapon ~= "") then
		equip({main=weapon, sub=shield})
		weapon = ""
		shield = ""
	end
end

function equip_TP()
	equip(sets.Engaged)
end

function equip_Idle()
	equip(sets.aftercast.Idle)
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
        if Melee_Ind > #sets.Engaged.index then Melee_Ind = 1 end
        send_command('@input /echo <----- TP Set changed to '..sets.Engaged.index[Melee_Ind]..' ----->')
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

function buff_change(buff, gain)
    if (gain) then
        add_to_chat(140, "Gained "..buff)
    else
        add_to_chat(140, "Lost "..buff)
    end
end