require('closetCleaner')
include('organizer-lib.lua')
include('Grioavolr.lua')
include('MaurMerlinic.lua')
    
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

function get_sets()

    sets.precast = {}
    sets.midcast = {}
    sets.aftercast = {}

    sets.aftercast.Idle = {main="Bolelabunga",sub="Genmei Shield", ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Repulse Mantle",waist="Fucho-no-obi",legs="Lengo Pants",feet="Herald's Gaiters"}

    sets.aftercast.PDT = {main="Earth Staff", ammo="Vanir Battery",
        head="Befouled Crown", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="",
        body="Vrikodara Jupon", ring1="Defending Ring", ring2="Patricius Ring",
        back="Repulse Mantle", waist="Siegel Sash", legs="Merlinic Shalwar", feet="Merlinic Crackows"}
        
    sets.precast.FastCast = {ammo="Incantor Stone",
        head="Nahtirah Hat" ,neck="Voltsurge Torque", ear1="Etiolation Earring", ear2="Loquacious Earring",
        body="Shango Robe", hands="Telchine Gloves", ring1="Kishar Ring", ring2="Weatherspoon Ring +1",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas", feet="Amalric Nails +1"}
    
    sets.precast.FastCure = {
        neck="Voltsurge Torque",ear2="Loquacious Earring",
        body="Vanir Cotehardie",ring2="Weatherspoon Ring +1",
        back="Pahtli Cape",waist="Witful Belt",legs="Psycloth Lappas"}

        
    sets.midcast.EnfeeblingMagic = {main="Contemplator +1",sub="Clerisy Strap",ammo="Hydrocera",
        head="Merlinic Hood",neck="Imbodla Necklace",ear1="Dignitary's Earring",ear2="Barkarole Earring",
        body="Vanya Robe",hands="Lurid Mitts", ring1="Kishar Ring", ring2="Weatherspoon Ring +1",
        back="Ghostfyre Cape",waist="Rumination Sash",legs="Psycloth Lappas",feet="Medium's Sabots"}

--    sets.midcast.ElementalMagic = {main="Grioavolr",sub="Enki Strap", ammo="Pemphredo Tathlum",
--        head=MerlinicHoodNuke,neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Malignance Earring",
--        body="Merlinic Jubbah",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
--        back="Lugh's Cape",waist="Sacro Cord",legs="Merlinic Shalwar",feet=MerlinicFeetNuke} 
    sets.midcast.ElementalMagicAcc = {
        main="Akademos",
        sub="Enki Strap",ammo="Strobilus",
        ammo="Pemphredo Tathlum",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+4%','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+14',}},
        body="Merlinic Jubbah",
        hands="Jhakri Cuffs +2",
        legs="Merlinic Shalwar",
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+3','MND+4','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
        neck="Sanctity Necklace", waist="Sacro Cord",
        left_ear="Barkaro. Earring", right_ear="Digni. Earring",
        ring2="Freke Ring",ring1="Weatherspoon Ring +1",
        back="Lugh's Cape"
    }
    
    sets.midcast.ElementalMagic = { 
        main="Marin Staff +1",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+4%','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+14',}},
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands={ name="Amalric Gages +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Phys. dmg. taken -2%','CHR+8','Mag. Acc.+9','"Mag.Atk.Bns."+14',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+3','MND+4','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
        neck="Sanctity Necklace",
        waist="Sacro Cord",
        left_ear="Barkaro. Earring",
        right_ear="Malignance Earring",
        left_ring="Shiva Ring +1",
        right_ring="Freke Ring",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+5','"Mag.Atk.Bns."+10',}}
    }      

    sets.midcast.ElementalMagicMP = set_combine(sets.midcast.ElementalMagic, {body = "Seidr Cotehardie"})
        
    sets.midcast.Stun = {main="Akademos",sub="Clerisy Strap",ammo="Hydrocera",
        head=MerlinicHoodNuke,neck="Voltsurge Torque",ear1="Dignitary's Earring",ear2="Barkarole Earring",
        body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Weatherspoon Ring +1",
        back="Ogapepo Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Merlinic Crackows"}
        
    sets.midcast.EnhancingMagic = {
        main="Bolelabunga", sub="Ammurapi Shield",
        head="Telchine Cap",neck="Colossus's Torque",ear1="Dignitary's Earring",ear2="Loquacious Earring",
        hands="Telchine Gloves",ring2="Weatherspoon Ring +1",
        back="Ghostfyre Cape",waist="Cascade Belt",legs="Telchine Braconi",feet="Telchine Pigaches"}

    sets.midcast.Cure = {main="Tamaxchi",sub="Genmei Shield",ammo="Hydrocera",
        neck="Colossus's Torque",
        body="Vrikodara Jupon",
        hands="Telchine Gloves",ring1="Stikini Ring",ring2="Ephedra Ring",
        back="Oretania's Cape",waist="Cascade Belt",legs="Chironic Hose",feet="Medium's Sabots"}

    sets.midcast.MagicBurst = {neck="Mizukage-no-Kubikazari", --10
        head=MerlinicHoodBurst,
        body=MerlinicBodyBurst,hands="Amalric Gages +1", ring1="Mujin Band", ring2="Locus Ring", --9,(5),(5),5 
        back="Seshaw Cape", feet=MerlinicFeetNuke} --5, 9 
        
    sets.precast.Impact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})
    sets.midcast.Impact = set_combine(sets.midcast.ElementalMagic, {head=empty, body="Twilight Cloak"}) 
    
    sets.TabulaRasa = {legs="Pedagogy Pants"}
    
    sets.Perpetuance = {hands="Arbatel Bracers +1"}
    
    sets.Klimaform = {feet="Arbatel Loafers +1"}
        
    sets.Regen = {head="Arbatel Bonnet +1"}
    sets.Ebullience={head="Arbatel Bonnet +1"}
    
    sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}
    
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
    if (spell.name == "Impact") then
        equip(sets.precast.Impact)
    elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        equip(sets.precast.FastCast)
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
    if (spell.name == "Impact") then
        equip(sets.midcast.Impact)
    elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        if string.find(spell.skill,'Healing Magic') then
            if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
                equip(sets.midcast.Cure)
            elseif string.find(spell.english, 'Regen') then
                equip(set_combine(sets.precast.FastCast, sets.Regen))
            else
                equip(sets.precast.FastCast)    
            end
            
        elseif string.find(spell.skill,'Enhancing Magic') then
            if(buffactive["Perpetuance"]) then
                equip(set_combine(sets.midcast.EnhancingMagic, sets.Perpetuance))
            else
                equip(sets.midcast.EnhancingMagic)
            end
            
        elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
            equip(sets.midcast.EnfeeblingMagic) 
            
        elseif string.find(spell.skill,'Elemental Magic') then
            if(MPSet) then
                equip(use_MB(use_obi(spell, sets.midcast.ElementalMagicMP)))
            else
                equip(use_MB(use_obi(spell, sets.midcast.ElementalMagicAcc)))
            end
        else
            equip(sets.precast.FastCast)
        end
        
    end
end 

-- --- Aftercast ---

function aftercast(spell)

        equip(sets.aftercast.Idle)

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
        equip(sets['aftercast.Idle'])
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
        equip_set = set_combine(equip_set, sets.midcast.MagicBurst)
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
        equip_set = set_combine(equip_set, sets.midcast.ElementalDay)
        if(buffactive['Klimaform']) then
            equip_set = set_combine(equip_set, sets.Klimaform)
        else
            add_to_chat(140, 'Where\'s your Klimaform!')
        end
    end
 
    return equip_set
end