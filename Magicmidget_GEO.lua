include('organizer-lib.lua')
-- Local Settings, setting the zones prior to use
toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

capeLocked = false
weaponLocked = false
nextTH = false
hasPet = true
-- Start Functions here
-- Gear Sets

nukingStaff = "Raetic"

function get_sets()

	sets.nukingStaves = {}
	sets.nukingStaves.Raetic = "Raetic Staff +1"
	sets.nukingStaves.Grioavolr = { name="Grioavolr", augments={'INT+9','Mag. Acc.+20','"Mag.Atk.Bns."+28','Magic Damage +8',}}

	sets.Reive = {neck="Arciela's Grace +1"}
	
	sets.Melee = {
	    main="Idris",
	    sub="Genmei Shield",
	    range="Dunna",
	    head="Jhakri Coronal +1",
	    body="Jhakri Robe",
	    hands="Jhakri Cuffs +1",
	    legs="Querkening Brais",
	    feet="Battlecast Gaiters",
	    neck="Clotharius Torque",
	    waist="Cetl Belt",
	    left_ear="Digni. Earring",
	    right_ear="Ishvara Earring",
	    left_ring="Rajas Ring",
	    right_ring="K'ayres Ring",
	    back={ name="Lifestream Cape", augments={'Geomancy Skill +7','Indi. eff. dur. +17','Pet: Damage taken -4%',}},
	}

	sets.Realmrazer = {
	    main="Idris",
	    sub="Genmei Shield",
	    range="Dunna",
	    head="Jhakri Coronal +1",
	    body="Jhakri Robe",
	    hands="Jhakri Cuffs +1",
	    legs="Jhakri Slops +1",
	    feet="Jhakri Pigaches +1",
	    neck="Imbodla Necklace",
	    waist="Luminary Sash",
	    left_ear="Digni. Earring",
	    right_ear="Ishvara Earring",
	    left_ring="Rajas Ring",
	    right_ring="K'ayres Ring",
	    back={ name="Lifestream Cape", augments={'Geomancy Skill +7','Indi. eff. dur. +17','Pet: Damage taken -4%',}},
	}

	sets.aftercast_PetRegen = {
		main="Idris",	
		sub="Genmei Shield",
		head="Azimuth Hood +1",
		body="Telchine Chasuble", hands="Telchine Gloves",
    	back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
		waist="Isa Belt", legs="Telchine Braconi", feet="Bagua Sandals +1",
		lear="Handler's Earring +1",
		rear="Handler's Earring",
		neck="Twilight Torque",
		ring1="Defending Ring",
		ring2="Dark Ring"
	}

	sets.aftercast_Idle = {main="Idris",sub="Genmei Shield",ranged="Dunna",
		head="Azimuth Hood +1",neck="Twilight Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Azimuth Coat +1",hands="Geomancy Mitaines +3",ring1="Defending Ring",ring2="Dark Ring",
	    back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},	
		waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Geomancy Sandals +3"}

	sets.aftercast_DT = set_combine(sets.aftercast_Idle, {
		})

	sets.Speed = {feet="Geomancy Sandals +3"}	
		
	sets.precast_FastCast = { main="Solstice", sub="Genmei Shield", 
		head="Merlinic Hood", neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Anhur Robe",hands="Repartie Gloves",ring1="Kishar Ring",ring2="Weatherspoon Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Geomancy Pants +1",feet="Merlinic Crackows"}
	
	sets.precast_FastCure = set_combine(sets.precast_FastCast, {	ear2="Loquacious Earring",
		ring2="Weatherspoon Ring",	back="Disperser's Cape",waist="Witful Belt",legs="Geomancy Pants +1"})

	--sets.Melee = {main="Buramenk'ah",sub="Genmei Shield",
	--	head="Umuthi Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
	--	body="Artsieq Jubbah",hands="Umuthi Gloves", 
	--	back="Atheling Mantle",waist="Cetl Belt", legs="Hagondes Pants",feet="Umbani Boots"}	
		
	sets.midcast_EnfeeblingMagic = {
	    main={ name="Grioavolr", augments={'INT+9','Mag. Acc.+20','"Mag.Atk.Bns."+28','Magic Damage +8',}},
	    sub="Niobid Strap",
	    ammo="Pemphredo Tathlum",
	    head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Conserve MP"+3','Mag. Acc.+11','"Mag.Atk.Bns."+10',}},
	    body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+27','Attack+6','Quadruple Attack +2','Accuracy+4 Attack+4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
	    hands="Azimuth Gloves +1",
	    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','CHR+2','Mag. Acc.+13','"Mag.Atk.Bns."+9',}},
	    feet="Jhakri Pigaches +1",
	    neck="Erra Pendant",
	    waist="Luminary Sash",
	    left_ear="Digni. Earring",
	    right_ear="Barkaro. Earring",
	    left_ring="Kishar Ring",
	    right_ring="Weather. Ring",
	    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast_ElementalMagic = {
	    -- main={ name="Grioavolr", augments={'INT+9','Mag. Acc.+20','"Mag.Atk.Bns."+28','Magic Damage +8',}},
	    -- main=sets.nukingStaves[nukingStaff],
	    main="Grioavolr",
	    sub="Niobid Strap",
	    ammo="Pemphredo Tathlum",
	    head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Conserve MP"+3','Mag. Acc.+11','"Mag.Atk.Bns."+10',}},
	    body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+27','Attack+6','Quadruple Attack +2','Accuracy+4 Attack+4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
	    hands="Jhakri Cuffs +1",
	    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','CHR+2','Mag. Acc.+13','"Mag.Atk.Bns."+9',}},
	    feet="Jhakri Pigaches +1",
	    neck="Deviant Necklace",
	    waist="Isa Belt",
	    left_ear="Friomisi Earring",
	    right_ear="Barkaro. Earring",
	    left_ring="Shiva Ring",
	    right_ring="Shiva Ring",
	    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	--sets.midcast_Stun = {main="Twebuliij",sub="Benthos Grip",ammo="Plumose Sachet",
		--head="Atrophy Chapeau +1",neck="Voltsurge Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		--body="Vanir Cotehardie",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Weatherspoon Ring",
		--back="Ogapepo Cape",waist="Ovate Rope",legs="Artsieq Hose",feet="Helios Boots"}
		
	sets.midcast_EnhancingMagic = {
		head="Befouled Crown",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		ring2="Weatherspoon Ring",
		waist="Cascade Belt"}

		
	sets.midcast_IndiSpells = {main="Idris",
	head="Azimuth Hood +1", 
	body="Azimuth Coat +1",	hands="Azimuth Gloves +1", 
	back="Lifestream Cape", legs="Bagua Pants",feet="Azimuth Gaiters +1"}
	
	sets.midcast_GeoSpells = set_combine(sets.midcast_IndiSpells, {legs="Azimuth Tights +1"})
	
	--sets.midcast_Cursna = {main="Beneficus",
	--	head="Orison Cap +2",neck="Malison medallion", ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",ring1="Ephedra ring", ring2="Sirona's ring",
	--	back="Mending cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}
		
	--sets.midcast_DebuffRemoval = {
	--	head="Orison Cap +2",neck="Malison medallion",ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",
	--	back="Swith Cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}

	sets.midcast_Cure = {main="Tamaxchi",sub="Genmei Shield",ammo="Plumose Sachet",
			head="Gendewitha Caubeen",neck="Fylgja Torque",lear="Novia Earring",
			hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Ephedra Ring",
			back="Pahtli Cape",waist="Porous Rope",legs="Gyve Trousers",feet="Umbani Boots"}
		
	sets.TH = {waist="Chaac Belt"}

	sets.RadialArcana = {
		feet="Bagua Sandals +1"
	}

	sets.LifeCycle = {
	back="Nantosuelta's Cape"
	}
		
	organizer_items = { main="Echo Drops", ranged="Cream Puff",
			body="Trizek Ring", ear1="Reraise Earring",
			ring1="Warp Ring",ring2="Capacity Ring", ear2="Echad Ring",
			back="Mecistopins Mantle"}

	send_command('bind f12 input /equip Feet "Geomancy Sandals +3"')

	send_command('bind f9 gs c nextTH')
	send_command('bind end send @others "input /follow Magicmidget"')
	send_command('bind f10 gs c changeStaff')

	windower.register_event('zone change', function()
		hasPet = false
		equip(sets.aftercast_Idle)
		end)

end

-- --- Precast ---

function precast(spell)
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') or string.find(spell.type, 'Geomancy') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cur') then 
				equip(sets.precast_FastCure)
				--send_command('input /echo "Cure"')
			else		
				equip(sets['precast_FastCast'])
				--send_command('input /echo "FC"')
			end
		else		
			equip(sets['precast_FastCast'])
			--send_command('input /echo "FC"')
		end
		if string.find(spell.skill,'Enhancing Magic') then
			equip({waist="Siegel Sash"})
			if string.find(spell.english,'Stoneskin') then
				equip({head="Umuthi Hat"})
			end
		end
	end
	if (string.find(spell.type,'Trust')) then
		equip(sets['precast_FastCast'])
	end
	if (string.find(spell.name,'Bolster')) then
		equip({body="Bagua Tunic +1"})
	end
	if (spell.english == "Life Cycle") then 
		equip(sets.LifeCycle)
	end
	if (spell.english == "Radial Arcana") then
		equip(sets.RadialArcana)
	end
	if (spell.english == "Realmrazer") then
		equip(sets.Realmrazer)
	end
end
-- --- MidCast ---
function midcast(spell)
	set = {}
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
				set = set_combine(sets.midcast_Cure, {})
			elseif string.find(spell.english,'Cursna') then
				set = set_combine(sets.precast_FastCast, {})
			elseif string.find(spell.english, 'na') then 
				set = set_combine(sets.precast_FastCast, {})
			elseif string.find(spell.english, 'Erase') then
				set = set_combine(sets.precast_FastCast, {})
			elseif string.find(spell.english, 'Raise') then
				set = set_combine(sets.precast_FastCast	, {})
			else
				set = set_combine(sets.precast_FastCast, {})
			end
		
		elseif string.find(spell.skill,'Enhancing Magic') then
			set = set_combine(sets.midcast_EnhancingMagic, {})

		elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
			set = set_combine(sets.midcast_EnfeeblingMagic, {})
			
		elseif string.find(spell.skill,'Elemental Magic') then
			set = use_obi(spell, sets.midcast_ElementalMagic)
		elseif string.find(spell.skill,'Dark Magic') then
			set = use_obi(spell, sets.midcast_EnfeeblingMagic, {})
		else
			set = set_combine(sets.precast_FastCast, {})
		end
	elseif string.find(spell.type, 'Geomancy') then
		if string.find(spell.english, 'Indi') then
			set = set_combine(sets.midcast_IndiSpells, {})
		else
			set = set_combine(sets.midcast_GeoSpells, {})
		end
		
	end
	if nextTH then
		equip(set_combine(set, {waist="Chaac Belt"}))
		nextTH = false
	else
		equip(set)
	end
end	

-- --- Aftercast ---

function aftercast(spell)

    --if player.status == 'Engaged' then
    --        equip(sets.Melee)
    if hasPet then
		equip(sets.aftercast_PetRegen)
		-- equip(sets.aftercast_Idle)
	
	else
		equip(sets.aftercast_Idle)
	end
		if spell.english == 'Sleep' or spell.english == 'Sleepga' then
			send_command('@wait 50;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
		elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
			send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
		elseif spell.english == 'Break' or spell.english == 'Breakga' then
			send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
		elseif spell.english == 'Repose' then
			send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
		end
end

-- Status Change - ie. Resting

function status_change(new,tab)
	if new == 'Engaged' then
	--	equip(sets['Melee'])
		--disable("Main")
	else
		equip(sets['aftercast_Idle'])
		--enable("Main")
	end
end

function pet_change(pet,gain_or_loss)
	status_change(player.status)
	hasPet = gain_or_loss
	if not gain_or_loss then
		add_to_chat(123,'Your luopan has vanished.')
		windower.play_sound('C:/Filepath/Filename.wav') --must be a .wav--
	end
end

function self_command(command)
	if command == 'coffer' then
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
	elseif command == 'gcoffer' then
		cycle = 0
		invCount = windower.ffxi.get_bag_info(0).count
		if invCount == 80 then
			add_to_chat(140,'Inv. full. Ending cycle')
		elseif player.inventory["Grand Velkk Coffer"] then
			send_command('input /item "Grand Velkk Coffer" <me> ')
			cycle = 1
		else
			add_to_chat(140,'No Coffers found in inv.')
			send_command('findall Grand Velkk Coffer')
		end
		if cycle == 1 then
			send_command('wait 2;gs c gcoffer')
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
	elseif command == 'codex' then
		cycle = 0
		if player.inventory["Codex of Etchings"] then
			send_command('input /item "Codex of Etchings" <me> ')
			cycle = 1
		else
			add_to_chat(140,'No pouches found in inv.')
			send_command('findall Codex of Etchings')
		end
		if cycle == 1 then
			send_command('wait 3;gs c codex')
		end
	elseif command == 'book' then
		cycle = 0
		if player.inventory["Mikhe's Memo"] then
			send_command('input /item "Mikhe\'s Memo" <me> ')
			cycle = 1
		else
			add_to_chat(140,'No books found in inv.')
			send_command('findall Mikhe')
		end
		if cycle == 1 then
			send_command('wait 3;gs c book')
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
	elseif command == 'nextTH' then
		nextTH = not nextTH
		add_to_chat(140, 'TH Next Attack: '..(nextTH and 'On' or 'Off'))
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
	elseif command == 'changeStaff' then
		if nukingStaff == "Raetic" then
			nukingStaff = "Grioavolr"
		else
			nukingStaff = "Raetic"
		end
		add_to_chat(140, "Nuking Staff: "..(nukingStaff))
	end
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


function use_obi(spell, equip_set)
    local use_obi = false
    -- first check to see if any elemental obi rule matches
    if(S{world.day_element, world.weather_element}:contains(spell.element)) then
            -- If at least one matches, try to find out if there is also a weak element involved
            if (world.weather_element == elements.weak_against[spell.element] ) then
                -- If weak weather is involved, but it is only single weather, check to see if use_on_single_conflict is set to true
                if (world.weather_id % 2 == 0 and elements.use_on_single_conflict) then
                    use_obi = true
                end
            elseif (world.day_element == elements.weak_against[spell.element]) then
                -- If weak day is involved check for double weather or single weather + use_on_single_conflict set to true
                if (world.weather_id % 2 == 1 or ( elements[use_on_single_conflict] and world.weather_id % 2 == 0) ) then
                    use_obi = true
                end
            else
				use_obi = true
			end
    end
 
    if (use_obi) then
        equip_set = set_combine(equip_set, { waist = "Hachirin-No-Obi"})
    end
 
    return equip_set
end