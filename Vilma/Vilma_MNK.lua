include('organizer-lib.lua')
include('displayBox/displayBox.lua')
-- Local Settings, setting the zones prior to use

Idle_Index = 1
Run_Index = 1
Staff_Count = 0
Hand_Count = -1
autoShoot = false
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

-- capeDEX={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
capeDEX={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
capeSTR={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}

-- Start Functions here
-- Gear Sets
function get_sets()

sets.Idle = {}
sets.Idle.index = {"Standard", "DT"}
sets.Idle.Standard = {
    feet="Herald's Gaiters"
}

sets.Idle.DT = set_combine(sets.Idle.Standard, {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    feet="Malignance Boots",
})

sets.TP = {}
sets.TP.index = {'Standard', 'Accuracy', 'DT'}
TP_ind = 1


sets.TP.Standard = {
    ammo="Coiste Bodhar",
    head="Malignance Chapeau",
    body="Tatena. Harama. +1",
    hands="Adhemar Wrist. +1",
    legs="Ken. Hakama +1",
    feet="Tatena. Sune. +1",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    ear1="Sherida Earring",
    ear2="Dedition Earring",
    ring1="Gere Ring",
    ring2="Epona's Ring",
    back=capeDEX
}

sets.TP.Accuracy = set_combine(sets.TP.Standard, {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    feet="Malignance Boots",
    legs="Kendatsuba Hakama +1",
})

sets.TP.DT = set_combine(sets.TP.Standard, {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    feet="Malignance Boots",
    legs="Kendatsuba Hakama +1",
})

sets.TP.Staff = {
    main="Malignance Pole",
    sub="Rigorous Grip +1"
}

sets.TP.H2H = {
    main="Godhands"
}

--Weapon skill sets

sets.WS = {}
sets.WS.index = {'Standard', 'Mid', 'Accuracy'}
WS_ind = 1

sets.WS.Generic = {
    ammo="Knobkierrie",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear2="Moonshade Earring",
    legs="Kendatsuba Hakama +1",
    back=capeSTR
}

sets.WS.Generic.Standard = sets.WS.Generic
sets.WS.Generic.Mid = set_combine(sets.WS.Generic.Standard, {
    
})

sets.WS.Generic.Acc = set_combine(sets.WS.Generic.Mid, {

})

sets.WS["Victory Smite"] = set_combine(sets.WS.Generic.Standard, { --STR, Acc/Att, DA
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Tatena. Harama. +1",
    hands="Mpaca's Gloves",
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    ear1="Sherida Earring",
    ear2="Bhikku Earring +1",
    ring1="Niqmaddu Ring",
    ring2="Gere Ring",
    back="Segomo's Mantle",
})

sets.WS["Victory Smite"].Mid = set_combine(sets.WS["Victory Smite"].Standard, {
    head="Malignance Chapeau"
})

sets.WS["Victory Smite"].Acc = set_combine(sets.WS["Victory Smite"].Mid, {
    neck="Monk's Nodowa +1"
})

sets.WS["Shijin Spiral"] = set_combine(sets.WS.Generic.Standard, { --DEX, Acc/Att, DA
    ammo="Knobkierrie",
    head="Adhemar Bonnet +1",
    body="Bhikku Cyclas +3",
    hands="Nyame Gauntlets",
    legs="Hes. Hose +3",
    feet="Mpaca's Boots",
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    ear1="Odr Earring",
    ear2="Bhikku Earring +1",
    ring1="Niqmaddu Ring",
    ring2="Gere Ring",
    back=capeDEX
})

sets.WS["Shijin Spiral"].Mid = set_combine(sets.WS["Shijin Spiral"].Standard, {
    
})

sets.WS["Shijin Spiral"].Acc = set_combine(sets.WS["Shijin Spiral"].Mid, {

})

sets.WS["Raging Fists"] = set_combine(sets.WS.Generic.Standard, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Bhikku Cyclas +3",
    hands="Adhemar Wrist. +1",
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    ear1="Moonshade Earring",
    ear2="Bhikku Earring +1",
    ring1="Niqmaddu Ring",
    ring2="Gere Ring",
    back=capeSTR,

})

sets.WS["Howling Fist"] = { 
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Tatena. Harama. +1",
    hands="Malignance Gloves",
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Niqmaddu Ring",
    ring2="Gere Ring",
    back=capeSTR
}

sets.WS["Asuran Fists"] = {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Bhikku Cyclas +3",
    hands="Nyame Gauntlets",
    legs="Hes. Hose +3",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Telos Earring",
    ear2="Bhikku Earring +1",
    ring1="Regal Ring",
    ring2="Gere Ring",
    back=capeSTR,

}

sets.WS["Shell Crusher"] = {
    ammo="Pemphredo Tathlum",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Rawhide Gloves",
    legs="Hesychast's Hose +3",
    feet="Malignance Boots",
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    ear1="Digni. Earring",
    ear2="Crepuscular Earring",
    ring1="Sangoma Ring",
    ring2="Etana Ring",

}
 sets.WS["Tornado Kick"] = {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Bhikku Cyclas +3",
    hands="Nyame Gauntlets",
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    ear1="Moonshade Earring",
    ear2="Bhikku Earring +1",
    ring2="Gere Ring",
    ring1="Niqmaddu Ring",
    back="Segomo's Mantle",

    back=capeSTR
}

sets.WS["Tornado Kick"].FootWork = {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Bhikku Cyclas +3",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Anch. Gaiters +3",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    ear1="Moonshade Earring",
    ear2="Bhikku Earring +1",
    ring1="Niqmaddu Ring",
    ring2="Gere Ring",
    back="Segomo's Mantle",

}

sets.WS["Dragon Kick"] = sets.WS["Tornado Kick"]

--JA Sets
sets.JA = {}
sets.JA.HundredFists = {
    legs="Hesychast's Hose +3"
}

sets.JA.Chakra = {
    head="Ken. Jinpachi",
    body="Anch. Cyclas +2",
    hands="Hesychast's Gloves +3",
    legs="Ken. Hakama +1",
    feet="Anch. Gaiters +3",
    left_ear="Handler's Earring +1",
    right_ear="Odnowa Earring +1",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
}

sets.Impetus = {
    body="Bhikku Cyclas +3"
}

sets.FastCast = {
    head="Herculean Helm",
    body="Dread Jupon",
    hands={ name="Leyline Gloves", augments={'Accuracy+7','Mag. Acc.+2',}},
    legs="Limbo Trousers",
    feet={ name="Taeon Boots", augments={'"Fast Cast"+4',}},
    neck="Orunmila's Torque",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Lebeche Ring",
    back={ name="Segomo's Mantle", augments={'"Fast Cast"+10',}},
}

    organizer_items = {
        weapon="Godhands",
        -- echos="Echo Drops",
        -- holy="Holy Water",
        RREar="Reraise Earring",
        InstRR="Instant Reraise",
        Warp="Warp Ring",
        WarpItem="Instant Warp",
        -- CP="Trizek Ring",
        -- Exp="Echad Ring",
        -- CPMantle="Mecistopins Mantle",
        -- Prism="Prism Powder",
        -- Oils="Silent Oil",
        -- remedy="Remedy",
        daifuku="Grape Daifuku"
    }

    send_command('bind f9 gs c equip staff')
    send_command('bind f10 gs c toggle TP set')
    send_command('bind f11 gs c toggle WS set')

    text_setup()
    addNewColors()
    updateTable()
end

function addNewColors()
    -- addTextColorPair("HighMP", "blue")
    -- addTextColorPair("DT", "yellow")
    addTextColorPair("Standard", "green")
    addTextColorPair("Accuracy", "yellow")
end

function updateTable()
    clear_table()
    if (Staff_Count > -1) then
        addToTable("(F9 x2) Equip Staff", Staff_Count)
    else
        addToTable("(F9 x2) Equip H2H", Hand_Count)
    end

    addToTable("(F10) Melee Set", sets.TP.index[TP_ind])
    addToTable("(F11) WS Set   ", sets.WS.index[WS_ind])
    update_message()
end

-- --- Precast ---

function precast(spell)
    if (Staff_Count > 0) then
        Staff_Count = 0
    elseif (Hand_Count > 0) then
        Hand_Count = 0
    end

    wsind = sets.WS.index[WS_ind]

    if spell.type:lower() == 'weaponskill' then
        if (sets.WS[spell.english]) then
            if ((spell.english == "Tornado Kick" or spell.english == "Dragon Kick") and buffactive["footwork"]) then
                equip(sets.WS["Tornado Kick"].FootWork)
            elseif (sets.WS[spell.english][wsind]) then
                if (spell.english == "Victory Smite") then
                    equip_with_impetus(sets.WS[spell.english][wsind])
                else
                    equip(sets.WS[spell.english][wsind])
                end
            else
                equip(sets.WS[spell.english])
            end
        else
        	equip(sets.WS.Generic[wsind])
        end
    end

    if (spell.english == "Hundred Fists") then
        equip(sets.JA.HundredFists)
    elseif (spell.english == "Chakra") then
        equip(sets.JA.Chakra)
    end

    if spell.skill == 'Ninjutsu' then
        equip(sets.FastCast)
    end
end
-- --- MidCast ---
function midcast(spell)
    if spell.skill == 'Ninjutsu' then
        equip(sets.Idle.DT)
    end
end 

-- --- Aftercast ---

function aftercast(spell)
    if (spell.english == "Impetus") then
        equip_with_impetus(sets.TP[sets.TP.index[TP_ind]], true)
    else 
        equip_current()
    end
end

function status_change(new,tab)
    equip_current()
end

function equip_current()
    if player.status == 'Engaged' then
        equip_TP()
    else
        equip_idle()
    end
end

function equip_with_impetus(set, override)
    if (buffactive['impetus']) or override then
        equip(set_combine(set, sets.Impetus))
    else
        equip(set)
    end
end

function equip_TP()
    equip_with_impetus(sets.TP[sets.TP.index[TP_ind]], false)
    
end

function equip_idle()
    equip(sets.Idle[sets.Idle.index[Idle_Index]])
end

function self_command(command)
    if command == 'toggle TP set' then
        TP_ind = TP_ind +1
        if TP_ind > #sets.TP.index then TP_ind = 1 end
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'toggle WS set' then
        WS_ind = WS_ind +1
        if WS_ind > #sets.WS.index then WS_ind = 1 end
        send_command('@input /echo <----- WS Set changed to '..sets.WS.index[WS_ind]..' ----->')
    elseif command == 'equip staff' then
        Staff_Count = Staff_Count +1
        if Staff_Count > 1 then 
            equip(sets.TP.Staff) 
            Staff_Count = -1
            Hand_Count = 0
            rebindWeapon()
        end
    elseif command == 'equip h2h' then
        Hand_Count = Hand_Count +1
        if Hand_Count > 1 then
            equip(sets.TP.H2H)
            Staff_Count = 0
            Hand_Count = -1
            rebindWeapon()
        end
    end
    updateTable()
end

function rebindWeapon()
    if (Staff_Count == 0) then
        send_command('bind f9 gs c equip staff')
    else
        send_command('bind f9 gs c equip h2h')
    end
end

function user_setup()
    send_command('bind pause send @others /follow Vilma')
    text_setup()
    addNewColors()
    updateTable()
end

function file_unload()
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
        equip_set =  set_combine(equip_set, {})
        -- equip_set = set_combine(equip_set, sets.midcast_ElementalDay)
    end
 
    return equip_set
end