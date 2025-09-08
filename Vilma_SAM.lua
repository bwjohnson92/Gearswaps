include('organizer-lib.lua')
include('displayBox.lua')
include('organizeritems.lua')

function get_sets()


    sets.AF = {}
    sets.Relic = {}
    sets.Empyrean = {}

    sets.AF.Feet = "Wakido Sune-Ate +2"
    sets.AF.Legs = "Wakido Haidate"
    sets.AF.Hands = "Wakido Kote +2"
    sets.AF.Body = "Wakido Domaru"
    sets.AF.Head = "Wakido Kabuto"

    sets.Relic.Feet = "Sakonji Sune-Ate"
    sets.Relic.Legs = "Sakonji Haidate"
    sets.Relic.Hands = "Sakonji Kote"
    sets.Relic.Body = "Sakonji Domaru +1"
    sets.Relic.Head = "Sakonji Kabuto"

    sets.Empyrean.Feet = "Kasuga Sune-Ate +1"
    sets.Empyrean.Legs = "Kasuga Haidate +1"
    sets.Empyrean.Hands = "Kasuga Kote +2"
    sets.Empyrean.Body = "Kasuga Domaru +2"
    sets.Empyrean.Head = "Kasuga Kabuto +1"



    backTP = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken -10%',}}
    backWS = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken -10%',}}

    send_command('bind f9 gs c toggle TP set')
    send_command('bind f10 gs c toggle WS set')
    send_command('bind f11 gs c toggle weapon')
    send_command('bind f12 gs c toggle Idle set')

    --Idle Sets--
    sets.Idle = {}      

    sets.Ammo = {ammo="Tulfaire Arrow"}

    sets.Idle.index = {'Standard'}

    sets.Weapons = {}
    sets.Weapons.Gekkei = {main="Gekkei",sub="Utu Grip"}
    sets.Weapons.Hachimonji = {main="Hachimonji",sub="Utu Grip"}
    sets.Weapons["Shining One"] = {main="Shining One",sub="Utu Grip"}
    sets.Weapons.index = {"Gekkei", "Shining One", "Hachimonji"}

    Backup_TP_Ind = 1

    Idle_ind = 1
    TP_ind = 1
    WS_ind = 1
    Weapon_ind = 1

    sets.Idle.Standard = {
        neck="Loricate torque +1",
        ring1="Gelatinous ring +1",ring2="Defending ring",
        feet="Danzo Sune-Ate"
    }
    
    --TP Sets--
    
    sets.TP = {}
    sets.TP.index = {'Standard', 'DT', 'Hachimonji' }

    sets.TP.Standard = {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body=sets.Empyrean.Body,
        hands=sets.AF.Hands,
        legs=sets.Empyrean.Legs,
        feet="Tatenashi Sune-ate +1",
        neck="Sam. Nodowa +1",
        waist="Ioskeha Belt +1",
        ear1="Dedition Earring",
        ear2="Kasuga Earring +1",
        ring1="Niqmaddu Ring",
        ring2="Chirich Ring +1",
        back=backTP
    }

    sets.TP.Hachimonji = set_combine(sets.TP.Standard, {

    })

    sets.TP.DT = set_combine(sets.TP.Standard, {
        head="Nyame Helm",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ring2="Defending Ring",
    })

    --Weaponskill Sets--
    sets.WS = {
        head="Mpaca's Cap",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1="Epaminondas's Ring",
        ring2="Regal Ring",
        neck="Samurai's Nodowa +1",
        waist="Sailfi Belt +1",
        back=backWS,
        ammo="Knobkierrie"

    }
    
    --FILL IN GENERIC WS HERE--
    
    sets.WS.index = {'Attack', 'Accuracy'}

    sets.WS["Tachi: Fudo"] = {}
    sets.WS["Tachi: Mumei"] = {}

    sets.WS["Tachi: Shoha"] = {
        ring2="Niqmaddu Ring"
    }
    sets.WS["Tachi: Shoha"].Accuracy = set_combine(sets.WS["Tachi: Shoha"], {
    })

    sets.WS["Tachi: Fudo"] = {} -- Fudo, Rana                      
    sets.WS["Tachi: Fudo"].Accuracy = set_combine(sets.WS["Tachi: Fudo"], {

    })

    sets.WS["Tachi: Rana"] = {
        ear2="Schere Earring"
    }
                        
    sets.WS["Tachi: Jinpu"] = {
        head="Nyame Helm",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear2="Schere Earring",
        ring2="Niqmaddu Ring"
    }
    sets.WS["Tachi: Koki"] = set_combine(sets.WS["Tachi: Jinpu"])
    sets.WS["Tachi: Kagero"] = set_combine(sets.WS["Tachi: Jinpu"])

    sets.WS["Impulse Drive"] = {
        ring1="Begrudging Ring"
    }

    sets.WS["Impulse Drive"].Accuracy = set_combine(sets.WS["Impulse Drive"], {})



    --Job Ability Sets--
    sets.JA = {}

    sets.JA["Meditate"] = {
        head=sets.AF.Head,
        back="Takaha Mantle",
        hands=sets.Relic.Hands
    }
                        
    sets.JA["Meikyo Shisui"] = {
        feet=sets.Relic.Feet
    }

    sets.JA["Sengikori"] = {
        feet=sets.Empyrean.Feet
    }

    organizer_items = organizerItems()

    text_setup()
    addNewColors()
    updateTable()
end

function addNewColors()
    addTextColorPair("Attack", "green")
    addTextColorPair("Accuracy", "bluelite")
    addTextColorPair("AccuracyLite", "bluelite")
    addTextColorPair("AccuracyFull", "bluelite")
    addTextColorPair("DT", "yellow")
    addTextColorPair("DTAccuracy", "yellow")
    addTextColorPair("Standard", "green")
end

function updateTable()
    addToTable("------------------------------\n")
    addToTable("(F9) TP Set", sets.TP.index[TP_ind])
    addToTable("(F10) WS Set", sets.WS.index[WS_ind])
    addToTable("(F11) Weapon", sets.Weapons.index[Weapon_ind])
    update_message()
end

function precast(spell)
    if spell.english == 'Meditate' then
        equip(sets.JA.Meditate)
    end
    
    if spell.english == 'Meikyo Shisui' then
        equip(sets.JA["Meikyo Shisui"])
        disable("feet")
    end
        
    if spell.type:lower() == 'weaponskill' then
        set = set_combine(sets.WS)
        if (sets.WS[spell.english]) then
            if (sets.WS.index[WS_ind] == Accuracy and sets.WS[spell.english].Accuracy) then
                set = sets.WS[spell.english].Accuracy
            elseif (sets.WS[spell.english].Attack) then
                set = sets.WS[spell.english].Attack
            else
                set = set_combine(sets.WS, sets.WS[spell.english])
            end
        else
            set = sets.WS
        end
        if (player.tp > 2500) then
            set = set_combine(set, {head="Nyame Helm"})
        end
        equip(set)
    end

    if spell.name == "Ranged" then
        equip(sets.Utility.Snapshot)
    end
    
    if spell.name == "Hasso" then
        equip(sets.TP[sets.TP.index[TP_ind]])
    end

    if spell.name == "Sengikori" then
        equip(sets.JA["Sengikori"])
    end
end     

function midcast(spell,act)
    if spell.name == "Ranged" then
        equip(sets.RangedTP[sets.RangedTP.index[RangedTP_ind]])
    end
end

function aftercast(spell,act)
    if player.status == 'Engaged' then
        equip(sets.TP[sets.TP.index[TP_ind]])
    else
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
    end
end

function status_change(new,old)
    if new == 'Engaged' then
        equip(sets.TP[sets.TP.index[TP_ind]])
    else
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
    end
end

function buff_change(buff, gain)
    if (buff == "Meikyo Shisui" and not gain) then
        enable("feet")
    end

    if (buff == "Hasso" and not gain) then
        enable("feet")
    end
end

function self_command(command)
    if command == 'toggle TP set' then
        TP_ind = TP_ind +1
        if TP_ind > #sets.TP.index - 1 then TP_ind = 1 end
        Backup_TP_Ind = TP_ind
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'toggle WS set' then
        WS_ind = WS_ind +1
        if WS_ind > #sets.WS.index then WS_ind = 1 end
        send_command('@input /echo <----- WS Set changed to '..sets.WS.index[WS_ind]..' ----->')
    elseif command == 'toggle weapon' then
        Weapon_ind = Weapon_ind +1
        if Weapon_ind > #sets.Weapons.index then Weapon_ind = 1 end

        if sets.Weapons.index[Weapon_ind] == "Hachimonji" then
            TP_ind = Weapon_ind
        else
            TP_ind = Backup_TP_Ind
        end 

        send_command('@input /echo <----- Weapon changed to '..sets.Weapons.index[Weapon_ind]..' ----->')
        equip(sets.Weapons[sets.Weapons.index[Weapon_ind]])
    elseif command == 'equip TP set' then
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'equip Idle set' then
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
    end
    updateTable()
end