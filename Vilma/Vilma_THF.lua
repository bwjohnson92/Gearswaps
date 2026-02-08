require('ClosetCleaner')
include('organizer-lib.lua')
include('organizeritems.lua')
include('displayBox/displayBox.lua')

function get_sets()
	send_command('bind f10 gs c toggle TP set')
    TP_Index = 1
    Idle_Index = 1

    sets.weapons = {}
    sets.weapons[1] ={main="Aeneas"}
    sets.weapons[2]={sub="Tauret"}
    sets.weapons[3]={sub="Gleti's Knife"}

    
    sets.JA = {}
--    sets.JA.Conspirator = {body="Raider's Vest +2"}
--    sets.JA.Accomplice = {head="Raider's Bonnet +2"}
--    sets.JA.Collaborator = {head="Raider's Bonnet +2"}
    sets.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
    sets.JA.Steal = {feet="Rogue's Poulaines"}
    sets.JA.Flee = {feet="Rogue's Poulaines"}
--    sets.JA.Despoil = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
--    sets.JA.Mug = {head="Assassin's Bonnet +2"}
    -- sets.JA.Waltz = {head="",neck="Dualism Collar +1",body="Iuitl Vest",hands="Slither Gloves +1",ring1="Valseur's Ring",ring2="Carbuncle Ring +1",
    --     waist="Aristo Belt",legs="Desultor Tassets",feet="Dance Shoes"}
    
	capeWS = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}}
    capeTP = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	TaeonHands = {name="Taeon Gloves",augments={'Accuracy+17 Attack+17','"Triple Atk."+2','Crit. hit damage +2%'}}    

    TP_Set_Names = {"Low Haste","High Haste","TH"}

    sets.TP = {}

    sets.TP['Low Haste'] = {ammo="Yamarang",
        head="Skulker's bonnet +2",neck="Erudition Necklace",ear2="Eabani Earring",ear1="Sherida Earring",
        body="Malignance Tabard",hands="Malignant Gloves",ring1="Moonbeam Ring",ring2="Gere Ring",
        back=capeTP,waist="Reiki Yotai",legs="Gleti's Breeches",
        feet="Skulker's Poulaines +2",} 
         
	sets.TP['High Haste'] = {range="Raider's Bmrng.",
        head="Skulker's bonnet +2", neck="Erudition Necklace",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Herculean Vest",hands="Adhemar Wristbands +1",ring1="Epona's Ring",ring2="Gere Ring",
        back=capeTP,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}},}
    
    sets.TP['Acc'] = {ammo="Yamarang",
        head="Skulker's bonnet +2",neck="Null Loop",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Meghanada Gloves +2",ring1="Moonbeam Ring",ring2="Gere Ring",
        back=capeTP,waist="Windbuffet Belt +1",
        back="Toutatis's Cape",waist="Kentarch Belt +1",legs="Gleti's Breeches",feet="Skulker's poulaines +2",}

	sets.TP['TH'] = set_combine(sets.TP['Low Man'], {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        waist="Chaac Belt",
        neck="Erudition Necklace",
        ring1="Moonbeam Ring",
        feet="Skulker's Poulaines +2",
        })

    sets.TP['TH Acc'] = set_combine(sets.TP['TH'], {
        legs="Meghanada Chausses +2", feet="Malignance Boots"
        })
        
    sets.WS = {}
    sets.WS.SA = {}
    sets.WS.TA = {}
    sets.WS.SATA = {}

    sets.WS.Evisceration = {head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Mache earring +1",
        body="Pillager's Vest +2",hands="Mummu wrists +2",ring1="Ilabrat Ring",ring2="Mummu Ring",
        back=capeWS,waist="Fotia Belt",legs="Pillager's Culottes +1",feet="Mummu Gamashes +2"}

    sets.WS.Evisceration.SA = set_combine(sets.WS.Evisceration,{hands="Raider's Armlets +2"})

    sets.WS["Rudra's Storm"] = { ammo="Cath Palug Stone",
        head="Pillager's Bonnet +3",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Skulker's Vest +1",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Regal ring",
        back=capeWS,waist="Kentarch Belt +1",legs="Plunder's Culottes +3",feet="Nyame Sollerets"}
        Ammo="Cath Palug stone"
        
    sets.WS["Rudra's Storm"].SA = set_combine(sets.WS["Rudra's Storm"],
        {
        -- head="Imperial Wing Hairpin",
        body="Pillager's Vest +2",hands="Raider's Armlets +2",legs="Nyame Flanchard", feet="Nyame Sollerets"}
    )
        
    sets.WS.Exenterator = {head="Nyame helm",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Skulker's Earring",
        body="Pillager's Vest +2",hands="Nyame gauntlets",ring1="Gere ring",ring2="Ilabrat Ring",
        back=capeWS,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.WS.Exenterator.TA = {
        body="Pillager's Vest +2",ring2="Gere Ring", --hands
        back=capeWS,waist="Windbuffet Belt +1",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}
        
    sets.WS.Exenterator.SATA = set_combine(sets.WS.TA.Exenterator, {})
    
    sets.WS["Aeolian Edge"] = {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        left_ear="Friomisi Earring",
        right_ear="Moonshade Earring",
        left_ring="Dingir Ring",
    }

    sets.WS["Cyclone"] = sets.WS["Aeolian Edge"]

    Idle_Set_Names = {'Normal'}
    sets.Idle = {}
    sets.Idle.Normal = {head="Skulker's bonnet +1",neck="Loricate Torque +1",--ear1="Merman's Earring",ear2="Bladeborn Earring",
        body="Emet Harness +1",hands="Plunderer's Armlets +3",ring1="Dark Ring",ring2="Defending Ring",
        back=capeTP,waist="Chaac Belt",legs="Nyame Flanchard",feet="Skadi's Jambeaux +1"}
                
    -- sets.Idle.MDT = {head="Skulker's bonnet +1",ear1="Merman's Earring",ear2="Bladeborn Earring",
    --     body="Avalon Breastplate",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Dark Ring",
    --     back="Mollusca Mantle",waist="Wanion Belt",legs="Nahtirah Trousers",feet="Skadi's Jambeaux +1"}
	
	organizer_items = organizerItems()
    updateTable()
    
end

function updateTable()
    addToTable("(F10) TP Set", TP_Set_Names[TP_Index])
    update_message()
end

function precast(spell)
    if sets.JA[spell.english] then
        equip(sets.JA[spell.english])
    elseif spell.type=="WeaponSkill" then
        if sets.WS[spell.english] then 
            equip(sets.WS[spell.english]) 
        end
        if buffactive['sneak attack'] and buffactive['trick attack'] and sets.WS[spell.english].SATA then 
            equip(sets.WS[spell.english].SATA)
        elseif buffactive['sneak attack'] and sets.WS[spell.english].SA then 
            equip(sets.WS[spell.english].SA)
        elseif buffactive['trick attack'] and sets.WS[spell.english].TA then 
            equip(sets.WS[spell.english].TA) end
    elseif string.find(spell.english,'Waltz') then
        equip(sets.JA.Waltz)
    end
end

function aftercast(spell)
    if player.status=='Engaged' then
        equip(sets.TP[TP_Set_Names[TP_Index]])
    else
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    end
end

function status_change(new,old)
    if T{'Idle','Resting'}:contains(new) then
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    elseif new == 'Engaged' then
        equip(sets.TP[TP_Set_Names[TP_Index]])
    end
end

function buff_change(buff,gain_or_loss)
    if buff=="Sneak Attack" then
        soloSA = gain_or_loss
    elseif buff=="Trick Attack" then
        soloTA = gain_or_loss
    end
end

function self_command(command)
    if command == 'toggle TP set' then
        TP_Index = TP_Index +1
        if TP_Index > #TP_Set_Names then TP_Index = 1 end
        send_command('@input /echo ----- TP Set changed to '..TP_Set_Names[TP_Index]..' -----')
        equip(sets.TP[TP_Set_Names[TP_Index]])
    elseif command == 'toggle Idle set' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #Idle_Set_Names then Idle_Index = 1 end
        send_command('@input /echo ----- Idle Set changed to '..Idle_Set_Names[Idle_Index]..' -----')
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    
    elseif command == 'coffer' then
        cycle = 0
        invCount = windower.ffxi.get_bag_info(0).count
        if invCount == 80 then
            add_to_chat(140,'Inv. full. Ending cycle')
        elseif player.inventory["Velkk Coffer"] then
            send_command('input /item "Velkk Coffer" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No Coffers found in inv.')
            send_command('findall Velkk Coffer')
        end
        if cycle == 1 then
            send_command('wait 2;gs c coffer')
        end
    end
    updateTable()
end