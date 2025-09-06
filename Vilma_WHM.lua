require('ClosetCleaner')
include('displayBox.lua')
include('organizeritems.lua')
-- Local Settings, setting the zones prior to use
toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
    "Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}


-- Start Functions here
-- Gear Sets
Idle_Index = 1
Cure_Index = 1
allowWeaponSwap = true

caressFlag = false;

AlaunusFC = { name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}}
AlaunusDT = { name="Alaunus's Cape", augments={'HP+60'}}

function get_sets()

    sets.precast = {};
    sets.midcast = {};
    sets.aftercast = {};

    sets.Idle = {}
    sets.Idle.index = {"Standard", "DT", "Move"}
    sets.Idle.Standard =  {
        main={ name="Queller Rod", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
        sub="Genmei Shield",
        ammo="Homiliary",
        head="Inyanga Tiara +2",
        body="Ebers Bilaut +3",
        hands="Inyanga Dastanas +2",
        legs="Assid. Pants +1",
        feet="Herald's Gaiters",
        neck="Loricate Torque +1",
        waist="Fucho-no-Obi",
        left_ear="Etiolation Earring",
        right_ear="Eabani Earring",
        left_ring="Inyanga Ring",
        right_ring="Defending Ring",
        back="Repulse Mantle"
    }

    sets.Idle.DT = {
        main="Malignance Pole",
        sub="Mensch Strap",
        ammo="Staunch Tathlum +1",
        head="Inyanga Tiara +2",
        body="Piety Bliaut +3",
        hands="Inyan. Dastanas +2",
        legs="Assid. Pants +1",
        feet="Inyan. Crackows +2",
        neck="Loricate Torque +1",
        waist="Fucho-no-Obi",
        left_ear="Etiolation Earring",
        right_ear="Eabani Earring",
        left_ring="Inyanga Ring",
        right_ring="Defending Ring",
        back={ name="Alaunus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
    }

    sets.Idle.DT2 = set_combine(sets.Idle.DT, {
        main="Bolelabunga",
        sub="Genmei Shield",
        head="Bunzi's Hat",
        feet="Bunzi's Sabots",
    })

    sets.Idle.Move = set_combine(sets.Idle.Standard,{feet="Herald's Gaiters"})
    
    sets.precast.FastCast = {main="Grioavolr", sub="Clerisy Strap",ammo="Incantor Stone",
        head="Bunzi's Hat",neck="Cleric's torque +2",ear1="Malignance Earring",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Medada's Ring",ring2="Kishar Ring",
        back=AlaunusFC, waist="Embla Sash", legs="Ayanmo cosciales +2", feet="Regal pumps +1"}
    
    sets.precast.FastCure = set_combine(sets.precast.FastCast, {
        legs="Ebers Pantaloons +3",feet="Kaykaus Boots +1"}
    )

    sets.midcast.EnfeeblingMagic = {main="Grioavolr",sub="Enki Strap", ammo="Pemphredo Tathlum",
        head="Theophany Cap +2",neck="Erra Pendant",ear1="Dignitary's Earring",ear2="Regal Earring",
        body="Theophany Bliaut +3",hands="Inyanga Dastanas +2",ring1="Medada's Ring",ring2="Kishar Ring",
        back="Alaunus's Cape",waist="Rumination Sash", legs="Chironic Hose",feet="Skaoi Boots"}

    sets.midcast.BarSpells_Solace = {main="Beneficus", sub="Ammurapi Shield",
        head="Ebers Cap +3",neck="Colossus's Torque",
        body="Ebers Bliaut +3",hands="Ebers Mitts +3",ring1="Medada's Ring",ring2="Stikini Ring +1",
        waist="Cascade Belt",legs="Piety Pantaloons +3",feet="Ebers Duckbills +3"}
    --sets.midcast.Barspells_noSolace = set_combine(sets.midcast.BarSpells_Solace,{body="Blessed Bliaut"})

    sets.midcast.EnhancingMagic = {main="Gada", sub="Ammurapi Shield", ammo="Incantor Stone",
        head="Befouled Crown",neck="Colossus's Torque",ear1="Mimir Earring",ear2="Andoaa Earring",
        back=AlaunusFC,waist="Embla Sash",legs="Piety Pantaloons +3",feet="Ebers Duckbills +3"}

    sets.midcast.EnhancingMagicDuration = set_combine(sets.midcast.EnhancingMagic, {
        head="Telchine Cap", 
        body="Telchine Chasuble", hands="Telchine Gloves",
        legs="Telchine Braconi", feet="Telchine Pigaches"
        })

    sets.midcast.Regen = set_combine(sets.precast.FastCast, {
        main="Bolelabunga", sub="Ammurapi Shield",
        head="Inyanga Tiara +2",body="Piety Bilaut +3",
        hands="Ebers Mitts +3",legs="Theophany pantaloons +3",
        -- feet="Telchine Pigaches"
        feet="Bunzi's Sabots"
    })
    
    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingMagic, {feet="Ebers Duckbills +3"})
    
    sets.midcast.Cursna = {main="Yagrush",
        head="Nahtirah Hat",neck="debilis medallion", ear1= "Healing Earring", ear2="Beatific Earring",
        body="Ebers Bliaut +3",hands="Fanatic Gloves",ring1="Menelaus's ring", ring2="Haoma's ring",
        back=AlaunusFC,waist="Bishop's Sash",legs="Theophany Pantaloons +3",feet="Gendewitha Galoshes +1" }
        
    sets.midcast.DebuffRemoval = {
        main="Yagrush",
        head="Nahtirah Hat", neck="Cleric's Torque +2",ear2="Loquacious Earring",
        body="Ebers Bliaut +3",hands="Ebers Mitts +3",
        back=AlaunusFC,waist="Witful Belt",legs="Theophany Pantaloons +3",feet='Regal pumps +1' }

    sets.midcast.DivineCaress = set_combine(sets.midcast.DebuffRemoval, {
        hands="Ebers Mitts +3",
        back="Mending Cape"
    })
 
    sets.Cure = {}
    sets.Curaga = {}
    sets.Cure.index = {"Standard", "DT"}

    sets.baseCureDT = {
        head="Ebers Cap +3",
        feet="Bunzi's Sabots",
        sub="Genmei Shield",
        neck="Cleric's Torque +2", 
        left_ring="Defending Ring",
        right_ring="Janniston Ring +1",
        back=AlaunusDT,
        ammo="Staunch Tathlum +1",
    }

    sets.curagaDT = set_combine(sets.baseCureDT, {

        
        body="Bunzi's Robe",
        head="Bunzi's Hat",
        feet="Bunzi's Sabots",
        right_ring="Janniston Ring +1",
        left_ring="Medada's Ring",
        waist="Lieutenant's Sash",
        right_ear="Nourishing Earring"
        })

    sets.Cure.Standard = {main="Queller Rod",sub="Sors Shield", ammo="Pemphredo Tathlum",
            head="Kaykaus mitra +1",neck="Cleric's torque +2",ear1="Glorious Earring",ear2="Nourishing Earring",--10% 3%--
            body="Ebers Bliaut +3",hands="Theophany Mitts +3",ring1="Naji's Loop",ring2="Janniston ring +1", --13%--
            back=AlaunusFC,waist="Embla sash",legs="Ebers Pantaloons +3",feet="Kaykaus Boots +1"}

    sets.Curaga.Standard = {main="Queller Rod",sub="Sors Shield", ammo="Pemphredo Tathlum",
            head="Ebers Cap +3",neck="Cleric's torque +2",ear1="Glorious Earring",--ear2="Sortiarius Earring",--10% 3%--
            body="Theophany Bliaut +3",hands="Theophany Mitts +3",ring1="Medada's Ring",ring2="Janniston Ring +1", --13%--
            back=AlaunusFC,waist="Cascade Belt",legs="Ebers Pantaloons +3",feet="Kaykaus Boots +1"}

    sets.Cure.DT = set_combine(sets.Cure.Standard, sets.baseCureDT)

    -- sets.Curaga.DT = set_combine(sets.Curaga.Standard, sets.curagaDT)

    sets.Curaga.DT = set_combine(sets.Curaga.Standard, sets.curagaDT, {
        main="Daybreak",
        sub="Genmei Shield",
        waist="Witful Belt"
        })
            
    sets.midcast.Stoneskin = {waist="Siegel Sash",}

    sets.midcast.Shellra = {legs="Piety Pantaloons +3"}
    
    sets.midcast.Recast = {head="Bunzi's Hat",ear2="Loquacious Earring",
    hands="Fanatic Gloves",ring2="Medada's Ring",
    back=AlaunusFC,waist="embla sash",legs="Piety Pantaloons +3",feet="Regal Pumps +1"}
    
    sets.cureWeather =  {back="Twilight Cape", waist="Hachirin-no-obi"}
    
    organizer_items = organizerItems()

    sets.Benediction = {
        body = "Piety Bliaut +3"
    }

    sets.Dispelga = { main = "Daybreak", sub="Ammurapi Shield" }

    send_command('bind f10 gs c toggle cure')
    send_command('bind f12 gs c toggle pdt')
    -- send_command('exec mulera.txt')
    text_setup()
    addNewColors()
    updateTable()
end

function addNewColors()
    addTextColorPair("DT", "yellow")
    addTextColorPair("Standard", "green")
end

function updateTable()
    addToTable("(F10) Cure Set", sets.Cure.index[Cure_Index])
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    addToTable("", "")
    -- addToTable("DEL", "Julika Ranged Attack")
    -- addToTable("END", "Julika Leaden Salute")
    -- addToTable("PGDown", "Julika Savage Blade")
    update_message()
end
-- --- Precast ---

function precast(spell)
    if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        if string.find(spell.skill,'Healing Magic') then
            if string.find(spell.english, 'Cur') then 
                equip(sets.precast.FastCure)
            else        
                equip(sets.precast.FastCast)
            end
        else
            if spell.name == "Dispelga" then
                equip(sets.precast.FastCast, sets.Dispelga)
            else
                equip(sets.precast.FastCast)
            end
        end
        if string.find(spell.skill,'Enhancing Magic') then
            equip({waist="Siegel Sash"})
        end
    elseif (spell.english == "Benediction") then 
        equip(sets.Benediction)
        add_to_chat(120, "Benediction")
    end
end
-- --- MidCast ---
function midcast(spell)
    if string.find(spell.type,'Magic') then
        if string.find(spell.skill,'Healing Magic') then
            if string.find(spell.english, 'Cura') then
                equip(use_obi(spell, return_curaga_set(sets1)))
            elseif string.find(spell.english, 'Cure') then 
                equip(use_obi(spell, return_cure_set(sets)))
            elseif string.find(spell.english,'Cursna') then
                equip(sets.midcast.Cursna)
            elseif string.find(spell.english, 'na') then
                if (caressFlag) then
                    equip(sets.midcast.DivineCaress)
                    caressFlag = false
                else
                    equip(sets.midcast.DebuffRemoval)
                end
            elseif string.find(spell.english, 'Raise') then
                equip(sets.midcast.Recast)
            elseif spell.english == 'Erase' then
                equip(sets.midcast.DebuffRemoval)
            end
            
        elseif spell.english == 'Erase' then
            equip(sets.midcast.DebuffRemoval)

        elseif string.find(spell.english,'Stoneskin') then
            equip(sets['midcast_Stoneskin'])
            
        elseif string.find(spell.skill,'Enhancing Magic') then
            if string.find(spell.english,'Bar') then
                equip(sets.midcast.BarSpells_Solace)
            elseif string.find(spell.english, 'Regen') then 
                equip(sets.midcast.Regen)
            elseif string.find(spell.english, 'Boost') then
                equip(sets.midcast.EnhancingMagicDuration)
            else
                equip(sets.midcast.EnhancingMagicDuration)
            end
            
        elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
            if spell.name == "Dispelga" then
                equip(sets.midcast.EnfeeblingMagic, sets.Dispelga)
            else
                equip(sets.midcast.EnfeeblingMagic) 
            end
        else
            equip(sets.midcast.Recast)
        end
    end     
end

-- --- Aftercast ---

function aftercast(spell)
    if (spell.english == 'Divine Caress') then
        caressFlag = true
    end
    equip(sets.Idle[sets.Idle.index[Idle_Index]])
    
    if spell.english == 'Repose' then
        send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    end
end

-- Status Change - ie. Resting

function self_command(command)
    if command == 'toggle pdt' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_Index]])
    elseif command == 'toggle cure' then
        allowWeaponSwap = false
        Cure_Index = Cure_Index +1
        if Cure_Index > #sets.Cure.index then 
            allowWeaponSwap = true
            Cure_Index = 1
        end
        add_to_chat(140, '<----- Cure Set changed to '..sets.Cure.index[Cure_Index]..' ----->')
    end
    updateTable()
end

function return_cure_set()
    return sets.Cure[sets.Cure.index[Cure_Index]]
end

function return_curaga_set()
    return sets.Curaga[sets.Cure.index[Cure_Index]]
end

function status_change(new,tab)
end

function return_true_false_string(flag)
    if (flag) then
        return "true"
    end
    return "false"
end

function use_obi(spell, equip_set)
    local use_obi = false
    -- first check to see if any elemental obi rule matches
    if(S{world.weather_element}:contains(spell.element)) then
        use_obi = true
    end
 
    if (use_obi) then
        equip_set = set_combine(equip_set, sets.cureWeather)
        if (allowWeaponSwap) then
            equip_set = set_combine(equip_set, {
                main="Chatoyant Staff", sub="Achaq Strap"
            })
        end
    end
 
    return equip_set
end