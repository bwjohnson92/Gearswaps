include('organizer-lib.lua')

trigger = false
capeLocked = false
weaponLocked = false 

function get_sets()
 
        send_command('bind f9 gs c toggle TP set')
        send_command('bind f10 gs c toggle Idle set')
        send_command('bind f11 gs c toggle CDC set')
        send_command('bind f12 gs c toggle Req set')
        send_command('bind !f12 gs c toggle Rea set')
       
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
               
		sets.Weapons = {main="Sequence", sub="Colada",}
		organizer_items = {
			echos="Echo Drops",
			holy="Holy Water",
			RREar="Reraise Earring",
			RRHair="Reraise Hairpin",
			InstRR="Instant Reraise",
			Warp="Warp Ring",
			WarpItem="Instant Warp",
			CP="Trizek Ring",
			Exp="Echad Ring",
			CPMantle="Mecistopins Mantle",
			Prism="Prism Powder",
			Oils="Silent Oil",
			--Puffs="Cream Puffs",
		}

		Colada={ name="Colada", augments={'"Mag.Atk.Bns."+13','DEX+13','Accuracy+18','DMG:+17',}}
	    HercHeadMAB={ name="Herculean Helm", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +1%','"Mag.Atk.Bns."+14',}}

	    HercBodyTP={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+3','Accuracy+11',}}
    	
    	HercHandsTP={ name="Herculean Gloves", augments={'Accuracy+18 Attack+18','"Triple Atk."+3','Attack+1',}}
    	
    	HercLegsTP={ name="Herculean Trousers", augments={'Accuracy+25 Attack+25','"Triple Atk."+2','STR+5',}}
    	HercLegsMAB={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+20','Weapon skill damage +4%','INT+10',}}
	
	    HercFeetMAB={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +4%','STR+7','Mag. Acc.+1','"Mag.Atk.Bns."+5',}}
    	HercFeetTP={ name="Herculean Boots", augments={'Rng.Acc.+21','"Triple Atk."+4','STR+5','Accuracy+12','Attack+2',}}

        --Idle Sets--  
        sets.Idle = {}
       
        sets.Idle.index = {'Standard','DT'}
        Idle_ind = 1                   
       
        sets.Idle.Standard = {ammo="Ginsen",
		  head="Adhemar Bonnet",neck="Loricate Torque +1", ear1="Loquacious earring", ear2="Moonshade earring",
		  body="Amalric Doublet +1",hands="Serpentes cuffs",ring1="Dark ring",ring2="Defending ring",
		  back="Repulse mantle",waist="Fucho-no-obi",legs="Crimson cuisses",feet="Serpentes sabots"}
                                                 
        sets.Idle.DT = {ammo="Ginsen",
				head="Rabid Visor",neck="Loricate Torque +1", ear1="Ethereal earring", ear2="Heartseeker earring",
				body="Ayanmo Corazza +2",hands="Umuthi gloves",ring1="Dark ring",ring2="Defending ring",
				back="Agema Cape",waist="Flume belt +1",legs="Herculean Trousers",feet="Herculean Boots"}
       
        --TP Sets--
        sets.TP = {}
 
        sets.TP.index = {'Standard', 'Accuracy',} --'Safe', 'AccuracyLite', 'AccuracyFull', 'AccuracyExtreme', 'DT', 'DTAccuracy'}
        --1=Standard, 2=Solo, 3=Marches, 4=AccuracyLite, 5=AccuracyFull, 6=DT, 7=DTAccuracy--
        TP_ind = 1
       
        sets.TP.Standard = {
	    main="Sequence",
	    sub="Colada",
	    ammo="Ginsen",
	    --head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
	    head="Adhemar Bonnet",
	    body=HercBodyTP,
	    hands=HercHandsTP,
	    legs="Samnuha Tights",
	    feet=HercFeetTP,
	    neck="Lissome Necklace",
	    waist="Windbuffet Belt +1",
	    left_ear="Brutal Earring",
	    right_ear="Suppanomimi",
	    left_ring="Epona's Ring",
	    right_ring="Petrov Ring",
	    back="Rosmerta's cape",
		}
		   
        --sets.TP.Solo = {ammo="Ginsen",
		--	head="Iuitl headgear +1",neck="Asperity necklace", ear1="Dudgeon earring", ear2="Heartseeker earring",
		--	body="Luhlaza jubbah +1",hands="Qaaxo mitaines",ring1="Epona's ring",ring2="Rajas ring",
		--	back="Atheling mantle",waist="Shetal Stone",legs="Iuitl Tights +1",feet="Qaaxo leggings"}
	   
      --  sets.TP.Safe = {ammo="Ginsen",
	--		head="Iuitl headgear +1",neck="Asperity necklace", ear1="Dudgeon earring", ear2="Heartseeker earring",
	--		body="Qaaxo harness",hands="Qaaxo mitaines",ring1="Epona's ring",ring2="Rajas ring",
	--		back="Atheling mantle",waist="Shetal Stone",legs="Iuitl Tights +1",feet="Qaaxo leggings"}
		   
        sets.TP.Accuracy = {ammo="Ginsen",
			head="Dampening Tam",neck="Sanctity Necklace", ear1="Dudgeon earring", ear2="Heartseeker earring",
			body=HercBodyTP,hands=HercHandsTP,ring1="Epona's ring",ring2="Patricius Ring",
			back="Rosmerta's cape",waist="Windbuffet Belt +1",legs=HercLegsTP,feet="Assimilator's Charuqs +1"}
       
      --[[  sets.TP.AccuracyFull = {ammo="Honed tathlum",
			head="Whirlpool mask",neck="Asperity necklace", ear1="Dudgeon earring", ear2="Heartseeker earring",
			body="Luhlaza jubbah +1",hands="Buremte gloves",ring1="Epona's ring",ring2="Rajas ring",
			back="Letalis mantle",waist="Shetal Stone",legs="Manibozho brais",feet="Assim. charuqs +1"}
                                                       
        sets.TP.AccuracyExtreme = {ammo="Honed tathlum",
			head="Whirlpool mask",neck="Iqabi necklace", ear1="Dudgeon earring", ear2="Heartseeker earring",
			body="Luhlaza jubbah +1",hands="Buremte gloves",ring1="Epona's ring",ring2="Mars's ring",
			back="Letalis mantle",waist="Dynamic belt +1",legs="Manibozho brais",feet="Assim. charuqs +1"}
                                                       
        sets.TP.DT = {ammo="Ginsen",
			head="Iuitl headgear +1",neck="Loricate Torque +1", ear1="Dudgeon earring", ear2="Heartseeker earring",
			body="Luhlaza jubbah +1",hands="Buremte gloves",ring1="Dark ring",ring2="Dark ring",
			back="Mollusca mantle",waist="Twilight belt",legs="Iuitl Tights +1",feet="Iuitl gaiters"}
                                 
        sets.TP.DTAccuracy = {ammo="Honed Tathlum",
			head="Iuitl headgear +1",neck="Loricate Torque +1", ear1="Dudgeon earring", ear2="Heartseeker earring",
			body="Luhlaza jubbah +1",hands="Buremte gloves",ring1="Dark ring",ring2="Dark ring",
			back="Mollusca mantle",waist="Hurch'lan sash",legs="Iuitl Tights +1",feet="Iuitl gaiters"}
       ]]
       
       
       
       
       
        --Weaponskill Sets--
        sets.WS = {}
       
        sets.Requiescat = {}
       
        sets.Requiescat.index = {'Attack','Accuracy'}
        Requiescat_ind = 1
       
        sets.Requiescat.Attack = {ammo="Cheruski needle",
			head="Whirlpool mask",neck="Soil gorget",ear1="Brutal earring",ear2="Moonshade earring",
			body="Telchine Chasuble",hands="Qaaxo mitaines",ring1="Epona's ring",ring2="Rufescent Ring",
			back="Rosmerta's cape",waist="Fotia belt",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}
                                                                 
        --sets.Requiescat.Accuracy = {ammo="Honed tathlum",
			--head="Whirlpool mask",neck="Soil gorget",ear1="Brutal earring",ear2="Moonshade earring",
			--body="Luhlaza jubbah +1",hands="Qaaxo mitaines",ring1="Epona's ring",ring2="Levia. ring",
			--back="Letalis mantle",waist="Soil belt",legs="Quiahuiz trousers",feet="Assim. charuqs +1"}
                                                         
        sets.ChantDuCygne = {}
       
        sets.ChantDuCygne.index = {'Attack','Accuracy'}
        ChantDuCygne_ind = 1
       
        sets.ChantDuCygne.Attack = {ammo="Jukukik feather",
			head="Dampening Tam",neck="Fotia Gorget",ear1="Brutal earring",ear2="Moonshade earring",
			body=HercBodyTP,hands="Adhemar Wristbands",ring1="Epona's ring",ring2="Apate ring",
			back="Rosmerta's cape",waist="Fotia Belt",legs="Samnuha Tights",feet=HercFeetTP}
                                                           
       -- sets.ChantDuCygne.Accuracy = {ammo="Jukukik feather",
		--	head="Imperial wing hairpin",neck="Flame gorget",ear1="Bladeborn earring",ear2="Steelflash earring",
			--body="Luhlaza jubbah +1",hands="Luh. bazubands +1",ring1="Epona's ring",ring2="Thundersoul ring",
			--back="Rancorous mantle",waist="Light belt",legs="Manibozho brais",feet="Assim. charuqs +1"}

        sets.WS.Expiacion = {ammo="Cheruski needle",
			head="Uk'uxkaj cap",neck="Soil Gorget",ear1="Moonshade earring",ear2="Brutal earring",
			body="Assim. jubbah +1",hands="Adhemar Wristbands",ring1="Epona's ring",ring2="Pyrosoul ring",
			back="Atheling mantle",waist="Fotia Belt",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}
                               
                                                                               
        --Blue Magic Sets--
        sets.BlueMagic = {}
       
        sets.BlueMagic.STR = {ammo="Floestone",
			head="Lilitu Headpiece",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
			body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent Ring",ring2="Rajas ring",
			back="Cornflower cape",waist="Wanion belt",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}
                                                 
        sets.BlueMagic.STRDEX = {ammo="Cheruski needle",
			head="Lilitu Headpiece",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
			body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent Ring",ring2="Rajas ring",
			back="Cornflower cape",waist="Wanion belt",legs="Manibozho brais",feet="Luhlaza charuqs +1"}
                                                       
        sets.BlueMagic.STRVIT = {ammo="Mavi tathlum",
			head="Lilitu Headpiece",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
			body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent ring",ring2="Spiral ring",
			back="Cornflower cape",waist="Latria Sash",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}
                                                         
        sets.BlueMagic.STRMND = {ammo="Mavi tathlum",
			head="Luh. Keffiyeh +1",neck="Caro Necklace",ear1="Flame pearl",ear2="Flame pearl",
			body="Rawhide Vest",hands="Rawhide Gloves",ring1="Candent ring",ring2="Levia. ring",
			back="Cornflower cape",waist="Latria Sash",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}
                                                               
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
		    right_ring="Shiva Ring +1",
		    back="Argocham. Mantle",
		}
                                                 
        sets.BlueMagic.Cures = {ammo="Aqua sachet",
			head="Uk'uxkaj cap",neck="Aife's medal",ear1="Loquac. earring",ear2="Novia earring",
			body="Assim. jubbah +1",hands="Weath. cuffs +1",ring1="Levia. ring",ring2="Janniston ring +1",
			back="Oretania's cape",waist="Pythia sash +1",legs="Quiahuiz trousers",feet="Skaoi Boots"}
                                                       
        sets.BlueMagic.SelfCures = {ammo="Aqua sachet",
			head="Uk'uxkaj cap",neck="Aife's medal",ear1="Loquac. earring",ear2="Novia earring",
			body="Assim. jubbah +1",hands="Buremte Gloves",ring1="Levia. ring",ring2="Janniston Ring +1",
			back="Oretania's cape",waist="Chuq'aba Belt",legs="Quiahuiz trousers",feet="Skaoi Boots"}
                                                       
        sets.BlueMagic.Stun = {ammo="Mavi tathlum",
			head="Assim. keffiyeh",neck="Eddy necklace",ear1="Loquac. earring",
			body="Assim. jubbah +1",hands="Mv. bazubands +2",ring1="Prolix ring",ring2="Sangoma ring",
			back="Cornflower cape",waist="Twilight belt",legs="Mavi tayt +2",feet="Luhlaza charuqs +1"}
                                                   
        sets.BlueMagic.HeavyStrike = set_combine(sets.BlueMagic.STR, {})
                                                                 
        sets.BlueMagic.ChargedWhisker = set_combine(sets.BlueMagic.INT, {}) --{ammo="Pemphredo Tathlum",
			--head="Uk'uxkaj cap",neck="Eddy necklace",ear1="Hecate's earring",ear2="Friomisi earring",
			--body="Hagondes Coat +1",hands="Umuthi gloves",ring1="Acumen ring",ring2="Rajas ring",
			--back="Cornflower cape",waist="Pipilaka belt",legs="Hagondes Pants +1",feet="Hagondes Sabots"}
       
        sets.BlueMagic.WhiteWind = {ammo="Mavi tathlum",
			head="Luh. Keffiyeh +1",neck="Cuamiz collar",ear1="Upsurge Earring",ear2="Cassie earring",
			body="Aetosaur jerkin",hands="Amalric Gages",ring1="Bomb queen ring",ring2="Janniston ring +1",
			back="Oretania's cape",feet="Llwyd's clogs"}
                                                                         
        sets.BlueMagic.MagicAccuracy = {ammo="Mavi Tathlum",
			head="Assim. keffiyeh",neck="Eddy necklace",ear1="Psystorm earring",ear2="Lifestorm earring",
			body="Assim. jubbah +1",hands="Hagondes cuffs",ring1="Mediator's ring",ring2="Sangoma ring",
			back="Cornflower cape",waist="Ovate rope",legs="Mavi tayt +2",feet="Luhlaza charuqs +1"}
                                                                         
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
       
        --sets.Utility.Stoneskin = {head="Haruspex hat",neck="Stone Gorget",ear1="Loquac. earring",ear2="Earthcry earring",
         --                                                 body="Assim. jubbah +1",hands="Stone Mufflers",ring1="Prolix ring",
         --                                                 back="Swith cape",waist="Siegel sash",legs="Haven hose",feet="Iuitl gaiters"}
                                                         
       -- sets.Utility.Phalanx = {head="Haruspex hat",neck="Colossus's torque",ear1="Loquac. earring",ear2="Augment. earring",
       --                                             body="Assim. jubbah +1",hands="Ayao's gages",ring1="Prolix ring",
     --                                                   back="Swith cape",waist="Pythia sash +1",legs="Portent pants",feet="Iuitl gaiters"}
                                                       
       -- sets.Utility.Steps = {ammo="Honed tathlum",
        --                                          head="Whirlpool mask",ear2="Heartseeker earring",
         --                                         body="Thaumas coat",hands="Umuthi gloves",
          --                                        back="Letalis cape",waist="Chaac belt",legs="Manibozho brais",feet="Manibozho boots"}
                                                 
        sets.Utility.PDT = {head="Whirlpool mask",neck="Loricate Torque +1",ear1="Ethereal earring",
                                                body="Iuitl vest",hands="Umuthi gloves",ring1="Dark ring",ring2="Dark ring",
                                                back="Mollusca mantle",waist="Flume belt",legs="Iuitl Tights +1",feet="Iuitl gaiters"}
                                               
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
       
end
 
 
 
 
 
 
function precast(spell)
        if spell.action_type == 'Magic' then
                equip(sets.precast.FC.Standard)
        end
       
        if spell.english == 'Azure Lore' then
                equip(sets.JA.AzureLore)
        end
       
        if spell.english == 'Requiescat' or spell.english == 'Savage Blade' then
                equip(sets.Requiescat[sets.Requiescat.index[Requiescat_ind]])
        end
       
        if spell.english == 'Chant du Cygne' then
                equip(sets.ChantDuCygne[sets.ChantDuCygne.index[ChantDuCygne_ind]])
        end
       
        if spell.english == 'Circle Blade' then
                equip(sets.WS.CircleBlade)
        end
               
        if spell.english == 'Expiacion' then
                equip(sets.WS.Expiacion)
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
       
        if spell.english == 'Frightful Roar' or spell.english == 'Infrasonics' or spell.english == 'Barbed Crescent' or spell.english == 'Tourbillion' or spell.english == 'Cimicine Discharge' or spell.english == 'Sub-zero smash' or spell.english == 'Filamented Hold' or spell.english == 'Mind Blast' or spell.english == 'Sandspin' or spell.english == 'Hecatomb Wave' or spell.english == 'Cold Wave' or spell.english == 'Terror Touch' then
                equip(sets.BlueMagic.MagicAccuracy)
        end
       
        if spell.english == 'MP Drainkiss' or spell.english == 'Digest' or spell.english == 'Blood Saber' or spell.english == 'Blood Drain' or spell.english == 'Osmosis' or spell.english == 'Occultation' or spell.english == 'Magic Barrier' or spell.english == 'Diamondhide' or spell.english == 'Metallic Body' or spell.english == 'Retinal Glare' then
                equip(sets.BlueMagic.SkillRecast)
                if buffactive['Diffusion'] then
                        equip(sets.JA.Diffusion)
                end
        end
       
        if spell.english == 'Cocoon' or spell.english == 'Harden Shell' or spell.english == 'Animating Wail' or spell.english == 'Battery Charge' or spell.english == 'Nat. Meditation' or spell.english == 'Carcharian Verve' or spell.english == 'O. Counterstance' or spell.english == 'Barrier Tusk' or spell.english == 'Saline Coat' or spell.english == 'Regeneration' or spell.english == 'Erratic Flutter' then
                if buffactive['Diffusion'] then
                        equip(sets.JA.Diffusion)
                end
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
		invCount = windower.ffxi.get_bag_info(0).count
		if invCount == 80 then
			add_to_chat(140,'Inv. full. Ending cycle')
		elseif player.inventory["Silt Pouch"] then
			send_command('input /item "Silt Pouch" <me> ')
			cycle = 1
		else
			add_to_chat(140,'No Coffers found in inv.')
			send_command('findall Silt Pouch')
		end
		if cycle == 1 then
			send_command('wait 3;gs c pouch')
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
end

function lock_gear()
	
end
	
	
	