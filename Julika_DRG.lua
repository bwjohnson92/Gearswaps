require('closetCleaner')
include('organizer-lib.lua')
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

capeLocked = false
weaponLocked = false


capeTP = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken -5%'}}
capeWS = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

-- Start Functions here
-- Gear Sets
function get_sets()

	-- Trishula = "Trishula"
	-- Chango = "Chango"
	Grip = "Utu Grip"

	AFHead = "Vishap Armet +1"
	AFBody = "Vishap Mail +2"
	AFHands = "Vishap Finger Gauntlets +2"
	AFLegs = "Vishap Brais +2"
	AFFeet = "Vishap Greaves +2"

	CapeTP = {name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	    
	CapeWS = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}


	areas = {}
	areas.AdoulinCity = S{'Eastern Adoulin','Western Adoulin','Mog Garden','Celennia Memorial Library'}

	sets.Idle = {
		feet="Hermes' Sandals"
	}

	sets.TP  ={};
	sets.TP.index = {'Standard', 'DT'}
	TP_ind = 1
	
	sets.Weapons = {
		main="Shining One",
		sub="Utu Grip"
	}

	sets.TP.Standard = {
	    ammo="Ginsen",
	    head="Flam. Zucchetto +2",
	    body="Flamma Korazin +2",
	    -- body="Valorous Mail",
--	    hands={ name="Odyssean Gauntlets", augments={'Accuracy+25 Attack+25','Weapon Skill Acc.+3','DEX+5','Accuracy+1','Attack+12',}},
--		hands="Emicho Gauntlets",
		hands="Sulevia's Gauntlets +2",
	    legs="Sulevia's Cuisses +2",
	    feet="Flamma Gambieras +2",
	    neck="Clotharius Torque",
	    right_ear="Telos Earring",
	    left_ear="Cessance Earring",
	    left_ring="Flamma Ring",
	    right_ring="Chirich Ring +1",
	    back=CapeTP,
	    waist="Ioskeha Belt +1"
	}

	sets.DT = {
		ammo="Vanir Battery",
	    head="Hjarrandi Helm",
	    body="Hjarrandi Breast.",
	    hands="Sulev. Gauntlets +2",
	    legs="Pumm. Cuisses +3",
	    feet="Pumm. Calligae +3",
	    neck="Loricate Torque +1",
	    waist="Ioskeha Belt +1",
	    left_ear="Cessance Earring",
	    right_ear="Brutal Earring",
	    left_ring="Defending Ring",
	    right_ring="Regal Ring",
	    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	}

	sets.DT2 = {    
		ammo="Staunch Tathlum",
    	head="Hjarrandi Helm",
	    body="Hjarrandi Breast.",
	    hands="Sulev. Gauntlets +2",
	    legs="Pumm. Cuisses +3",
	    feet="Pumm. Calligae +3",
	    neck="War. Beads +1",
	    waist="Ioskeha Belt +1",
	    left_ear="Cessance Earring",
	    right_ear="Brutal Earring",
	    left_ring="Defending Ring",
	    right_ring="Regal Ring",
	    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	}

	sets.TP.DT = sets.DT2


	-- sets.Hybrid = {
	--     ammo="Staunch Tathlum",
	--     head="Flam. Zucchetto +2",
	--     neck="Loricate Torque +1",
	--     ear1="Darkness Earring",
	--     ear2="Genmei Earring",
	--     body="Souv. Cuirass +1",
	--     hands="Sulev. Gauntlets +2",
	--     ring1="Moonlight Ring",
	--     ring2="Defending Ring",
	--     back="Cichol's Mantle",
	--     waist="Ioskeha Belt +1",
	--     legs="Sulev. Cuisses +2",
	--     feet="Pumm. Calligae +3"
	-- }

	sets.WS = {
	    ammo="Knobkierrie",
	    head="Flam. Zucchetto +2",
	    body="Dagon Breast.",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulevia's Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Niqmaddu Ring",
	    right_ring="Regal Ring",
	    back=capeWS
	}

	sets.Impulse = {
	    main="Shining One",
	    sub="Utu Grip",
	    ammo="Knobkierrie",
	    head="Flam. Zucchetto +2",
	    body="Dagon Breast.",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulevia's Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Fotia Gorget",
	    waist="Metalsinger Belt",
	    left_ear="Ishvara Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Niqmaddu Ring",
	    right_ring="Regal Ring",
	    back=capeWS
	}

	sets.Jump = {
		body=AFBody,
		hands=AFHands,
		legs=AFLegs,
		feet=AFFeet,
		back=capeTP
	}

	sets.Reraise = {
		head="Twilight Helm",
		body="Twilight Mail"
	}

	windower.register_event('zone change', function()
		equip(customize_idle_set(sets.Idle))
	end)

    send_command('bind f10 gs c toggle TP set')

 text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("DT", "yellow")
end

function updateTable()
    addToTable("(F10) TP Set", sets.TP.index[TP_ind])
    update_message()
end

-- --- Precast ---

function precast(spell)
	if spell.english == "Impulse Drive" then
		equip(sets.Impulse)
		add_to_chat(140,'Impulse!')
	elseif spell.action_type == 'WeaponSkill' then	
			add_to_chat(140,'Weaponskill!')
			equip(sets.WS)
	end

	if string.find(spell.english, "Jump") then
		equip(sets.Jump)
	end
end
-- --- MidCast ---
function midcast(spell)
end	

-- --- Aftercast ---



function aftercast(spell)
	if player.status == 'Engaged' then
            equip_TP()
    else
    	equip(customize_idle_set(sets.Idle))
    end
end

-- Status Change - ie. Resting

function equip_TP()
	-- equip(sets.TP)
	equip(sets.TP[sets.TP.index[TP_ind]])
end

function status_change(new,tab)
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
		--disable("Main")
	else
		equip(sets.Idle)
		--enable("Main")
	end
end

function customize_idle_set(idleSet)
    if areas.AdoulinCity:contains(world.area) then
        idleSet = set_combine(idleSet, {body="Councilor's Garb"})
    end
 
    return idleSet
end

function self_command(command)
	 if command == 'toggle TP set' then
            TP_ind = TP_ind + 1
            if TP_ind > #sets.TP.index then TP_ind = 1 end
            send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
            equip(sets.TP[sets.TP.index[TP_ind]])
        end
        updateTable()
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
        equip_set = set_combine(equip_set, { waist = "Hachirin-No-Obi"})
    end
 
    return equip_set
end