    include('organizer-lib.lua')
    
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
MPSet = false
MBSet = false
perpOn = false

MerlinicFeet = { name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-3','CHR+9','Mag. Acc.+3','"Mag.Atk.Bns."+5',}}

-- Start Functions here
-- Gear Sets
function get_sets()

    sets.aftercast_Idle = {main="Akademos",sub="Clerisy Strap", ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +1",hands="Amalric Gages",ring1="Defending Ring",ring2="Dark Ring",
        back="Repulse Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="Herald's Gaiters"}

    sets.aftercast_PDT = {main="Earth Staff", ammo="Vanir Battery",
        head="Befouled Crown", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="",
        body="Vrikodara Jupon", ring1="Defending Ring", ring2="Patricius Ring",
        back="Repulse Mantle", waist="Siegel Sash", legs="Merlinic Shalwar", feet="Merlinic Crackows"}
        
    sets.precast_FastCast = {main="Akademos",sub="Clerisy Strap", ammo="Incantor Stone",
        head="Nahtirah Hat" ,neck="Voltsurge Torque", ear1="Etiolation Earring", ear2="Loquacious Earring",
        body="Merlinic Jubbah",hands="Repartie Gloves", ring1="Kishar Ring", ring2="Weatherspoon Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas", feet=MerlinicFeet}
    
    sets.precast_FastCure = set_combine(sets.precast_FastCast, {
        back="Pahtli Cape"})

        
    sets.midcast_EnfeeblingMagic = {main="Akademos",sub="Clerisy Strap",ammo="Hydrocera",
        head="Merlinic Hood",neck="Imbodla Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vanya Robe",hands="Lurid Mitts", ring1="Kishar Ring", ring2="Weatherspoon Ring",
        back="Ghostfyre Cape",waist="Rumination Sash",legs="Psycloth Lappas",feet="Medium's Sabots"}

--    sets.midcast_ElementalMagic = {main="Grioavolr",sub="Niobid Strap", ammo="Pemphredo Tathlum",
--        head=MerlinicHoodNuke,neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
--        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Icesoul Ring",ring2="Icesoul Ring",
--        back="Toro Cape",waist="Yamabuki-no-obi",legs="Merlinic Shalwar",feet=MerlinicFeetNuke} 
    sets.midcast_ElementalMagicAcc = {
        main="Akademos",
        sub="Niobid Strap",ammo="Strobilus",
        ammo="Phantom Tathlum",
        head="Merlinic Hood",
        body="Merlinic Jubbah",
        hands="Jhakri Cuffs +1",
        legs="Merlinic Shalwar",
        feet=MerlinicFeet,
        neck="Sanctity Necklace", waist="Yamabuki-no-obi",
        left_ear="Sortiarius Earring", right_ear="Digni. Earring",
        ring2="Weather. Ring +1",ring1="Stikini Ring",
        back="Toro Cape"
    }
    
    sets.midcast_ElementalMagic = {main="Akademos",sub="Niobid Strap", ammo="Pemphredo Tathlum",
    head="Merlinic Hood",neck="Eddy Necklace",ear1="Sortiarius Earring",ear2="Friomisi Earring",
    body="Merlinic Jubbah",hands="Amalric Gages",ring1="Icesoul Ring",ring2="Icesoul Ring",
    back="Toro Cape",waist="Yamabuki-no-obi",legs="Psycloth Lappas",feet=MerlinicFeet}      

    sets.midcast_ElementalMagicMP = set_combine(sets.midcast_ElementalMagic, {body = "Seidr Cotehardie"})
        
    sets.midcast_Stun = {main="Akademos",sub="Benthos Grip",ammo="Hydrocera",
        head="Merlinic Hood",neck="Voltsurge Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Weatherspoon Ring",
        back="Ogapepo Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Merlinic Crackows"}
        
    sets.midcast_EnhancingMagic = {
        head="Telchine Cap",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
        hands="Telchine Gloves",ring2="Weatherspoon Ring",
        back="Ghostfyre Cape",waist="Cascade Belt",legs="Telchine Braconi",feet="Telchine Pigaches"}

    sets.midcast_Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Hydrocera",
        head="Vanya Hood",neck="Nodens Gorget",
        hands="Telchine Gloves",ring1="Stikini Ring",ring2="Ephedra Ring",
        back="Tempered Cape +1",waist="Cascade Belt",legs="Chironic Hose",feet="Vanya Clogs"}

    sets.midcast_MagicBurst = {neck="Mizukage-no-Kubikazari", --10
        head="Merlinic hood",
        body="Merlinic Body",hands="Amalric Gages", ring1="Mujin Band", ring2="Locus Ring", --9,(5),(5),5 
        back="Seshaw Cape", feet="Merlinic Feet"} --5, 9 
        
    sets.midcast_Impact = set_combine(sets.midcast_ElementalMagic, {head=empty, body="Twilight Cloak"}) 
    
    sets.TabulaRasa = {legs="Pedagogy Pants"}
    
    sets.Perpetuance = {hands="Arbatel Bracers +1"}
    
    sets.Klimaform = {feet="Arbatel Loafers +1"}
        
    sets.Regen = {head="Arbatel Bonnet +1"}
    sets.Ebullience={head="Arbatel Bonnet +1"}
    
    sets.midcast_ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}
    
    sets.Sublimation = {head="Academic's Mortarboard", body="Pedagogy Gown +1"}
    
    organizer_items = { main="Echo Drops", ranged="Cream Puff", ammo="Pear Crepe",
        body="Trizek Ring", ear1="Reraise Earring",
        ring1="Warp Ring",ring2="Capacity Ring", ear2="Echad Ring",
        back="Mecistopins Mantle"}

    send_command('bind f11 gs c switch mb')
    send_command('bind f10 gs c switch MP')
    send_command('bind f12 gs c switch pdt')

end

-- --- Precast ---

function precast(spell)
    if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        equip(sets.precast_FastCast)
        if string.find(spell.skill,'Enhancing Magic') then
            equip({waist="Siegel Sash"})
            if string.find(spell.english,'Stoneskin') then
                equip({head="Umuthi Hat"})
            end
        end

    elseif spell.english == "Tabula Rasa" then
        equip(sets.TabulaRasa)
    end
    
end
-- --- MidCast ---
function midcast(spell)
    if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        if string.find(spell.skill,'Healing Magic') then
            if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
                equip(sets.midcast_Cure)
            elseif string.find(spell.english, 'Regen') then
                equip(set_combine(sets.precast_FastCast, sets.Regen))
            else
                equip(sets.precast_FastCast)    
            end
            
        elseif string.find(spell.skill,'Enhancing Magic') then
            if(buffactive["Perpetuance"]) then
                equip(set_combine(sets.midcast_EnhancingMagic, sets.Perpetuance))
            else
                equip(sets.midcast_EnhancingMagic)
            end
            
        elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
            equip(sets.midcast_EnfeeblingMagic) 
            
        elseif string.find(spell.skill,'Elemental Magic') then
            if(MPSet) then
                equip(use_MB(use_obi(spell, sets.midcast_ElementalMagicMP)))
            else
                equip(use_MB(use_obi(spell, sets.midcast_ElementalMagic)))
            end
        else
            equip(sets.precast_FastCast)
        end
        
    end
end 

-- --- Aftercast ---

function aftercast(spell)

        equip(sets.aftercast_Idle)

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

-- Status Change - ie. Resting

function status_change(new,tab)
    if new == 'Engaged' then
        equip(sets['Melee'])
        --disable("Main")
    else
        equip(sets['aftercast_Idle'])
        --enable("Main")
    end
end

function self_command(command)
    if command == 'coffer' then
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
    elseif command == 'pouch' then
        cycle = 0
        invCount = windower.ffxi.get_bag_info(0).count
        if invCount == 80 then
            add_to_chat(140,'Inv. full. Ending cycle')
        elseif player.inventory["Silt Pouch"] then
            send_command('input /item "Silt Pouch" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No Coffers found in inv.')
            send_command('findall Silt Pouch')
        end
        if cycle == 1 then
            send_command('wait 3;gs c pouch')
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
    elseif command == 'switch mb' then
        if (MBSet) then
            MBSet = false
            add_to_chat(140,'Magic Burst: Off')
        else
            MBSet = true
            add_to_chat(140,'Magic Burst: On')
        end
    elseif command == 'switch perp' then
        if perpOn == false then
            perpOn = true
            equip({hands="Savant's Bracers +2"})
            disable("Hands")
            add_to_chat(140,'Hands are being locked')
        else
            perpOn = false
            enable("Hands")
            add_to_chat(140,'Hands are being unlocked')
        end
    elseif command == 'switch MP' then
        MPSet = not MPSet
        add_to_chat(140, 'Elemental Magic: '..(MPSet and 'MP' or 'Damage'))
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
        if(buffactive['Klimaform']) then
            equip_set = set_combine(equip_set, sets.Klimaform)
        else
            --add_to_chat(140, 'Where\'s your Klimaform!')
        end
    end
 
    return equip_set
end