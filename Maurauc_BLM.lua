require('closetCleaner')
include('organizer-lib.lua')
include('Grioavolr.lua')
include('MaurMerlinic.lua')
include('displayBox.lua')

-- Local Settings, setting the zones prior to use

Nuke_Index = 1
Idle_Index = 1

MPSet = false
MBSet = false
AccSet = false
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
    
    MerlinicHoodBurst = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','Magic burst dmg.+9%','INT+3','Mag. Acc.+15',}}

    MerlinicBodyBurst = {name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+29','Magic burst dmg.+7%','Mag. Acc.+9',}}

    MerlinicFeetBurst = {  name="Merlinic Crackows", augments={'Mag. Acc.+8','Magic burst dmg.+11%','MND+7','"Mag.Atk.Bns."+8',}}
    TaranusNuke = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}
    TaranusMP = {name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

    sets.Reive = {neck="Arciela's Grace +1"}
    sets.Idle = {}
    sets.precast = {}
    sets.midcast = {}
    sets.JA = {}
    sets.WS = {}    
    sets.Idle.index = {"Standard", "PDT", "HighMP"}

    sets.availableWeapons = {
        main = "Lathi",
        sub = "Raetic Staff +1",
        ammo = "Grioavolr"
    }

    sets.Melee = {
        head="Jhakri"
    }

    sets.Idle.PDT = {main="Earth Staff", ammo="Vanir Battery",
        head="Befouled Crown", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="",
        body="Vrikodara Jupon", hands="Amalric Gages +1", ring1="Defending Ring", ring2="Gelatinous Ring +1",
        back="Repulse Mantle", waist="Siegel Sash", legs="Merlinic Shalwar", feet=MerlinicFeetNuke}

    sets.Idle.Standard = {
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=TaranusNuke,waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Wicce Sabots +1"}

    sets.Idle.HighMP = set_combine(sets.Idle.Standard, { ammo="Strobilus",
        head="Pixie Hairpin +1", body="Amalric Doublet +1", hands="Amalric Gages +1", legs="Amalric Slops +1", feet="Amalric Nails +1",
        neck="Dualism Collar", ear1="Etiolation Earring", ear2="Loquacious Earring", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
        back="Bane Cape", waist="Yamabuki-no-obi"})
        
    sets.Idle.DeathIdle = set_combine(sets.Idle.Standard, {})
        
    sets.precast.FastCast = {
        head="Nahtirah Hat" ,neck="Voltsurge Torque", ear1="Etiolation Earring", ear2="Loquacious Earring",
        body="Eirene's Manteel",hands="Merlinic Dastanas", ring1="Kishar Ring",ring2="Weatherspoon Ring +1",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas", feet=MerlinicFeetNuke}

    sets.precast.FastCastHighMP = set_combine(sets.precast.FastCast, {
        body="Amalric Doublet +1",hands="Amalric Gages +1", ring2="Mephitas's Ring",back="Bane Cape",legs="Amalric Slops +1",waist="Mujin Obi"})
    
    sets.precast.FastCastImpact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})

    sets.midcast.EnfeeblingMagic = {sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=MerlinicHoodNuke,neck="Sorcerer's Stole",ear1="Digni. Earring",ear2="Barkarole Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Kishar Ring",ring2="Weatherspoon Ring +1",
        back=TaranusNuke,waist="Rumination Sash",legs="Psycloth Lappas",feet="Skaoi Boots"}

    sets.midcast.ElementalMagic = {sub="Niobid Strap", ammo="Pemphredo Tathlum",
        head={ name="Arch. Petasos +3"},neck="Sorcerer's Stole",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=TaranusNuke,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}

    sets.midcast.ElementalMagicAcc = {
        --main={  name="Grioavolr", augments={'Magic burst dmg.+9%','Mag. Acc.+27','"Mag.Atk.Bns."+21','Magic Damage +6',}},
        sub="Niobid Strap",ammo="Strobilus",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+4%','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+14',}},
        body=MerlinicBodyNuke,
        hands="Ea Cuffs",
        legs=MerlinicLegsNuke,
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+3','MND+4','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
        neck="Sorcerer's Stole", waist="Yamabuki-no-obi",
        left_ear="Barkaro. Earring", right_ear="Digni. Earring",
        ring2="Weather. Ring +1",ring1="Stikini Ring",
        back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }

    sets.midcast.ElementalMagicHighMP = {sub="Niobid Strap", ammo="Strobilus",
        head={ name="Arch. Petasos +3"}, neck="Eddy Necklace",ear1="Etiolation Earring",ear2="Barkarole Earring",
        body="Spaekona's Coat +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet=MerlinicFeetNuke}

    sets.midcast.ElementalMagicMP = set_combine(sets.midcast.ElementalMagic, {body = "Spaekona's Coat +1"})

    sets.midcast.Impact = set_combine(sets.midcast.ElementalMagicAcc, {head=empty, body="Twilight Cloak"})
        
    sets.midcast.MagicBurst = {neck="Mizukage-no-Kubikazari", --10
        head=MerlinicHoodNuke,
        body=MerlinicBodyBurst,
        hands="Amalric Gages +1", ring1="Mujin Band", ring2="Locus Ring", --9,(5),(5),5 
        back=TaranusNuke, feet=MerlinicFeetNuke} --5, 9 
        
    sets.midcast.Stun = {main="Lathi",sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=MerlinicHoodNuke,neck="Voltsurge Torque",ear1="Digni. Earring",ear2="Barkarole Earring",
        body=MerlinicBodyNuke,hands="Lurid Mitts",ring1="Stikini Ring",ring2="Weatherspoon Ring +1",
        back="Swith Cape",waist="Witful Belt",legs="Merlinic Shalwar",feet=MerlinicFeetNuke}

    sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Hydrocera",
        neck="Voltsurge Torque",ear2="Novia Earring",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Kishar Ring",ring2="Ephedra Ring",
        back="Oretania's Cape",waist="Cascade Belt",feet="Skaoi Boots"}

    organizer_items = {main="Echo Drops", sub="Cehuetzi Snow Cone",ranged="Cream Puff",ammo="Pear Crepe", 
    head="Crepe b. Helene", body="Trizek Ring", ear1="Reraise Earring",
        ring1="Warp Ring",ring2="Capacity Ring", ear2="Echad Ring",
        back="Mecistopins Mantle"}
        
    sets.midcast.Death = {main="Lathi",sub="Niobid Strap", ammo="Strobilus",
        head="Pixie Hairpin +1",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Static Earring",
        body=MerlinicBodyBurst,hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet=MerlinicFeetNuke}
    
    sets.midcast.DeathHighMP = {main="Lathi",sub="Niobid Strap", ammo="Strobilus",
        head="Pixie Hairpin +1",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}
    
    sets.midcast.DeathHighMPMB = {main="Lathi",sub="Niobid Strap", ammo="Strobilus",
        head="Pixie Hairpin +1",neck="Sorcerer's Stole",ear1="Etiolation Earring",ear2="Barkarole Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric slops +1",feet="Amalric Nails +1"}
        
    sets.midcast.DrainAspir = set_combine(sets.midcast.ElementalMagic, {
    head="Pixie Hairpin +1",neck="Voltsurge Torque",  ear1="Gwati Earring", ear2="Barkarole Earring",   
    back="Bane Cape", waist="Fucho-no-obi",feet=MerlinicFeetNuke, ring1="Archon Ring", ring2="Weatherspoon Ring +1"})
            
    sets.midcast.DarkMagic = set_combine(sets.midcast.ElementalMagic, {head="Pixie Hairpin +1"})
            
    sets.WS_Myrkr = set_combine(sets.Idle.HighMP, {})
            
    sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}

    sets.ManaWall = {back=TaranusMP, feet="Wicce Sabots +1"}
        
    sets.midcast.DeathMagicBurst = {
    main={ name="Lathi", augments={'MP+80', 'INT+20','"Mag.Atk.Bns."+20'}}, sub="Niobid Strap",  ammo="Strobilus",
    head="Pixie Hairpin +1",   body="Amalric Doublet +1",
    hands={ name="Amalric Gages +1"},  legs="Amalric Slops +1",
    feet=MerlinicFeetBurst,
    neck="Mizu. Kubikazari",   waist="Yamabuki-no-Obi",   left_ear="Barkaro. Earring",   right_ear="Friomisi Earring",
    left_ring="Archon Ring",   right_ring="Mephitas's Ring +1",  back=TaranusMP}

    sets.superTank = {
    main="Earth Staff",
    sub="Niobid Strap",
    ammo="Strobilus",
    head="Pixie Hairpin +1",
    body={ name="Amalric Doublet +1"},
    hands={ name="Amalric Gages +1"},
    legs="Amalric Slops +1",
    feet="Wicce Sabots +1",
    neck="Loricate Torque +1",
    waist="Yamabuki-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Defending Ring",
    back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }
            
    sets.midcast.OccultAcumen = {
    ammo="Seraphic Ampulla",
    head="Mallquis Chapeau +1",
    body="Spaekona's Coat +1",  
    hands="Ea Cuffs",
    legs="Perdition Slops",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+3','MND+4','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
    neck="Lissome Necklace",
    waist="Oneiros Rope",
    left_ear="Tripudio Earring",
    right_ear="Telos Earring",
    left_ring="Rajas Ring",
    right_ring="Petrov Ring",
    }

    sets.midcast.Ja = {
    	legs="Wicce Chausses +1"
	}

    send_command('bind f10 gs c switch MP')
    send_command('bind f11 gs c switch mb')
    send_command('bind f12 gs c switch pdt')
    send_command('bind ^f11 gs c acc')
    --send_command('bind end gs c lockWeapon')

    text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("HighMP", "yellow")
end

function updateTable()
    addToTable("(F10) MP Body", MPSet)
    addToTable("(F11) MB Set", MBSet)
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    addToTable("(END) Weapon Locked", weaponLocked)
    update_message()
end

-- --- Precast ---

function precast(spell)
if (Idle_Index == 3) then
    if spell.english == 'Myrkr' then
        equip(sets.WS.Myrkr)
    else 
        equip(sets.precast.FastCastHighMP)
    end
else
    if spell.english == 'Impact' then
        equip(sets.precast.FastCastImpact)
    elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        equip(sets.precast.FastCast)
        if string.find(spell.skill,'Enhancing Magic') then
            equip({waist="Siegel Sash"})
            if string.find(spell.english,'Stoneskin') then
                equip({head="Umuthi Hat"})
            end
        end
    end
    if spell.english == 'Myrkr' then
        equip(sets.WS.Myrkr)
    end
    if spell.english == 'Mana Wall' then
        equip(sets.JA.ManaWall)
        disable("Feet")
        disable("back")
    end
end
end
-- --- MidCast ---
function midcast(spell)
    if (Idle_Index == 3) then
        if spell.english == 'Death' then
            if (MBSet == true) then
                equip(use_obi(spell, sets.midcast.DeathHighMPMB))
            else
                equip(use_obi(spell, sets.midcast.DeathHighMP))
            end
        elseif spell.english == 'Myrkr' then
            equip(sets.WS.Myrkr)
        elseif string.find(spell.type,'BlackMagic') then
            equip(sets.midcast.ElementalMagicHighMP)
        else
            equip(sets.precast.FastCastHighMP)
        end
        return
    end
        

    if spell.english == 'Impact' then
        equip(sets.midcast.Impact)
    elseif spell.english == 'Death' then
        equip(set_combine(use_MB(use_obi(spell, sets.midcast.Death))), {head="Pixie Hairpin +1"})
    elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
        if string.find(spell.skill,'Healing Magic') then
            if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
                equip(sets.midcast.Cure)
            else
                equip(sets.precast.FastCast)
            end
        elseif string.find(spell.skill,'Enhancing Magic') then
            equip(sets.midcast.EnhancingMagic)
                        
        elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
            equip(sets.midcast.EnfeeblingMagic) 
    
        elseif string.find(spell.skill,'Elemental Magic') then
            -- if DotDebuffs:contains(spell.english) then 
                -- equip(set_combine(sets.midcast.EnfeeblingMagic, sets.ElementalDebuff))
            if (MPSet) then
                equip(use_MB(use_acc(use_obi(spell, sets.midcast.ElementalMagicMP))))
            else
                equip(use_MB(use_acc(use_obi(spell, sets.midcast.ElementalMagic))))
            end
        elseif string.find(spell.skill, 'Dark Magic') then
            if spell.english ~= 'Stun' then
                equip(sets.midcast.DrainAspir)
            else
                equip(sets.midcast.Stun)
            end
        else
            equip(sets.precast.FastCast)
        end
    end
end 

-- --- Aftercast ---

function aftercast(spell)
    equip(sets.Idle[sets.Idle.index[Idle_Index]])
    check_spell(spell)
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

-- Status Change - ie. Resting

function status_change(new,tab)
end

function self_command(command)
    if command == 'test' then
        -- print_table()
        add_to_chat(140, Idle_Index)
    end
    if command == 'switch MP' then
        MPSet = not MPSet
        add_to_chat(140, '<-- Nuking using '..(MPSet and 'MP Recovery' or 'Damage')..' Body -->')
    elseif command == 'acc' then
        AccSet = not AccSet
        add_to_chat(140, 'Elemental Magic: '..(AccSet and 'Acc' or 'Damage'))
    elseif command == 'switch mb' then
        MBSet = not MBSet
        add_to_chat(140, '<-- Magic Burst Set: '..(MBSet and 'ON' or 'OFF')..'-->')
    elseif command == 'switch pdt' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_Index]])
    elseif command == 'lockCape' then
        capeLocked = not capeLocked
        if capeLocked == true then
            disable("Back")
        else
            enable("Back")
        end
        add_to_chat(140, '<----- Cape is now '..(capeLocked and 'locked' or 'unlocked')..' ----->')
    elseif command == 'lockWeapon' then
        weaponLocked = not weaponLocked
        if weaponLocked == true then
            disable("Main")
            disable("Sub")
        else
            enable("Main")
            enable("Sub")
        end
        add_to_chat(140, '<----- Weapon is now '..(weaponLocked and 'locked' or 'unlocked')..' ----->')
    end
    updateTable()
end

function use_MB(equip_set)
    if (MBSet) then
        equip_set = set_combine(equip_set, sets.midcast.MagicBurst)
    end
    return equip_set
end

function use_acc(equip_set)
    if (AccSet) then
        equip_set = set_combine(equip_set, sets.midcast.ElementalMagicAcc)
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
    end
 
    return equip_set
end