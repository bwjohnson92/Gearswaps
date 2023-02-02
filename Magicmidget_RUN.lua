require('ClosetCleaner')
include('organizer-lib.lua')
include('displayBox.lua')

function get_sets()


    OgmaSTR = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
    OgmaTank = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}
    OgmaDEX = { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    OgmaCasting = { name="Ogma's Cape", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}}
    OgmaEvasion = { name="Ogma's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}}

   capeStandard = "Ogma's cape"
   capeWSDex = "Ogma's cape"

    organizer_items = {
        trizek="Trizek Ring",
        echos="Echo Drops",
        warp="Instant Warp",
        reraise="Instant Reraise",
        ramen="Miso Ramen",
        ramen1="Miso Ramen +!",
        sushi="Sublime Sushi",
        pizza="Marinara Slice",
        holy="Holy Water",
        RREar="Reraise Earring",
        Warp="Warp Ring",
        Exp="Echad Ring",
        CPMantle="Mecistopins Mantle",
        Prism="Prism Powder",
        Oils="Silent Oil",
 }

    sets.Idle = {}
    sets.Idle.index = {
        'Standard',
        'DT',
        -- 'MagicDT'
        'Evasion'
    }
    Idle_ind = 3
    --Idle Sets--
    sets.Idle.Standard = { --ammo="Homiliary",
        head="Nyame Helm",neck="Futhark Torque +2",ear1="Odnowa Earring +1", --ear2="Ethereal Earring",   
        body="Nyame Mail",hands="Regal Gauntlets",ring1="Moonlight Ring",ring2="Defending Ring",     
        back=OgmaTank,waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Nyame Sollerets"}   

    sets.Idle.DT = {
        ammo="Staunch Tathlum +1",          
        head="Nyame Helm",
        neck="Futhark Torque +2",
        ear1="Odnowa Earring +1",
        ear2="Sanare Earring",          
        body="Erilaz Surcoat +2",
        hands="Nyame Gauntlets",
        ring1="Moonlight Ring",ring2="Defending Ring",   
        back=OgmaTank,
        waist="Flume Belt +1",
        legs="Erilaz Leg Guards +3",
        feet="Nyame Sollerets"
    }

    sets.Idle.MagicDT = set_combine(sets.Idle.DT, {
        neck="Futhark Torque +2",
        legs="Ayanmo Cosciales +2",
        -- right_ear="Dominance Earring +1",
        legs="Runeist Trousers +2",
        -- body="Erilaz Surcoat +1",
        feet="Erilaz Greaves +2",
        hands="Erilaz Gauntlets +2"
    })

    sets.Idle.Evasion = set_combine(sets.Idle.DT, {
        ammo="Yamarang",
        head="Nyame Helm",
        body="Nyame Mail",
        -- hands="Turms Mittens +1",
        hands="Nyame Gauntlets",
        legs="Erilaz Leg Guards +3",
        -- feet="Turms Leggings +1",
        feet="Nyame Sollerets",
        neck="Bathy Choker +1",
        -- waist="Flume Belt +1",
        waist="Sveltesse Gouriz +1",
        left_ear="Eabani Earring",
        right_ear="Infused Earring",
        left_ring="Moonlight Ring",
        -- right_ring="Vengeful Ring",
        right_ring="Defending Ring",
        back=OgmaEvasion
    })
    --TP Sets--
    sets.TP = {}
    sets.TP.index = {
        'Standard',
        -- 'Accuracy', 
        'Hybrid',
        'DT',
        'HP',
        'MEva'
    }
    TP_ind = 5
    --offensive melee set
    sets.TP.Standard = {
        -- ammo="Ginsen",
        ammo="Yamarang",
        -- head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
        head="Ayanmo Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Turms Mittens +1",
        legs="Samnuha Tights",
        feet="Herculean Boots",
        neck="Defiant Collar",
        waist="Grunfeld Rope",
        left_ear="Telos Earring",
        right_ear="Sherida Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Moonlight Ring",
        back=OgmaSTR
    }
    --high accuracy/DT hybrid set
    sets.TP.Accuracy = set_combine(sets.TP.Standard, {
        ammo="Falcon Eye",
        head="Nyame Helm",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet="Turms Leggings +1",
        left_ear="Digni. Earring",
        right_ear="Telos Earring",
        left_ring="Etana Ring",
        -- right_ring="Cacoethic Ring +1",
        back={ name="Ogma's cape",}
    })

    sets.TP.Hybrid = {
        ammo="Yamarang",
        head="Ayanmo Zucchetto +2",
        body="Ashera Harness",
        hands="Turms Mittens +1",
        legs="Erilaz Leg Guards +3",
        feet="Turms Leggings +1",
        neck="Futhark Torque +2",
        -- waist="Windbuffet Belt +1",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Moonlight Ring",
        right_ring="Defending Ring",
        back=OgmaTank
    }                        
    --full DT melee set
    sets.TP.DT = {
        ammo="Staunch Tathlum +1",          
        -- head="Futhark Bandeau +3",
        head="Nyame Helm",
        neck="Futhark Torque +2",
        ear1="Odnowa Earring +1",ear2="Odnowa Earring",          
        body="Ashera Harness",hands="Turms Mittens +1",ring1="Moonlight Ring",ring2="Defending Ring",   
        back="Moonbeam Cape",waist="Flume Belt +1",
        -- legs="Erilaz Leg Guards +3",
        legs="Erilaz Leg Guards +3",
        feet="Turms Leggings +1"}

    sets.TP.HP = {
        head="Nyame Helm",
        body="Runeist Coat +3",
        hands="Regal Gauntlets",
        legs="Eri. Leg Guards +3",
        feet="Erilaz Greaves +2",
        waist="Flume Belt +1",
        neck="Futhark Torque +2",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring="K'ayres Ring",
        right_ring="Regal Ring",
        back="Moonbeam Cape",
    }

    sets.TP.MEva = {
        -- sub="Irenic Strap +1",
        ammo="Staunch Tathlum +1",
        neck="Futhark Torque +2",
        ear1="Odnowa Earring +1",
        ear2="Odnowa Earring",
        head="Nyame Helm",
        -- body="Nyame Mail",
        body="Erilaz Surcoat +2",
        hands="Turms Mittens +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=OgmaTank,
        waist="Flume Belt +1",
        legs="Erilaz Leg Guards +3",
        feet="Turms Leggings +1"
    }


    --Weaponskill Sets--
    sets.WS = {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        waist="Soil Belt",
        back=OgmaDEX
    }     
    --multi, carries FTP
    sets.Resolution = {
        ammo="Aurgelmir Orb",
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        legs="Samnuha Tights",
        feet="Herculean Boots",
        neck="Fotia Gorget",
        waist="Soil Belt",
        left_ear="Sherida Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back=OgmaSTR
    }

    sets.Dimidiation = {
        ammo="Knobkierrie",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Meg. Gloves +2",
        -- legs="",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        -- feet={ name="Lustratio Leggings", augments={'HP+50','STR+10','DEX+10',}},
        -- neck="Caro Necklace",
        neck="Futhark Torque +2",
        waist="Grunfeld Rope",
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        -- left_ring="Ilabrat Ring",
        left_ring="Epaminondas's Ring",
        right_ring="Regal Ring",
        back=OgmaDEX
    }

    --single, doesn't carry FTP
    sets.Single = set_combine(sets.WS, {
        ammo="Seething Bomblet",
        feet="Runeist Bottes +1",
        -- neck="Fotia Gorget",
        -- waist="Fotia Belt",
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        left_ring="Apate Ring",
        right_ring="Petrov Ring"
    })

    --single hit, benefits from DA
    sets.Cleave = set_combine(sets.WS, { ammo="Seething Bomblet",
        ring2="Petrov Ring",
        back=capeStandard})

    --added effect
    sets.Shockwave = set_combine(sets.WS, {
        ear1="Cessance earring",ear2="Digni. Earring",
        ring1="Regal Ring",ring2="Niqmaddu Ring",
        back=capeStandard,waist="Eschan Stone"})

    --magic WS
    sets.HercSlash = set_combine(sets.WS, {})
     
    sets.Utility = {}   
    --full PDT set for when stunned, etc.
    sets.Utility.PDT = sets.Idle.DT      
    --full MDT set for when stunned, etc
    sets.Utility.MDT = sets.TP.MEva       
             
    --Job Ability Sets--
    sets.JA = {}
    sets.JA.Lunge = set_combine(sets.WS, {ammo="Seething Bomblet",
        neck="Deviant Necklace",ear1="Hecate's Earring",ear2="Friomisi earring",                        
        waist="Eschan Stone"})

    sets.JA.Vallation = {body="Runeist Coat +3",legs="Futhark Trousers +2"}       
    sets.JA.Gambit = {hands="Runeist mitons +3"}
    sets.JA.Rayke = {feet="Futhark boots +1"}  
    sets.JA.Battuta = {head="Futhark bandeau +3"}      
    sets.JA.Pflug = {feet="Runeist bottes +1"}              
    sets.JA.Pulse = {main="Morgelai",head="Erilaz Galea +2",legs="Runeist Trousers +2"}
                    
    --Precast Sets--
    --Fast Cast set
    sets.precast = {
        ammo="Sapience Orb",
        head={name="Runeist bandeau +3", priority=1},
        neck="Orunmila's Torque",
        ear1={name="Odnowa Earring +1",priority=1},
        ear2={name="Etiolation Earring",priority=1},
        body="Erilaz Surcoat +2",
        hands="Leyline Gloves",
        ring1={name="Moonlight Ring", priority=1},
        ring2="Kishar Ring",
        -- back=OgmaCasting,
        back={name="Moonbeam Cape", priority=1},
        waist="Rumination Sash",
        legs="Ayanmo Cosciales +2", 
        feet={name="Carmine Greaves +1", priority=1}}

    sets.Phalanx = {
        ammo="Staunch Tathlum +1",
        head="Futhark bandeau +3",
        body={ name="Taeon Tabard", augments={'"Phalanx"+3',}},
        hands={ name="Taeon gloves", augments ={'"Phalanx"+3',}},
        left_ear="Odnowa Earring +1",
        right_ear="Augmenting earring",
        -- right_ring="Stikini ring",
        legs="Taeon Tights",
        back="Moonbeam Cape",
        neck="Futhark Torque +2",
        -- legs="Futhark Trousers +2",
        waist="Flume Belt +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        feet={ name="Taeon boots", augments={'"Phalanx"+3',}}
    }

    sets.Phalanx.Potency = sets.Phalanx
    sets.Phalanx.Duration = set_combine(sets.Phalanx.Potency, {
        legs="Futhark Trousers +2"
    })

    sets.Interrupt = set_combine(sets.Idle.DT, {
        -- Merits - 10
        ammo="Staunch Tathlum +1", --10
        head="Erilaz Galea +2", --20
        body="Ashera Harness", --0
        hands="Regal Gauntlets", --15
        legs="Carmine Cuisses +1", --20
        feet="Erilaz Greaves +2", --0
        neck="Moonbeam Necklace", --10
        ear2="Halasz Earring", --5 --Magnetic?
        ring1="Gelatinous Ring +1", --0
        waist="Audumbla Sash", --10
        back=OgmaCasting --10
    })

    sets.Taeon = {
        head="Taeon Chapeau",
        body="Taeon Tabard",
        hands="Taeon Gloves",
        legs="Taeon Tights",
        feet="Taeon Boots"
    }

    --Enmity set for high hate generating spells and JAs                
    sets.Enmity =  {
        -- main="Morgelai",
        ammo="Sapience Orb",
        neck="Futhark Torque +2",
        body={name="Emet Harness +1", priority=2},
        hands="Kurys Gloves",
        ear1="Odnowa Earring +1",
        ear2="Trux earring",    
        -- ring1="Supershear Ring",ring2="Petrov Ring",
        -- back=OgmaTank,
        ring1="Moonlight Ring", 
        -- ring2={name="Supershear Ring", priority=1},
        ring2="Defending Ring",
        back="Moonbeam Cape",
        -- waist="Sinew Belt",
        waist="Trance Belt",
        legs={name="Erilaz Leg Guards +3",priority=1},
        -- feet="Erilaz Greaves +2"
        -- feet={name="Carmine Greaves +1",priority=1}
        feet="Erilaz Greaves +2"
    }  

    sets.Regen = set_combine(sets.Idle.Evasion, {
        main="Morgelai",head="Runeist bandeau +3",neck='Sacro Gorget',ear2="Erilaz Earring"
    })

    --Magic acc for enfeebles, handy for VW
    sets.MagicAcc = {}
        -- head="Dampening Tam",ear1="Gwati Earring",
        -- body="Samnuha Coat",hands="Leyline Gloves",ring1="Sangoma Ring",ring2="Kishar Ring",
        -- waist="Salire Belt",legs="Runeist Trousers +2"}
     
    --Toggle TP sets button, change if you want; currently ALT+F9 toggles forward, CTRL+F9 toggles backwards
    send_command('bind end send @others input /follow Magicmidget')
    send_command('bind f11 gs c toggle TP set')
    send_command('bind ^f11 gs c reverse TP set')

    send_command('bind f10 gs c toggle Idle set')
    send_command('bind ^f10 gs c reverse Idle set')
    send_command('bind f12 gs c equip gear')

    send_command('bind numpad. shockwave')
    
    --other stuff, don't touch
    ShadowType = 'None'

    text_setup()
    addNewColors()
    updateTable()
end

function addNewColors()
    addTextColorPair("HighMP", "blue")
    addTextColorPair("PDT", "yellow")
    addTextColorPair("Standard", "green")
end

function updateTable()
    addToTable("(F10) Idle Set", sets.Idle.index[Idle_ind])
    addToTable("(F11) TP Set", sets.TP.index[TP_ind])
    update_message()
end
 
--the following section looks at the weather/day to see if the Hachirin-no-Obi is worth using
--add the following line to a section to have it check the element and equip the obi:
-->>>  mid_obi(spell.element,spell.name)
function mid_obi(spellelement,spellname)
    if spellelement == nil then
    spellelement = "Light"
    end
    if spellname == nil then
    spellname = "Cure"
    end   
    elements = {}
        elements.list = S{'Fire','Ice','Wind','Earth','Lightning','Water','Light','Dark'}
        elements.number = {[0]="Fire",[1]="Ice",[2]="Wind",[3]="Earth",[4]="Lightning",[5]="Water",[6]="Light",[7]="Dark"}
        elements.weak = {['Light']='Dark', ['Dark']='Light', ['Fire']='Water', ['Ice']='Fire', ['Wind']='Ice', ['Earth']='Wind',
    ['Lightning']='Earth', ['Water']='Lightning'}
        weather = world.weather_element
        intensity = 1 + (world.weather_id % 2)
        day = world.day
        boost = 0
        obi = nil
        
       for _,buff in pairs (windower.ffxi.get_player().buffs) do
            if buff > 177 and buff < 186 then
                weather = elements.number[(buff - 178)]
                intensity = 1
            elseif buff > 588 and buff < 597 then
                weather = elements.number[(buff - 589)]
                intensity = 2
            end
            if spellname == "Swipe" or spellname == "Lunge" or spellname == "Vivacious Pulse" then
                if buff > 522 and buff < 531 then
                spellelement = elements.number[(buff - 523)]
                end
            end
        end
        if weather == spellelement then
        boost = boost + intensity
        elseif weather == elements.weak[spellelement] then
        boost = boost - intensity
        end
        if day == spellelement then
        boost = boost + 1
        elseif day == elements.weak[spellelement] then
        boost = boost - 1
        end
        if boost > 0 then
            if player.inventory["Hachirin-no-Obi"] or player.wardrobe["Hachirin-no-Obi"] then
                equip({waist="Hachirin-no-Obi"})
            end
        end
end
                
function precast(spell,abil)
        --equips favorite weapon if disarmed
        equip_weapon()
        if spell.action_type == 'Magic' then 
                equip(sets.Idle.Evasion,sets.precast)            
        end  
        if spell.skill == 'Enhancing Magic' then
                equip({legs="Futhark Trousers +2"})
        end
        if string.find(spell.name,'Utsusemi') then
                equip({neck="Magoraga Beads"})
        end  
        if spell.name == 'Lunge' or spell.name == 'Swipe' then
                equip(sets.JA.Lunge)
                mid_obi(spell.element,spell.name)
        end      
        --prevents Valiance/Vallation/Liement from being prevented by each other (cancels whichever is active)
        if spell.name == 'Valiance' or spell.name == 'Vallation' or spell.name == 'Liement' then
                if buffactive['Valiance'] then
                    cast_delay(0.2)
                    windower.ffxi.cancel_buff(535)
                elseif buffactive['Vallation'] then
                    cast_delay(0.2)
                    windower.ffxi.cancel_buff(531)
                elseif buffactive['Liement'] then
                    cast_delay(0.2)
                    windower.ffxi.cancel_buff(537)
                end
        end
        if spell.name == 'Vallation' or spell.name == 'Valiance' then
                equip(sets.Enmity,sets.JA.Vallation)
        end  
        if spell.name == 'Pflug' then
                equip(sets.Enmity,sets.JA.Pflug)
        end      
        if spell.name == 'Elemental Sforzo' or spell.name == 'Liement' then
                equip(sets.Enmity,{body="Futhark Coat +1"})
        end      
        if spell.name == 'Gambit' then
                equip(sets.Enmity,sets.JA.Gambit)
        end
        if spell.name == 'Rayke' then
                equip(sets.Enmity,sets.JA.Rayke)
        end
        if spell.name == 'Battuta' then
                equip(sets.Enmity,sets.JA.Battuta)
        end
        if spell.name == 'Vivacious Pulse' then
                equip(sets.Enmity,sets.JA.Pulse)
                -- mid_obi(spell.element,spell.name)
        end
        if spell.name == 'One for All' or spell.name == 'Embolden' or spell.name == 'Odyllic Subterfuge' or spell.name == 'Warcry' 
        or spell.name == 'Swordplay' or spell.name == 'Rayke' or spell.name == 'Meditate' then
            equip(sets.Idle.Evasion)
        end        
        if spell.name == 'Provoke' then   
                equip(sets.Enmity)
        end
        if spell.name == 'Resolution' or spell.name == 'Ruinator'  then
            equip(sets.Resolution)
        end
        if spell.name == 'Dimidiation' then
            equip(sets.Dimidiation)
        end
        if spell.name == 'Spinning Slash' 
        or spell.name == 'Ground Strike'
        or spell.name == 'Upheaval' 
        or spell.name == 'Steel Cyclone'    
        or spell.name == 'Savage Blade' then
                equip(sets.Single)
        end
        if spell.name == 'Shockwave' then
            equip(sets.Idle.Evasion)
        end
        if spell.name == 'Fell Cleave' or spell.name == 'Circle Blade' then
                equip(sets.Cleave)
        end
        if spell.name == 'Requiescat' then
                equip(sets.Req)
        end
        if spell.name == 'Vorpal Blade' or spell.name == 'Rampage' then
                equip(sets.Vorp)
        end
        if spell.name == 'Herculean Slash' 
        or spell.name == 'Freezebite'  
        or spell.name == 'Sanguine Blade' 
        or spell.name == 'Red Lotus Blade'
        or spell.name == 'Seraph Blade' then
                equip(sets.HercSlash)
                mid_obi(spell.element,spell.name)
        end
        --prevents casting Utsusemi if you already have 3 or more shadows
        if spell.name == 'Utsusemi: Ichi' and ShadowType == 'Ni' and (buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) then
            cancel_spell()
        end
        if buffactive.sleep and player.hp > 100 and player.status == "Engaged" then 
                equip({head="Frenzy Sallet"})
        end
end            
  
function midcast(spell,act,arg) 
        if spell.action_type == 'Magic' then 
                equip(sets.Idle.Evasion,{head="Runeist bandeau +3",hands="Regal Gauntlets"})         
        end  
        if spell.skill == 'Enhancing Magic' then
                equip(sets.Idle.Evasion, {head="Erilaz Galea +2",legs="Futhark Trousers +2",hands="Regal Gaunlets"})
                if spell.name == "Blink" or spell.name == "Stoneskin" or spell.name == "Aquaveil" or string.find(spell.name,'Utsusemi') then
                    equip(sets.Interrupt)
                elseif string.find(spell.name,'Bar') or spell.name=="Temper" then
                    equip({hands="Runeist Mitons +3"})
                end
                if buffactive.embolden then
                    equip({back="Evasionist's Cape"})
                end 
        end
        if spell.name == 'Foil' or spell.name == 'Flash' or spell.name == "Stun" then 
                equip(sets.Idle.Evasion, sets.Enmity,{head="Runeist bandeau +3"})
        end 
        if spell.name == 'Phalanx' then
                equip(sets.Idle.Evasion,sets.Phalanx.Potency)
        end      
        if string.find(spell.name,'Regen') then
                equip(sets.Regen)
        end
        if spell.name == "Repose" or spell.skill == 'Enfeebling Magic' or spell.skill == 'Dark Magic' then
                equip(sets.MagicAcc)
        end
        if spell.skill == 'Elemental Magic' then
                equip(sets.JA.Lunge)
                mid_obi(spell.element,spell.name)
        end
        if spell.skill == 'Blue Magic' then
            if spell.name == "Jettuara" or spell.name == "Geist Wall" then
                equip(sets.Enmity, sets.Interrupt)
                -- equip(sets.Enmity)
            -- else
            end
        end
        --cancels Ni shadows (if there are only 1 or 2) when casting Ichi
        if spell.name == 'Utsusemi: Ichi' and ShadowType == 'Ni' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
                send_command('cancel Copy Image')
                send_command('cancel Copy Image (2)')
        end
end
 
function aftercast(spell)
        equip_current()
        if string.find(spell.name,'Utsusemi') and not spell.interrupted then
            if spell.name == 'Utsusemi: Ichi' then
            ShadowType = 'Ichi'
            elseif spell.name == 'Utsusemi: Ni' then
            ShadowType = 'Ni'
            end
        end
end
 
function status_change(new,old)
    equip_current()
end 
  
function equip_TP()
    equip(sets.TP[sets.TP.index[TP_ind]])
    equip_weapon()
end
 
function equip_idle()
    equip(sets.Idle[sets.Idle.index[Idle_ind]])
    equip_weapon()
end
 
function buff_change(buff,gain)
    local buff = string.lower(buff)
    if buff == "terror" or buff == "petrification" or buff == "stun" or buff == "sleep" then
        -- if gain then  
        --     -- if TP_ind == 4 then
        --     -- equip(sets.Utility.MDT) else
        --     -- equip(sets.Utility.PDT)
        --     -- end
        --     -- if buff == "sleep" and player.hp > 100 and player.status == "Engaged" then 
        --     -- equip({head="Frenzy Sallet"})
        --     -- end
        -- else 
        equip_current()
        -- end
    end
    if not gain then
        add_to_chat(140, "Lost "..buff)
    end

end
 
 function equip_weapon() 
    if player.equipment.main == "empty" or player.equipment.main == "Morgelai" or player.equipment.sub == "empty" then
            equip({main="Epeolatry",sub="Utu Grip"})
    end
 end

function equip_current()
    if player.status == 'Engaged' then
    equip_TP()
    else
    equip_idle()
    end
end
             
function self_command(command)
        if command == 'toggle TP set' then
                TP_ind = TP_ind +1
                if TP_ind > #sets.TP.index then TP_ind = 1 end
                send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
                equip(sets.TP[sets.TP.index[TP_ind]])
        elseif command == 'reverse TP set' then
                TP_ind = TP_ind -1
                if TP_ind == 0 then TP_ind = #sets.TP.index end
                send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
                equip_current()
        elseif command == 'toggle Idle set' then
                Idle_ind = Idle_ind +1
                if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
                send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
                equip(sets.Idle[sets.Idle.index[Idle_ind]])
        elseif command == 'reverse Idle set' then
                Idle_ind = Idle_ind -1
                if Idle_ind == 0 then Idle_ind = #sets.Idle.index end
                send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
                equip_current()
        elseif command == 'equip gear' then
            -- equip({main="Epeolatry"})
            equip_current()
        end

        updateTable()
end