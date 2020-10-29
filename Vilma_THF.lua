require('ClosetCleaner')
include('organizer-lib.lua')
include('organizeritems.lua')

function get_sets()
	send_command('bind f10 gs c toggle TP set')
    TP_Index = 1
    Idle_Index = 1

    sets.weapons = {}
    sets.weapons[1] ={main="Aeneas"}
    sets.weapons[2]={sub="Tauret"}
    sets.weapons[3]={main="Odium"}

    
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
    
    sets.WS = {}
    sets.WS.SA = {}
    sets.WS.TA = {}
    sets.WS.SATA = {}
	
	TaeonHands = {name="Taeon Gloves",augments={'Accuracy+17 Attack+17','"Triple Atk."+2','Crit. hit damage +2%'}}
    
    sets.WS.Evisceration = {head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Mache earring +1",
        body="Pillager's Vest +2",hands="Mummu wrists +2",ring1="Ilabrat Ring",ring2="Mummu Ring",
        back="Toutatis's Cape",waist="Fotia Belt",legs="Pillager's Culottes +1",feet="Mummu Gamashes +2"}
        
    sets.WS.SA.Evisceration = set_combine(sets.WS.Evisceration,{hands="Raider's Armlets +2"})

    sets.WS["Rudra's Storm"] = {
		head="Pillager's Bonnet +2",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Sherida Earring",
        body="Meghanada cuirie +2",hands="Meghanada gloves +2",ring1="Ilabrat Ring",ring2="Thundersoul ring",
        back="Toutatis's Cape",waist="Grunfeld Rope",legs="Lustratio Subligar",feet="Plunderer's Poulaines +1"}
        Ammo="Cath Palug stone"
        
    sets.WS.SA["Rudra's Storm"] = set_combine(sets.WS["Rudra's Storm"],{head="Imperial Wing Hairpin",
		body="Pillager's Vest +2",hands="Raider's Armlets +2",legs="Pillager's Culottes +1", feet="Plunderer's Poulaines +1"})
        
    sets.WS.Exenterator = {head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Sherida Earring",
        body="Pillager's Vest +2",hands="Herculean Gloves",ring1="Ilabrat ring",ring2="Mummu Ring",
        back="Toutatis's Cape",waist="Fotia Belt",legs="Nahtirah Trousers",feet="Mummu gamashes +2"}

    sets.WS.TA.Exenterator = {ear1="Steelflash Earring",ear2="Bladeborn Earring", --head neck ring1
        body="Pillager's Vest +2",ring2="Gere Ring", --hands
        back="Toutatis's Cape",waist="Windbuffet Belt +1",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}
        
    sets.WS.SATA.Exenterator = set_combine(sets.WS.TA.Exenterator, {})

    TP_Set_Names = {"Low Man","Party","Acc","TH","TH Acc"}
    sets.TP = {}
    sets.TP['Low Man'] = {ammo="Yamarang",
        head="Adhemar bonnet +1",neck="Erudition Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Herculean Vest",hands=TaeonHands,ring1="Petrov Ring",ring2="Gere Ring",
        back="Toutatis's Cape",waist="Windbuffet Belt +1",legs="Taeon Tights",feet={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}},} --I think it goes in here and party and acc?
         
	sets.TP['Party'] = {range="Raider's Bmrng.",
        head="Adhemar bonnet +1", neck="Erudition Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Herculean Vest",hands=TaeonHands,ring1="Petrov Ring",ring2="Gere Ring",
        back="Toutatis's Cape",waist="Windbuffet Belt +1",legs="Taeon Tights",feet={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}},}
    
    sets.TP['Acc'] = {ammo="Yamarang",
        head="Meghanada visor +2",neck="Erudition Necklace",ear1="Sherida Earring",ear2="Telos Earring",
        body="Pillager's Vest +2",hands="Meghanada Gloves +2",ring1="Petrov Ring",ring2="Gere Ring",
        back="Toutatis's Cape",waist="Kentarch Belt +1",legs="Pill. Culottes +1",feet={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}},}

	sets.TP['TH'] = set_combine(sets.TP['Low Man'], {
        hands="Plunderer's Armlets +3",
        waist="Chaac Belt"
        })

    sets.TP['TH Acc'] = set_combine(sets.TP['TH'], {
        legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"
        })
        
        
    --sets.TP.Evasion = {
    --  head="Skulker's bonnet +1",neck="Ej Necklace +1",ear1="Novia Earring",ear2="Phawaylla Earring",
    --	body="Qaaxo Harness",hands="Pill. Armlets +1",ring1="Defending Ring",ring2="Epona's Ring",
    --	back="Fugacity Mantle +1",waist="Kasiri Belt",legs="Pill. Culottes +1",feet="Plunderer's Poulaines +1"}
    
    Idle_Set_Names = {'Normal','MDT'}
    sets.Idle = {}
    sets.Idle.Normal = {head="Skulker's bonnet +1",neck="Loricate Torque +1",--ear1="Merman's Earring",ear2="Bladeborn Earring",
        body="Emet Harness +1",hands="Plunderer's Armlets +3",ring1="Dark Ring",ring2="Defending Ring",
        back="Repulse Mantle",waist="Chaac Belt",legs="Ighwa Trousers",feet="Skadi's Jambeaux +1"}
                
    -- sets.Idle.MDT = {head="Skulker's bonnet +1",neck="Twilight Torque",ear1="Merman's Earring",ear2="Bladeborn Earring",
    --     body="Avalon Breastplate",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Dark Ring",
    --     back="Mollusca Mantle",waist="Wanion Belt",legs="Nahtirah Trousers",feet="Skadi's Jambeaux +1"}
	
	organizer_items = organizerItems()
    
end

function precast(spell)
    if sets.JA[spell.english] then
        equip(sets.JA[spell.english])
    elseif spell.type=="WeaponSkill" then
        if sets.WS[spell.english] then equip(sets.WS[spell.english]) end
        if buffactive['sneak attack'] and buffactive['trick attack'] and sets.WS.SATA[spell.english] then equip(sets.WS.SATA[spell.english])
        elseif buffactive['sneak attack'] and sets.WS.SA[spell.english] then equip(sets.WS.SA[spell.english])
        elseif buffactive['trick attack'] and sets.WS.TA[spell.english] then equip(sets.WS.TA[spell.english]) end
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
end