require('ClosetCleaner')
include('organizer-lib.lua')
include('displayBox/displayBox.lua')
include('organizeritems.lua')

function get_sets()

    sets.Aettir = {
       main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
    }

   capeStandard={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
   capeWSDex = { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

    organizer_items = organizerItems()
    --Idle Sets--
    sets.Idle = { ammo="Homiliary",
        head="Futhark Bandeau +3",neck="Loricate Torque +1",
        --ear1="Hearty Earring",
        --ear2="Ethereal Earring",   
        body="Futhark coat +2",hands="Erilaz Gauntlets +1",ring1="Moonbeam Ring",ring2="Defending Ring",     
        back="Evasionist's Cape",waist="Flume Belt +1",legs="Erilaz Leg Guards +1",feet="Skadi's Jambeaux +1"}   

    --TP Sets--
    sets.TP = {}
    --COMMENT OUT AS BELOW TO ADD/REMOVE SETS FROM THE QUICK SWAP TOGGLE--
    sets.TP.index = {
    'Standard', 
    'Accuracy', 
    'Hybrid', 
    'DT', 
    -- 'MDTacc', 
    'HP'}

    TP_ind = 1
    --offensive melee set
    sets.TP.Standard = {
        -- sub="Utu grip",
        ammo="Yamarang",
        -- head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
        head="Adhemar Bonnet +1",
        --body={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}},
        body="Ayanmo Corazza +2",
        hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}},
        neck="Anu Torque",
        waist="Windbuffet Belt +1",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Ilabrat Ring",
        right_ring="Petrov Ring",
        back=capeStandard
    }
    --high accuracy/DT hybrid set
    sets.TP.Accuracy = {
        ammo="Falcon Eye",
        head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
        body={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}},
        hands="Meghanada Gloves +2",
        legs="Meghanada Chausses +2",
        feet={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}},
        neck="Iqabi Necklace",
        waist="Olseni Belt",
        left_ear="Digni. Earring",
        right_ear="Telos Earring",
        left_ring="Etana Ring",
        right_ring="Cacoethic Ring +1",
        back=capeStandard
    }

    sets.TP.Hybrid = {
        -- sub="Mensch strap",
        -- ammo="Yamarang",
        ammo="Yamarang",
        -- head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
        head="Ayanmo Zucchetto +2",
        --body={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}},
        body="Ayanmo Corazza +2",
        hands="Turms Mittens +1",
        -- legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        legs="Erilaz Leg Guards +1",
        feet="Turms Leggings",
        -- neck="Anu Torque",
        neck="Anu Torque",
        waist="Flume Belt +1",
        -- waist="Ioskeha Belt",
        left_ear="Etiolation Earring",
        right_ear="Telos Earring",
        left_ring="Moonbeam Ring",
        right_ring="Defending Ring",
        back=capeStandard
    }                                          
    --full DT melee set
    sets.TP.DT = {
    -- sub="Mensch Strap", 
    ammo="Staunch Tathlum +1",          
        head="Futhark Bandeau +3",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",          
        body="Erilaz Surcoat +1",hands="Erilaz Gauntlets +1",ring1="Gelatinous Ring",ring2="Defending Ring",   
        back="Evasionist's Cape",waist="Flume Belt +1",legs="Erilaz Leg Guards +1",feet="Erilaz Greaves +1"}                                          
    --MDT melee set
    sets.TP.MDTacc = {
    -- sub="Mensch Strap", 
    ammo="Yamarang",          
        head="Futhark Bandeau +3",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",         
        body="Rawhide Vest",hands="Erilaz Gauntlets +1",ring1="Moonbeam Ring",ring2="Defending Ring",         
        back="Engulfer Cape +1",waist="Lieutenant's sash",legs="Runiest's Trousers +2",feet="Taeon Boots"}         
    sets.TP.HP = {
        -- sub="Balarama Grip",
        ammo="Aqreqaq Bomblet",
        head="Erilaz Galea +1",neck="Sanctity Necklace",ear1="Odnowa Earring",ear2="Odnowa Earring +1", --Halitus Helm
        body="Erilaz Surcoat +1",hands="Runeist mitons +1",ring1="K'ayres Ring",ring2="Etana Ring",
        back="Agema Cape",waist="Oneiros Belt",legs="Erilaz Leg Guards +1",feet="Erilaz Greaves +1" --Reiki Cloak, Runeist Bottes
    }
    --Weaponskill Sets--
    sets.WS = {}     
    --multi, carries FTP
    sets.Resolution = {
        ammo="Seething Bomblet +1",
        head="Adhemar Bonnet +1",
        body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
        hands="Meghanada Gloves +2",
        legs="Meghanada Chausses +2",
        feet={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Epona's Ring",
        right_ring="Niqmaddu Ring",
        back=capeStandard
    }

    sets.Dimidiation = {
        ammo="Knobkierrie",
        head="Adhemar Bonnet +1",
        body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
        hands="Meghanada Gloves +2",
        legs={ name="Herculean Trousers", augments={'Weapon skill damage +3%','DEX+14','Accuracy+3','Attack+9',}},
        feet={ name="Lustratio Leggings", augments={'HP+50','STR+10','DEX+10',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Ilabrat Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
    }

    --single, doesn't carry FTP
    sets.Single = {
        ammo="Seething Bomblet +1",
        head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
        body={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}},
        hands={ name="Herculean Gloves", augments={'Accuracy+23 Attack+23','"Triple Atk."+2','Attack+9',}},
        legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
        -- feet="Runeist Bottes +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Ishvara Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Apate Ring",
        right_ring="Petrov Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
    }
    --single hit, benefits from DA
    sets.Cleave = { ammo="Seething Bomblet +1",
        head="Dampening Tam",neck="Fotia Gorget",ear1="Brutal earring",---ear2="Zennaroi Earring",
        body={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}},
        hands="Herculean Gloves",ring1="Epona's Ring",ring2="Petrov Ring",
        back=capeStandard,waist="Fotia Belt",legs="Lustratio Subligar",feet="Herculean Boots"}
    --added effect
    sets.Shockwave = { ammo="Falcon Eye",
        head="Dampening Tam",neck="Fotia Gorget",ear1="Brutal earring",--ear2="Zennaroi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Epona's Ring",ring2="Petrov Ring",
        back=capeStandard,waist="Eschan Stone",legs="Lustratio Subligar",feet="Taeon Boots"} 
    --Requiescat
    sets.Req = { ammo="Seething Bomblet +1",
        head="Dampening Tam",neck="Fotia Gorget",ear1="Brutal earring",ear2="Moonshade Earring",
        body={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}},
        hands="Herculean Gloves",ring1="Epona's Ring",ring2="Petrov Ring",
        back=capeStandard,waist="Fotia Belt",legs="Taeon Tights",feet="Taeon Boots"} 
    --crit based
    sets.Vorp = {  
    --ammo="Qirmiz Tathlum",
        head="Dampening Tam",neck="Fotia Gorget",ear1="Brutal earring",ear2="Moonshade Earring",
        body={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}},
        hands="Herculean Gloves",ring1="Epona's Ring",ring2="Petrov Ring",
        back=capeWSDex,waist="Fotia Belt",legs="Lustratio Subligar",feet="Herculean Boots"}
    --magic WS
    sets.HercSlash = {  ammo="Seething Bomblet +1",
        --head="Highwing Helm", --neck="Deviant Necklace", --MISSING
        --ear1="Hecate's Earring",
        ear2="Friomisi earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",
        back="Argochampsa Mantle",waist="Eschan Stone",legs="Limbo Trousers",
        --feet="Adhemar Gamashes"
    }  
     
    sets.Utility = {}   
    --full PDT set for when stunned, etc.
    sets.Utility.PDT = { --ammo="Vanir Battery",
        head="Erilaz Galea +1",neck="loricate torque +1",
        --ear1="Hearty Earring",ear2="Ethereal Earring", --MISSING  
        body="Futhark coat +2",hands="Erilaz Gauntlets +1",ring1="Gelatinous Ring",ring2="Defending Ring",       
        back="Evasionist's Cape",waist="Flume Belt +1",legs="Erilaz Leg Guards +1",feet="Erilaz Greaves +1"}       
    --full MDT set for when stunned, etc
    sets.Utility.MDT = { --ammo="Vanir Battery",
        head="Dampening Tam",neck="loricate torque +1",
        --ear1="Hearty Earring",ear2="Zennaroi Earring", --MISSING          
        body="Rawhide Vest",hands="Erilaz Gauntlets +1",ring1="Vengeful Ring",ring2="Defending Ring",             
        back="Engulfer Cape +1",waist="Olseni Belt",legs="Runiest's Trousers +2",feet="Erilaz Greaves +1"}        
             
    --Job Ability Sets--
    sets.JA = {}
    sets.JA.Lunge = {ammo="Seething Bomblet +1",
        --head="Highwing Helm",
        --neck="Deviant Necklace",
        --ear1="Hecate's Earring",
        ear2="Friomisi earring",      
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",                         
        back="Argochampsa Mantle",waist="Eschan Stone",legs="Limbo Trousers",
    --    feet="Adhemar Gamashes"
    }  

    sets.JA.Vallation = {body="Runeist's Coat +2",legs="Futhark Trousers"}       
    sets.JA.Gambit = {hands="Runeist mitons +1"}
    sets.JA.Rayke = {feet="Futhark boots"}  
    sets.JA.Battuta = {head="Futhark bandeau +3",legs="Erilaz Leg Guards +1",feet="Turms Leggings"}      
    sets.JA.Pflug = {
    -- feet="Runeist bottes +2"
    }              
    sets.JA.Pulse = {head="Erilaz Galea +1",legs="Runiest's Trousers +2"}
                    
    --Precast Sets--
    --Fast Cast set
    sets.precast = {
        head="Runeist's bandeau +2",neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Etiolation Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Prolix Ring",
        back="Ogma's Cape",waist="Rumination Sash",legs="Ayanmo cosciales +2"}

    sets.Phalanx = {
    head="Futhark bandeau +3",
    body={ name="Taeon Tabard", augments={'"Phalanx"+3',}},
    hands={ name="Taeon gloves", augments ={'"Phalanx"+3',}},
    right_ear="Augmenting earring",
    left_ear="Andoaa earring",
    right_ring="Stikini ring",
    left_ring="Stikini ring",
    legs={ name="Taeon Tights", augments={'"Phalanx"+3',}},
    feet={ name="Taeon boots", augments={'"Phalanx"+3',}}}

    --Enmity set for high hate generating spells and JAs                
    sets.Enmity =  {ammo="Aqreqaq bomblet",
        head="Halitus Helm",neck="Unmoving Collar +1",ear1="Cryptic Earring",ear2="Friomisi earring",         
        body="Emet Harness +1",hands="Nilas Gloves",ring1="Provocare Ring",ring2="Petrov Ring",
        back="Agema Cape",waist="Trance Belt",legs="Erilaz Leg Guards +1",feet="Erilaz Greaves +1"}  

    --Magic acc for enfeebles, handy for VW
    sets.MagicAcc = {
        head="Dampening Tam",ear1="Crepuscular Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Sangoma Ring",ring2="Kishar Ring",
        --waist="Salire Belt",
        legs="Runiest's Trousers +2"}
     
    --Toggle TP sets button, change if you want; currently ALT+F9 toggles forward, CTRL+F9 toggles backwards
    send_command('bind f10 gs c toggle TP set')
    send_command('bind ^f10 gs c reverse TP set')
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
    addToTable("(F10) TP Set", sets.TP.index[TP_ind])
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
        if player.equipment.main == "empty" or player.equipment.sub == "empty" then
                equip({main="Epeolatry",sub="Utu Grip"})
        end
        if spell.action_type == 'Magic' then 
                equip(sets.Utility.PDT,sets.precast)            
        end  
        if spell.skill == 'Enhancing Magic' then
                equip({legs="Futhark Trousers"})
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
                equip(sets.Enmity,{body="Futhark Coat +2"})
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
                mid_obi(spell.element,spell.name)
        end
        if spell.name == 'One for All' or spell.name == 'Embolden' or spell.name == 'Odyllic Subterfuge' or spell.name == 'Warcry' 
        or spell.name == 'Swordplay' or spell.name == 'Rayke' or spell.name == 'Meditate' or spell.name == 'Provoke' then   
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
            equip(sets.Shockwave)
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
        if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
                if TP_ind == 4 then
                equip(sets.Utility.MDT) else
                equip(sets.Utility.PDT)
                end
        end
        if buffactive.sleep and player.hp > 100 and player.status == "Engaged" then 
                equip({head="Frenzy Sallet"})
        end
end            
  
function midcast(spell,act,arg) 
        if spell.action_type == 'Magic' then 
                equip(sets.Utility.PDT,{head="Runeist bandeau +2"})         
        end  
        if spell.skill == 'Enhancing Magic' then
                equip({head="Erilaz Galea +1",legs="Futhark Trousers"})
                if spell.name == "Blink" or spell.name == "Stoneskin" or string.find(spell.name,'Utsusemi') then
                    equip(sets.Utility.PDT,{head="Runeist bandeau +2",hands="Leyline Gloves"})
                elseif string.find(spell.name,'Bar') or spell.name=="Temper" then
                    equip({hands="Runeist Mitons +1"})
                end
                if buffactive.embolden then
                    equip({back="Evasionist's Cape"})
                end 
        end
        if spell.name == 'Foil' or spell.name == 'Flash' or spell.name == "Stun" then 
                equip(sets.Enmity,{head="Runeist bandeau +2"})
        end 
        if spell.name == 'Phalanx' then
                equip(sets.Phalanx)
        end      
        if string.find(spell.name,'Regen') then
                equip({head="Runeist bandeau +2"})
        end
        if spell.name == "Repose" or spell.skill == 'Enfeebling Magic' or spell.skill == 'Dark Magic' then
                equip(sets.MagicAcc)
        end
        if spell.skill == 'Elemental Magic' then
                equip(sets.JA.Lunge)
                mid_obi(spell.element,spell.name)
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
        --equips offensive gear despite being on defensive set if you have shadows
        if TP_ind == 4 and ((buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) or buffactive['Third Eye'] or buffactive['Blink']) then
            equip(sets.TP.Accuracy)
        end
        --equips DW gear if using two weapons
        if player.equipment.sub == "Tramontane Axe" or player.equipment.sub == "Pukulatmuj" or player.equipment.sub == "Anahera Sword" then
            equip({ear2="Suppanomimi"})
        end
        --equips offensive gear and relic boots during Battuta
        if buffactive.battuta then
            --remains on defensive set if Avoidance Down is active
            if buffactive['Avoidance Down'] then
            else
                if TP_ind == 4 then
                    equip(sets.TP.Accuracy)
                end
            equip({feet="Futhark Boots"})
            end
        end
        --equip defensive gear when hit with terror/petrify/stun/sleep
        if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
                if TP_ind == 5 then
                equip(sets.Utility.MDT) else
                equip(sets.Utility.PDT)
                end
        end
        --equip Frenzy Sallet (will wake you up) if engaged, slept, and over 100 HP
        if buffactive.sleep and player.hp > 100 then 
            equip({head="Frenzy Sallet"})
        end
end
 
function equip_idle()
    equip(sets.Idle)
        --equips extra refresh gear when MP is below 75%
        if player.mpp < 75 then
            equip({body="Runeist's Coat +2"})
        end
        --auto-equip defensive gear when hit with terror/petrify/stun/sleep
        if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
                if TP_ind == 4 then
                equip(sets.Utility.MDT) else
                equip(sets.Utility.PDT)
                end
        end
end
 
function buff_change(buff,gain)
    local buff = string.lower(buff)
        if buff == "terror" or buff == "petrification" or buff == "stun" or buff == "sleep" then
            if gain then  
                if TP_ind == 4 then
                equip(sets.Utility.MDT) else
                equip(sets.Utility.PDT)
                end
                if buff == "sleep" and player.hp > 100 and player.status == "Engaged" then 
                equip({head="Frenzy Sallet"})
                end
            else 
            equip_current()
            end
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
        end
        updateTable()
end