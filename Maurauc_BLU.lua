require('closetCleaner')
include('organizer-lib.lua')
include('displayBox.lua')

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

    HercBootsAcc = "Jhakri Pigaches +2"
    HercBootsWS = { name="Herculean Boots", augments={'Accuracy+1','Pet: DEX+4','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
    HercBootsTA = { name="Herculean Boots", augments={'"Triple Atk."+4','DEX+4','Accuracy+8','Attack+13',}}

    DEXCape = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
    STRCape = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    INTCape = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Haste+10','Phys. dmg. taken-10%',}}
    
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
      head="Adhemar Bonnet +1",neck="Loricate Torque +1", ear1="Loquacious earring", ear2="Moonshade earring",
      body="Jhakri Robe +2",hands="Amalric Gages +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
      back=DEXCape,waist="Fucho-no-obi",legs="Carmine Cuisses +1",feet="Carmine Greaves"}
                                             
    sets.Idle.DT = {
        ammo="Staunch Tathlum +1",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Ayanmo Manopolas +2",
        -- legs="Aya. Cosciales +2",
        legs="Carmine Cuisses +1",
        feet="Ayanmo Gambieras +2",
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
        ammo="Ginsen",
        head={ name="Adhemar Bonnet +1"},
        -- body={ name="Herculean Vest", augments={'Accuracy+28','"Triple Atk."+4',}},
        body="Adhemar Jacket +1",
        -- hands={ name="Herculean Gloves", augments={'Accuracy+19','"Triple Atk."+4','STR+3',}},
        hands="Adhemar Wristbands +1",
        -- legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+4','DEX+3','Attack+13',}},
        legs="Adhemar Kecks +1",
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
           
    --sets.TP.Solo = {ammo="Ginsen",
    --  head="Carmine Mask",neck="Asperity necklace", ear1="Dudgeon earring", ear2="Heartseeker earring",
    --  body="Luhlaza jubbah +1",hands="Qaaxo mitaines",ring1="Epona's ring",ring2="Rajas ring",
    --  back="Atheling mantle",waist="Shetal Stone",legs="Iuitl Tights +1",feet="Qaaxo leggings"}
   
  --  sets.TP.Safe = {ammo="Ginsen",
--      head="Carmine Mask",neck="Asperity necklace", ear1="Dudgeon earring", ear2="Heartseeker earring",
--      body="Qaaxo harness",hands="Qaaxo mitaines",ring1="Epona's ring",ring2="Rajas ring",
--      back="Atheling mantle",waist="Shetal Stone",legs="Iuitl Tights +1",feet="Qaaxo leggings"}
       
    sets.TP.Hybrid = set_combine(sets.TP.Standard, {
        head="Malignance Chapeau",
        })

    sets.TP.Accuracy = {ammo="Ginsen",
        head="Malignance Chapeau",
        neck="Sanctity Necklace", ear1="Dignitary's earring", ear2="Telos earring",
        -- ring1="Cacoethic ring",
        ring2="Patricius Ring",
        back=DEXCape,
        waist="Olseni Belt", feet=HercBootsAcc}
                                                   
    -- sets.TP.DT = {ammo="Ginsen",
    --     head="Carmine Mask",neck="Loricate Torque +1", ear1="Dudgeon earring", ear2="Heartseeker earring",
    --     body="Ayanmo Corazza +2",hands="Buremte gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
    --     back="Reiki Cloak",waist="Twilight belt",legs="Ayanmo Cosciales +2",}
                             
    -- sets.TP.DTAccuracy = {ammo="Honed Tathlum",
    --     head="Carmine Mask",neck="Loricate Torque +1", ear1="Dudgeon earring", ear2="Heartseeker earring",
    --     body="Luhlaza jubbah +1",hands="Buremte gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
    --     back="Reiki Cloak",waist="Hurch'lan sash",legs="Iuitl Tights +1",feet="Iuitl gaiters"}
   

    --Weaponskill Sets--
    sets.WS = {}
    sets.WS.CircleBlade = {}
   
    sets.Requiescat = {}
   
    sets.Requiescat.index = {'Attack','Accuracy'}
    Requiescat_ind = 1
   
    sets.Requiescat.Attack = {ammo="Floestone",
        head="Carmine Mask",neck="Fotia gorget",ear1="Brutal earring",ear2="Moonshade earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Epona's ring",ring2="Rufescent Ring",
        back="Rosmerta's Cape",waist="Fotia belt",legs="Carmine Cuisses +1",feet="Luhlaza charuqs +1"}
                                                             
    --sets.Requiescat.Accuracy = {ammo="Honed tathlum",
        --head="Whirlpool mask",neck="Soil gorget",ear1="Brutal earring",ear2="Moonshade earring",
        --body="Luhlaza jubbah +1",hands="Qaaxo mitaines",ring1="Epona's ring",ring2="Stikini Ring",
        --back="Letalis mantle",waist="Soil belt",legs="Quiahuiz trousers",feet="Assim. charuqs +1"}
                                                     
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
        head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
        body="Assimilator's Jubbah +3",hands="Jhakri Cuffs +2",ring1="Rufescent Ring",ring2="Candent Ring",
        back=STRCape,waist="Fotia Belt",legs="Luhlaza Shalwar +3",
        feet="Jhakri Pigaches +2"
    }
                                                                           
    --Blue Magic Sets--
    sets.BlueMagic = {}
   
    sets.BlueMagic.STR = {ammo="Floestone",
        head="Lilitu Headpiece",neck="Caro Necklace",
        body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent Ring",ring2="Rajas ring",
        back="Cornflower cape",waist="Wanion belt",legs="Samnuha Tights",feet="Luhlaza charuqs +1"}
                                             
    sets.BlueMagic.STRDEX = {ammo="Jukukik Feather",
        head="Lilitu Headpiece",neck="Caro Necklace",
        body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent Ring",ring2="Rajas ring",
        back="Cornflower cape",waist="Wanion belt",legs="Samnuha Tights",feet="Luhlaza charuqs +1"}
                                                   
    sets.BlueMagic.STRVIT = {ammo="Mavi tathlum",
        head="Lilitu Headpiece",neck="Caro Necklace",
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
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=INTCape,waist="Sacro Cord",legs="Amalric Slops +1",feet="Amalric Nails +1"}
                                             
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
                                                             
    sets.BlueMagic.ChargedWhisker = set_combine(sets.BlueMagic.INT, {}) --{ammo="Pemphredo Tathlum",, {})
        --head="Uk'uxkaj cap",neck="Eddy necklace",ear1="Hecate's earring",ear2="Friomisi earring",
        --body="Hagondes Coat +1",hands="Umuthi gloves",ring1="Acumen ring",ring2="Rajas ring",
        --back="Cornflower cape",waist="Latria Sash",legs="Hagondes Pants +1",feet="Hagondes Sabots"}
   
    sets.BlueMagic.WhiteWind = {
        head="Carmine Mask",neck="Dualism Collar",ear1="Etiolation Earring",
        -- ear2="Thureous earring",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring2="Ilabrat ring",ring1="Gelatinous Ring +1",
        back="Oretania's cape", waist="Oneiros Belt",legs="Carmine Cuisses +1",feet="Medium's Sabots"}
                                                                     
    sets.BlueMagic.MagicAccuracy = {ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Dignitary's earring",ear2="Gwati earring",
        body="Ayanmo Corazza +2",hands="Ayanmo Manopolas +2",ring1="Weatherspoon ring +1",ring2="Stikini ring",
        back="Cornflower cape",waist="Sacro Cord",legs="Ayanmo Cosciales +2",feet="Ayanmo Gambieras +2"}

    -- sets.BlueMagic.DT = set_combine(sets.BlueMagic.MagicAccuracy, {
    --     body="Ayanmo Corazza +2",
    -- })
    
    sets.BlueMagic.Stun = set_combine(sets.BlueMagic.MagicAccuracy, {})
                                                                     
    sets.BlueMagic.Skill = {ammo="Mavi tathlum",
        head="Carmine Mask",ear1="Loquac. earring",
        body="Assim. jubbah +3",
        -- hands="Ayao's gages",
        ring1="Weatherspoon ring +1", ring2="Stikini Ring",
        back="Cornflower cape",waist="Twilight belt",legs="Mavi tayt +2",feet="Luhlaza charuqs +1"}
                                                  
    sets.BlueMagic.BatteryCharge = {
        head="Amalric Coif +1", waist="Gishdubar Sash"
    }

    sets.WS.SanguineBlade = set_combine(sets.BlueMagic.INT, {})
        
    --Utility Sets--
    sets.Utility = {}
   
    --sets.Utility.Stoneskin = {head="Haruspex hat",neck="Stone Gorget",ear1="Loquac. earring",ear2="Earthcry earring",
     --                                                 body="Assim. jubbah +1",hands="Stone Mufflers",ring1="Prolix ring",
     --                                                 back="Swith cape",waist="Siegel sash",legs="Haven hose",feet="Iuitl gaiters"}
                                                     
    sets.Utility.Phalanx = {
        head="Herculean Helm",neck="Melic torque",ear1="Loquac. earring",
        -- ear2="Augment. earring",
        body="Taeon Tabard",hands="Taeon Gloves",ring1="Stikini ring",
        back="Swith cape",waist="Cascade Belt",legs="Taeon Tights",feet="Taeon Boots"
    }
                                                   
   -- sets.Utility.Steps = {ammo="Honed tathlum",
    --                                          head="Whirlpool mask",ear2="Heartseeker earring",
     --                                         body="Thaumas coat",hands="Umuthi gloves",
      --                                        back="Letalis cape",waist="Chaac belt",legs="Samnuha Tights",feet="Manibozho boots"}
                                             
    --sets.Utility.PDT = {head="Whirlpool mask",neck="Loricate Torque +1",
    --                                        body="Vrikodara Jupon",hands="Umuthi gloves",ring1="Defending ring",ring2="Gelatinous Ring +1",
    --                                        back="Rosmerta's Cape",legs="Iuitl Tights +1"}
                                           
    --sets.Utility.MDT = {head="Whirlpool mask",neck="Loricate Torque +1",
    --                                        body="Assim. jubbah +3",hands="Umuthi gloves",ring1="Defending ring",ring2="Gelatinous Ring +1",
    --                                        back="Reiki Cloak",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}
                                                   

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
       
        if spell.english == 'Frightful Roar' or spell.english == 'Feather Tickle' or spell.english == 'Reaving Wind' or spell.english == 'Blank Gaze' or spell.enligh == 'Geist Wall' or spell.english == 'Infrasonics' or spell.english == 'Barbed Crescent' or spell.english == 'Tourbillion' or spell.english == 'Cimicine Discharge' or spell.english == 'Sub-zero smash' or spell.english == 'Filamented Hold' or spell.english == 'Mind Blast' or spell.english == 'Sandspin' or spell.english == 'Hecatomb Wave' or spell.english == 'Cold Wave' or spell.english == 'Terror Touch' then
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
    if player.status == 'Engaged' then
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
    
    
    