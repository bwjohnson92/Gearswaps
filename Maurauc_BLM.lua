require('closetCleaner')
include('organizer-lib.lua')
include('Grioavolr.lua')
include('MaurMerlinic.lua')
include('displayBox.lua')

Idle_Index = 1

Nuke_Index = 1
Accuracy_Index = 1

MPSet = false
PDTSet = false
capeLocked = false
weaponLocked = false

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
    "Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

DotDebuffs = S{"Burn", "Choke", "Shock", "Drown", "Frost", "Rasp"}

stikini1={name="Stikini Ring +1", bag="wardrobe2"}
stikini2={name="Stikini Ring +1", bag="wardrobe3"}

-- Start Functions here
-- Gear Sets
function get_sets()
    
    MerlinicHoodBurst = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+6','Magic burst dmg.+9%','INT+3','Mag. Acc.+15',}}

    MerlinicBodyBurst = {name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+29','Magic burst dmg.+7%','Mag. Acc.+9',}}

    -- MerlinicFeetBurst = {  name="Merlinic Crackows", augments={'Mag. Acc.+8','Magic burst dmg.+11%','MND+7','"Mag.Atk.Bns."+8',}}
    MerlinicFeetBurst = MerlinicFeetNuke
    TaranusNuke = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}
    TaranusMP = {name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

    sets.Reive = {neck="Arciela's Grace +1"}
    sets.Idle = {}
    sets.precast = {}
    sets.midcast = {}
    sets.JA = {}
    sets.WS = {}    
    sets.Idle.index = {"Standard", "PDT", "PDTMove", "HighMP"}

    sets.availableWeapons = {
        -- main = "Lathi",
        sub = "Marin Staff +1",
        ammo = "Grioavolr"
    }

    sets.Idle.PDT = {
        head="Nyame Helm", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sorcerer's Earring",
        body="Vrikodara Jupon", hands="Nyame Gauntlets", ring1="Defending Ring", ring2=stikini2,
        back=TaranusNuke,waist="Fucho-no-obi", legs="Nyame Flanchard", feet="Nyame Sollerets"}

    sets.Idle.PDTMove = set_combine(sets.Idle.PDT, {
        feet="Herald's Gaiters"
    })

    sets.Idle.Standard = {
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Volte Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=TaranusNuke,waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Wicce Sabots +2"}

    sets.Idle.HighMP = set_combine(sets.Idle.Standard, { ammo="Strobilus",
        head="Pixie Hairpin +1", body="Amalric Doublet +1", hands="Amalric Gages +1", legs="Amalric Slops +1", feet="Amalric Nails +1",
        -- neck="Dualism Collar", 
        ear1="Etiolation Earring", ear2="Loquacious Earring", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
        back="Bane Cape", waist="Sacro Cord"})
        
    sets.Idle.DeathIdle = set_combine(sets.Idle.Standard, {})
        
    sets.precast.FastCast = {
        head="Nahtirah Hat" ,neck="Voltsurge Torque", ear1="Malignance Earring", ear2="Loquacious Earring",
        body="Shango Robe",hands="Volte Gloves", ring1="Kishar Ring",ring2="Weatherspoon Ring +1",
        back="Swith Cape",waist="Embla Sash",legs="Psycloth Lappas", feet="Amalric Nails +1"}

    sets.precast.FastCastHighMP = set_combine(sets.precast.FastCast, {
        body="Amalric Doublet +1",hands="Amalric Gages +1", ring2="Mephitas's Ring",back="Bane Cape",legs="Amalric Slops +1",
        -- waist="Mujin Obi"
    })
    
    sets.precast.FastCastImpact = set_combine(sets.precast.FastCast, {head=empty, body="Twilight Cloak"})

    sets.midcast.EnfeeblingMagic = {sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=MerlinicHoodNuke,neck="Sorcerer's Stole",ear1="Digni. Earring",ear2="Malignance Earring",
        body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Kishar Ring",ring2="Weatherspoon Ring +1",
        back=TaranusNuke,waist="Rumination Sash",legs="Psycloth Lappas",feet="Skaoi Boots"}

    sets.ElementalDebuff = {
        legs="Archmage's Tonban +3",
        feet="Archmage's Sabots +3"
    }

    --NUKING

    sets.midcast.ElementalMagic = {sub="Enki Strap", ammo="Pemphredo Tathlum",
        head={ name="Arch. Petasos +3"},neck="Sorcerer's Stole",ear1="Malignance Earring",ear2="Barkarole Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Freke Ring",
        back=TaranusNuke,waist="Sacro Cord",legs="Amalric Slops +1",feet="Amalric Nails +1"}

    sets.midcast.ElementalMagic.index = {'Standard', 'Burst'}
    sets.midcast.ElementalMagic.Acc = {}
    sets.midcast.ElementalMagic.Acc.index = {'MidAcc', 'Accuracy'}

    sets.midcast.ElementalMagic.Standard = sets.midcast.ElementalMagic

    sets.midcast.ElementalMagic.Standard.Damage = sets.midcast.ElementalMagic.Standard
    
    sets.midcast.ElementalMagic.Standard.MidAcc = set_combine(sets.midcast.ElementalMagic.Standard.Damage, {
        head="Archmage's Petasos +3",
        body="Wicce Coat +3",
        hands="Archmage's Gloves +3",
        legs="Wicce Chausses +3",
        feet="Wicce Sabots +2",
        neck="Sorcerer's Stole", waist="Sacro Cord",
        left_ear="Barkaro. Earring", right_ear="Malignance Earring",
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    })
    
    sets.midcast.ElementalMagic.Standard.Accuracy = set_combine(sets.midcast.ElementalMagic.Standard.Damage, {
        head="Archmage's Petasos +3",
        body="Wicce Coat +3",
        hands="Ea Cuffs",
        legs="Wicce Chausses +3",
        feet="Wicce Sabots +2",
        neck="Sorcerer's Stole", waist="Sacro Cord",
        left_ear="Barkaro. Earring", right_ear="Malignance Earring",
        ring1="Stikini Ring +1",
        ring2="Metamorph Ring +1",
        back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    })

    sets.midcast.MagicBurst = {
        neck="Mizukage-no-Kubikazari", --10
        head=MerlinicHoodNuke,
        -- body=MerlinicBodyBurst,
        hands="Amalric Gages +1", 
        ring1="Mujin Band", ring2="Locus Ring", --9,(5),(5),5 
        back=TaranusNuke, 
        feet=MerlinicFeetNuke
    } --5, 9 

    sets.midcast.ElementalMagic.Burst = set_combine(sets.midcast.ElementalMagic.Standard, sets.midcast.MagicBurst)

    sets.midcast.ElementalMagic.Burst.Damage = sets.midcast.ElementalMagic.Burst

    sets.midcast.ElementalMagic.Burst.MidAcc = set_combine(sets.midcast.ElementalMagic.Standard.MidAcc, {
        neck="Mizukage-no-Kubikazari",
        ring1="Mujin Band",
        ring2="Locus Ring",
    })
    
    sets.midcast.ElementalMagic.Burst.Accuracy = set_combine(sets.midcast.ElementalMagic.Burst.Damage, {
        hands="Ea Cuffs"
    })

    sets.midcast.ElementalMagic.OccultAcumen = {
        -- ammo="Seraphic Ampulla",
        -- head="Mallquis Chapeau +1",
        -- body="Spaekona's Coat +3",  
        -- hands="Ea Cuffs",
        -- legs="Perdition Slops",
        -- feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+3','MND+4','Mag. Acc.+15','"Mag.Atk.Bns."+10',}},
        -- neck="Lissome Necklace",
        -- waist="Oneiros Rope",
        -- left_ear="Tripudio Earring",
        -- right_ear="Telos Earring",
        -- left_ring="Rajas Ring",
        -- right_ring="Petrov Ring",
    }

    sets.midcast.NukeMPRestore = {body = "Spaekona's Coat +3"}

    sets.midcast.ElementalMagicHighMP = {sub="Enki Strap", ammo="Strobilus",
        head={ name="Arch. Petasos +3"}, neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Malignance Earring",
        body="Spaekona's Coat +3",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=TaranusMP,waist="Sacro Cord",legs="Amalric Slops +1",feet=MerlinicFeetNuke}


    sets.midcast.Impact = set_combine(sets.midcast.ElementalMagicAcc, {head=empty, body="Twilight Cloak"})
        
    sets.midcast.Stun = {
        -- main="Lathi",
        sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head=MerlinicHoodNuke,neck="Voltsurge Torque",ear1="Digni. Earring",ear2="Malignance Earring",
        body="Wicce Coat +3",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Weatherspoon Ring +1",
        back="Swith Cape",waist="Cornelia's Belt",legs="Merlinic Shalwar",feet=MerlinicFeetNuke}

    sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Hydrocera",
        neck="Voltsurge Torque",ear2="Novia Earring",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Kishar Ring",ring2="Ephedra Ring",
        back="Oretania's Cape",waist="Cascade Belt",feet="Skaoi Boots"}

    organizer_items = {
        main="Echo Drops", sub="Cehuetzi Snow Cone",ranged="Remedy",ammo="Pear Crepe", 
        head="Tropical Crepe", body="Trizek Ring", ear1="Reraise Earring",
        ring1="Warp Ring",ring2="Capacity Ring", ear2="Echad Ring",
        back="Mecistopins Mantle"
    }
        
    sets.midcast.Death = {
        -- main="Lathi",
        sub="Enki Strap", ammo="Strobilus",
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Malignance Earring",ear2="Static Earring",
        body=MerlinicBodyBurst,hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=TaranusMP,waist="Sacro Cord",legs="Amalric Slops +1",feet=MerlinicFeetNuke}
    
    sets.midcast.DeathHighMP = {
        -- main="Lathi",
        sub="Enki Strap", ammo="Strobilus",
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Malignance Earring",ear2="Barkarole Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=TaranusMP,waist="Sacro Cord",legs="Amalric Slops +1",feet="Amalric Nails +1"}
    
    sets.midcast.DeathHighMPMB = {
        -- main="Lathi",
        sub="Enki Strap", ammo="Strobilus",
        head="Pixie Hairpin +1",neck="Sorcerer's Stole",ear1="Etiolation Earring",ear2="Malignance Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
        back=TaranusMP,waist="Sacro Cord",legs="Amalric slops +1",feet="Amalric Nails +1"}
        
    sets.midcast.DrainAspir = set_combine(sets.midcast.ElementalMagic, {
    head="Pixie Hairpin +1",neck="Voltsurge Torque",  ear1="Dignitary's Earring", ear2="Malignance Earring",   
    back="Bane Cape", waist="Fucho-no-obi",feet=MerlinicFeetNuke, ring1="Archon Ring", ring2="Weatherspoon Ring +1"})
            
    sets.midcast.DarkMagic = set_combine(sets.midcast.ElementalMagic, {head="Pixie Hairpin +1"})
            
    sets.WS_Myrkr = set_combine(sets.Idle.HighMP, {})
            
    sets.midcast.ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}

    sets.ManaWall = {back=TaranusMP, feet="Wicce Sabots +2"}
        
    sets.midcast.DeathMagicBurst = {
    -- main={ name="Lathi", augments={'MP+80', 'INT+20','"Mag.Atk.Bns."+20'}}, sub="Enki Strap",  
    ammo="Strobilus",
    head="Pixie Hairpin +1",   body="Amalric Doublet +1",
    hands={ name="Amalric Gages +1"},  legs="Amalric Slops +1",
    feet=MerlinicFeetBurst,
    neck="Mizu. Kubikazari",   waist="Sacro Cord",   left_ear="Barkaro. Earring",   right_ear="Barkarole Earring",
    left_ring="Archon Ring",   right_ring="Mephitas's Ring +1",  back=TaranusMP}

    sets.superTank = {
        main="Malignance Pole",
        sub="Enki Strap",
        ammo="Strobilus",
        head="Pixie Hairpin +1",
        body={ name="Amalric Doublet +1"},
        hands={ name="Amalric Gages +1"},
        legs="Amalric Slops +1",
        feet="Wicce Sabots +2",
        neck="Loricate Torque +1",
        waist="Sacro Cord",
        left_ear="Etiolation Earring",
        right_ear="Loquac. Earring",
        left_ring="Mephitas's Ring +1",
        right_ring="Defending Ring",
        back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }

    sets.Melee = {    
        ammo="Vanir Battery",
        head="Nyame Helm",
        body="Volte Jupon",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Lissome Necklace",
        waist="Cornelia's Belt",
        left_ear="Telos Earring",
        right_ear="Tripudio Earring",
        left_ring="Chirich Ring +1",
        right_ring="Petrov Ring",
        -- back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    }

    sets.WS = {
        head="Nyame Helm",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        waist="Fotia Belt",
        neck="Fotia Gorget",
        ring1="Epaminondas's Ring",
        ring2="Cornelia's Ring"
    }

    sets.midcast.Ja = {
    	legs="Wicce Chausses +3"
	}

    send_command('bind f9 gs c switch MP')
    send_command('bind f10 gs c acc')
    send_command('bind f11 gs c switch mb')
    send_command('bind f12 gs c switch pdt')
    send_command('bind ^f12 gs c switch back')
    send_command('bind pause gs c nuke')
    -- send_command('bind f9 gs c melee')
    --send_command('bind end gs c lockWeapon')

    text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("HighMP", "yellow")
    addTextColorPair("Accuracy", "yellow")
end

function updateTable()
    addToTable("(F9) MP Body", MPSet)
    addToTable("(F10) Dmg or Acc", sets.midcast.ElementalMagic.Acc.index[Accuracy_Index])
    addToTable("(F11) MB Set", sets.midcast.ElementalMagic.index[Nuke_Index])
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    addToTable("(END) Weapon Locked", weaponLocked)
    update_message()
end

-- --- Precast ---

function precast(spell)
    if (spell.type == "WeaponSkill" or spell.action_type == "WeaponSkill") then
        if spell.english == 'Myrkr' then
            equip(sets.WS.Myrkr)
        else
            equip(sets.WS)
        end
        return
    end
if (sets.Idle.index[Idle_Index] == "HighMP") then
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
    if (spell.type == "WeaponSkill" or spell.action_type == "WeaponSkill") then
        if spell.english == 'Myrkr' then
            equip(sets.WS.Myrkr)
        else
            equip(sets.WS)
        end
    end
    if spell.english == 'Mana Wall' then
        equip(sets.JA.ManaWall)
    end
end
end
-- --- MidCast ---
function midcast(spell)
    if (spell.type == "WeaponSkill") then
        return
    end
    if spell.english == 'Mana Wall' then
        return
    end
    if (sets.Idle.index[Idle_Index] == "HighMP") then
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
            if DotDebuffs:contains(spell.english) then 
                equip(set_combine(sets.midcast.EnfeeblingMagic, sets.ElementalDebuff))
                return
            end

            set = getNukeSet()
            set = use_obi(spell, set)

            if (MPSet) then
                set = set_combine(set, sets.midcast.NukeMPRestore)
            end

            if(string.find(spell.english, 'ja')) then
                set = set_combine(set, sets.midcast.Ja)
            end
            equip(set)

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
    if spell.english == 'Mana Wall' then
        equip(set_combine(sets.Idle[sets.Idle.index[Idle_Index]], {
            back=sets.ManaWall.back, feet=sets.ManaWall.feet
        }))
        return
    end
    if (spell.type == "WeaponSkill" or spell.action_type == "WeaponSkill") then
        if (spell.english ~= "Myrkr") then
            equip(sets.Melee)
        end
    else
        equip(sets.Idle[sets.Idle.index[Idle_Index]])
        check_spell(spell)
    end
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

function getNukeSet()
    set = {}
    nukeIndex = sets.midcast.ElementalMagic.index[Nuke_Index]
    accIndex = sets.midcast.ElementalMagic.Acc.index[Accuracy_Index]

    -- add_to_chat(140, "Nuke Set "..nukeIndex.." and acc index "..accIndex)
    if (sets.midcast.ElementalMagic[nukeIndex][accIndex]) then
        add_to_chat(140, "Found nuke set")
        set = sets.midcast.ElementalMagic[nukeIndex][accIndex]
    else 
        set = sets.midcast.ElementalMagic[nukeIndex]
    end

    return set
end

function buff_change(buff, gain)
    if (gain) then
        add_to_chat(140, "Gained "..buff)
    else
        add_to_chat(140, "Lost "..buff)
    end

    if (buff == "Mana Wall") then
        if (gain) then
            add_to_chat(140, "disabling feet & back")
            disable("feet")
            disable("back")
        else
            add_to_chat(140, "enabling feet & back")
            enable("feet")
            enable("back")
        end
    end
end

function self_command(command)
    if command == 'switch MP' then
        MPSet = not MPSet
        add_to_chat(140, '<-- Nuking using '..(MPSet and 'MP Recovery' or 'Damage')..' Body -->')
    
    elseif command == 'acc' then
        Accuracy_Index = Accuracy_Index +1
        if Accuracy_Index > #sets.midcast.ElementalMagic.Acc.index then
            Accuracy_Index = 1
        end
    
    elseif command == 'switch mb' then
        Nuke_Index = Nuke_Index +1
        if Nuke_Index > #sets.midcast.ElementalMagic.index then
            Nuke_Index = 1
        end
    
    elseif command == 'switch pdt' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_Index]])

    elseif command == 'switch back' then
        Idle_Index = Idle_Index +-1
        if Idle_Index < 0 then Idle_Index = #sets.Idle.index -1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_Index]])

    elseif command == 'nuke' then
        equip(getNukeSet())
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

    elseif command == 'melee' then
        equip(sets.Melee)
        add_to_chat(140, "Equipping Melee set")
    end

    updateTable()
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
    end
 
    return equip_set
end