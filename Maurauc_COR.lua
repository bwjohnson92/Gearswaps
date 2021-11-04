include('organizer-lib.lua')
include('displayBox.lua')

Idle_Index = 1
Run_Index = 1
Leaden_Index = 1
Savage_Index = 1
Roll_Index = 2
Gun_Index = 1
Ranged_Index = 1
current_roll = ""

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

-- Start Functions here
-- Gear Sets
wsHerc= {name="Herculean Boots", augments={'Accuracy+1','Pet: DEX+4','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}


function get_sets()

    capeTP={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
    capeWSMAB={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+7','Weapon skill damage +10%',}}
    capeMeleeWS = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    capeMeleeTP={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    -- capeMeleeTP = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}}
    capeSnapshot = { name="Camulus's Mantle", augments={'"Snapshot"+10',}}

    sets.Gun = {}
    sets.Gun.index = {"Death Penalty", "Fomalhaut", "Anarchy"}
    sets.Gun["Death Penalty"] = {
        ranged="Death Penalty"
    }

    sets.Gun["Fomalhaut"] = {
        ranged="Fomalhaut"
    }

    sets.Gun["Anarchy"] = {
        ranged="Anarchy +2"
    }

    sets.Weapons = {}

    sets.Weapons["Sword"] = {
        main="Naegling",
        sub="Lanun Knife",
        ranged="Nusku Shield"
    }

    sets.Idle = {
        -- main="Eletta Sword",
        -- head="Herculean Helm",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        -- hands="Carmine finger gauntlets +1",
        hands="Malignance Gloves",
        -- legs="Feast Hose",
        -- legs="Carmine Cuisses +1",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Chaac Belt",
        left_ear="Etiolation Earring",
        right_ear="Loquac. Earring",
        left_ring="Defending Ring",
        -- right_ring="Barataria Ring",
        back="Repulse Mantle",
    }

    sets.preshot = { -- aim 60 Snapshot, then Rapid Shot
        head="Taeon Chapeau",
        body="Laksamana's frac +3", --Need
        body="Oshosi Vest",
        hands="Carmine Finger Gauntlets +1",
        waist="Yemaya Belt",
        legs="Adhemar Kecks +1",
        feet="Meg. Jam. +2",
        --back="Navarch's Mantle",
        neck="Commodore Charm +1",
    }

    sets.Melee = {
        -- head={ name="Adhemar Bonnet +1"},
        -- body="Adhemar Jacket +1",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        -- hands="Adhemar Wristbands +1",
        -- legs="Adhemar Kecks +1",
        -- feet={ name="Herculean Boots", augments={'"Triple Atk."+4','DEX+4','Accuracy+8','Attack+13',}},
        feet="Malignance Boots",
        -- neck="Asperity Necklace",
        neck="Iskur Gorget",
        waist="Windbuffet Belt +1",
        -- left_ear="Suppanomimi",
        left_ear="Cessance Earring",
        right_ear="Telos Earring",
        left_ring="Defending Ring",
        right_ring="Petrov Ring",
        back=capeMeleeTP
    }

    sets.RA = {}
    sets.RA.index = {'Standard', 'Acc', "Enmity"}

    sets.RA.Standard = { --RAcc and STP
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Meghanada Gloves +2",
        legs="Meghanada Chausses +2",
        feet="Meg. Jam. +2",
        neck="Iskur gorget",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        back=capeTP,
        ring1="Regal Ring",
        ring2="Cacoethic Ring",
    }

    sets.RA.Acc = set_combine(sets.RA, { --RAcc and STP
        -- body="Laksamana's Frac +3",
        -- legs="Laksamana's Trews +3",
        -- neck="Commodore Charm +1",
        -- ring1="Hajduk Ring",
        -- ring2="Hajduk Ring",
        head="Meghanada Visor +2",
        body="Meghanada Cuirie +2",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet="Meghanada Jambeaux +2",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        left_ring="Cacoethic Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
    })

    sets.RA.Enmity = set_combine(sets.RA.Standard, {
        body="Laksamana's Frac +3",
        legs="Laksamana's Trews +3",
        ring1="Cacoethic Ring +1",
        waist="Elanid Belt",
        ear2="Novia Earring",
        feet="Oshosi Leggings"
    })


    sets.WS = {}



    sets.WS.Generic = { --Generic Physical WS
        head="Meghanada Visor +2",
        body="Herculean Vest",
        hands="Meghanada Gloves +2",
        -- legs="Feast Hose",
        feet="Meg. Jam. +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Digni. Earring",
        right_ear="Friomisi Earring",
        ring1="Meghanada Ring",
        -- ring2="Arvina Ringlet +1",
        back=capeWSMAB,
    }

    --MELEE----------

    sets.WS.SavageBlade = {
        -- head="Lilitu Headpiece",
        head="Nyame Helm",
        -- neck="Caro Necklace",
        neck="Commodore Charm +1",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Laksamana's Frac +3",
        hands="Meg. Gloves +2",
        -- ring1="Rufescent Ring", --Shukuyu
        ring1="Epaminondas's Ring",
        ring2="Regal Ring", --Rufescent 
        back=capeMeleeWS,
        waist="Sailfi Belt +1",
        -- legs="Meghanada Chausses +2",
        legs="Nyame Flanchard",
        -- feet=wsHerc,
        feet="Lanun Bottes +3"
    }
    sets.WS.SavageBlade.index = { 'Standard' }
    sets.WS.SavageBlade.Standard = set_combine(sets.WS.SavageBlade, {

    })

    sets.WS.SavageBlade.Acc = set_combine(sets.WS.SavageBlade.Standard, {
        head="Malignance Chapeau"
    })


    sets.WS.Evisceration = {
        left_ear="Moonshade Earring",
        right_ear="Brutal Earring",
        head="Mummu Bonnet +2",
        body="Mummu Jacket +2",
        hands="Meg. Gloves +2",
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ring="Mummu Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }



    --RANGED------------------

    sets.WS.LeadenSalute = {}
    sets.WS.LeadenSalute.index = {"Standard", "Enmity"}

    sets.WS.LeadenSalute.Standard = { --AGI Weaponskill
        head="Pixie Hairpin +1",
        body="Lanun Frac +3",
        hands="Carmine Fin. Ga. +1",
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Dbl.Atk."+3','Mag. Acc.+5','"Mag.Atk.Bns."+8',}},
        feet="Lanun Bottes +3",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Friomisi Earring",
        left_ring="Dingir Ring",
        right_ring="Archon Ring",
        back=capeWSMAB,
    }

    sets.WS.LeadenSalute.Enmity = set_combine(sets.WS.LeadenSalute.Standard, {

    })

    sets.WS.LastStand = set_combine(sets.RA.Enmity, {
        neck="Fotia Gorget",
        waist="Fotia Belt",
        head="Meghanada Visor +2",
        ear1="Moonshade Earring",
        feet="Lanun Bottes +3",
        ring1="Regal Ring",
        ring2="Dingir Ring",
        back=capeWSMAB
    })

    sets.WS.LastStand.Standard = sets.WS.LastStand

    sets.WS.LastStand.Acc = {
        head="Lanun Tricorne +1",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Meg. Cuirie +2",
        hands="Meg. Gloves +2",
        ring1="Dingir Ring",
        ring2="Apate Ring",
        back="Camulus's Mantle",
        waist="Fotia Belt",
        legs="Meg. Chausses +2",
        feet="Lanun Bottes +3"
    }

    sets.WS.LastStand.Enmity = set_combine(sets.WS.LastStand, {

    }) 


    sets.roll = {}
    sets.roll.index = {"Short", "Long"}

    sets.roll.Short={
        head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
        body="Lanun Frac +3",
        hands="Navarch's Gants +1",
        legs="Lanun Culottes",
        feet="Meg. Jam. +2",
        neck="Regal Necklace",
        waist="Chaac Belt",
        left_ear="Etiolation Earring",
        right_ear="Loquac. Earring",
        -- left_ring="Luzaf's Ring",
        -- right_ring="Luzaf's Ring",
        back=capeTP, --AMBUSCADE
    }

    sets.roll.Long = set_combine(sets.roll.Short, {left_ring="Luzaf's Ring"})

    sets.roll["Caster's Roll"] = {legs="Chasseur's Culottes"}
    sets.roll["Tactician's Roll"] = {body="Chasseur's Frac +1"}
    sets.RandomDeal = {body="Lanun Frac +3"}
    sets.Fold = {}--{hands="Lanun Gauntlets"}
    sets.SnakeEye = {}--{legs="Lanun Culottes"}
    sets.WildCard = {feet="Lanun Bottes +3"}

    organizer_items = {
        trump="Trump Card",
        case="Trump Card Case",
        echos="Echo Drops",
        holy="Holy Water",
        RREar="Reraise Earring",
        InstRR="Instant Reraise",
        remedy="Remedy",
        Crepe="Pear Crepe",
        food="Grape Daifuku",
        dagger="Lanun Knife",
        gunpouch="Chrono Bullet Pouch",
        gunpouch2="Living Bullet Pouch",
        bullet1="Chrono Bullet",
        bullet2="Living Bullet"
    }

    sets.QuickDraw = set_combine(sets.WS.LeadenSalute, {
        head="Laksamana's Tricorne",
        feet="Navarch's Bottes +2",
        lear="Dignitary's Earring",
        ring2="Weatherspoon Ring +1"
    })


    sets.FastCast = {
        head="Carmine Mask",
        body="Taeon Tabard",
        hands="Leyline Gloves",
        legs="Carmine Cuisses +1",
        feet="Carmine Greaves",
        neck="Voltsurge Torque",
        left_ear="Etiolation Earring",
        right_ear="Loquac. Earring",
        right_ring="Weather. Ring +1",
    }
    
    sets.midcast_ElementalDay = {waist="Hachirin-no-obi"}
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
    -- addToTable("(F9)  Savage Set", sets.WS.SavageBlade.index[Savage_Index])
    addToTable("(F10) Ranged Set", sets.RA.index[Ranged_Index])
    addToTable("(F11) Leaden Set", sets.WS.LeadenSalute.index[Leaden_Index])
    -- addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    update_message()
end

function user_setup()
    add_to_chat(140, "Loading Maurauc's Gearswap")
    send_command('bind ^g gs c toggle gun')
    send_command('bind f7 gs c toggle roll')
    send_command('bind f9 gs c toggle savage')
    send_command('bind f10 gs c toggle RA set')
    send_command('bind f11 gs c toggle leaden')
    send_command('bind f12 gs c equip gear')
    send_command('bind pause send @others /follow Maurauc')

    text_setup()
    addNewColors()
    updateTable()
end

-- --- Precast ---

function precast(spell)
    --JA--
    if spell.english == 'Random Deal' then
        equip(sets.RandomDeal)
    elseif spell.english == 'Fold' then
        equip(sets.Fold)
    elseif spell.english == 'Snake Eye' then
        equip(sets.SnakeEye)
    elseif spell.english == 'Wild Card' then
        equip(sets.WildCard)
    elseif (spell.type == 'CorsairRoll') then
        current_roll = spell.english
        equip(set_combine(sets.roll[sets.roll.index[Roll_Index]], sets.roll[current_roll]))
    elseif (spell.type == 'Double-Up') then
        equip(set_combine(sets.roll[sets.roll.index[Roll_Index]], sets.roll[current_roll]))
    end


    if spell.action_type == 'Ranged Attack' then
        equip(sets.preshot)
    elseif spell.type:lower() == 'weaponskill' then
        if (spell.english == "Leaden Salute") then
        	equip(use_obi(spell, sets.WS.LeadenSalute[sets.WS.LeadenSalute.index[Leaden_Index]]))
            add_to_chat(140, "Leaden Salute Index: "..sets.WS.LeadenSalute.index[Leaden_Index])
        elseif (spell.english == "Wildfire") then
        	equip(sets.WS.LeadenSalute.index[sets.WS.LeadenSalute.index[Leaden_Index]])
        elseif (spell.english == "Last Stand") or (spell.english == "Detonator") then
        	equip(sets.WS.LastStand[sets.RA.index[Ranged_Index]])
        -- equip(sets.RA.Standard)
        elseif (spell.english == "Savage Blade") then
          -- equip(sets.WS.SavageBlade[sets.WS.SavageBlade.index[Savage_Index]])
          equip(sets.WS.SavageBlade)
        elseif (spell.english == "Evisceration") then
            equip(sets.WS.Evisceration)
        else
        	-- equip(sets.WS.LastStand)
            -- equip(sets.RA.Acc)
        end
        add_to_chat(140, "Blah")
    end
    if string.find(spell.english, ' Shot') then
        equip(sets.QuickDraw)
    end
    if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') or string.find(spell.type, "Ninjutsu") then
        add_to_chat(140, "Casting")
        equip(sets.FastCast)
    end
end
-- --- MidCast ---
function midcast(spell)
    if spell.action_type == 'Ranged Attack' then
        equip(sets.RA[sets.RA.index[Ranged_Index]])
    end
end 

-- --- Aftercast ---

function aftercast(spell)
    equip_current()
end

function status_change(new,old)
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
    equip(sets.Idle)
    equip(sets.Gun[sets.Gun.index[Gun_Index]])
end


function self_command(command)

    --toggles
    if command == 'toggle RA set' then
        Ranged_Index = Ranged_Index +1
        if Ranged_Index > #sets.RA.index then 
            Ranged_Index = 1 
        end
        send_command('@input /echo <----- RA Set changed to '..sets.RA.index[Ranged_Index]..' ----->')
        equip(sets.RA[sets.RA.index[Ranged_Index]])
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
    elseif command == 'equip gear' then
        equip_current()
    end

    equip_current()
    updateTable()
end

function buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Reive Mark" and gain then
        equip(sets.Reive)
        disable("neck")
    elseif buff == "Reive Mark" and not gain then
        enable("neck")
    end
end

function use_obi(spell, equip_set)
    local use_obi = false
    if (spell.name == "Leaden Salute") then
        spell.element = "Dark"
    end
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
        equip_set = set_combine(equip_set, sets.midcast_ElementalDay)
    end
 
    return equip_set
end