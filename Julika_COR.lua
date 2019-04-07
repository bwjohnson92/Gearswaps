include('organizer-lib.lua')
include('displayBox.lua')
-- Local Settings, setting the zones prior to use

Idle_Index = 1
Run_Index = 1
Melee_Index = 1
Ranged_Index = 1

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

capeTP={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
capeWS={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}}
capeSavage={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
capeTPMelee={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
capeDT={ name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Damage taken-5%',}}

HercLegsMAB={ name="Herculean Trousers", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','Weapon skill damage +3%','MND+5','Mag. Acc.+12','"Mag.Atk.Bns."+14',}}

-- Start Functions here
-- Gear Sets
function get_sets()
sets.roll={
    head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
    body="Lanun Frac +3",
    hands="Chasseur's Gants +1", --Chasseur's Gants
    -- legs="Lanun Culottes",
    feet="Meg. Jam. +2",
    neck="Regal Necklace",
    waist="Chaac Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Luzaf's Ring",
    right_ring="Barataria Ring",
    back=capeTP, --AMBUSCADE
}

sets.Idle = {}
sets.Idle.index = {"Standard", "DT"}
sets.Idle.Standard = {

    --range="Compensator",
    -- ammo="Eminent Bullet",
    head="Meghanada Visor +2",
    hands="Meghanada gloves +2",
    legs="Feast Hose",
    feet="Hermes' Sandals",
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear="Hearty Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Iximulew cape",
    -- back="Repulse Mantle",
}

sets.Idle.DT = set_combine(sets.Idle.Standard, {
    body="Lanun frac +3",
    legs="Mummu kecks +2",
    feet="Lanun Bottes +2",
    back=capeDT
})

sets.Melee = {}
sets.Melee.index = {"Standard", "Acc"}
sets.Melee.Standard = {
    head={name="Herculean Helm", augments={'Accuracy +16','"Dual Wield"+4',}},
    neck="Sanctity Necklace",
    ear1="Dignitary's Earring",
    ear2="Suppanomimi",
    body="Lanun Frac +3",
    hands="Floral Gauntlets",
    ring1="Petrov Ring",
    ring2="Epona's Ring",
    back=capeTPMelee,
    waist="Reiki Yotai",
    legs="Adhemar Kecks +1",
    feet="Taeon Boots"
    -- feet="Herculean Boots",
}

sets.Melee.Acc = set_combine(sets.Melee.Standard, {})

sets.preshot = { -- aim 60 Snapshot, then Rapid Shot
    head="Taeon Chapeau",
    body="Laksamana's frac +3", --Need
    -- body="Oshosi Vest",
    hands="Carmine Finger Gauntlets +1",
    waist="Impulse Belt",
    legs="Laksamana's trews +3", --Need
    feet="Meg. Jam. +2",
    back="Navarch's Mantle",
    neck="Commodore Charm",
}

sets.RA = {}
sets.RA.index = {'Standard', 'Accuracy'}
rangedSets = {'Standard', 'Accuracy'}

sets.RA.Standard = { --RAcc and STP
    head="Meghanada Visor +2",
    body="Oshosi Vest",
    hands="Adhemar Wristbands +1",
    legs="Adhemar Kecks +1",
    feet="Meg. Jam. +2",
    neck="Ocachi gorget",
    waist="Yemaya Belt",
    left_ear="Neritic Earring",
    right_ear="Volley Earring",
    back=capeTP,
    ring1="Dingir Ring",
    ring2="Ilabrat Ring",
}

sets.RA.Accuracy = set_combine(sets.RA, { --RAcc and STP
    body="Laksamana's Frac +3",
    legs="Laksamana's Trews +3",
    neck="Commodore Charm",
    ring1="Hajduk Ring",
    ring2="Hajduk Ring",
})

sets.WS = {}

sets.WS.SavageBlade = {
    head="Meghanada Visor +2",
    neck="Caro Necklace",
    ear1="Moonshade Earring",
    ear2="Ishvara Earring",
    body="Laksamana's Frac +3",
    hands="Meg. Gloves +2",
    ring1="Petrov Ring", --Shukuyu
    ring2="Ilabrat Ring", --Rufescent 
    back=capeSavage,
    waist="Metalsinger Belt", --Prosilio Belt
    legs="Laksamana's Trews +3",
    feet="Lanun Bottes +2",
}

sets.WS.LastStand = { --Generic Physical WS
    head="Meghanada Visor +2",
    body="Laksamana's Frac +3",
    hands="Meghanada Gloves +1", --+2
    legs="Laksamana's trews +3",
    feet="Lanun bottes +2",
    neck="Commodore Charm",
    waist="Eschan Stone",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    ring1="Dingir Ring",
    ring2="Apate ring",
    back=capeWS,
}

sets.WS.Wildfire = {
    head={ name="Herculean Helm", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2','"Mag.Atk.Bns."+15',}},
    body="Lanun Frac +3",
    hands="Carmine finger gauntlets +1",
    legs=HercLegsMAB,
    feet="Lanun bottes +2",
    neck="Commodore Charm",
    waist="Eschan Stone",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    ring1="Dingir Ring",
    ring2="Ilabrat ring",
    back=capeWS,
}


sets.WS.LeadenSalute = { --AGI Weaponskill
    head="Pixie Hairpin +1",
    body="Lanun Frac +3",
    hands="Carmine finger gauntlets +1",
    legs=HercLegsMAB,
    feet="Lanun Bottes +2",
    -- neck="Commodore Charm",
    neck="Stoicheion Medal",
    waist="Eschan Stone",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Dingir Ring",
    right_ring="Archon Ring",
    back=capeWS,
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

sets.roll["Caster's Roll"] = {
    -- legs="Chasseur's Culottes"
}
sets.roll["Tactician's Roll"] = {
    body="Chasseur's Frac"
}
sets.RandomDeal = {body="Lanun Frac +3"}
sets.Fold = {
    -- hands="Lanun Gauntlets"
}
sets.SnakeEye = {
    legs="Lanun Trews"
}
sets.WildCard = {feet="Lanun Bottes +2"}

sets.Luzaf = {ring1="Luzaf's Ring"}

    organizer_items = {
        echos="Echo Drops",
        holy="Holy Water",
        RREar="Reraise Earring",
        InstRR="Instant Reraise",
        Warp="Warp Ring",
        WarpItem="Instant Warp",
        CP="Trizek Ring",
        Exp="Echad Ring",
        CPMantle="Mecistopins Mantle",
        Prism="Prism Powder",
        Oils="Silent Oil",
        remedy="Remedy",
        Crepe="Pear Crepe",
        gun1="Fomalhaut",
        gun2="Death Penalty",
        -- gun1="Doomsday",
    }

    user_setup()
end

function addNewColors()
    -- addTextColorPair("HighMP", "blue")
    addTextColorPair("DT", "yellow")
    addTextColorPair("Standard", "green")
    addTextColorPair("Accuracy", "yellow")
end

function updateTable()
    addToTable("(F10) Ranged Set", sets.RA.index[Ranged_Index])
    addToTable("(F11) Melee Set", sets.RA.index[Melee_Index])
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    addToTable("Auto Shooting", autoShoot)
    update_message()
end

-- --- Precast ---

function precast(spell)
    if spell.english == 'Random Deal' then
        equip(sets.RandomDeal)
    elseif spell.english == 'Fold' then
        equip(sets.Fold)
    elseif spell.english == 'Snake Eye' then
        equip(sets.SnakeEye)
    elseif spell.english == 'Wild Card' then
        equip(sets.WildCard)
    elseif (spell.type == 'CorsairRoll') then
        equip(set_combine(sets.roll, sets.roll[spell.name]))
    end

    if spell.action_type == 'Ranged Attack' then
        equip(sets.preshot)
    elseif spell.type:lower() == 'weaponskill' then
        if (spell.english == "Leaden Salute") then
            equip(use_obi(spell, sets.WS.LeadenSalute))
        elseif (spell.english == "Savage Blade") then
              equip(sets.WS.SavageBlade)
        elseif (spell.english == "Wildfire") then
            equip(sets.WS.Generic)
        elseif (spell.english == "Last Stand") then
            equip(sets.WS.Generic)
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
    elseif (spell.type == 'CorsairRoll') then
        equip(set_combine(sets.roll, sets.roll[spell.name]))
    end
    if spell.action_type == 'Ranged Attack' then
        equip(sets.RA[rangedSets[Ranged_Index]])
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
    equip(sets.Melee[sets.Melee.index[Melee_Index]])
end

function equip_idle()
    equip(sets.Idle[sets.Idle.index[Idle_Index]])
end

function self_command(command)
    if command == 'toggle RA set' then
        Ranged_Index = Ranged_Index +1
        if Ranged_Index > #sets.RA.index then 
            Ranged_Index = 1 
        end
        send_command('@input /echo <----- RA Set changed to '..sets.RA.index[Ranged_Index]..' ----->')
        equip(sets.RA[sets.RA.index[Ranged_Index]])
    elseif command == 'toggle melee set' then
        Melee_Index = Melee_Index +1
        if Melee_Index > #sets.RA.index then 
            Melee_Index = 1 
        end
        send_command('@input /echo <----- RA Set changed to '..sets.Melee.index[Melee_Index]..' ----->')
        equip_TP()
    elseif command == 'toggle dt' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip_idle()
    elseif command == 'auto' then
        if autoShoot then
            send_command('@input /echo <----TURNING OFF AUTORA ----->')
            send_command('send Vilma /echo STOPPING RANGED ATTACK ON JULIKA')
            send_command('autora stop')
        else
            send_command('@input /echo <----TURNING ON AUTORA ----->')
            send_command('send Vilma /echo STARTING RANGED ATTACK ON JULIKA')
            send_command('@input /ta <bt>')
            send_command('wait 1;gs c aimAtTarget')
        end
        autoShoot = not autoShoot
    elseif command == 'aimAtTarget' then
        send_command('input /attack on')
        send_command('setkey numpad2 down')
        send_command('wait 0.1; gs c finishAiming')
    elseif command == 'finishAiming' then
        send_command('setkey numpad2 up')
        send_command('autora start')
    end
    updateTable()
end

function user_setup()
    add_to_chat(140, "Loading Julika's Gearswap")
    send_command('bind f10 gs c toggle RA set')
    send_command('bind f12 gs c toggle dt')
    send_command('bind pause send @others /follow Julika')
    send_command('lua l autora')

    text_setup()
    addNewColors()
    updateTable()
end

function file_unload()
    add_to_chat(140, "Unloading Julika's COR gearswap.")
    send_command('lua u autora')
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