require('closetCleaner')
include('organizer-lib.lua')
include('displayBox/displayBox.lua')

MagicBurstFlag = false

-- Start Functions here
-- Gear Sets

Utsu    = S {"Utsusemi: Ichi", "Utsusemi: Ni", "Utsusemi: San"}
Nukes   = S {"Katon: Ichi", "Katon: Ni", "Katon: San",
			"Suiton: Ichi", "Suiton: Ni", "Suiton: San",
			"Raiton: Ichi", "Raiton: Ni", "Raiton: San",
			"Doton: Ichi", "Doton: Ni", "Doton: San",
			"Huton: Ichi", "Huton: Ni", "Huton: San",
			"Hyoton: Ichi", "Hyoton: Ni", "Hyoton: San"}
Enfeebles = S {"Hojo: Ichi", "Hojo: Ni", "Kurayami: Ichi", "Kurayami: Ni", "Jubaku: Ichi", "Dokumori: Ichi", "Aisha: Ichi", "Yurin: Ichi"}
Enhancing = S {"Tonko: Ichi", "Tonki: Ni", "Monomi: Ichi", "Myoshu: Ichi", "Kakka: Ichi", "Migawari: Ichi", "Gekka: Ichi", "Yain: Ichi"}
proc_ws   = S {"Shadow of Death", "Raiden Thrust", "Freezebite", "Tachi: Jinpu", "Tachi: Koki", "Earth Crusher", "Sunburst", "Red Lotus Blade", "Seraph Blade", "Cyclone", "Energy Drain", "Seraph Strike"}
fastcast  = S {"Ninjutsu", "Enhancing Magic", "Elemental Magic", "Divine Magic", "Dark Magic", "(N/A)"}



function get_sets()

	gear = {}
    gear.Artifact = {}
    gear.Artifact.head  = { name="Hachi. Hatsu. +3" }
    gear.Artifact.body  = { name="Hachiya Chainmail +3"}
    gear.Artifact.hands = { name="Hachiya Tekko +3"}
    gear.Artifact.legs  = { name="Hachiya Hakama +3"}
    gear.Artifact.feet  = { name="Hachiya Kyahan +3" }

    gear.Relic = {}
    gear.Relic.head  = { name="Mochi. Hatsu. +3"}
    gear.Relic.body  = { name="Mochi. Chainmail +3"}
    gear.Relic.hands = { name="Mochizuki Tekko +3"}
    gear.Relic.legs  = { name="Mochi. Hakama +3"}
    gear.Relic.feet  = { name="Mochi. Kyahan +3"}

    gear.Empyrean = {}
    gear.Empyrean.head  = { name="Hattori Zukin +2"}
    gear.Empyrean.body  = { name="Hattori Ningi +2"}
    gear.Empyrean.hands = { name="Hattori Tekko +3"}
    gear.Empyrean.legs  = { name="Hattori Hakama +3"}
    gear.Empyrean.feet  = { name="Hattori Kyahan +3"}

	gear.AmbuCape = {}

	-- TP GEAR --

	sets.TP  ={};
	sets.TP.index = {'Standard'}

	sets.TP.Standard = {
	    ammo="Date Shuriken",
	    head="Malignance Chapeau",
	    body=gear.Artifact.body,
		hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Null Loop",
	    left_ear="Cessance Earring",
	    right_ear="Hattori Earring +2",
	    left_ring="Chirich Ring +1",
	    right_ring="Ilabrat Ring",
	    -- back=CapeTP,
	    waist="Windbuffet Belt +1"
	}

	-- WEAPONSKILLS --

	sets.WS = {
	    ammo="Knobkierrie",
		head=gear.Artifact.head,
	    body="Nyame Mail",
	    hands="Nyame Gauntlets",
	    legs="Nyame Flanchard",
	    feet="Nyame Sollerets",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring"},
	    right_ear="Thrud Earring",
	    right_ring="Regal Ring",
	    left_ring="Niqmaddu Ring"
	}

	-- HYBRID WS --
	sets.WS["Blade: Chi"] = set_combine(sets.WS, {
		ammo="Seething Bomblet +1",
		right_ring="Epamindondas's Ring",
		left_ring="Gere Ring"

	})
	sets.WS["Blade: To"] = set_combine(sets.WS, {
		ammo="Seething Bomblet +1",
		right_ring="Epamindondas's Ring",
		left_ring="Gere Ring"

	})
	sets.WS["Blade: Teki"] = set_combine(sets.WS, {
		ammo="Seething Bomblet +1",
		right_ring="Epamindondas's Ring",
		left_ring="Gere Ring"

	})

	-- OTHERS --
	sets.WS["Blade: Rin"] = set_combine(sets.WS, {

	})
	sets.WS["Blade: Retsu"] = set_combine(sets.WS, {

	})
	sets.WS["Blade: Ei"] = set_combine(sets.WS, {

	})
	sets.WS["Blade: Jin"] = set_combine(sets.WS, {

	})
	sets.WS["Blade: Ten"] = set_combine(sets.WS, {

	})
	sets.WS["Blade: Ku"] = set_combine(sets.WS, {

	})
	sets.WS["Blade: Yu"] = set_combine(sets.WS, {

	})
	sets.WS["Blade: Kamu"] = set_combine(sets.WS, {
		head="Hachiya Hatsuburi +4",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck="Ninja Nodowa +1",
		waist="Sailfi Belt +1",
		back="Andartia's Mantle",
		ammo="Crepuscular Pebble"

	})
	sets.WS["Blade: Hi"] = set_combine(sets.WS, {

	})
	sets.WS["Blade: Shun"] = set_combine(sets.WS, {
		head="Mpaca's Cap",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Mpaca's Hose",
		feet="Hattori Kyahan +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ring="Gere Ring",
		left_ring="Regal Ring",
		ammo="Coiste Bodhar",
		left_ear="Hattori Earring +2"

	})

	-- JOB ABILITIES -- 

	sets.JA = {}

	-- Example: sets.JA["Provoke"] = {}

	-- IDLE --

	sets.Idle = set_combine(sets.TP, {
		head="Nyame Helm",
		body=gear.Artifact.body,
		hands="Nyame Gauntlets",
		legs=gear.Artifact.legs,
		feet="Danzo Sune-ate",
		waist="Patentia Sash",
		ear1="Suppanomimi",
		ear2="Eabani Earring",
		ring1="Murky Ring",
		ring2="Defending Ring",
	})

	sets.Idle.DT = set_combine(sets.Idle, {

	})

	-- CASTING SETS -- 
	sets.precast = {}

	sets.precast.FastCast = {
		head="Herculean Helm",
		body="Dread Jupon",
		hands="Leyline Gloves",
		neck="Orunmila's Torque",
		ear1="Etiolation Earring",
        ear2="Loquac. Earring",
        ring1="Medada's Ring",
        ring2="Prolix Ring",

	}

	sets.precast.Utsusemi = set_combine(sets.precast.FastCast, {

	})

	sets.Enmity = {

	}

	sets.midcast = {}
	sets.midcast.Utsusemi = {

	}

	sets.midcast.Nuke = {

	}

	sets.midcast.MagicAccuracy = set_combine(sets.precast.FastCast, {

	})

	sets.midcast.SpellInterruption = {

	}

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
    update_message()
end

-- --- Precast ---

function precast(spell)
	type = spell.type:lower()
	if (type == "jobability" and sets.JA[spell.name]) then
		equip(sets.JA[spell.name])
	elseif (type == "weaponskill") then
		if (sets.WS[spell.name]) then
			equip(sets.WS[spell.name])
		else
			equip(sets.WS)
		end

	elseif Utsu:contains(spell.name) then
        equip(set_combine(sets.precast.FastCast, sets.precast.Utsusemi))

	elseif fastcast:contains(spell.skill) then -- Default to FastCast set only if casting a spell (don't equip FastCast for JA or items)
        equip(sets.precast.FastCast)

	end
end
-- --- MidCast ---
function midcast(spell)
	if spell.skill == "Ninjutsu" then

        if spell.name == "Migawari: Ichi" then
            equip(set_combine(sets.Idle.DT, sets.precast.FastCast))

        elseif Utsu:contains(spell.name) then
            if buffactive["Yonin"] and UtsuEnmityFlag==true then
                equip(set_combine(sets.Idle.DT, sets.Enmity, sets.midcast.Utsusemi))
            else
                equip(set_combine(sets.Idle.DT, sets.midcast.SpellInterruption, sets.midcast.Utsusemi))
            end
            -- Cancel high tiers of Utsusemi when casting lower tiers:
            if not buffactive["Copy Image (4+)"] and not buffactive["Copy Image (3)"] and not buffactive["Copy Image (2)"] and not buffactive["Copy Image"] or current_utsusemi == nil then
                -- If there is no Copy Image buff up, then set current Utsusemi priority = 0
                -- Cancel any pre-existing Utsusemi during this mid-cast.
                --   This is for the edge-case that occurs when you load this gearswap with shadows already up.
                --   It prevents it from throwing an error for the first cast before a priority is set.
                windower.ffxi.cancel_buff(446)  -- Copy Image (4+)
                windower.ffxi.cancel_buff(445)  -- Copy Image (3)
                windower.ffxi.cancel_buff(444)  -- Copy Image (2)
                windower.ffxi.cancel_buff(66)   -- Copy Image
                current_utsusemi = 0
            else
                -- If Utsusemi is already up, determine the priority of the Utsusemi being casted.
                if spell.name == "Utsusemi: Ichi" then
                    try_utsusemi = 1
                elseif spell.name == "Utsusemi: Ni" then
                    try_utsusemi = 2
                elseif spell.name == "Utsusemi: San" then
                    try_utsusemi = 3
                end
                if try_utsusemi < current_utsusemi then
                    -- This will still remove the existing Copy Image if you get interrupted.
                    -- using 'if not spell.interrupted' does not work for midcast
                    -- cancelling Copy Image and getting interrupted isn't optimal, but it's better than casting Utsusemi and not getting any shadows.
                    -- plus, if you got interrupted, then you probably don't have shadows anyway. So this is fine as is.
                    windower.ffxi.cancel_buff(446)  -- Copy Image (4+)
                    windower.ffxi.cancel_buff(445)  -- Copy Image (3)
                    windower.ffxi.cancel_buff(444)  -- Copy Image (2)
                    windower.ffxi.cancel_buff(66)   -- Copy Image
                end
            end

        elseif Nukes:contains(spell.name) then

            if MagicBurstFlag == true then
                equip(sets.midcast.MagicBurst)
            else
                equip(sets.midcast.Nuke)
            end

            if buffactive["Futae"] then
                equip({hands = gear.Empyrean.hands})
            end

            if (world.weather_element == spell.element and world.day_element == spell.element) or (world.weather_element == spell.element and weather_intensity == 2) then
                equip({waist="Hachirin-no-Obi"})
            elseif world.weather_element == spell.element or world.day_element == spell.element then
                equip({waist="Hachirin-no-Obi"})
            end

        elseif Enfeebles:contains(spell.name) then
            equip(sets.midcast.MagicAccuracy)

        elseif Enhancing:contains(spell.name) then
            equip(sets.midcast.SpellInterruption)
        end

    elseif spell.name=="Provoke" or spell.name=="Animated Flourish" or spell.name=="Flash" or spell.name=="Warcry" then
        equip(sets.Enmity)
    end
end	

-- --- Aftercast ---

function aftercast(spell)
	check_for_idle()
	
	if Utsu:contains(spell.name) then
        if not spell.interrupted then
            -- If the spell is not interrupted, then set the current Utsusemi spell's priority.
            -- In other words: don't set a priority if the spell got interrupted for some reason.
            -- This current priority is compared to any future Utsusemi being casted.
            -- The higher priority loses and is removed to allow lower priority to take effect.
            -- This way you avoid "Utsusemi: Ichi fails to take effect." when casting Ichi with Ni/San shadows up still.
            if spell.name == "Utsusemi: Ichi" then
                current_utsusemi = 1
            elseif spell.name == "Utsusemi: Ni" then
                current_utsusemi = 2
            elseif spell.name == "Utsusemi: San" then
                current_utsusemi = 3
            end
        end
    end
end


function check_for_idle()
	if player.status == "Idle" then
		equip(sets.Idle)

		if world.time/60. > 17 or world.time/60. < 7 then
			equip({feet = gear.Artifact.feet})
		else
			equip({feet="Danzo Sune-Ate"})
		end
	elseif player.status == "Engaged" then
		equip(sets.TP.Standard)
	end
end

function status_change(new,tab)
	if (new == "Idle" or new == "Enagaged") then
		check_for_idle()
	end
end

function self_command(command)
	 if command == 'toggle TP set' then
        TP_ind = TP_ind + 1
        if TP_ind > #sets.TP.index then TP_ind = 1 end
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'equip_current' then
    	equip_current()
    end
    equip_current()
    updateTable()
end