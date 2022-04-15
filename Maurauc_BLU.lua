require('closetCleaner')
include('organizer-lib.lua')
include('displayBox.lua')

trigger = false
capeLocked = false
weaponLocked = false

spells = {}
spells.STR = S{'Vertical Cleave', 'Death Scissors', 'Empty Thrash', 'Dimensional Death', 'Quadrastrike', 'Bloodrake'}
spells.STRDEX = S{'Disseverment', 'Hysteric Barrage', 'Frenetic Rip', 'Seedspray', 'Vanity Dive', 'Goblin Rush', 'Paralyzing Triad', 'Thrashing Assault', 'Sinker Drill', 'Saurian Slide'}
spells.STRVIT = S{'Quad. Continuum', 'Delta Thrust', 'Cannonball', 'Glutinous Dart'}
spells.STRMND = S{'Whirl of Rage'}
spells.AGI = S{'Benthic Typhoon', 'Final Sting', 'Spiral Spin'}
spells.INT = S{'Gates of Hades', 'Leafstorm', 'Firespit', 'Acrid Stream', 'Regurgitation', 'Corrosive Ooze', 'Thermal Pulse', 'Magic Hammer', 'Evryone. Grudge', 'Water Bomb', 'Dark Orb', 'Thunderbolt', 'Tem. Upheaval', 'Embalming Earth', 'Foul Waters', 'Rending Deluge', 'Droning Whirlwind', 'Subduction', 'Searing Tempest', 'Blinding Fulgor', 'Spectral Floe', 'Scouring Spate', 'Anvil Lightning', 'Entomb', 'Tenebral Crush', 'Palling Salvo', 'Atramentous Libations', 'Molting Plumage', 'Nectarous Deluge', 'Diffusion Ray'}
spells.MagicAccuracy = S{ 'Mortal Ray','Silent Storm', 'Frightful Roar', "Cruel Joke", "Sheep Song", "Dream Flower", 'Blank Gaze', 'Geist Wall', 'Infrasonics', 'Barbed Crescent', 'Tourbillion', 'Cimicine Discharge', 'Sub-zero smash', 'Filamented Hold', 'Mind Blast', 'Sandspin', 'Hecatomb Wave', 'Cold Wave', 'Terror Touch'}
spells.MagicAccuracyFast = S{ 'Feather Tickle', 'Reaving Wind' }
spells.Cures = S{'Magic Fruit', 'Plenilune Embrace', 'Wild Carrot', 'Pollen', 'Cure III', 'Cure IV'}
spells.WhiteWind = S{'White Wind'}
spells.Stun = S{'Head Butt', 'Sudden Lunge', 'Blitzstrahl'}
spells.HeavyStrike = S{'Heavy Strike'}
spells.ChargedWhisker = S{'Charged Whisker'}
spells.SkillRecast = S{'MP Drainkiss', 'Digest', 'Blood Saber', 'Blood Drain', 'Osmosis', 'Occultation', 'Magic Barrier', 'Diamondhide', 'Metallic Body', 'Retinal Glare'}
spells.SkillRecast2 = S{'Cocoon', 'Harden Shell', 'Animating Wail', 'Battery Charge', 'Nat. Meditation', 'Carcharian Verve', 'O. Counterstance', 'Barrier Tusk', 'Saline Coat', 'Regeneration', 'Erratic Flutter', 'Mighty Guard'}

function get_sets()
    send_command('alias mf magicfruit')
    send_command('alias ww whitewind')
    send_command('alias wop windsofpromy')
    send_command('bind f9 gs c toggle TP set')
    send_command('bind f10 gs c toggle Idle set')
    send_command('bind f11 gs c toggle main weapon')
    send_command('bind f12 gs c toggle sub weapon')
    send_command('bind ^f12 gs c equip current')
    send_command('bind end send @others input "/follow Maurauc"')
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

    -- HercBootsAcc = "Jhakri Pigaches +2"
    HercBootsWS = { name="Herculean Boots", augments={'Accuracy+1','Pet: DEX+4','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
    HercBootsTA = { name="Herculean Boots", augments={'"Triple Atk."+4','DEX+4','Accuracy+8','Attack+13',}}

    DEXCape = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}
    STRCape = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    INTCape = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
    
    organizer_items = { main="Echo Drops", ranged="Sublime Sushi",
        grape="Grape Daifuku", rolanberry="Rolanberry Daifuku"
    }

    sets.Weapons = {}
    sets.Weapons.Main = {}
    sets.Weapons.Offhand = {}

    Weapon_ind = 1
	sets.Weapons.index = { "Tizona", "Naegling", "Bunzi's Rod", "Maxentius"}

    WeaponOff_ind = 1
    sets.Weapons.Offhand.index = { "Machaera +2", "Bunzi's Rod", "Maxentius"}


    --Idle Sets--   
    sets.Idle = {}
    
    -- sets.Reive = {neck="Arciela's Grace +1"}

    sets.Idle.index = {'Standard','DT', 'Evasion'}
    Idle_ind = 2                   

    sets.Idle.Standard = {ammo="Coiste Bodhar",
        head="Malignance Chapeau",neck="Loricate Torque +1", ear1="Loquacious earring", ear2="Moonshade earring",
        body="Jhakri Robe +2",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back=DEXCape,waist="Fucho-no-obi",legs="Carmine Cuisses +1",feet="Malignance Boots"
    }

    sets.Idle.DT = {
        ammo="Staunch Tathlum +1",
        -- head="Malignance Chapeau",
        head="Nyame Helm",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        -- legs="Aya. Cosciales +2",
        legs="Carmine Cuisses +1",
        -- feet="Malignance Boots",
        feet="Nyame Sollerets",
        waist="Flume Belt +1",
        neck="Loricate Torque +1",
        left_ear="Novia Earring",
        right_ear="Telos Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Defending Ring",
        back=DEXCape,
    }

    sets.Idle.Evasion = set_combine(sets.Idle.DT, {
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        
    })

    --TP Sets--
    sets.TP = {}

    sets.TP.index = {'Standard', 'Hybrid', 'Accuracy', 'Subtle Blow'} --'Safe', 'AccuracyLite', 'AccuracyFull', 'AccuracyExtreme', 'DT', 'DTAccuracy'}
    --1=Standard, 2=Solo, 3=Marches, 4=AccuracyLite, 5=AccuracyFull, 6=DT, 7=DTAccuracy--
    TP_ind = 2

    sets.TP.Standard = {
        ammo="Coiste Bodhar",
        head={ name="Adhemar Bonnet +1"},
        -- body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4',}},
        body="Adhemar Jacket +1",
        -- hands={ name="Herculean Gloves", augments={'Accuracy+19','"Triple Atk."+4','STR+3',}},
        hands="Adhemar Wristbands +1",
        -- legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+4','DEX+3','Attack+13',}},
        -- legs="Adhemar Kecks +1",
        legs="Malignance Tights",
        feet={ name="Herculean Boots", augments={'"Triple Atk."+4','DEX+4','Accuracy+8','Attack+13',}},
        -- neck="Asperity Necklace",
        neck="Mirage Stole +1",
        waist="Windbuffet Belt +1",
        -- waist="Reiki Yotai",
        left_ear="Cessance Earring",
        right_ear="Telos Earring",
        left_ring="Epona's Ring",
        right_ring="Hetairoi Ring",
        back=DEXCape,
    }

    sets.TP.Hybrid = set_combine(sets.TP.Standard, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        ring1="Defending Ring"
    })

    sets.TP.Accuracy = set_combine(sets.TP.Hybrid, {ammo="Coiste Bodhar",
        head="Malignance Chapeau",
        neck="Sanctity Necklace", ear1="Dignitary's earring", ear2="Telos earring",
        -- ring1="Cacoethic ring",
        ring2="Patricius Ring",
        back=DEXCape,
        waist="Olseni Belt"})

        sets.TP["Subtle Blow"] = set_combine(sets.TP.Hybrid, {
            left_ear="Dignitary's Earring",
            ring1="Chirich Ring +1",
            ring2="Chirich Ring +1"
        })

    --Weaponskill Sets--
    sets.WS = {}
    sets.WS.CircleBlade = {}

    sets.Requiescat = {}

    sets.Requiescat.index = {'Attack'}
    Requiescat_ind = 1

    sets.Requiescat.Attack = {ammo="Floestone",
        head="Carmine Mask",neck="Fotia gorget",ear1="Brutal earring",ear2="Moonshade earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Epona's ring",ring2="Rufescent Ring",
    back="Rosmerta's Cape",waist="Fotia belt",legs="Carmine Cuisses +1",feet="Luhlaza charuqs +1"}

    sets.ChantDuCygne = {}

    sets.ChantDuCygne.index = {'Attack','Accuracy'}
    ChantDuCygne_ind = 1

    sets.ChantDuCygne.Attack = {ammo="Jukukik feather",
        head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade earring",ear2="Ishvara earring",
        body="Assimilator's Jubbah +3",hands="Adhemar Wristbands +1",ring1="Epona's ring",ring2="Begrudging ring",
        back=DEXCape,
    waist="Fotia Belt",legs="Luhlaza Shalwar +3",feet="Thereoid Greaves"}

    sets.ChantDuCygne.Accuracy = set_combine(sets.ChantDuCygne.Attack, {
        waist="Olseni Belt"
    })


    sets.WS.ExpSavage = {
        ammo="Floestone",
        head="Nyame Helm",neck="Mirage Stole +1",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Assimilator's Jubbah +3",hands="Nyame Gauntlets",ring1="Ilabrat Ring",ring2="Epaminondas's Ring",
        back=STRCape,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"
    }

    --Blue Magic Sets--
    sets.BlueMagic = {}

    sets.BlueMagic.STR = {ammo="Floestone",
        head="Nyame Helm",neck="Caro Necklace",
        body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent Ring",ring2="Rajas ring",
    back="Cornflower cape",waist="Wanion belt",legs="Samnuha Tights",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.STRDEX = {ammo="Jukukik Feather",
        head="Nyame Helm",neck="Caro Necklace",
        body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent Ring",ring2="Rajas ring",
    back="Cornflower cape",waist="Wanion belt",legs="Samnuha Tights",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.STRVIT = {ammo="Mavi tathlum",
        head="Nyame Helm",neck="Caro Necklace",
        body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent ring",ring2="Petrov Ring",
    back="Cornflower cape",waist="Latria Sash",legs="Samnuha Tights",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.STRMND = {ammo="Mavi tathlum",
        head="Carmine Mask",neck="Caro Necklace",
        body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent ring",ring2="Stikini Ring",
    back="Cornflower cape",waist="Latria Sash",legs="Samnuha Tights",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.AGI = {ammo="Mavi tathlum",
        head="Carmine Mask",neck="Caro Necklace",
        body="Dread Jupon",hands="Adhemar Wristbands +1",ring1="Apate ring",ring2="Petrov ring",
    back="Cornflower cape",waist="Latria Sash",legs="Samnuha Tights",feet="Luhlaza charuqs +1"}

    sets.BlueMagic.INT = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Sanctity necklace",ear1="Novio Earring",ear2="Friomisi earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Metamorph Ring +1",
    back=INTCape,waist="Sacro Cord",legs="Luhlaza Shalwar +3",feet="Amalric Nails +1"}

    sets.BlueMagic.Cures = {ammo="Hydrocera",
        head="Carmine Mask",ear1="Loquac. earring",ear2="Novia earring",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Weatherspoon Ring +1",
    back="Oretania's cape",waist="Cascade Belt",legs="Psycloth Lappas",feet="Medium's Sabots"}

    sets.BlueMagic.SelfCures = {ammo="Hydrocera",
        head="Carmine Mask",ear1="Loquac. earring",ear2="Novia earring",
        body="Vrikodara Jupon",
        -- hands="Buremte Gloves",
        ring2="Weatherspoon Ring +1",
    back="Oretania's cape",waist="Gishdubar Sash",legs="Psycloth Lappas",feet="Medium's Sabots"}

    sets.BlueMagic.HeavyStrike = set_combine(sets.BlueMagic.STR, {})

    sets.BlueMagic.ChargedWhisker = set_combine(sets.BlueMagic.INT, {})

    sets.BlueMagic.WhiteWind = {
        head="Nyame Helm",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        -- ear2="Thureous earring",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring2="Ilabrat ring",ring1="Gelatinous Ring +1",
        back="Moonbeam Cape", waist="Gishdubar Sash",legs="Carmine Cuisses +1",feet="Skaoi Boots"}

    sets.BlueMagic.MagicAccuracy = {
        ammo="Pemphredo Tathlum",
        head={ name="Amalric Coif +1", augments={'INT+12','Mag. Acc.+25','Enmity-6',}},
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck={ name="Mirage Stole +1", augments={'Path: A',}},
        waist="Sacro Cord",
        left_ear="Digni. Earring",
        right_ear="Gwati Earring",
        left_ring="Defending Ring",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back=INTCape
    }

    sets.BlueMagic.MagicAccuracyFast = set_combine(sets.BlueMagic.MagicAccuracy, {
        
    })

    sets.BlueMagic.Stun = set_combine(sets.BlueMagic.MagicAccuracy, {})

    sets.BlueMagic.Skill = {ammo="Mavi tathlum",
        head="Carmine Mask",ear1="Loquac. earring",
        body="Assim. jubbah +3",
        
        ring1="Weatherspoon ring +1", ring2="Stikini Ring",
        back="Cornflower cape",waist="Twilight belt",legs="Mavi tayt +2",feet="Luhlaza charuqs +1"
    }

    sets.BlueMagic.BatteryCharge = {
        head="Amalric Coif +1", waist="Gishdubar Sash"
    }

    sets.WS.SanguineBlade = set_combine(sets.BlueMagic.INT, {})

    --Utility Sets--

    sets.Phalanx = {
        -- main="Pukulatmuj +1",sub="Pukulatmuj",
        head="Herculean Helm",neck="Melic torque",ear1="Loquac. earring",
        -- ear2="Augment. earring",
        body={ name="Herculean Vest", augments={'Pet: CHR+5','MND+1','Phalanx +5',}},
        hands="Taeon Gloves",ring1="Stikini ring",
        back="Swith cape",waist="Cascade Belt",legs="Taeon Tights",feet="Taeon Boots"
    }

    --Job Ability Sets--

    sets.JA = {}

    sets.JA.ChainAffinity = {
        feet="Assim. charuqs +1"
    }

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

    sets.BlueMagic.SkillRecast = set_combine(sets.precast.FC.Standard, {})

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
    addToTable("(F11) Main Weapon", sets.Weapons.index[Weapon_ind])
    addToTable("(F12) Off-Weapon", sets.Weapons.Offhand.index[WeaponOff_ind])
    addToTable("(DEL) Equip Current Gear", "")

    -- addToTable("(F11) CDC Set", sets.ChantDuCygne.index[ChantDuCygne_ind])
    -- addToTable("(F12) Req Set", sets.Requiescat.index[Requiescat_ind])
    -- addToTable("(END) Weapon Locked", weaponLocked)
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

    if spell.english == 'Expiacion' or spell.english == 'Savage Blade' or spell.english == 'Black Halo' then
        equip(sets.WS.ExpSavage)
    end

    if spell.english == 'Sanguine Blade' then
        equip(sets.WS.SanguineBlade)
    end

    if spell.english == 'Box Step' then
        equip(sets.Steps)
    end

    if spell.english == 'Realmrazer' then
        equip(sets.Realmrazer[sets.Realmrazer.index[Realmrazer_ind]])
    end

    if spell.english == 'Flash Nova' then
        equip(sets.WS.FlashNova)
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

    if spells.MagicAccuracyFast:contains(spell.name) then
        equip(sets.BlueMagic.MagicAccuracyFast)
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
        equip(sets.Phalanx)
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

function equip_weapons()
    equip({main=sets.Weapons.index[Weapon_ind], sub=sets.Weapons.Offhand.index[WeaponOff_ind]})
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
    elseif command == 'toggle main weapon' then
        equip_current()
        Weapon_ind = Weapon_ind +1
        if Weapon_ind > #sets.Weapons.index then Weapon_ind = 1 end
        send_command('@input /echo <----- Weapon changed to '..sets.Weapons.index[Weapon_ind]..' ----->')
        equip_weapons()
    elseif command == 'toggle sub weapon' then
        equip_current()
        WeaponOff_ind = WeaponOff_ind +1
        if WeaponOff_ind > #sets.Weapons.Offhand.index then WeaponOff_ind = 1 end
        send_command('@input /echo <----- Offhand changed to '..sets.Weapons.Offhand.index[WeaponOff_ind]..' ----->')
        equip_weapons()
    elseif command == 'toggle Rea set' then
        Realmrazer_ind = Realmrazer_ind +1
        if Realmrazer_ind > #sets.Realmrazer.index then Realmrazer_ind = 1 end
        send_command('@input /echo <----- Realmrazer Set changed to '..sets.Realmrazer.index[Realmrazer_ind]..' ----->')
    elseif command == 'equip current' then
        equip_current()
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


