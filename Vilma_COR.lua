include('organizer-lib.lua')
include('displayBox.lua')
-- Local Settings, setting the zones prior to use

Idle_Index = 1
Run_Index = 1
Leaden_Index = 1
Savage_Index = 1
Roll_Index = 2
Gun_Index = 1
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

capeTPRanged={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
capeRangedWS={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
capeMeleeWS={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}}
capeTPMelee={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10',}}
capeSnapshot={ name="Camulus's Mantle", augments={'"Snapshot"+10',}}
capeDT = capeTPMelee
HercLegsMAB={ name="Herculean Trousers", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','Weapon skill damage +3%','MND+5','Mag. Acc.+12','"Mag.Atk.Bns."+14',}}

-- Start Functions here
-- Gear Sets
function get_sets()

sets.Gun = {}
sets.Gun.index = {
    "Death Penalty", 
    "Fomalhaut", 
    "Anarchy"
}
sets.Gun["Death Penalty"] = {
    ranged="Death Penalty"
}

sets.Gun["Fomalhaut"] = {
    ranged="Fomalhaut"
}

sets.Gun["Anarchy"] = {
    ranged="Anarchy +2"
}

sets.Idle = {}
sets.Idle.index = {"Standard", "DT"}
sets.Idle.Standard = {

    --range="Compensator",
    -- ammo="Eminent Bullet",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    -- legs="Feast Hose",
    legs="Carmine Cuisses +1",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Hearty Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back=capeDT,
    -- back="Repulse Mantle",
}

sets.Idle.DT = set_combine(sets.Idle.Standard, {
    body="Lanun frac +3",
    legs="Mummu kecks +2",
    feet="Lanun Bottes +3",
    back=capeDT
})

sets.Melee = {
    head="Malignance Chapeau",
    neck="Iskur Gorget",
    ear1="Telos Earring",
    ear2="Brutal Earring",
    body="Malignance Tabard",
    hands="Nyame Gauntlets",
    ring1="Petrov Ring",
    ring2="Epona's Ring",
    back=capeTPMelee,
    waist="Windbuffet Belt +1",
    legs="Nyame Flanchard",
    feet="Malignance Boots"
    -- feet="Herculean Boots",
}

sets.preshot = { -- aim 60 Snapshot, then Rapid Shot
    -- body="Laksamana's frac +3", --Need
    head="Taeon Chapeau",
    body="Pursuer's Doublet",
    hands="Carmine Finger Gauntlets +1",
    waist="Impulse Belt",
    legs="Adhemar Kecks +1", 
    feet="Meg. Jam. +2",
    back=capeSnapshot,
    neck="Commodore Charm +2",
    ring1="Crepuscular Ring"
}

sets.RA = {}
sets.RA.index = {'Standard', 'Accuracy'}
rangedSets = {'Standard', 'Accuracy'}
rangedIndex = 1

sets.RA.Standard = { --RAcc and STP
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Ikenga's Gloves",
    legs="Ikenga's Trousers",
    feet="Malignance Boots",
    neck="Ocachi gorget",
    waist="Yemaya Belt",
    left_ear="Neritic Earring",
    right_ear="Telos Earring",
    back=capeTPRanged,
    ring1="Dingir Ring",
    ring2="Ilabrat Ring",
}

sets.RA.Accuracy = set_combine(sets.RA, { --RAcc and STP

})

sets.WS = {}

sets.WS.SavageBlade = {
    head="Meghanada Visor +2",
    neck="Republican platinum medal",
    ear1="Moonshade Earring",
    ear2="Ishvara Earring",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    ring1="Regal Ring", --Shukuyu
    ring2="Epaminondas's ring", --Rufescent 
    back=capeMeleeWS,
    waist="Sailfi Belt", --Prosilio Belt
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
}

sets.WS.SavageBlade.index = {"Attack", "Accuracy"}

sets.WS.SavageBlade.Attack = sets.WS.SavageBlade
sets.WS.SavageBlade.Accuracy = set_combine(sets.WS.SavageBlade, {
    neck="Sanctity Necklace",
    ear1="Telos Earring",
    })

sets.WS.Generic = sets.WS.SavageBlade

sets.WS.LastStand = { --Generic Physical WS
    head="Lanun Tricorne +3",
    body="Nyame Mail",
    hands="Nyame Gauntlets", --+2
    legs="Nyame Flanchard",
    -- feet="Lanun Bottes +3",
    -- feet="Nyame Sollerets",
    feet="Lanun Bottes +3",
    -- neck="Commodore Charm +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    ring1="Dingir Ring",
    ring2="Regal ring",
    back=capeRangedWS,
}

sets.WS.LastStand.Standard = sets.WS.LastStand

sets.WS.LastStand.Accuracy = set_combine(sets.WS.LastStand, {
    -- legs="Meghanada Chausses +2",
    lear="Telos Earring",
})

sets.WS.LastStand.Enmity = set_combine(sets.WS.LastStand, {
    legs="Laksamana's Trews +4",
    ring1="Cacoethic Ring +1", --+1
    ear1="Novia Earring",
    waist="Reiki Yotai"
})

sets.WS.Wildfire = {
    head={ name="Herculean Helm", augments={'Mag. Acc.+15,"Mag.Atk.Bns."+30','"Fast Cast"+2%',}},
    body="Lanun Frac +3",
    -- hands="Carmine finger gauntlets +1",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Lanun Bottes +3",
    neck="Commodore Charm +2",
    waist="Eschan Stone",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    ring1="Dingir Ring",
    ring2="Ilabrat ring",
    back=capeRangedWS,
}

sets.WS.Aeolian = {
    head="Nyame Helm",
    body="Lanun Frac +3",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Lanun Bottes +3",
    neck="Commodore Charm +2",
    waist="Eschan Stone",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Dingir Ring",
    right_ring="Shiva Ring +1",
    back=capeRangedWS,
}


sets.WS.LeadenSalute = {
}

sets.WS.LeadenSalute.index = {"Standard", "Enmity"}
sets.WS.LeadenSalute.Standard = { --AGI Weaponskill
    -- ammo=MABullet,
    head="Pixie Hairpin +1",
    body="Lanun Frac +3",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Lanun Bottes +3",
    neck="Commodore Charm +2",
    waist="Eschan Stone",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Dingir Ring",
    right_ring="Archon Ring",
    back=capeRangedWS,
}

sets.WS.LeadenSalute.Enmity = set_combine(sets.WS.LeadenSalute.Standard, {
    right_ear="Enervating Earring",
    left_ring="Resonance Ring",
    hands={ name="Taeon Gloves", augments={'"Mag.Atk.Bns."+19','Weapon skill damage +2%',}},
    legs="Laksamana's Trews +4",
    waist="Reiki Yotai"
    })

sets.WS.HotShot = {
    head="Nyame Helm",
    neck="Fotia Gorget",
    ear1="Friomisi Earring",
    ear2="Moonshade Earring",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    ring1="Dingir Ring",
    ring2="Epaminondas's Ring",
    back=capeRangedWS,
    waist="Fotia Belt",
    legs="Nyame Flanchard",
    feet="Lanun Bottes +3"
}

sets.FastCast = {
    -- head="Carmine Mask",
    body="Taeon Tabard",
    -- feet="Carmine Greaves +1",
    neck="Voltsurge Torque",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    right_ring="Weather. Ring",
}


sets.roll = {}
sets.roll.index = {"Short", "Long", "ShortGun", "LongGun"}
sets.roll.Short = {
    head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
    body="Lanun Frac +3",
    hands="Chasseur's Gants +3",
    feet="Meg. Jam. +2",
    neck="Regal Necklace",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Novio Earring",
    right_ring="Defending Ring",
    left_ring="Barataria Ring",    
    back=capeDT, --AMBUSCADE
}

sets.Luzaf = {ring1="Luzaf's Ring"}

sets.roll.Long = set_combine(sets.roll.Short, sets.Luzaf)

sets.roll.ShortGun = set_combine(sets.roll.Short, {
    ranged="Compensator"
    })

sets.roll.LongGun = set_combine(sets.roll.ShortGun, sets.Luzaf)

sets.roll["Caster's Roll"] = {
    -- legs="Chasseur's Culottes"
}
sets.roll["Tactician's Roll"] = {
    -- body="Chasseur's Frac"
}
sets.RandomDeal = {body="Lanun Frac +3"}
sets.Fold = {
    -- hands="Lanun Gauntlets"
}
sets.SnakeEye = {
    -- legs="Lanun Culottes"
}
sets.WildCard = {feet="Lanun Bottes +3"}



    organizer_items = {
        echos="Echo Drops",
        holy="Holy Water",
        RREar="Reraise Earring",
        InstRR="Instant Reraise",
        Warp="Warp Ring",
        WarpItem="Instant Warp",
        CPMantle="Mecistopins Mantle",
        remedy="Remedy",
        Crepe="grape dafaiku",
        gun1="Fomalhaut",
        gun2="Death Penalty",
        -- gun1="Doomsday",
    }

    user_setup()
    equip_current()
end

function addNewColors()
    -- addTextColorPair("HighMP", "blue")
    addTextColorPair("Death Penalty", "red")
    addTextColorPair("Fomalhaut", "red")
    addTextColorPair("Anarchy", "red")
    addTextColorPair("DT", "yellow")
    addTextColorPair("Standard", "green")
    addTextColorPair("Short", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("Long", "yellow")
    addTextColorPair("Enmity", 'yellow')
end

function updateTable()
    addToTable("Ctrl+G  Gun Set", sets.Gun.index[Gun_Index])
    addToTable("(F7)  Roll  Set", sets.roll.index[Roll_Index])
    addToTable("(F9)  Savage Set", sets.WS.SavageBlade.index[Savage_Index])
    addToTable("(F10) Ranged Set", sets.RA.index[rangedIndex])
    addToTable("(F11) Leaden Set", sets.WS.LeadenSalute.index[Leaden_Index])
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    update_message()
end



function bullet_check(spell)
    if player.equipment.ammo == "empty" then
        equip({ammo="Chrono Bullet"})
        return false
    end
    return true
end
--     local bullet_name
--     local bullet_min_count = 1
--     if spell.type == 'WeaponSkill' then
--         if spell.skill == "Marksmanship" then
--             if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
--                 -- magical weaponskills
--                 bullet_name = MABullet
--             else
--                 -- physical weaponskills
--                 bullet_name = WSBullet
--             end
--         else
--             -- Ignore non-ranged weaponskills
--             return true
--         end
--     elseif spell.type == 'CorsairShot' then
--         bullet_name = QDBullet
--     elseif spell.action_type == 'Ranged Attack' then
--         bullet_name = RABullet
--         if buffactive['Triple Shot'] then
--             bullet_min_count = 3
--         end
--     end

--     local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

--     if not available_bullets then
--         if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
--             add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
--             return true
--         elseif spell.type == 'WeaponSkill' and player.equipment.ammo == RABullet then
--             add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
--             return true
--         else
--             add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
--             return false
--         end
--     end
-- end

-- --- Precast ---

function precast(spell)
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        if not bullet_check(spell) then
            equip({ammo="Chrono Bullet"})
        end
    end

    if spell.english == 'Random Deal' then
        equip(sets.RandomDeal)
    elseif spell.english == 'Fold' then
        equip(sets.Fold)
    elseif spell.english == 'Snake Eye' then
        equip(sets.SnakeEye)
    elseif spell.english == 'Wild Card' then
        equip(sets.WildCard)
    elseif (spell.type == 'CorsairRoll') then
        equip(set_combine(sets.roll[sets.roll.index[Roll_Index]], sets.roll[spell.name]))
    elseif (spell.type == 'Double Up') then
        equip(set_combine(sets.roll[sets.roll.index[Roll_Index]], sets.roll[spell.name]))
    elseif (spell.type == 'CorsairShot') then
        equip(use_obi(spell,sets.QD))
    end

    if spell.action_type == 'Ranged Attack' then
        equip(sets.preshot)
    elseif spell.type:lower() == 'weaponskill' then
        if (spell.english == "Leaden Salute") then
            equip(use_obi(spell, sets.WS.LeadenSalute[sets.WS.LeadenSalute.index[Leaden_Index]]))
        elseif (spell.english == "Savage Blade") then
              equip(sets.WS.SavageBlade[sets.WS.SavageBlade.index[Savage_Index]])
        elseif (spell.english == "Evisceration") then
            equip(sets.WS.Evisceration)
        elseif (spell.english == "Wildfire") then
            equip(sets.WS.Wildfire)
        elseif (spell.english == "Detonator") then
            equip(sets.WS.LastStand[rangedSets[rangedIndex]])
        elseif (spell.english == "Last Stand") then
            equip(sets.WS.LastStand[rangedSets[rangedIndex]])
        elseif (spell.english == "Hot Shot") then
            equip(sets.WS.HotShot)
        elseif (spell.english == "Aeolian Edge") then
            equip(sets.WS.Aeolian)
        elseif (sets.WS[spell.english]) then
            equip(sets.WS[spell.english])
        else
            equip(sets.WS.Generic)
        end
        -- add_to_chat(140, "Blah")
    end
    if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        equip(sets.FastCast)
    end
end
-- --- MidCast ---
function midcast(spell)
    if spell.english == 'Random Deal' then
        equip(sets.RandomDeal)
    elseif spell.english == 'Fold' then
        equip(sets.Fold)
    elseif spell.english == 'Snake Eye' then
        equip(sets.SnakeEye)
    elseif spell.english == 'Wild Card' then
        equip(sets.WildCard)
    elseif (spell.type == 'CorsairRoll') or (spell.name == 'Double-Up') then
        equip(set_combine(sets.roll[sets.roll.index[Roll_Index]], sets.roll[spell.name]))
    end

    if spell.action_type == 'Ranged Attack' then
        equip(sets.RA[rangedSets[rangedIndex]])
    end
end 

-- --- Aftercast ---

function aftercast(spell)
    --equip(sets.RA)
    equip_current()
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

function equip_TP()
    equip(sets.Melee)
    equip(sets.Gun[sets.Gun.index[Gun_Index]])
end

function equip_idle()
    equip(sets.Idle[sets.Idle.index[Idle_Index]])
    equip(sets.Gun[sets.Gun.index[Gun_Index]])
end

function self_command(command)

    --toggles
    if command == 'toggle RA set' then
        rangedIndex = rangedIndex +1
        if rangedIndex > #sets.RA.index then 
            rangedIndex = 1 
        end
        send_command('@input /echo <----- RA Set changed to '..sets.RA.index[rangedIndex]..' ----->')
        equip(sets.RA[sets.RA.index[rangedIndex]])
    elseif command == 'toggle dt' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_Index]])
    elseif command == 'toggle roll' then
        Roll_Index = Roll_Index +1
        if Roll_Index > #sets.roll.index then Roll_Index = 1 end
        add_to_chat(140, '<----- Roll Set changed to '..sets.roll.index[Roll_Index]..' ----->')
    elseif command == 'toggle gun' then
        Gun_Index = Gun_Index +1
        if Gun_Index > #sets.Gun.index then Gun_Index = 1 end
        add_to_chat(141, 'Gun now set to: !!!       '..sets.Gun.index[Gun_Index]..'     !!!')
    elseif command == 'toggle leaden' then
        Leaden_Index = Leaden_Index +1
        if Leaden_Index > #sets.WS.LeadenSalute.index then Leaden_Index = 1 end
        add_to_chat(140, '<----- Leaden Set changed to '..sets.WS.LeadenSalute.index[Leaden_Index]..' ----->') 
    elseif command == 'toggle savage' then
        Savage_Index = Savage_Index +1
        if Savage_Index > #sets.WS.SavageBlade.index then Savage_Index = 1 end
        add_to_chat(140, '<----- Savage Set changed to '..sets.WS.SavageBlade.index[Savage_Index]..' ----->') 
    end

    equip_current()
    updateTable()
end

function user_setup()
    add_to_chat(140, "Loading Vilma's Gearswap")
    send_command('bind ^g gs c toggle gun')
    send_command('bind f7 gs c toggle roll')
    send_command('bind f9 gs c toggle savage')
    send_command('bind f10 gs c toggle RA set')
    send_command('bind f11 gs c toggle leaden')
    send_command('bind f12 gs c toggle dt')
    send_command('bind pause send @others /follow Vilma')

    text_setup()
    addNewColors()
    updateTable()
end

function file_unload()
    add_to_chat(140, "Unloading Vilma's COR gearswap.")
end

function use_obi(spell, equip_set)
    local use_obi = false
    -- first check to see if any elemental obi rule matches
    if (spell.name == "Leaden Salute") then
        spell.element = "Dark"
    end
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
        equip_set =  set_combine(equip_set, {waist="Hachirin-no-obi"})
        -- equip_set = set_combine(equip_set, sets.midcast_ElementalDay)
    end
 
    return equip_set
end