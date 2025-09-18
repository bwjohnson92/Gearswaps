include('organizer-lib.lua')
include('displayBox/displayBox.lua')
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
            ring2="Defending Ring",ring1="Karieyh ring",
            feet="Danzo Sune-Ate"}
                                      
        --TP Sets--
        sets.TP = {main="Gekkei", sub="Utu Grip"}
        sets.Polearm = {main="Shining One"}

        sets.TP.index = {'Standard', 'Accuracy', 'Zanhasso'}
        TP_ind = 1
    
        sets.TP.Standard = {
            -- ammo="Aurgelmir Orb",
            ammo="Coiste Bodhar",
            head="Flamma Zucchetto +2",
            body="Kasuga Domaru +3",
            hands="Wakido Kote +3",
            legs="Kasuga Haidate +3",
            feet="Kasuga Sune-ate +2",
            neck="Sam. Nodowa +1",
            waist="Sailfi Belt +1",
            ear2="Telos Earring",
            ear1="Dedition Earring",
            left_ring="Chirich Ring +1",
            right_ring="Niqmaddu Ring",
            back=backTP
        }
                            
    
        sets.TP.Accuracy = set_combine(sets.TP.Standard, {
        })

        sets.TP.Zanhasso = {
            ammo="Aurgelmir Orb",
            head="Fkanna Zucchetto +2", --Kasuga Kabuto
            body="Kasuga Domaru +3",
            hands="Valorous Mitts",
            legs="Kasuga Haidate +3",
            feet="Ryuo Sune-ate +1",
            neck="Sam. Nodowa +1", --Moonbeam/light Nodowa
            ear1="Dedition Earring",
            ear2="Kasuga Earring", --HQ?
            -- ring1="Defending Ring",
            ring1="Chirich Ring +1",
            ring2="Niqmaddu Ring",
            back=backTP,
            waist="Cornelia's Belt"

        }

        --Weaponskill Sets--

        sets.WS = {
            ammo="Knobkierrie",
            head="Mpaca's Cap",
            body="Nyame Mail",
            hands="Kasuga Kote +3",
            legs="Nyame Flanchard",
            feet="Nyame Sollerets",
            neck="Fotia Gorget",
            waist="Sailfi Belt +1",
            ear1="Thrud Earring",
            ear2="Moonshade Earring",
            ring1="Karieyh Ring",
            ring2="Ephramad's Ring",
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

        
        shoha = set_combine(sets.WS, {
            
        })

        rana = set_combine(shoha, {
            head="Nyame Helm"
        })

        setupBasicWSSet('Tachi: Shoha', shoha)
        setupBasicWSSet('Tachi: Rana', rana)
        
        sets.WS["Impulse Drive"] = sets.WS["Tachi: Fudo"]

        hybridSet = {
            head="Nyame Helm",
            body="Nyame Mail",
            hands="Nyame Gauntlets",
            legs="Nyame Flanchard",
            feet="Nyame Sollerets",
            neck="Fotia Gorget",
            waist="Eschan Stone",
            ear1="Friomisi Earring",
            ear2="Moonshade Earring",
            ring1="Karieyh Ring",
            ring2="Ephramad's Ring",
            back=backWS
        }


        setupBasicWSSet('Tachi: Kagero', hybridSet)
        setupBasicWSSet('Tachi: Jinpu', hybridSet)
            
        --Job Ability Sets--
        sets.JA = {}
    
        sets.JA.Meditate = {head="Wakido Kabuto +1",
                            back="Smertrios's Mantle",
                            hands="Sakonji Kote +2"}
                            
        sets.JA.Meikyo = {feet="Sakonji sune-ate"}

        sets.FastCast =     {
            ammo="Sapience Orb",
            head={ name="Nyame Helm", augments={'Path: B',}},
            body={ name="Nyame Mail", augments={'Path: B',}},
            hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
            legs={ name="Nyame Flanchard", augments={'Path: B',}},
            feet="Kas. Sune-Ate +2",
            neck="Voltsurge Torque",
            waist="Cornelia's Belt",
            left_ear="Loquac. Earring",
            right_ear="Dedition Earring",
            left_ring="Gurebu's Ring",
            right_ring="Rahab Ring",
            back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        }

        sets.Utility = {}

        sets.Utility.Snapshot = {
            head="Acro Helm",
            body="Acro Surcoat",
            hands="Acro Gauntlets",
            legs="Acro Breeches",
            feet="Acro Leggings",
            waist="Yemaya Belt",
        }

        organizer_items = organizerItems()

        text_setup()
        addNewColors()
        updateTable()
end

function setupBasicWSSet(name, set)
    if (set == nil) then
        set = sets.WS
    end
    sets.WS[name] = set_combine(set, {})
    
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

    if (spell.action_type == 'Magic') then 
        equip (sets.FastCast) 
    end
end     

function midcast(spell,act)
    if spell.name == "Ranged" then
        --equip(sets.RangedTP[sets.RangedTP.index[RangedTP_ind]])
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
    if (gain) then
        add_to_chat(140, "Gained "..buff)
    else
        add_to_chat(140, "Lost "..buff)
    end

    if (buff == "Meikyo Shisui") then
        if (gain) then
        else
            enable("feet")
        end
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