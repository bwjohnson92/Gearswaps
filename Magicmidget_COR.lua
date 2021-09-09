include('organizer-lib.lua')
-- Local Settings, setting the zones prior to use

Nuke_Index = 1
Run_Index = 1

MPSet = false
MBSet = false
PDTSet = false
capeLocked = false
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
sets.roll={
    head={ name="Lanun Tricorne", augments={'Enhances "Winning Streak" effect',}},
    body="Chasseur's Frac",
    hands="Chasseur's Gants", --Chasseur's Gants
    legs="Chas. Culottes",
    feet="Meg. Jambeaux",
    neck="Regal Necklace",
    waist="Chaac Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Luzaf's Ring",
    right_ring="Barataria Ring",
    back="Camulus's Mantle", --AMBUSCADE
}

sets.idle = {
    main="Fettering Blade",
    range="Compensator",
    ammo="Eminent Bullet",
    head="Herculean Helm",
    body="Meghanada Cuirie",
    hands="Meghanada Gloves",
    legs="Carmine Cuisses +1",
    feet="Meg. Jambeaux",
    neck="Twilight Torque",
    waist="Chaac Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Luzaf's Ring",
    right_ring="Barataria Ring",
    back="Repulse Mantle",
}

sets.preshot = {
    head="Aurore Beret +1",
    body="Pursuer's Doublet",
    hands="Carmine Finger Gauntlets",
    waist="Impulse Belt",
    legs="Adhemar Kecks",
    feet="Meghanada Jambeaux",
    back="Navarch's Mantle"
}

sets.RA = {
    ammo="Chrono Bullet",
    head={ name="Lanun Tricorne", augments={'Enhances "Winning Streak" effect',}},
    body="Chasseur's Frac",
    hands="Meghanada Gloves",
    legs={ name="Lanun Culottes", augments={'Enhances "Snake Eye" effect',}},
    feet="Meg. Jambeaux",
    neck="Iqabi Necklace",
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear="Pixie Earring",
}

sets.FastCast = {
    head="Carmine Mask",
    body="Taeon Tabard",
    feet="Carmine Greaves +1",
    neck="Orunmila's Torque",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    right_ring="Weather. Ring",
}

    sets.WS= { --AGI Weaponskill
        head="Pixie Hairpin +1",
        -- body={ name="Herculean Vest", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic dmg. taken -2%','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        -- body="Rawhide Vest",
        body="Laksamana's Frac +3",
        -- legs=""
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Dbl.Atk."+3','Mag. Acc.+5','"Mag.Atk.Bns."+8',}},
        -- feet=wsHerc,
        feet="Lanun Bottes +3",
        neck="Sanctity Necklace",
        -- waist="Yemaya Belt",
        waist="Eschan Stone",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Friomisi Earring",
        left_ring="Dingir Ring",
        right_ring="Archon Ring",
        back=capeWSMAB,
    }

sets.roll["Caster's Roll"] = {legs="Chasseur's Culottes"}
sets.roll["Tactician's Roll"] = {body="Chasseur's Frac"}
sets.RandomDeal = {body="Lanun Frac"}
sets.Fold = {hands="Lanun Gauntlets"}
sets.SnakeEye = {legs="Lanun Culottes"}
sets.WildCard = {feet="Lanun Boots"}

sets.Luzal = {ring1="Luzaf's Ring"}

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
    elseif (spell.name == 'Double-Up') then
        equip(sets.roll)
    end

    if spell.action_type == 'Ranged Attack' then
        equip(sets.RA)
    elseif spell.action_type == 'Weapon Skill' then
        equip(sets.WS)
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
    elseif (spell.name == 'Double-Up') then
        equip(sets.roll)
    end
    if spell.action_type == 'Ranged Attack' then
        equip(sets.RA)
    elseif spell.action_type == 'Weapon Skill' then
        equip(sets.RA)
    end
end 

-- --- Aftercast ---

function aftercast(spell)
    --equip(sets.RA)
    equip(sets.idle)
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

function status_change(new,tab)

end

function self_command(command)
    if command == 'toggle Nuke set' then
        Nuke_Index = Nuke_Index +1
        if Nuke_Index > 2 then
            Nuke_Index = 1
            send_command('input /echo Equipped normal nuke set')
        else
            send_command('input /echo Equipped accurate nuke set')
        end
    elseif (command == 'toggle Idle set') then
        Idle_Index = Idle_Index +1
        if Idle_Index > 2 then
            Idle_Index = 1
            send_command('input /echo Equipped Nares Legs')
        else
            send_command('input /echo Equipped Tatsu Legs')
        end
    
    elseif command == 'coffer' then
        cycle = 0
        invCount = windower.ffxi.get_bag_info(0).count
        if invCount == 80 then
            add_to_chat(140,'Inv. full. Ending cycle')
        elseif player.inventory["Velkk Coffer"] then
            send_command('input /item "Velkk Coffer" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No Coffers found in inv.')
            send_command('findall Velkk Coffer')
        end
        if cycle == 1 then
            send_command('wait 2;gs c coffer')
        end
    elseif command == 'gcoffer' then
        cycle = 0
        invCount = windower.ffxi.get_bag_info(0).count
        if invCount == 80 then
            add_to_chat(140,'Inv. full. Ending cycle')
        elseif player.inventory["Grand Velkk Coffer"] then
            send_command('input /item "Grand Velkk Coffer" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No Coffers found in inv.')
            send_command('findall Grand Velkk Coffer')
        end
        if cycle == 1 then
            send_command('wait 2;gs c gcoffer')
        end
    
    elseif command == 'pouch' then
        cycle = 0
        if player.inventory["Silt Pouch"] then
            send_command('input /item "Silt Pouch" <me>')
            cycle = 1
        elseif player.inventory["Bead Pouch"] then
            send_command('input /item "Bead Pouch" <me>')
            cycle = 1
        else
            add_to_chat(140,'No pouches found in inv.')
            send_command('findall Silt Pouch')
            send_command('findall Bead Pouch')
        end
        if cycle == 1 then
            send_command('wait 3; gs c pouch')
        end
    elseif command == 'bpouch' then
        cycle = 0
        invCount = windower.ffxi.get_bag_info(0).count
        if invCount == 80 then
            add_to_chat(140,'Inv. full. Ending cycle')
        elseif player.inventory["Bead Pouch"] then
            send_command('input /item "Bead Pouch" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No Coffers found in inv.')
            send_command('findall Bead Pouch')
        end
        if cycle == 1 then
            send_command('wait 3;gs c bpouch')
        end 
    elseif command == 'book' then
        cycle = 0
        if player.inventory["Barrels of Fun"] then
            send_command('input /item "Barrels of Fun" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No books found in inv.')
            send_command('findall Barrel')
        end
        if cycle == 1 then
            send_command('wait 3;gs c book')
        end
    elseif command == 'switch MP' then
        MPSet = not MPSet
        add_to_chat(140, 'Elemental Magic: '..(MPSet and 'MP' or 'Damage'))
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
            equip(sets.aftercast_Idle)
        else
            PDTSet = true
            add_to_chat(140,'PDT Set On')
            equip(sets.aftercast_PDT)
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
            add_to_chat(140,'Weapon is being locked')
        else
            weaponLocked = false
            enable("Main")
            enable("Sub")
            add_to_chat(140,'Weapon is being unlocked')
        end
    end
    
end

function use_MB(equip_set)
    if (MBSet) then
        equip_set = set_combine(equip_set, sets.midcast_MagicBurst)
    end
    return equip_set
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