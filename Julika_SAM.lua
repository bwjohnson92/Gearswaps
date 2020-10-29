include('organizer-lib.lua')
include('displayBox.lua')
include('organizeritems.lua')

function get_sets()

    backTP = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10',}}
    backWS = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    send_command('bind f9 gs c toggle MTP set')
    send_command('bind f10 gs c toggle Shoha set')
    send_command('bind f11 gs c toggle Fudo set')
    send_command('bind f12 gs c toggle Idle set')

    send_command('bind ^f11 gs c toggle Apex set')
    send_command('bind ^f12 gs c toggle Kaiten set')
    
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
                              neck="Twilight torque",
                              ring1="Gelatinous ring +1",ring2="Defending ring",
                              feet="Danzo Sune-Ate"}
                              
        -- sets.Idle.Town = {
        --                   head="Sakonji kabuto +1",neck="Twilight torque", ear1="Steelflash earring", ear2="Bladeborn earring",
        --                   body="Sakonji domaru +1",hands="Wakido kote +2",ring1="Defending ring",ring2="Dark ring",
        --                   back="Shadow mantle",waist="Flume belt",legs="Wakido haidate +1",feet="Danzo Sune-Ate"}
        
        --TP Sets--
        sets.TP = {main="Ichigohitofuri"}
        sets.Polearm = {main="Shining One"}

        -- sets.TP.index = {'Standard', 'AccuracyLite', 'AccuracyFull', 'DT', 'DTAccuracy'}
        sets.TP.index = {'Standard', 'AccuracyLite', 'AccuracyFull' }
        --1=Standard, 2=AccuracyLite, 3=AccuracyFull, 4=DT, 5=DTAccuracy--
        TP_ind = 1
    
        sets.TP.Standard = {
            ammo="Ginsen",
            head="Flam. Zucchetto +2",
            body="Kasuga Domaru +1",
            hands="Wakido Kote +3",
            legs="Hiza. Hizayoroi +2", --Swap for lower haste? Wakido?
            feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
            neck="Sam. Nodowa +1",
            waist="Ioskeha Belt +1",
            ear1="Dignitary's Earring",
            ear2="Cessance Earring",
            left_ring="Flamma Ring",
            right_ring="Ilabrat Ring",
            back=backTP
        }
                            
        sets.TP.AccuracyLite = {
            ammo="Ginsen",
            head="Flam. Zucchetto +2",
            body="Flamma Korazin +2",
            hands="Wakido Kote +3",
            legs="Hiza. Hizayoroi +2",
            -- feet={ name="Valorous Greaves", augments={'Accuracy+14','Weapon skill damage +5%',}}, --Something
            feet="Flamma Gambieras +2",
            neck="Sam. Nodowa +1",
            waist="Ioskeha Belt +1",
            ear1="Digni. Earring",
            ear2="Telos Earring",
            left_ring="Flamma Ring",
            right_ring="Ilabrat Ring",
            back=backTP
        }
    
        sets.TP.AccuracyFull = {
                                ammo="Ginsen",
                                head="Flamma Zucchetto +2",neck="Samurai's Nodowa +1",ear1="Telos earring", ear2="Dignitary's earring",
                                body="Flamma Korazin +2",hands="Wakido kote +3",ring1="Flamma ring",ring2="Hizamaru ring",
                                back=backTP,waist="Ioskeha belt +1",legs="Wakido Haidate +3",feet="Flamma Gambieras +2"}
                            
        -- sets.TP.DT = {
        --               head="Yaoyotl helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",
        --               body="Miki. breastplate",hands="Wakido kote +2",ring1="K'ayres ring",ring2="Rajas ring",
        --               back="Takaha mantle",waist="Cetl belt",legs="Otronif brais",feet="Waki. Sune-Ate +1"}
                  
        -- sets.TP.DTAccuracy = {
        --                       head="Yaoyotl helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",
        --                       body="Miki. breastplate",hands="Wakido kote +2",ring1="K'ayres ring",ring2="Rajas ring",
        --                       back="Takaha mantle",waist="Cetl belt",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
                              
        -- sets.RangedTP = {}

        -- sets.RangedTP.index = {'Standard', 'AccuracyLite', 'AccuracyFull'}
        -- --1=Standard, 2=AccuracyLite, 3=AccuracyFull--
        -- TP_ind = 1
    
        -- sets.RangedTP.Standard = {range="Cibitshavore",
        --                   head="Otomi helm",neck="Iqabi necklace", ear1="Steelflash earring", ear2="Bladeborn earring",                       
        --                   body="Sakonji domaru +1",hands="Umuthi gloves",ring1="K'ayres ring",ring2="Rajas ring",
        --                   back="Takaha mantle",waist="Cetl belt",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
                            
        -- sets.RangedTP.AccuracyLite = {range="Cibitshavore",
        --                   head="Otomi helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",                    
        --                   body="Sakonji domaru +1",hands="Otronif gloves",ring1="K'ayres ring",ring2="Rajas ring",
        --                   back="Takaha mantle",waist="Dynamic belt +1",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
    
        -- sets.RangedTP.AccuracyFull = {range="Cibitshavore",
        --                   head="Yaoyotl helm",neck="Iqabi necklace", ear1="Steelflash earring", ear2="Bladeborn earring",                     
        --                   body="Sakonji domaru +1",hands="Umuthi gloves",ring1="K'ayres ring",ring2="Rajas ring",
        --                   back="Takaha mantle",waist="Dynamic belt +1",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
      
        --Weaponskill Sets--
        sets.WS = {}
    
        sets.Shoha = {}  --  Shoha, Gekko, Yikikaze, Kasha
    
        sets.Shoha.index = {'Attack','Accuracy'}
        Shoha_ind = 1
    
        sets.Shoha.Attack = {ammo="Knobkierrie", 
        head="Valorous Mask",neck="Samurai's Nodowa +1",ear1="Ishvara Earring",ear2="Moonshade earring",
                             body="Sakonji Domaru +2",hands="Valorous mitts",ring1="Karieyh Ring",ring2="Flamma ring",
                             back=backWS,waist="Fotia belt",legs="Wakido Haidate +3",feet="Valorous Greaves"}
                                  
        sets.Shoha.Accuracy = {ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Samurai's Nodowa +1",ear1="Ishvara Earring",ear2="Moonshade earring",
                               body="Sakonji Domaru +2",hands="Valorous Mitts",ring1="Karieyh Ring",ring2="Flamma ring",
                               back=backWS,waist="Fotia belt",legs="Wakido Haidate +3",feet="Flamma Gambieras +2"}
                             
        sets.Fudo = {} -- Fudo, Rana
    
        sets.Fudo.index = {'Attack','Accuracy'}
        Fudo_ind = 1
    
        sets.Fudo.Attack ={
            ammo="Knobkierrie",
            head="Valorous Mask",
            body="Sakonji domaru +2",
            hands="Valorous Mitts",
            legs="Wakido Haidate +3",
            feet="Valorous Greaves",
            neck="Sam. Nodowa +1",
            waist="Fotia Belt",
            ear1={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
            ear2="Ishvara Earring",
            left_ring="Karieyh Ring",
            right_ring="Apate Ring",
            back=backWS,
        }
                               
        sets.Fudo.Accuracy = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2",neck="Samurai's Nodowa +1",ear1="Dignitary's earring",ear2="Moonshade earring",
        body="Sakonji Domaru +2",hands="Wakido Kote +3",ring1="Apate ring",ring2="Rajas ring",
        back=backWS,waist="Fotia belt",legs="Wakido Haidate +3",feet="Flamma Gambieras +2"}
                          
        sets.ImpulseDrive = {}
        sets.ImpulseDrive.index = {'Attack','Accuracy'}
        Impulse_ind = 1

        sets.ImpulseDrive.Attack = {
            ammo="Knobkierrie",
            head="Valorous Mask",
            body="Sakonji domaru +2",
            hands="Valorous Mitts",
            legs="Wakido Haidate +3",
            feet="Valorous Greaves",
            neck="Sam. Nodowa +1",
            waist="Fotia Belt",
            ear1={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
            ear2="Ishvara Earring",
            left_ring="Karieyh Ring",
            right_ring="Apate Ring",
            back=backWS,
        }

        sets.ImpulseDrive.Accuracy = {
            ammo="Knobkierrie",
            head="Valorous Mask",
            body="Sakonji domaru +2",
            hands="Valorous Mitts",
            legs="Wakido Haidate +3",
            feet="Valorous Greaves",
            neck="Sam. Nodowa +1",
            waist="Fotia Belt",
            ear1={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
            ear2="Ishvara Earring",
            left_ring="Karieyh Ring",
            right_ring="Apate Ring",
            back=backWS,
        }
        -- sets.Kaiten = {}
        
        -- sets.Kaiten.index = {'Attack','Accuracy'}
        -- Kaiten_ind = 1
    
        -- sets.Kaiten.Attack = {range="Cibitshavore",
        --                       head="Otomi helm",neck="Light gorget",ear1="Steelflash earring", ear2="Bladeborn earring",
        --                       body="Flamma Korazin +1",hands="Phorcys mitts",ring1="Karieyh Ring",ring2="Apate ring",
        --                       back="Buquwik cape",waist="Light belt",legs="Wakido haidate +1",feet="Sakonji sune-ate"}
                               
        -- sets.Kaiten.Accuracy = {range="Cibitshavore",
        --                         head="Yaoyotl helm",neck="Light gorget",ear1="Steelflash earring", ear2="Bladeborn earring",
        --                         body="Flamma Korazin +1",hands="Phorcys mitts",ring1="Karieyh Ring",ring2="Apate ring",
        --                         back="Buquwik cape",waist="Light belt",legs="Wakido haidate +1",feet="Sakonji sune-ate"}        
        -- sets.Jinpu = {}
        
        -- sets.Jinpu = {range="Cibitshavore",
        --               head="Yaoyotl helm",neck="Soil gorget",ear1="Friomisi earring",ear2="Moonshade earring",                            
        --               body="Flamma Korazin +1",hands="Phorcys mitts",ring1="Flamma Ring",ring2="Apate ring",
        --               back="Buquwik cape",waist="Soil belt",legs="Wakido haidate +1",feet="Sakonji sune-ate"}

        -- sets.Apex = {}
    
        -- sets.Apex.index = {'Attack','Accuracy', 'Accuracy Max'}
        -- Apex_ind = 1
    
        -- sets.Apex.Attack = {range="Cibitshavore",
        --                     head="Sakonji kabuto +1",neck="Light gorget",ear1="Matanki earring",ear2="Moonshade earring",
        --                     body="Flamma Korazin +1",hands="Unkai kote +2",ring1="Stormsoul ring",ring2="Auster's ring",
        --                     back="Buquwik cape",waist="Light belt",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
                            
        -- sets.Apex.Accuracy = {range="Cibitshavore",
        --                       head="Sakonji kabuto +1",neck="Light gorget",ear1="Matanki earring",ear2="Moonshade earring",
        --                       body="Flamma Korazin +1",hands="Buremte gloves",ring1="Hajduk ring",ring2="Longshot ring",
        --                       back="Thall Mantle",waist="Light belt",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
                               
        -- sets.Apex.MaxAccuracy = {range="Cibitshavore",
        --                          head="Sakonji kabuto +1",neck="Light gorget",ear1="Matanki earring",ear2="Clearview earring",
        --                          body="Aetosaur Jerkin",hands="Buremte gloves",ring1="Hajduk ring",ring2="Longshot ring",
        --                          back="Thall Mantle",waist="Light belt",legs="Aeto. Trousers",feet="Waki. Sune-Ate +1"}

        -- sets.Namas = {}
    
        -- sets.Namas.index = {'Attack','Accuracy'}
        -- Namas_ind = 1
    
        -- sets.Namas.Attack = {range="Cibitshavore",
        --                      head="Otomi helm",neck="Flame gorget",ear1="Brutal earring",ear2="Moonshade earring",
        --                      body="Flamma Korazin +1",hands="Phorcys mitts",ring1="Flamma Ring",ring2="Rajas ring",
        --                      back="Buquwik cape",waist="Light belt",legs="Wakido haidate",feet="Gor. sollerets +1"}
                               
        -- sets.Namas.Accuracy = {range="Cibitshavore",
        --                        head="Yaoyotl helm",neck="Flame gorget",ear1="Brutal earring",ear2="Moonshade earring",
        --                        body="Flamma Korazin +1",hands="Phorcys mitts",ring1="Flamma Ring",ring2="Rajas ring",
        --                        back="Buquwik cape",waist="Light belt",legs="Wakido haidate",feet="Gor. sollerets +1"}

        --Utility Sets--
        -- sets.Utility = {}
        
        -- sets.Utility.PDT = {head="Otronif mask",neck="Twilight torque",
        --                     body="Miki. breastplate",hands="Otronif gloves",ring1="Dark ring",ring2="Dark ring",
        --                     back="Mollusca mantle",waist="Flume belt",legs="Otronif brais",feet="Otronif boots"}
                        
        -- sets.Utility.MDT = {head="Ogier's helm",neck="Twilight torque",
        --                     body="Nocturnus mail",hands="Umuthi gloves",ring1="Dark ring",ring2="Dark ring",
        --                     back="Mollusca mantle",legs="Wakido haidate +1",feet="Waki. Sune-Ate +1"}
            
        --Job Ability Sets--
        sets.JA = {}
    
        sets.JA.Meditate = {head="Myochin Kabuto",
                            back="Takaha mantle",
                            hands="Sakonji Kote"}
                            
        sets.JA.Meikyo = {feet="Sakonji sune-ate"}

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
    -- addToTable("(F10) Idle Set", sets.Idle.index[Idle_ind])
    addToTable("(F10) Shoha Set", sets.Shoha.index[Shoha_ind])
    addToTable("(F11) Fudo Set", sets.Fudo.index[Fudo_ind])
    update_message()
end

function precast(spell)
    if spell.english == 'Meditate' then
        equip(sets.JA.Meditate)
    end
    
    if spell.english == 'Meikyo Shisui' then
        equip(sets.JA.Meikyo)
    end
        
    if spell.english == 'Tachi: Shoha' or spell.english == 'Tachi: Gekko' or spell.english == 'Tachi: Yukikaze' or spell.english == 'Tachi: Kasha' then
        equip(sets.Shoha[sets.Shoha.index[Shoha_ind]])
    end
    
    if spell.english == 'Tachi: Fudo' or spell.english == 'Tachi: Rana' then
        equip(sets.Fudo[sets.Fudo.index[Fudo_ind]])
    end
    if spell.english == 'Tachi: Kaiten' then
        equip(sets.Kaiten[sets.Kaiten.index[Kaiten_ind]])
    end
    
     if spell.english == 'Tachi: Jinpu' then
        equip(sets.Jinpu)
    end
    
    if spell.english == 'Apex Arrow' then
        equip(sets.Apex[sets.Apex.index[Apex_ind]])
    end

    if spell.english == 'Namas Arrow' then
        equip(sets.Namas[sets.Namas.index[Namas_ind]])
    end

    if spell.english == 'Impulse Drive' then
        equip(sets.ImpulseDrive[sets.ImpulseDrive.index[Impulse_ind]])
    end

    if spell.name == "Ranged" then
        equip(sets.Utility.Snapshot)
    end
    
    if spell.name == "Hasso" then
        equip(sets.TP[sets.TP.index[TP_ind]])
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
    elseif command == 'toggle Shoha set' then
        Shoha_ind = Shoha_ind +1
        if Shoha_ind > #sets.Shoha.index then Shoha_ind = 1 end
        send_command('@input /echo <----- Tachi: Shoha Set changed to '..sets.Shoha.index[Shoha_ind]..' ----->')
    elseif command == 'toggle Fudo set' then
        Fudo_ind = Fudo_ind +1
        if Fudo_ind > #sets.Fudo.index then Fudo_ind = 1 end
        send_command('@input /echo <----- Tachi: Fudo Set changed to '..sets.Fudo.index[Fudo_ind]..' ----->')
    elseif command == 'toggle Kaiten set' then
        Kaiten_ind = Kaiten_ind +1
        if Kaiten_ind > #sets.Kaiten.index then Kaiten_ind = 1 end
        send_command('@input /echo <----- Tachi: Kaiten Set changed to '..sets.Kaiten.index[Kaiten_ind]..' ----->')
    elseif command == 'toggle Apex set' then
        Apex_ind = Apex_ind +1
        if Apex_ind > #sets.Apex.index then Apex_ind = 1 end
        send_command('@input /echo <----- Apex Arrow Set changed to '..sets.Apex.index[Apex_ind]..' ----->')
    elseif command == 'toggle Namas set' then
        Namas_ind = Namas_ind +1
        if Namas_ind > #sets.Namas.index then Namas_ind = 1 end
        send_command('@input /echo <----- Namas Arrow Set changed to '..sets.Namas.index[Namas_ind]..' ----->')
    elseif command == 'equip TP set' then
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'equip Idle set' then
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
    end
    updateTable()
end