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

-- Start Functions here
-- Gear Sets
function get_sets()

	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}

	sets.desperation = {body="Seidr Cotehardie"}

	-- sets.aftercast.Idle = {
	--     main="Naegling",
	--     sub="Sacro Bulwark",
	--     ammo="Incantor Stone",
	--     head="Twilight Helm",
	--     body="Twilight Mail",
	--     hands="Sulev. Gauntlets +2",
	--     legs={ name="Carmine Cuisses +1", augments={'MP+80','INT+12','MND+12',}},
	--     feet="Sulev. Leggings +2",
	--     neck="Loricate Torque +1",
	--     waist="Cetl Belt",
	--     left_ear="Etiolation Earring",
	--     right_ear="Loquac. Earring",
	--     left_ring="Defending Ring",
	--     right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
	--     back="Repulse Mantle",
	-- }

	sets.aftercast.Idle = {
		head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Carmine Cuisses +1",
	    feet="Sakpata's Leggings",
	    left_ring="Defending Ring",
	    right_ring="Gelatinous Ring +1",
	    waist="Flume Belt"

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

	sets.WS = {}

	sets.WS.SavageBlade = set_combine(sets.Melee,{

	})

	sets.Melee = {
		ammo="Ginsen",
		head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
    	legs="Sakpata's Cuisses",
	    feet="Sakpata's Leggings",
	    ring1="Petrov Ring",
	    ring2="Apate Ring",
	    waist="Celt Belt",

	}
	
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
	if string.find(spell.type,'White') or string.find(spell.type,'Black') then
		equip(sets.precast.FastCast)
	elseif string.find(spell.name,'Savage Blade') then
		equip(sets.WS.SavageBlade)
	elseif string.find(spell.type,'Ability') then
		equip(sets.Enmity)
	end

end
-- --- MidCast ---
function midcast(spell)
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
end

function equip_TP()
	equip(sets.Melee)
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