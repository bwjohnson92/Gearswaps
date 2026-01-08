require('closetCleaner')
include('organizer-lib.lua')
include('displayBox/displayBox.lua')

trigger = false
capeLocked = false
weaponLocked = false 

spells = {}
spells.STR = S{'Vertical Cleave', 'Death Scissors', 'Empty Thrash', 'Dimensional Death', 'Quadrastrike', 'Bloodrake'}
spells.STRDEX = S{'Disseverment', 'Hysteric Barrage', 'Frenetic Rip', 'Seedspray', 'Vanity Dive', 'Goblin Rush', 'Paralyzing Triad', 'Thrashing Assault', 'Sinker Drill', 'Saurian Slide'}
spells.STRVIT = S{'Quad. Continuum', 'Delta Thrust', 'Cannonball', 'Glutinous Dart'}
spells.STRMND = S{'Whirl of Rage'}
spells.AGI = S{'Benthic Typhoon', 'Final Sting', 'Spiral Spin'}
spells.INT = S{'Gates of Hades', 'Leafstorm', 'Firespit', 'Acrid Stream', 'Regurgitation', 'Corrosive Ooze', 'Thermal Pulse', 'Magic Hammer', 'Evryone. Grudge', 'Water Bomb', 'Dark Orb', 'Thunderbolt', 'Tem. Upheaval', 'Embalming Earth', 'Foul Waters', 'Rending Deluge', 'Droning Whirlwind', 'Subduction', 'Searing Tempest', 'Blinding Fulgor', 'Spectral Floe', 'Scouring Spate', 'Anvil Lightning', 'Silent Storm', 'Entomb', 'Tenebral Crush', 'Palling Salvo', 'Atramentous Libations', 'Molting Plumage', 'Nectarous Deluge', 'Diffusion Ray'}
spells.MagicAccuracy = S{'Frightful Roar', "Cruel Joke", "Sheep Song", "Dream Flower", 'Feather Tickle', 'Reaving Wind', 'Blank Gaze', 'Geist Wall', 'Infrasonics', 'Barbed Crescent', 'Tourbillion', 'Cimicine Discharge', 'Sub-zero smash', 'Filamented Hold', 'Mind Blast', 'Sandspin', 'Hecatomb Wave', 'Cold Wave', 'Terror Touch'}
spells.Cures = S{'Magic Fruit', 'Plenilune Embrace', 'Wild Carrot', 'Pollen', 'Cure III', 'Cure IV'}
spells.WhiteWind = S{'White Wind'}
spells.Stun = S{'Head Butt', 'Sudden Lunge', 'Blitzstrahl'}
spells.HeavyStrike = S{'Heavy Strike'}
spells.ChargedWhisker = S{'Charged Whisker'}
spells.SkillRecast = S{'MP Drainkiss', 'Digest', 'Blood Saber', 'Blood Drain', 'Osmosis', 'Occultation', 'Magic Barrier', 'Diamondhide', 'Metallic Body', 'Retinal Glare'}
spells.SkillRecast2 = S{'Cocoon', 'Harden Shell', 'Animating Wail', 'Battery Charge', 'Nat. Meditation', 'Carcharian Verve', 'O. Counterstance', 'Barrier Tusk', 'Saline Coat', 'Regeneration', 'Erratic Flutter', 'Mighty Guard'}

Colada={ name="Colada", augments={'"Mag.Atk.Bns."+13','DEX+13','Accuracy+18','DMG:+17',}}
HercHeadMAB={ name="Herculean Helm", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +1%','"Mag.Atk.Bns."+14',}}
HercBodyTP={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}}
HercHandsTP={ name="Herculean Gloves", augments={'Accuracy+18 Attack+18','"Triple Atk."+3','Attack+1',}}
HercLegsTP={ name="Herculean Trousers", augments={'Accuracy+25 Attack+25','"Triple Atk."+2','STR+5',}}
HercLegsMAB={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+20','Weapon skill damage +4%','INT+10',}}
HercFeetMAB={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +4%','STR+7','Mag. Acc.+1','"Mag.Atk.Bns."+5',}}
HercFeetTP={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}}

CapeINT = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}}
CapeDEXTP = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
CapeWS = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

function get_sets()

    send_command('bind f9 gs c toggle TP set')
    send_command('bind f10 gs c toggle Idle set')
    send_command('bind f11 gs c toggle CDC set')
    send_command('bind f12 gs c equip gear')

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

    sets.Weapons = {main="Sequence", sub="Colada",ranged="Naegling",ammo="Kaja Rod"}
    organizer_items = {
        echos="Echo Drops",
        holy="Holy Water",
        RREar="Reraise Earring",
        RRHair="Reraise Hairpin",
        InstRR="Instant Reraise",
        --Puffs="Cream Puffs",
    }

    --Idle Sets--  
    sets.Idle = {}

    sets.Idle.index = {'Standard','DT', "DTMove"}
    Idle_ind = 3

    sets.Idle.Standard = {ammo="Ginsen",
    head="Malignance Chapeau",neck="Loricate Torque +1", ear1="Loquacious earring", ear2="Moonshade earring",
    body="Malignance Tabard",hands="Nyame Gauntlets",ring1="Dark ring",ring2="Defending ring",
    back="Repulse mantle",waist="Fucho-no-obi",legs="Nyame Flanchard",feet="Malignance Boots"}

    sets.Idle.DT = {ammo="Coiste Bodhar",
        head="Nyame Helm",neck="Loricate Torque +1", ear1="Ethereal earring", ear2="Heartseeker earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Dark ring",ring2="Defending ring",
        back="Agema Cape",waist="Flume belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"
    }

    sets.Idle.DTMove = set_combine(sets.Idle.DT, {legs="Carmine Cuisses +1"})
    --TP Sets--
    sets.TP = {}

    sets.TP.index = {'Standard', 'DT',} 
    TP_ind = 2

    sets.TP.Standard = {
        ammo="Coiste Bodhar",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Malignance Boots",
        neck="Lissome Necklace",
        waist="Sailfi Belt +1",
        left_ear="Suppanomimi",
        right_ear="Telos Earring",
        left_ring="Epona's Ring",
        right_ring="Chirich Ring +1",
        back=CapeDEXTP,
    }

    sets.TP.DT = {ammo="Coiste Bodhar",
    head="Malignance Chapeau",neck="Loricate Torque +1", ear1="Telos earring", ear2="Dignitary's earring",
    body="Malignance Tabard",hands="Adhemar Wristbands +1",ring1="Epona's ring",ring2="Murky Ring",
    back=CapeDEXTP,waist="Windbuffet Belt +1",legs=HercLegsTP,feet="Malignance Boots"}

    --Weaponskill Sets--
    sets.WS = {
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade earring",ear2="Ishvara earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Rufescent ring",ring2="Epaminondas's Ring",
        back=CapeWS,waist="Sailfi Belt +1",legs="Nyame Flanchard", feet="Nyame Sollerets",
    }

    sets.WS["Requiescat"] = {ammo="Cheruski needle",
        head="Whirlpool mask",neck="Fotia gorget",ear1="Brutal earring",ear2="Moonshade earring",
        body="Telchine Chasuble",hands="Qaaxo mitaines",ring1="Epona's ring",ring2="Rufescent Ring",
        back=CapeWS,waist="Fotia belt",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"
    }

    sets.WS["Chant Du Cygne"] = {ammo="Jukukik feather",
    head="Dampening Tam",neck="Fotia Gorget",ear1="Brutal earring",ear2="Moonshade earring",
    body=HercBodyTP,hands="Adhemar Wristbands",ring1="Epona's ring",ring2="Apate ring",
    back=CapeWS,waist="Fotia Belt",legs="Samnuha Tights",feet=HercFeetTP}

    sets.WS.ExpSavage = {ammo="Ginsen",
        head="Nyame Helm",neck="Rep. Plat. Medal",ear1="Moonshade earring",ear2="Hashishin earring +1",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Rufescent ring",ring2="Epaminondas's Ring",
        back=CapeWS,waist="Sailfi Belt +1",legs="Nyame Flanchard", feet="Nyame Sollerets",
    }

    sets.WS["Expiacion"] = sets.WS.ExpSavage
    sets.WS["Savage Blade"] = sets.WS.ExpSavage
    sets.WS["Black Halo"] = sets.WS.ExpSavage

    --Blue Magic Sets--
    sets.BlueMagic = {}

    sets.BlueMagic.STR = {ammo="Floestone",
    head="Lilitu Headpiece",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
    body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent Ring",ring2="Rajas ring",
    back=CapeWS,waist="Wanion belt",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.STRDEX = {ammo="Cheruski needle",
    head="Lilitu Headpiece",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
    body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent Ring",ring2="Rajas ring",
    back=CapeWS,waist="Wanion belt",legs="Manibozho brais",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.STRVIT = {ammo="Mavi tathlum",
    head="Lilitu Headpiece",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
    body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent ring",ring2="Spiral ring",
    back=CapeWS,waist="Latria Sash",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.STRMND = {ammo="Mavi tathlum",
    head="Luh. Keffiyeh +1",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
    body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent ring",ring2="Levia. ring",
    back=CapeWS,waist="Latria Sash",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.AGI = {ammo="Mavi tathlum",
    head="Luh. Keffiyeh +1",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
    body="Dread Jupon",hands="Iuitl wristbands",ring1="Apate ring",ring2="Auster's ring",
    back="Cornflower cape",waist="Pipilaka belt",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.INT ={
        ammo="Pemphredo Tathlum",
        head=HercHeadMAB,
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands={ name="Amalric Gages +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        neck="Sanctity Necklace",
        waist="Yamabuki-no-Obi",
        left_ear="Novio Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Metamorph ring +1",
        back=CapeINT,
    }

    sets.BlueMagic.Cures = {ammo="Staunch Tathlum +1",
    head="Nyame Helm",neck="Colossus's Torque",ear1="Loquac. earring",ear2="Beatific earring",
    body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Menelaus's ring",ring2="Janniston ring +1",
    back="Swith Cape cape",waist="Bishop's Sash",legs="Carmine cuisses +1",feet="Skaoi Boots"}

    sets.BlueMagic.SelfCures = {ammo="Staunch Tathlum +1",
    head="Nyame Helm",neck="Colossus's Torque",ear1="Loquac. earring",ear2="Beatific earring",
    body="Vrikodara Jupon",hands="Telchine Gloves Gloves",ring1="Menelaus's ring",ring2="Janniston Ring +1",
    back="Swith Cape",waist="Bishop's Sash",legs="Carmine cuisses +1",feet="Skaoi Boots"}

    sets.BlueMagic.Stun = {ammo="Mavi tathlum",
    head="Assim. keffiyeh",neck="Sanctity necklace",ear1="Loquac. earring",
    body="Assim. jubbah +1",hands="Mv. bazubands +2",ring1="Prolix ring",ring2="Sangoma ring",
    back="Cornflower cape",waist="Twilight belt",legs="Mavi tayt +2",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.HeavyStrike = set_combine(sets.BlueMagic.STR, {})

    sets.BlueMagic.ChargedWhisker = set_combine(sets.BlueMagic.INT, {}) 

    sets.BlueMagic.WhiteWind = {ammo="Egoist's Tathlum",
    head="Nyame Helm",neck="Sanctity necklace",ear1="Etiolation earring",ear2="Eabani Earring",
    body="Nyame mail",hands="Nyame gauntlets",ring1="Etana ring",ring2="Gelatinous ring +1",
    back="Reiki cloak",waist="Lieutenant's sash",legs="Nyame flanchard",feet="Nyame sollerets"}

    sets.BlueMagic.MagicAccuracy = {ammo="Pemphredo Tathlum",
    head="Malignance Chapeau",neck="Sanctity necklace",ear1="Dignitary's earring",ear2="Crepuscular earring",
    body="Malignance Tabard",hands="Jhakri Cuffs +2",ring1="Stikini ring",ring2="Metamorph ring +1",
    back=CapeINT,waist="Sacro Cord",legs="Ayanmo Cosciales +2",feet="Malignance Boots"}

    sets.BlueMagic.Skill = {ammo="Mavi tathlum",
    head="Luh. Keffiyeh +1",neck="Jeweled collar",ear1="Loquac. earring",
    body="Assim. jubbah +1",hands="Rawhide Gloves",ring1="Prolix ring",
    back="Cornflower cape",waist="Twilight belt",legs="Mavi tayt +2",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.SkillRecast = {ammo="Mavi tathlum",
    head="Luh. Keffiyeh +1",neck="Jeweled collar",ear1="Loquac. earring",
    body="Assim. jubbah +1",hands="Mv. Bazubands +2",ring1="Prolix ring",
    back="Swith cape",waist="Twilight belt",legs="Mavi tayt +2",feet="Luhlaza charuqs +1"}

    sets.WS.SanguineBlade = set_combine(sets.BlueMagic.INT, {})
                
    --Utility Sets--
    sets.Utility = {}

    sets.Utility.PDT = {head="Whirlpool mask",neck="Loricate Torque +1",ear1="Ethereal earring",
    body="Iuitl vest",hands="Umuthi gloves",ring1="Dark ring",ring2="Dark ring",
    back="Mollusca mantle",waist="Flume belt +1",legs="Iuitl Tights +1",feet="Iuitl gaiters"}

    sets.Utility.MDT = {head="Whirlpool mask",neck="Loricate Torque +1",
    body="Assim. jubbah +1",hands="Umuthi gloves",ring1="Dark ring",ring2="Dark ring",
    back="Mollusca mantle",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}


    --Job Ability Sets--

    sets.JA = {}

    sets.JA.ChainAffinity = {feet="Assim. charuqs +1"}

    sets.JA.BurstAffinity = {feet="Mavi Basmak +2"}

    sets.JA.Efflux = {legs="Mavi tayt +2"}

    sets.JA.AzureLore = {hands="Luh. bazubands +1"}

    sets.JA.Diffusion = {feet="Luhlaza Charuqs +1"}

    --Precast Sets--
    sets.precast = {}

    sets.precast.FC = {}

    sets.precast.FC.Standard = 
    {head="Herculean Helm", neck="Voltsurge Torque", ear1="Loquac. Earring", ear2="Etiolation Earring", 
    body="Dread Jupon",hands="Leyline Gloves", ring1="Prolix Ring",ring2="Kishar Ring",
    back="Swith Cape",waist="Witful Belt",legs="Psycloth lappas",feet="Amalric Nails +1"}

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
    addToTable("(F10) Idle Set", sets.Idle.index[Idle_ind])
    update_message()
end

function precast(spell)
    if spell.action_type == 'Magic' then
        equip(sets.precast.FC.Standard)
    end

    if spell.english == 'Azure Lore' then
        equip(sets.JA.AzureLore)
    end

    if spell.type:lower() == 'weaponskill' then
        if (sets.WS[spell.english]) then
            equip(sets.WS[spell.english])
        else
            equip(sets.WS)
        end
    end

    if spell.english == 'Box Step' then
        equip(sets.Utility.Steps)
    end
end

function midcast(spell,act)

    if spells.STR:contains(spell.name) then
        equip(sets.BlueMagic.STR)
        if buffactive['Chain Affinity'] then
            equip(sets.JA.ChainAffinity)
        end
        if buffactive['Efflux'] then
            equip(sets.JA.Efflux)
        end
    end

    if spells.STRDEX:contains(spell.name) then
        equip(sets.BlueMagic.STRDEX)
        if buffactive['Chain Affinity'] then
            equip(sets.JA.ChainAffinity)
        end
        if buffactive['Efflux'] then
            equip(sets.JA.Efflux)
        end
    end

    if spells.STRVIT:contains(spell.name) then
        equip(sets.BlueMagic.STRVIT)
        if buffactive['Chain Affinity'] then
            equip(sets.JA.ChainAffinity)
        end
        if buffactive['Efflux'] then
            equip(sets.JA.Efflux)
        end
    end

    if spells.STRMND:contains(spell.name) then
        equip(sets.BlueMagic.STRMND)
        if buffactive['Chain Affinity'] then
            equip(sets.JA.ChainAffinity)
        end
        if buffactive['Efflux'] then
            equip(sets.JA.Efflux)
        end
    end

    if spells.AGI:contains(spell.name) then
        equip(sets.BlueMagic.AGI)
        if buffactive['Chain Affinity'] then
            equip(sets.JA.ChainAffinity)
        end
        if buffactive['Efflux'] then
            equip(sets.JA.Efflux)
        end
    end

    if spells.INT:contains(spell.name) then
        equip(sets.BlueMagic.INT)
        if buffactive['Burst Affinity'] then
            equip(sets.JA.BurstAffinity)
        end
    end

    if spells.Cures:contains(spell.name) then
        equip(sets.BlueMagic.Cures)
        if spell.target.name == player.name then
            equip(sets.BlueMagic.SelfCures)
        end
    end

    if spells.WhiteWind:contains(spell.name) then
        equip(sets.BlueMagic.WhiteWind)
    end

    if spells.Stun:contains(spell.name) then
        equip(sets.BlueMagic.Stun)
    end

    if spells.HeavyStrike:contains(spell.name) then
        equip(sets.BlueMagic.HeavyStrike)
    end

    if spells.ChargedWhisker:contains(spell.name) then
        equip(sets.BlueMagic.ChargedWhisker)
        if buffactive['Burst Affinity'] then
            equip(sets.JA.BurstAffinity)
        end
    end

    if spells.MagicAccuracy:contains(spell.name) then
        equip(sets.BlueMagic.MagicAccuracy)
    end

    if spells.SkillRecast:contains(spell.name) then
        equip(sets.BlueMagic.SkillRecast)
        if buffactive['Diffusion'] then
            equip(sets.JA.Diffusion)
        end
    end

    if spells.SkillRecast2:contains(spell.name) then
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

    if spell.type:lower() == 'weaponskill' then
        add_to_chat(140,'TP Return: ['..tostring(player.tp)..']')
    end
end

function equip_current()
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
    elseif command == 'equip TP set' then
        equip(sets.TP[sets.TP.index[TP_ind]])
    elseif command == 'equip Idle set' then
        equip(sets.Idle[sets.Idle.index[Idle_ind]])
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
    equip_current()
    updateTable()
end
