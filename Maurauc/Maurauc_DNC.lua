require('closetCleaner')
include('organizer-lib.lua')
include('displayBox/displayBox.lua')

trigger = false
capeLocked = false
weaponLocked = false

function get_sets()
    send_command('alias mf magicfruit')
    send_command('alias ww whitewind')
    send_command('alias wop windsofpromy')
    send_command('bind f9 gs c toggle TP set')
    send_command('bind f10 gs c toggle Idle set')
    send_command('bind f11 gs c toggle CDC set')
    send_command('bind f12 gs c toggle Req set')
    --send_command('bind !f12 gs c toggle Rea set')
   
   --send_command('bind !f11 gs c lock gear')
   
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

    HercGlovesTA = { name="Herculean Gloves", augments={'Accuracy+19','"Triple Atk."+4','STR+3',}}

    HercLegsAcc = {name="Herculean Trousers", augments={'Accuracy+20 Attack+20','"Dual Wield"+3','Accuracy+15',}}
    HercLegsTA = { name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+4','DEX+3','Attack+13',}}

    HercBootsWS = { name="Herculean Boots", augments={'Accuracy+1','Pet: DEX+4','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
    HercBootsTA = { name="Herculean Boots", augments={'"Triple Atk."+4','DEX+4','Accuracy+8','Attack+13',}}

    DEXCape = { name="Senuna's Mantle" }
    STRCape = { name="Senuna's Mantle" }
    INTCape = { name="Senuna's Mantle" }
    
    organizer_items = { main="Echo Drops", ranged="Sublime Sushi",
        body="Trizek Ring", ear1="Reraise Earring",
        pizza="Marinara Slice",
        ring1="Warp Ring",ring2="Capacity Ring", ear2="Echad Ring",
        back="Mecistopins Mantle"}
    --Idle Sets--   
    sets.Idle = {}
    
    -- sets.Reive = {neck="Arciela's Grace +1"}
   
    sets.Idle.index = {'Standard','DT'}
    Idle_ind = 1                   
   
    sets.Idle.Standard = {ammo="Ginsen",
      head="Malignance Chapeau",neck="Loricate Torque +1", ear1="Loquacious earring", ear2="Moonshade earring",
      body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
      back=DEXCape,waist="Fucho-no-obi",legs="Carmine Cuisses +1",feet="Malignance Boots"}
                                             
    sets.Idle.DT = {
        ammo="Staunch Tathlum +1",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Ayanmo Manopolas +2",
        -- legs="Aya. Cosciales +2",
        legs="Carmine Cuisses +1",
        feet="Malignance Boots",
        waist="Flume Belt +1",
        neck="Loricate Torque +1",
        left_ear="Novia Earring",
        right_ear="Telos Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Defending Ring",
        back=INTCape,
    }
   
    --TP Sets--
    sets.TP = {}

    sets.TP.index = {'Standard', 'Hybrid', 'Accuracy',} --'Safe', 'AccuracyLite', 'AccuracyFull', 'AccuracyExtreme', 'DT', 'DTAccuracy'}
    --1=Standard, 2=Solo, 3=Marches, 4=AccuracyLite, 5=AccuracyFull, 6=DT, 7=DTAccuracy--
    TP_ind = 1
   
    sets.TP.Standard = {
        ammo="Charis Feather",
        head={ name="Adhemar Bonnet +1"},
        -- body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4',}},
        body="Adhemar Jacket +1",
        -- hands={ name="Herculean Gloves", augments={'Accuracy+19','"Triple Atk."+4','STR+3',}},
        hands="Adhemar Wristbands +1",
        -- legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+4','DEX+3','Attack+13',}},
        legs="Adhemar Kecks +1",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','DEX+4','Accuracy+8','Attack+13',}},
        -- neck="Asperity Necklace",
        -- neck="Mirage Stole +1",
        neck="Etoile Gorget",
        waist="Windbuffet Belt +1",
        -- waist="Reiki Yotai",
        left_ear="Cessance Earring",
        right_ear="Telos Earring",
        left_ring="Epona's Ring",
        right_ring="Hetairoi Ring",
        back="Senuna's Mantle",
    }

    sets.TP.Hybrid = set_combine(sets.TP.Standard, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        feet="Malignance Boots"
        })

    sets.TP.Accuracy = set_combine(sets.TP.Hybrid, {ammo="Ginsen",
        head="Malignance Chapeau",
        neck="Sanctity Necklace", ear1="Dignitary's earring", ear2="Telos earring",
        -- ring1="Cacoethic ring",
        ring2="Patricius Ring",
        -- back=DEXCape,
        waist="Olseni Belt", feet=HercBootsAcc})
  
        sets.WS = {}

    sets.WS.ExpSavage = {
        ammo="Floestone",
        head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Assimilator's Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ilabrat Ring",ring2="Metamorph Ring +1",
        back="Senuna's Mantle",waist="Fotia Belt",legs="Luhlaza Shalwar +3",feet="Jhakri Pigaches +2"
    }

    sets.WS.RudrasStorm = {
        ammo="Charis Feather",
        head="Mummu Bonnet +2",neck="Etoile Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Regal Ring",ring2="Mummu Ring",
        back=STRCape,waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamashes +2"
    }

    sets.WS.Evisceration = {
        ammo="Charis Feather",
        head="Adhemar Bonnet +1",neck="Etoile Gorget",ear1="Sherida Earring",ear2="Brutal Earring",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Regal Ring",ring2="Mummu Ring",
        back=STRCape,waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamashes +2"
    }

    --Utility Sets--
    sets.Utility = {}
                                                    

    --Job Ability Sets--
   
    sets.JA = {}
   
    sets.JA.ChainAffinity = {feet="Assim. charuqs +1"}
   
    --sets.JA.BurstAffinity = {feet="Mavi Basmak +2"}
   
   -- sets.JA.Efflux = {legs="Mavi tayt +2"}
   
    --sets.JA.AzureLore = {hands="Luh. bazubands +1"}
   
    sets.JA.Diffusion = {feet="Luhlaza Charuqs +1"}
                   
    --Precast Sets--
    sets.precast = {}
   
    sets.precast.FC = {}
   
    sets.precast.FC.Standard = 
    {
        head="Carmine Mask", neck="Voltsurge Torque", ear1="Loquac. Earring", ear2="Etiolation Earring", 
        body="Dread Jupon",hands="Leyline Gloves",ring1="Weatherspoon Ring +1", ring2="Kishar Ring",
        back="Swith Cape",
        waist="Witful Belt",
        legs="Psycloth Lappas",feet="Carmine Greaves"
    }
   
    sets.precast.FC.PDT = {}

    sets.precast.FC.Acc = {}

    sets.precast.FC.PDTAcc = {}
       
    text_setup()
    
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("PDT", "yellow")
end

function updateTable()
    addToTable("(F9) TP Set", sets.TP.index[TP_ind])
    -- addToTable("Enfeeble Potency", not EnfeebSet)
    addToTable("(F10) Idle Set", sets.Idle.index[Idle_ind])
    addToTable("(F11) CDC Set", sets.ChantDuCygne.index[ChantDuCygne_ind])
    addToTable("(F12) Req Set", sets.Requiescat.index[Requiescat_ind])
    addToTable("(END) Weapon Locked", weaponLocked)
    update_message()
end

function precast(spell)
        if spell.action_type == 'Magic' then
                equip(sets.precast.FC.Standard)
        end
       
        if spell.english == 'Azure Lore' then
                equip(sets.JA.AzureLore)
        end
       
        if spell.english == 'Requiescat' then
                equip(sets.Requiescat[sets.Requiescat.index[Requiescat_ind]])
        end
       
        if spell.english == 'Chant du Cygne' then
                equip(sets.ChantDuCygne[sets.ChantDuCygne.index[ChantDuCygne_ind]])
        end
       
        if spell.english == 'Circle Blade' then
                equip(sets.WS.CircleBlade)
        end
               
        if spell.english == 'Expiacion' or spell.english == 'Savage Blade' then
                equip(sets.WS.ExpSavage)
        end
       
        if spell.english == 'Sanguine Blade' then
                equip(sets.WS.SanguineBlade)
        end
       
        if spell.english == 'Box Step' then
                equip(sets.Utility.Steps)
        end
       
        if spell.english == 'Realmrazer' then
                equip(sets.Realmrazer[sets.Realmrazer.index[Realmrazer_ind]])
        end
       
        if spell.english == 'Flash Nova' then
                equip(sets.WS.FlashNova)
        end

        if spell.english == 'Rudra\'s Storm' then
                equip(sets.WS.RudrasStorm)
        elseif spell.english == 'Evisceration' then
                equip(sets.WS.Evisceration)
        else
            equip(sets.WS.Evisceration)
        end

end
       
function midcast(spell,act)
        if spell.english == 'Vertical Cleave' or spell.english == 'Death Scissors' or spell.english == 'Empty Thrash' or spell.english == 'Dimensional Death' or spell.english == 'Quadrastrike' or spell.english == 'Bloodrake' then
                equip(sets.BlueMagic.STR)
                if buffactive['Chain Affinity'] then
                        equip(sets.JA.ChainAffinity)
                end
                if buffactive['Efflux'] then
                        equip(sets.JA.Efflux)
                end
        end
               
        if spell.english == 'Disseverment' or spell.english == 'Hysteric Barrage' or spell.english == 'Frenetic Rip' or spell.english == 'Seedspray' or spell.english == 'Vanity Dive' or spell.english == 'Goblin Rush' or spell.english == 'Paralyzing Triad' or spell.english == 'Thrashing Assault' or spell.english == 'Sinker Drill' or spell.english == 'Saurian Slide' then
                equip(sets.BlueMagic.STRDEX)
                if buffactive['Chain Affinity'] then
                        equip(sets.JA.ChainAffinity)
                end
                if buffactive['Efflux'] then
                        equip(sets.JA.Efflux)
                end
        end
       
        if spell.english == 'Quad. Continuum' or spell.english == 'Delta Thrust' or spell.english == 'Cannonball' or spell.english == 'Glutinous Dart' then
                equip(sets.BlueMagic.STRVIT)
                if buffactive['Chain Affinity'] then
                        equip(sets.JA.ChainAffinity)
                end
                if buffactive['Efflux'] then
                        equip(sets.JA.Efflux)
                end
        end
       
        if spell.english == 'Whirl of Rage' then
                equip(sets.BlueMagic.STRMND)
                if buffactive['Chain Affinity'] then
                        equip(sets.JA.ChainAffinity)
                end
                if buffactive['Efflux'] then
                        equip(sets.JA.Efflux)
                end
        end
       
        if spell.english == 'Benthic Typhoon' or spell.english == 'Final Sting' or spell.english == 'Spiral Spin' then
                equip(sets.BlueMagic.AGI)
                if buffactive['Chain Affinity'] then
                        equip(sets.JA.ChainAffinity)
                end
                if buffactive['Efflux'] then
                        equip(sets.JA.Efflux)
                end
        end
       
        if spell.english == 'Gates of Hades' or spell.english == 'Leafstorm' or spell.english == 'Firespit' or spell.english == 'Acrid Stream' or spell.english == 'Regurgitation' or spell.english == 'Corrosive Ooze' or spell.english == 'Thermal Pulse' or spell.english == 'Magic Hammer' or spell.english == 'Evryone. Grudge' or spell.english == 'Water Bomb' or spell.english == 'Dark Orb' or spell.english == 'Thunderbolt' or spell.english == 'Tem. Upheaval' or spell.english == 'Embalming Earth' or spell.english == 'Foul Waters' or spell.english == 'Rending Deluge' or spell.english == 'Droning Whirlwind' or spell.english == 'Subduction' or spell.english == 'Searing Tempest' or spell.english == 'Blinding Fulgor' or spell.english == 'Spectral Floe' or spell.english == 'Scouring Spate' or spell.english == 'Anvil Lightning' or spell.english == 'Silent Storm' or spell.english == 'Entomb' or spell.english == 'Tenebral Crush' or spell.english == 'Palling Salvo' or spell.english == 'Atramentous Libations' or spell.english == 'Molting Plumage' or spell.english == 'Nectarous Deluge' or spell.english == 'Diffusion Ray' then
                equip(sets.BlueMagic.INT)
                if buffactive['Burst Affinity'] then
                        equip(sets.JA.BurstAffinity)
                end
        end
       
        if spell.english == 'Magic Fruit' or spell.english == 'Plenilune Embrace' or spell.english == 'Wild Carrot' or spell.english == 'Pollen' or spell.english == 'Cure III' or spell.english == 'Cure IV' then
                equip(sets.BlueMagic.Cures)
                        if spell.target.name == player.name and string.find(spell.english, 'Magic Fruit') or string.find(spell.english, 'Plenilune Embrace') or string.find(spell.english, 'Wild Carrot') or string.find(spell.english, 'Cure III') or string.find(spell.english, 'Cure IV') then
                                equip(sets.BlueMagic.SelfCures)
                        end
        end
       
        if spell.english == 'White Wind' then
                equip(sets.BlueMagic.WhiteWind)
        end
       
        if spell.english == 'Head Butt' or spell.english == 'Sudden Lunge' or spell.english == 'Blitzstrahl' then
                equip(sets.BlueMagic.Stun)
        end
       
        if spell.english == 'Heavy Strike' then
                equip(sets.BlueMagic.HeavyStrike)
        end
       
        if spell.english == 'Charged Whisker' then
                equip(sets.BlueMagic.ChargedWhisker)
                if buffactive['Burst Affinity'] then
                        equip(sets.JA.BurstAffinity)
                end
        end
       
        if spell.english == 'Frightful Roar' or spell.english == "Sheep Song" or spell.english == "Dream Flower" or spell.english == 'Feather Tickle' or spell.english == 'Reaving Wind' or spell.english == 'Blank Gaze' or spell.enligh == 'Geist Wall' or spell.english == 'Infrasonics' or spell.english == 'Barbed Crescent' or spell.english == 'Tourbillion' or spell.english == 'Cimicine Discharge' or spell.english == 'Sub-zero smash' or spell.english == 'Filamented Hold' or spell.english == 'Mind Blast' or spell.english == 'Sandspin' or spell.english == 'Hecatomb Wave' or spell.english == 'Cold Wave' or spell.english == 'Terror Touch' then
                equip(sets.BlueMagic.MagicAccuracy)
        end
       
        if spell.english == 'MP Drainkiss' or spell.english == 'Digest' or spell.english == 'Blood Saber' or spell.english == 'Blood Drain' or spell.english == 'Osmosis' or spell.english == 'Occultation' or spell.english == 'Magic Barrier' or spell.english == 'Diamondhide' or spell.english == 'Metallic Body' or spell.english == 'Retinal Glare' then
                equip(sets.BlueMagic.SkillRecast)
                if buffactive['Diffusion'] then
                        equip(sets.JA.Diffusion)
                end
        end
       
        if spell.english == 'Cocoon' or spell.english == 'Harden Shell' or spell.english == 'Animating Wail' or spell.english == 'Battery Charge' or spell.english == 'Nat. Meditation' or spell.english == 'Carcharian Verve' or spell.english == 'O. Counterstance' or spell.english == 'Barrier Tusk' or spell.english == 'Saline Coat' or spell.english == 'Regeneration' or spell.english == 'Erratic Flutter' or spell.english == 'Mighty Guard' then
                if (spell.english == 'Battery Charge') then
                    equip(sets.BlueMagic.BatteryCharge)
                end
                if buffactive['Diffusion'] then
                        equip(sets.JA.Diffusion)
                end
                if (spell.english == "Carcharian Verve") then
                    equip({head="Amalric Coif +1"})
                end

        end

        if spell.english == "Phalanx" then
            equip(sets.Utility.Phalanx)
        end
end
 
function aftercast(spell)
    if (spell.name == "Phalanx") then
        equip(set_combine(sets.Idle[sets.Idle.index[Idle_ind]]))
    elseif player.status == 'Engaged' then
            equip(sets.TP[sets.TP.index[TP_ind]])
    else
            equip(sets.Idle[sets.Idle.index[Idle_ind]])
    end
   
    if spell.action_type == 'Weaponskill' then
            add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
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
    if command == 'toggle TP set' then
            TP_ind = TP_ind +1
            if TP_ind > #sets.TP.index then TP_ind = 1 end
            send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
            equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'toggle Idle set' then
            Idle_ind = Idle_ind +1
            if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
            send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
            equip(sets.Idle[sets.Idle.index[Idle_ind]])
    elseif command == 'toggle Req set' then
            Requiescat_ind = Requiescat_ind +1
            if Requiescat_ind > #sets.Requiescat.index then Requiescat_ind = 1 end
            send_command('@input /echo <----- Requiescat Set changed to '..sets.Requiescat.index[Requiescat_ind]..' ----->')
    elseif command == 'toggle CDC set' then
            ChantDuCygne_ind = ChantDuCygne_ind +1
            if ChantDuCygne_ind > #sets.ChantDuCygne.index then ChantDuCygne_ind = 1 end
            send_command('@input /echo <----- Chant du Cygne Set changed to '..sets.ChantDuCygne.index[ChantDuCygne_ind]..' ----->')
    elseif command == 'toggle Rea set' then
            Realmrazer_ind = Realmrazer_ind +1
            if Realmrazer_ind > #sets.Realmrazer.index then Realmrazer_ind = 1 end
            send_command('@input /echo <----- Realmrazer Set changed to '..sets.Realmrazer.index[Realmrazer_ind]..' ----->')
    elseif command == 'equip TP set' then
            equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'equip Idle set' then
            equip(sets.Idle[sets.Idle.index[Idle_ind]])
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
    elseif command == 'pouch' then
        cycle = 0
        if player.inventory["Silt Pouch"] then
            send_command('input /item "Silt Pouch" <me> ')
            cycle = 1
        elseif player.inventory["Bead Pouch"] then
            send_command('input /item "Bead Pouch" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No pouches found in inv.')
            send_command('findall Silt Pouch')
            send_command('findall Bead Pouch')
        end
        if cycle == 1 then
            send_command('wait 3; gs c pouch')
        end
    elseif command == 'bpouch' then
        cycle = 0
        invCount = windower.ffxi.get_bag_info(0).count
        if invCount == 80 then
            add_to_chat(140,'Inv. full. Ending cycle')
        elseif player.inventory["Bead Pouch"] then
            send_command('input /item "Bead Pouch" <me> ')
            cycle = 1
        else
            add_to_chat(140,'No Coffers found in inv.')
            send_command('findall Bead Pouch')
        end
        if cycle == 1 then
            send_command('wait 3;gs c bpouch')
        end 
    elseif command == 'lockCape' then
        if capeLocked == false then
            capeLocked = true
            equip({back="Mecistopins Mantle"})
            disable("back")
            add_to_chat(140,'Back is being locked')
        else
            capeLocked = false
            enable("back")
            add_to_chat(140,'Back is being unlocked')
        end
    elseif command == 'lockWeapon' then
        if weaponLocked == false then
            weaponLocked = true
            --equip{{back="Mecistopins Mantle"}}
            disable("Main")
            disable("Sub")
            add_to_chat(140,'Weapon is being locked')
        else
            weaponLocked = false
            enable("Main")
            enable("Sub")
            add_to_chat(140,'Weapon is being unlocked')
        end
    end
    updateTable()
end

function buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Reive Mark" and gain then
        equip(sets.Reive)
        disable("neck")
    elseif buff == "Reive Mark" and not gain then
        enable("neck")
    end
end


function lock_gear()
    
end
    
    
    