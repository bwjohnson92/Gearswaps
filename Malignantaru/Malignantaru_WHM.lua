require('ClosetCleaner')
include('displayBox/displayBox.lua')
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

AlaunusFC={ name="Alaunus's Cape", augments={'"Fast Cast"+10',}}

function get_sets()

    sets.precast = {};
    sets.midcast = {};
    sets.aftercast = {};

    sets.Idle = {}
    sets.Idle.index = {"Standard", "DT", "Move"}
    sets.Idle.Standard =  {
        main="Bolelabunga",
        sub="Genmei Shield",
        ammo="Homiliary",
        head="Befouled Crown",
        body="Artsieq Jubbah",
        legs="Assid. Pants +1",
        neck="Loricate Torque +1",
        waist="Fucho-no-Obi",
        left_ear="Etiolation Earring",
        right_ear="Enervating Earring",
        left_ring="Ayanmo Ring",
        right_ring="Defending Ring",
        back=AlaunusFC
    }

    sets.Idle.DT = {
        main="Bolelabunga",
        sub="Genmei Shield",
        ammo="Staunch Tathlum",
        head="Inyanga Tiara +1",
        body="Ayanmo Corazza +1",
        hands="Gendewitha Gages +1",
        legs="Inyanga Shalwar +2",
        feet="Ayanmo Gambieras +1",
        neck="Loricate Torque +1",
        waist="Lieutenant's sash",
        left_ear="Etiolation Earring",
        right_ear="Genmei Earring",
        left_ring="Ayanmo Ring",
        right_ring="Defending Ring",
        back=AlaunusFC
    }

    sets.Idle.Move = set_combine(sets.Idle.Standard,{feet="Herald's Gaiters"})
    
    sets.precast.FastCast = {ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Cleric's Torque",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring2="Lebeche Ring",
        back=AlaunusFC, waist="Witful Belt",feet="Regal Pumps +1"}
    
    sets.precast.FastCure = set_combine(sets.precast.FastCast, {
        neck="Aceso's Choker +1",ear2="Nourishing Earring",
        legs="Ebers Pantaloons +1",feet="Hygieia Clogs +1"}
    )

    sets.midcast.EnfeeblingMagic = {main="Grioavolr",sub="Enki Strap", ammo="Pemphredo Tathlum",
        head="Theophany Cap +2",neck="Erra Pendant",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Theophany Briault +2",hands="Inyanga Dastanas +1",ring1="Kishar Ring",ring2="Sangoma Ring",
        back=AlaunusFC,waist="Rumination Sash", legs="Theophany Pantaloons +2",feet="Skaoi Boots"}

    -- sets.midcast.BarSpells_Solace = {main="Beneficus",
    --     head="Ebers Cap +1",neck="Colossus's Torque",
    --     body="Ebers Bliaud +1",hands="Ebers Mitts +1",ring1="Kishar Ring",ring2="Stikini Ring",
    --     waist="Cascade Belt",legs="Piety Pantaloons +1",feet="Ebers Duckbills +1"}
    --sets.midcast.Barspells_noSolace = set_combine(sets.midcast.BarSpells_Solace,{body="Blessed Briault"})

    sets.midcast.BarSpells_Solace = set_combine(sets.midcast.EnhancingMagicDuration, {
        main="Beneficus",
        legs="Piety Pantaloons +1"
    })

    sets.midcast.EnhancingMagic = {main="Gada", sub="Ammurapi Shield", ammo="Incantor Stone",
        head="Befouled Crown",neck="Colossus's Torque",ear1="Novia Earring",ear2="Loquacious Earring",
        body="Gendewitha Bliaut",hands="Gendewitha Gages +1",ring2="Prolix Ring",
        back="Swith Cape",waist="Cascade Belt",legs="Piety Pantaloons +1",feet="Ebers Duckbills +1"}

    sets.midcast.EnhancingMagicDuration = set_combine(sets.midcast.EnhancingMagic, {
        head="Telchine Cap",
        body="Telchine Chasuble",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches"
    })

    sets.midcast.Regen = set_combine(sets.precast.FastCast, {
        main="Bolelabunga", sub="Ammurapi Shield",
        head="Inyanga Tiara +1",body="Piety Briault +1",
        hands="Ebers Mitts +1",legs="Theophany pantaloons +2"})
    
    sets.midcast.Auspice = {feet="Orison Duckbills +2"}
    
    sets.midcast.Cursna = set_combine(sets.precast.FastCast, {main="Yagrush",
        head="Nahtirah Hat",neck="Debilis medallion", ear1= "Healing Earring", ear2="Beatific Earring",
        body="Ebers Bliaud +1",hands="Fanatic Gloves",ring1="Menelaus's ring", ring2="Haoma's ring",
        back=AlaunusFC,legs="Theophany Pantaloons +2",feet="Vanya Clogs" })
        
    sets.midcast.DebuffRemoval = {
        main="Yagrush",
        head="Nahtirah Hat", neck="Cleric's Torque",ear2="Loquacious Earring",
        body="Ebers Bliaud +1",hands="Ebers Mitts +1",
        back="Swith Cape",waist="Witful Belt",legs="Theophany Pantaloons +2",feet='Gendewitha Galoshes' }

    sets.midcast.DivineCaress = set_combine(sets.midcast.DebuffRemoval, {
        hands="Ebers Mitts +1",
        back="Mending Cape"
    })

    sets.Cure = {}
    sets.Curaga = {}
    sets.Cure.index = {"Standard", "DT"}

    sets.baseCureDT = {
        sub="Genmei Shield",
        neck="Loricate Torque", 
        left_ring="Defending Ring"
    }

    sets.Cure.Standard = {main="Queller Rod",sub="Sors Shield", ammo="Hydrocera",
            head="Vanya Hood",neck="Cleric's Torque",ear1="Roundel Earring",ear2="Nourishing Earring",--10% 3%--
            body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Lebeche ring",ring2="Sirona's Ring", --13%--
            back="Alaunus's Cape",waist="Cascade Belt",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}

    sets.Curaga.Standard = set_combine(sets.Cure.Standard, {})

    sets.Cure.DT = set_combine(sets.Cure.Standard, sets.baseCureDT)

    sets.Curaga.DT = set_combine(sets.Curaga.Standard, sets.baseCureDT)
            
    sets.midcast.Stoneskin = {main="Kirin's Pole",neck="Stone Gorget",waist="Siegel Sash",legs="Shedir Seraweels"}

    sets.midcast.Shellra = sets.midcast.EnhancingMagic
    
    sets.midcast.Recast = {head="Nahtirah Hat",ear2="Loquacious Earring",
    hands="Fanatic Gloves",ring2="Prolix Ring",
    back="Swith Cape",waist="Witful Belt",legs="Blessed Trousers",feet="Gendewitha Galoshes"}
    
    sets.cureWeather =  {back="Twilight Cape", waist="Hachirin-no-obi"}
    
    organizer_items = {
        HiElixir="Hi-Elixir",
        echos="Echo Drops",
        holy="Holy Water",
        remedy="remedy",
        Prism="Prism Powder",
        Oils="Silent Oil",
        Puffs="Cream Puffs",
        Crepe="Pear Crepe",
        Vile="Vile Elixir",
        VileP1="Vile Elixir +1",
        InstRR="Instant Reraise",
        WarpItem="Instant Warp",
        RRHair="Reraise Hairpin",
        RREar="Reraise Earring",
        Warp="Warp Ring",
        CP="Trizek Ring",
        Exp="Echad Ring",
        CPMantle="Mecistopins Mantle",
    }

    send_command('bind end send @others input /follow Malignantaru')
    send_command('bind f10 gs c toggle cure')
    send_command('bind f12 gs c toggle pdt')
    send_command('lua u equipviewer')
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
    update_message()
end
-- --- Precast ---

function precast(spell)
    if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') or string.find(spell.type,'Trust') then
        if string.find(spell.skill,'Healing Magic') then
            if string.find(spell.english, 'Cur') then 
                equip(sets.precast.FastCure)
            else        
                equip(sets.precast.FastCast)
            end
        else        
            equip(sets.precast.FastCast)
        end
        if string.find(spell.skill,'Enhancing Magic') then
            equip({waist="Siegel Sash"})
        end
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
        else
            equip(sets.midcast.EnhancingMagicDuration)
        end
        
    elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
        equip(sets.midcast.EnfeeblingMagic) 
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