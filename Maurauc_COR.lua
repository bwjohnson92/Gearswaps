include('organizer-lib.lua')
-- Local Settings, setting the zones prior to use

Nuke_Index = 1
Run_Index = 1

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
function get_sets()

    capeTP={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
    capeWS={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+7','Weapon skill damage +10%',}}
    capeMeleeWS = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    capeMeleeTP = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}}

    sets.roll={
        head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
        body="Lanun Frac +1",
        -- hands="Chasseur's Gants +1", --Chasseur's Gants
        hands="Navarch's Gants +1",
        legs="Lanun Culottes",
        feet="Meg. Jam. +2",
        -- neck="Regal Necklace",
        waist="Chaac Belt",
        left_ear="Etiolation Earring",
        right_ear="Loquac. Earring",
        left_ring="Luzaf's Ring",
        right_ring="Barataria Ring",
        back=capeTP, --AMBUSCADE
    }

    sets.Idle = {
        -- main="Eletta Sword",
        head="Herculean Helm",
        body="Lanun Frac +1",
        hands="Carmine finger gauntlets +1",
        legs="Feast Hose",
        feet="Skadi's Jambeaux +1",
        neck="Loricate Torque +1",
        waist="Chaac Belt",
        left_ear="Etiolation Earring",
        right_ear="Loquac. Earring",
        left_ring="Defending Ring",
        right_ring="Barataria Ring",
        back="Repulse Mantle",
    }

    sets.preshot = { -- aim 60 Snapshot, then Rapid Shot
        head="Taeon Chapeau",
        body="Laksamana's frac +1", --Need
        -- body="Oshosi Vest",
        hands="Carmine Finger Gauntlets +1",
        waist="Yemaya Belt",
        legs="Navarch's Culottes +1", --Need
        feet="Meg. Jam. +2",
        back="Navarch's Mantle",
        neck="Commodore Charm",
    }

    sets.Melee = {
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4',}},
        hands={ name="Herculean Gloves", augments={'Accuracy+19','"Triple Atk."+4','STR+3',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+4','DEX+3','Attack+13',}},
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','DEX+4','Accuracy+8','Attack+13',}},
        neck="Asperity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Suppanomimi",
        right_ear="Telos Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back=capeMeleeTP
    }

    sets.RA = {}
    rangedSets = {'Standard', 'Acc'}
    rangedIndex = 1

    sets.RA.Standard = { --RAcc and STP
        head="Meghanada Visor +2",
        body="Mummu Jacket +2",
        -- hands="Adhemar Wristbands +1",
        hands="Meghanada Gloves +2",
        -- legs="Adhemar Kecks +1",
        legs="Meghanada Chausses +2",
        feet="Meg. Jam. +2",
        neck="Ocachi gorget",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        back=capeTP,
        ring1="Rajas Ring",
        ring2="Ilabrat Ring",
    }

    sets.RA.Acc = set_combine(sets.RA, { --RAcc and STP
        -- body="Laksamana's Frac +1",
        -- legs="Laksamana's Trews +3",
        -- neck="Commodore Charm",
        -- ring1="Hajduk Ring",
        -- ring2="Hajduk Ring",
        head="Meghanada Visor +2",
        body="Meghanada Cuirie +2",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet="Meghanada Jambeaux +2",
        neck="Sanctity Necklace",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        left_ring="Cacoethic Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
    })

    sets.WS = {}

    sets.WS.Generic = { --Generic Physical WS
        head="Meghanada Visor +2",
        body="Herculean Vest",
        hands="Meghanada Gloves +2",
        legs="Feast Hose",
        feet="Meg. Jam. +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Digni. Earring",
        right_ear="Friomisi Earring",
        ring1="Meghanada Ring",
        ring2="Arvina Ringlet +1",
        back=capeWS,
    }

    sets.WS.SavageBlade = {
        head="Meghanada Visor +2",
        neck="Caro Necklace",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Laksamana's Frac +3",
        hands="Meg. Gloves +2",
        ring1="Petrov Ring", --Shukuyu
        ring2="Ilabrat Ring", --Rufescent 
        back=capeMeleeWS,
        waist="Prosilio Belt",
        legs="Laksamana's Trews +3",
        feet="Lanun Bottes +2",
    }

    sets.WS.LeadenSalute = { --AGI Weaponskill
        head="Pixie Hairpin +1",
        -- body={ name="Herculean Vest", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic dmg. taken -2%','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        body="Rawhide Vest",
        -- legs=""
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Dbl.Atk."+3','Mag. Acc.+5','"Mag.Atk.Bns."+8',}},
        feet={ name="Lanun Bottes +1", augments={'Enhances "Wild Card" effect',}},
        neck="Sanctity Necklace",
        waist="Yemaya Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Archon Ring",
        back=capeWS,
    }

    sets.WS.LastStand = {
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
        feet="Lanun Bottes +1"
    }

    sets.FastCast = {
        head="Carmine Mask",
        body="Taeon Tabard",
        feet="Carmine Greaves",
        neck="Orunmila's Torque",
        left_ear="Etiolation Earring",
        right_ear="Loquac. Earring",
        right_ring="Weather. Ring +1",
    }

    sets.roll["Caster's Roll"] = {legs="Chasseur's Culottes"}
    sets.roll["Tactician's Roll"] = {body="Chasseur's Frac +1"}
    sets.RandomDeal = {body="Lanun Frac +1"}
    sets.Fold = {hands="Lanun Gauntlets"}
    sets.SnakeEye = {legs="Lanun Culottes"}
    sets.WildCard = {feet="Lanun Bottes +1"}

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
        gun1="Doomsday",
    }

sets.QuickDraw = set_combine(sets.WS.LeadenSalute, {
    head="Laksamana's Hat",
    feet="Navarch's Bottes +2",
    lear="Dignitary's Earring",
    ring2="Weatherspoon Ring +1"
    })

    -- send_command('bind f10 gs c toggle RA set')

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
        	equip(sets.WS.LeadenSalute)
        elseif (spell.english == "Wildfire") then
        	equip(sets.WS.LeadenSalute)
        elseif (spell.english == "Last Stand") then
        	equip(sets.WS.LastStand)
        elseif (spell.english == "Savage Blade") then
          equip(sets.WS.SavageBlade)
        else
        	-- equip(sets.WS.LastStand)
            -- equip(sets.RA.Acc)
        end
        add_to_chat(140, "Blah")
    end
    if string.find(spell.english, ' Shot') then
        equip(sets.QuickDraw)
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
        equip(sets.RA[rangedSets[rangedIndex]])
    end
end 

-- --- Aftercast ---

function aftercast(spell)
    equip_current()
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

function status_change(new,old)
    equip_current()
end 
  
function equip_TP()
    equip(sets.Melee)
end
 
function equip_idle()
    equip(sets.Idle)
end
 
function equip_current()
    if player.status == 'Engaged' then
        equip_TP()
    else
        equip_idle()
    end
end

function self_command(command)
    if command == 'toggle RA set' then
        rangedIndex = rangedIndex +1
        if rangedIndex > #sets.RA.index then rangedIndex = 1 end
        send_command('@input /echo <----- RA Set changed to '..sets.RA.index[rangedIndex]..' ----->')
        equip(sets.RA[sets.RA.index[rangedIndex]])
    elseif command == 'book' then
        cycle = 0
        invCount = windower.ffxi.get_bag_info(0).count
        if player.inventory["Barrels of Fun"] then
            send_command('input /item "Barrels of Fun" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No Coffers found in inv.')
            send_command('findall barrels of fun')
        end
        if cycle == 1 then
            send_command('wait 3;gs c book')
        end
    else
        send_command('@input /echo hello')
    end
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