include('organizer-lib.lua')
include('displayBox.lua')
include('organizeritems.lua')

function get_sets()

    backTP = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    backWS = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    send_command('bind f9 gs c toggle MTP set')
    send_command('bind f10 gs c toggle WS set')
    send_command('bind f12 gs c toggle Idle set')
    
    function file_unload()
      
        send_command('unbind ^f9')
        send_command('unbind ^f10')
        send_command('unbind ^f11')
        send_command('unbind ^f12')
        send_command('unbind !f9')
        send_command('unbind !f10')
        send_command('unbind !f11')
        send_command('unbind !f12')
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')

    end
    

        --Idle Sets--
        sets.Idle = {}      

        sets.Weapons = {ammo="Tulfaire Arrow"}

        sets.Idle.index = {'Standard'}
        
        Idle_ind = 1
        
        sets.Idle.Standard = {
            head="Nyame Helm",
            body="Nyame Mail",
            hands="Nyame Gauntlets",
            legs="Nyame Flanchard",
                              neck="Loricate torque +1",
                              ring1="Gelatinous ring +1",ring2="Defending ring",
                              feet="Danzo Sune-Ate"}
                                      
        --TP Sets--
        sets.TP = {main="Gekkei", sub="Utu Grip"}
        sets.Polearm = {main="Shining One"}

        sets.TP.index = {'Standard', 'Accuracy'}
        TP_ind = 1
    
        sets.TP.Standard = {
            -- ammo="Aurgelmir Orb",
            ammo="Coiste Bodhar",
            head="Flamma Zucchetto +2",
            body="Tatenashi Haramaki +1",
            hands="Wakido Kote +3",
            legs="Tatenashi Haidate +1",
            feet="Nyame Sollerets",
            neck="Sam. Nodowa +1",
            waist="Sailfi Belt +1",
            ear1="Telos Earring",
            ear2="Dedition Earring",
            left_ring="Chirich Ring +1",
            right_ring="Niqmaddu Ring",
            back=backTP
        }
                            
    
        sets.TP.Accuracy = set_combine(sets.TP.Standard, {
        })

        --Weaponskill Sets--

        sets.WS = {
            head="Mpaca's Cap",
            body="Nyame Mail",
            hands="Nyame Gauntlets",
            legs="Nyame Flanchard",
            feet="Nyame Sollerets",
            neck="Fotia Gorget",
            waist="Sailfi Belt +1",
            ear1="Thrud Earring",
            ear2="Moonshade Earring",
            back=backWS
        }

        sets.WS.index = {'Attack','Accuracy'}
        WS_ind = 1

        setupBasicWSSet('Tachi: Enpi')
        setupBasicWSSet('Tachi: Hobaku')
        setupBasicWSSet('Tachi: Goten')
        setupBasicWSSet('Tachi: Koki')
        setupBasicWSSet('Tachi: Ageha')
        setupBasicWSSet('Tachi: Fudo')

        sets.WS["Tachi: Kasha"] = sets.WS["Tachi: Fudo"]
        sets.WS["Tachi: Gekko"] = sets.WS["Tachi: Fudo"]
        sets.WS["Tachi: Yukikaze"] = sets.WS["Tachi: Fudo"]

        
        setupBasicWSSet('Tachi: Shoha')
        
        sets.WS["Impulse Drive"] = sets.WS["Tachi: Shoha"]


        setupBasicWSSet('Tachi: Kagero')
        setupBasicWSSet('Tachi: Jinpu')
        sets.WS["Tachi: Jinpu"] = set_combine(sets.WS["Tachi: Jinpu"], {
            ear1="Friomisi Earring"
        })
            
        --Job Ability Sets--
        sets.JA = {}
    
        sets.JA.Meditate = {head="Wakido Kabuto",
                            back="Smertrios's Mantle",
                            hands="Sakonji Kote +2"}
                            
        sets.JA.Meikyo = {feet="Sakonji sune-ate"}

        organizer_items = organizerItems()

        text_setup()
        addNewColors()
        updateTable()
end

function setupBasicWSSet(name)
    sets.WS[name] = set_combine(sets.WS, {})
    
    sets.WS[name].Attack = set_combine(sets.WS[name], {})
    sets.WS[name].Accuracy = set_combine(sets.WS[name], {})

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
    -- addToTable("(F10) Idle Set", sets.Idle.index[Idle_ind])
    addToTable("(F10) WS Set", sets.WS.index[WS_ind])
    update_message()
end

function precast(spell)
    if (sets.JA[spell.english]) then
        equip(sets.JA[spell.english])
        return
    end
    
    if spell.english == 'Meikyo Shisui' then
        equip(sets.JA.Meikyo)
        disable("feet")
    end
        
    if spell.type:lower() == 'weaponskill' then
        set = sets.WS
        if (sets.WS[spell.english]) then
			set = sets.WS[spell.english]
            if (set[sets.WS.index[WS_ind]]) then
                set = set[sets.WS.index[WS_ind]]
            end
        end
        equip(set)
        return
    end
    if spell.name == "Ranged" then
        equip(sets.Utility.Snapshot)
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

function self_command(command)
    if command == 'toggle MTP set' then
        TP_ind = TP_ind +1
        if TP_ind > #sets.TP.index then TP_ind = 1 end
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'toggle RTP set' then
        RangedTP_ind = RangedTP_ind +1
        if RangedTP_ind > #sets.RangedTP.index then RangedTP_ind = 1 end
        send_command('@input /echo <----- Ranged TP Set changed to '..sets.RangedTP.index[RangedTP_ind]..' ----->')
        equip(sets.RangedTP[sets.RangedTP.index[RangedTP_ind]])
    elseif command == 'toggle Idle set' then
        Idle_ind = Idle_ind +1
        if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
        send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
    elseif command == 'toggle WS set' then
        WS_ind = WS_ind +1
        if WS_ind > #sets.WS.index then WS_ind = 1 end
        send_command('@input /echo <----- Tachi: WS Set changed to '..sets.WS.index[WS_ind]..' ----->')
    elseif command == 'equip TP set' then
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'equip Idle set' then
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
    end
    updateTable()
end