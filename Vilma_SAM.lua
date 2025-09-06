include('organizer-lib.lua')
include('displayBox.lua')
include('organizeritems.lua')

function get_sets()


    sets.AF = {}
    sets.Relic = {}
    sets.Empyrean = {}

    sets.AF.Feet = "Wakido Sune-Ate"
    sets.AF.Legs = "Wakido Haidate"
    sets.AF.Hands = "Wakido Kote"
    sets.AF.Body = "Wakido Domaru"
    sets.AF.Head = "Wakido Kabuto"

    sets.Relic.Feet = "Sakonji Sune-Ate"
    sets.Relic.Legs = "Sakonji Haidate"
    sets.Relic.Hands = "Sakonji Kote"
    sets.Relic.Body = "Sakonji Domaru +1"
    sets.Relic.Head = "Sakonji Kabuto"

    sets.Empyrean.Feet = "Kasuga Sune-Ate"
    sets.Empyrean.Legs = "Kasuga Haidate +1"
    sets.Empyrean.Hands = "Kasuga Kote +1"
    sets.Empyrean.Body = "Kasuga Domaru +1"
    sets.Empyrean.Head = "Kasuga Kabuto"



    backTP = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+20','"Store TP"+10','Phys. dmg. taken -10%',}}
    backWS = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken -10%',}}

    send_command('bind f9 gs c toggle TP set')
    send_command('bind f10 gs c toggle WS set')
    send_command('bind f12 gs c toggle Idle set')

    --Idle Sets--
    sets.Idle = {}      

    sets.Weapons = {ammo="Tulfaire Arrow"}

    sets.Idle.index = {'Standard'}
    
    Idle_ind = 1
    TP_ind = 1
    WS_ind = 1
    
    sets.Idle.Standard = {
        neck="Loricate torque +1",
        ring1="Gelatinous ring +1",ring2="Defending ring",
        feet="Danzo Sune-Ate"
    }
    
    --TP Sets--
    sets.TP = {main="Ichigohitofuri"}
    sets.Polearm = {main="Shining One"}

    sets.TP.index = {'Standard', 'DT' }

    sets.TP.Standard = {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body=sets.Empyrean.Body,
        hands=sets.AF.Hands,
        legs="Ryup hakama +1", --Jinxed Hakama when abjuration
        feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
        neck="Sam. Nodowa +1",
        waist="Ioskeha Belt +1",
        ear1="Telos Earring",
        ear2="Dedition Earring", --Dignitary when you get it
        left_ring="Flamma Ring",
        right_ring="Niqmaddu Ring",
        back=backTP
    }

    sets.TP.DT = set_combine(sets.TP.Standard, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ring2="Defending Ring",
    })

    --Weaponskill Sets--
    sets.WS = {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ear1="Moonshade Earring",
        ring1="Epaminondas's Ring",
        back=backWS

    }



        --FILL IN GENERIC WS HERE--


    
    sets.WS.index = {'Attack', 'Accuracy'}

    sets.WS["Tachi: Shoha"] = {}  --  Shoha, Gekko, Yikikaze, Kasha

    sets.WS["Tachi: Shoha"].Attack = set_combine(sets.WS, {
    
    })
                                
    sets.WS["Tachi: Shoha"].Accuracy = set_combine(sets.WS["Tachi: Shoha"].Attack, {
        ring2="Regal Ring"
        })
                            
    sets.WS["Tachi: Fudo"] = {} -- Fudo, Rana

    sets.WS["Tachi: Fudo"].Attack = set_combine(sets.WS, {
    
    })
                            
    sets.WS["Tachi: Fudo"].Accuracy = set_combine(sets.WS["Tachi: Fudo"].Attack, {

    })
                        
    sets.WS["Impulse Drive"] = {}

    sets.WS["Impulse Drive"].Attack = set_combine(sets.WS, {
    
    })

    sets.WS["Impulse Drive"].Accuracy = set_combine(sets.WS["Impulse Drive"].Attack, {

    })

    --Job Ability Sets--
    sets.JA = {}

    sets.JA["Meditate"] = {
        head=sets.AF.Head,
        back="Takaha mantle",
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

    addToTable("(F9) TP Set", sets.TP.index[TP_ind])
    addToTable("(F10) WS Set", sets.WS.index[WS_ind])
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
        if (sets.WS[spell.english]) then
            if (sets.WS.index[WS_ind] == Accuracy and sets.WS[spell.english].Accuracy) then
                equip(sets.WS[spell.english].Accuracy)
            elseif (sets.WS[spell.english].Attack) then
                equip(sets.WS[spell.english].Attack)
            else
                equip(set_combine(sets.WS, sets.WS[spell.english]))
            end
        else
            equip(sets.WS)
        end
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
    add_to_chat(140,buff)
    if (buff == "Meikyo Shisui" and not gain) then
        enable("feet")
        add_to_chat(140, "Lost Meikyo")
    end

    if (buff == "Hasso" and not gain) then
        enable("feet")
        add_to_chat(140, "Lost Meikyo")
    end
end

function self_command(command)
    if command == 'toggle TP set' then
        TP_ind = TP_ind +1
        if TP_ind > #sets.TP.index then TP_ind = 1 end
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'toggle WS set' then
        WS_ind = WS_ind +1
        if WS_ind > #sets.WS.index then WS_ind = 1 end
        send_command('@input /echo <----- WS Set changed to '..sets.WS.index[WS_ind]..' ----->')
    elseif command == 'equip TP set' then
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'equip Idle set' then
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
    end
    updateTable()
end