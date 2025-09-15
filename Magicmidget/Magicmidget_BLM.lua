include('organizer-lib.lua')
-- Local Settings, setting the zones prior to use

Nuke_Index = 1
Run_Index = 1

MPSet = false
MBSet = false
PDTSet = false
capeLocked = false
weaponLocked = false

toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

-- Start Functions here
-- Gear Sets
function get_sets()

	sets.Reive = {neck="Arciela's Grace +1"}

	sets.aftercast_PDT = {main="Earth Staff", ammo="Vanir Battery",
	head="Hagondes Hat", neck="Twilight Torque", ear1="Etiolation Earring", ear2="",
	body="Vrikodara Jupon", hands="Hagondes Cuffs", ring1="Defending Ring", ring2="Patricius Ring",
	back="Repulse Mantle", waist="Siegel Sash", legs="Hagondes Pants", feet=""}

	sets.aftercast_Idle = {main="Grioavolr", sub="Niobid Strap",
		head="Merlinic Hood",neck="Twilight Torque",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Ischemia Chasuble",hands="Helios Gloves",ring1="Defending Ring",ring2="Dark Ring",
		back="Repulse Mantle",waist="Porous Rope",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
		
	sets.precast_FastCast = {main="Grioavolr",
		head="Merlinic Hood",neck="Orunmila's Torque", ear1="Barkarole Earring", ear2="Loquacious Earring",
		body="Merlinic Jubbah",hands="Repartie Gloves", ring1="Rahab Ring",ring2="Weatherspoon Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Gyve Trousers", feet="Merlinic Crackows"}
	
	sets.precast_FastCastImpact = set_combine(sets.precast_FastCast, {head=empty, body="Twilight Cloak"})

	sets.midcast_EnfeeblingMagic = {
	    ammo="Pemphredo Tathlum",
	    head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Conserve MP"+3','Mag. Acc.+11','"Mag.Atk.Bns."+10',}},
	    body="Jhakri Robe",
	    hands="Jhakri Cuffs +1",
	    legs="Jhakri Slops +1",
	    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+9','"Mag.Atk.Bns."+9',}},
	    neck="Erra Pendant",
	    waist="Rumination Sash",
	    left_ear="Barkaro. Earring",
	    right_ear="Digni. Earring",
	    left_ring="Rahab Ring",
	    right_ring="Weather. Ring",
	    back="Hecate's Cape",
	}

	sets.midcast_ElementalMagic = {main="Grioavolr",sub="Niobid Strap", ammo="Ombre Tathlum",
		head={ name="Arch. Petasos +3", augments={'Increases Ancient Magic II damage',}},
		neck="Deviant Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Merlinic Jubbah",hands="Jhakri Gloves +1",ring1="Shiva Ring",ring2="Shiva Ring",
		back="Toro Cape",waist="Eschan Stone",legs="Merlinic Shalwar",feet="Merlinic Crackows"}

		
	sets.midcast_ElementalMagicMP = set_combine(sets.midcast_ElementalMagic, {body = "Spaekona's Coat"})
	
	sets.midcast_ElementalMagicAcc = {main="Grioavolr",sub="Benthos Grip", ammo="Ombre Tathlum",
		head={ name="Arch. Petasos +3", augments={'Increases Ancient Magic II damage',}},
		neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Wicce Coat +1",hands="Wicce Gloves +1",ring1="Weatherspoon Ring",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-obi",legs="Merlinic Shalwar",feet="Merlinic Crackows"}	
		
	sets.midcast_Impact = set_combine(sets.midcast_ElementalMagicAcc, {head=empty, body="Twilight Cloak"})
		
	sets.midcast_MagicBurst = {neck="Mizukage-no-Kubikazari", --10
		head="Merlinic Hood",
		hands="Amalric Gages", ring1="Mujin Band", ring2="Locus Ring", --9,(5),(5),5 
		back="Seshaw Cape", feet="Helios Boots"} --5, 9	
		
	sets.midcast_Stun = {main="Grioavolr",sub="Mephitis Grip",ammo="Ombre Tathlum",
		head="Merlinic Hood",neck="Voltsurge Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Vanya Robe",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Weatherspoon Ring",
		back="Swith Cape",waist="Witful Belt",legs="Merlinic Shalwar",feet="Merlinic Crackows"}

	sets.midcast_Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Plumose Sachet",
		neck="Voltsurge Torque",
		body="Vitivation Tabard",hands="Gendewitha Gages",ring1="Sirona's Ring",ring2="Ephedra Ring",
		back="Oretania's Cape",waist="Cascade Belt",legs="Atrophy Tights",feet="Umbani Boots"}

	organizer_items = {main="Echo Drops", sub="Cehuetzi Snow Cone",ranged="Cream Puff",ammo="Pear Crepe", 
	head="Crepe b. Helene",		
	body="Trizek Ring", ear1="Reraise Earring",
		ring1="Warp Ring",ring2="Capacity Ring", ear2="Echad Ring",
		back="Mecistopins Mantle"}
		
	sets.midcast_Death = {main="Grioavolr",sub="Niobid Strap", ammo="Ombre Tathlum",
		head="Merlinic Hood",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Merlinic Jubbah",hands="Amalric Gages",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Seshaw Cape",waist="Yamabuki-no-obi",legs="Merlinic Shalwar",feet="Merlinic Crackows"}
	
		
	sets.midcast_DrainAspir = set_combine(sets.midcast_ElementalMagic, {
	head="Pixie Hairpin +1",neck="Voltsurge Torque",  ear1="Gwati Earring", ear2="Barkarole Earring",	
	back="Bane Cape", waist="Fucho-no-obi",feet="Merlinic Crackows"})
			
	sets.midcast_DarkMagic = set_combine(sets.midcast_ElementalMagic, {head="Pixie Hairpin +1"})
			
	sets.WS_Myrkr = { ammo="Strobilus",
	head="Kaabnax Hat", neck="Dualism Collar", ear1="Moonshade Earring", ear2="Etiolation Earring",
	body="Weatherspoon Robe +1", hands="Otomi Gloves", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
	back="Bane Cape", waist="Mujin obi", legs="Psycloth Lappas", feet="Merlinic Crackows"}
			
	sets.midcast_ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}

	sets.ManaWall = {feet="Wicce Sabots +1"}
			
	send_command('bind f10 gs c switch MP')
	send_command('bind f11 gs c switch mb')
	send_command('bind f12 gs c switch pdt')
end

-- --- Precast ---

function precast(spell)
	if spell.english == 'Impact' then
		equip(sets.precast_FastCastImpact)
	elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		equip(sets.precast_FastCast)
		if string.find(spell.skill,'Enhancing Magic') then
			equip({waist="Siegel Sash"})
			if string.find(spell.english,'Stoneskin') then
				equip({head="Umuthi Hat"})
			end
		end
	end
	if spell.english == 'Myrkr' then
		equip(sets.WS_Myrkr)
	end
	if spell.english == 'Mana Wall' then
        equip(sets.ManaWall)
	elseif spell.english == 'Elemental Seal' then
		add_to_chat(140, 'Ele seal!')
    end
end
-- --- MidCast ---
function midcast(spell)
	if spell.english == 'Impact' then
		equip(sets.midcast_Impact)
	elseif spell.english == 'Death' then
		equip(set_combine(use_MB(use_obi(spell, sets.midcast_Death))), {head="Pixie Hairpin +1"})
	elseif spell.english == 'Comet' or spell.english == 'Death' then
		equip(sets.midcast_DarkMagic)
	elseif string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
				equip(sets.midcast_Cure)
			else
				equip(sets.precast_FastCast)
			end
		elseif string.find(spell.skill,'Enhancing Magic') then
			equip(sets.midcast_EnhancingMagic)
						
		elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
			equip(sets.midcast_EnfeeblingMagic)	
	
		elseif string.find(spell.skill,'Elemental Magic') then
			if(MPSet) then
				equip(use_MB(use_obi(spell, sets.midcast_ElementalMagicMP)))
			else
				equip(use_MB(use_obi(spell, sets.midcast_ElementalMagic)))
			end
		elseif string.find(spell.skill, 'Dark Magic') then
			if spell.english ~= 'Stun' then
				equip(sets.midcast_DrainAspir)
			else
				equip(sets.precast_FastCast)
			end
		else
			equip(sets.precast_FastCast)
		end
		
	end
end	

-- --- Aftercast ---

function aftercast(spell)
	if spell.english ~= 'Mana Wall' then
		if not buffactive["Mana Wall"] then
			enable("feet")
		end
		if(PDTSet) then
			equip(sets.aftercast_PDT)
		else
			equip(sets.aftercast_Idle)
		end
	else
	equip(set_combine(sets.aftercast_PDT, sets.ManaWall))
	end
	
	check_spell(spell)
end

-- Status Change - ie. Resting

function check_spell(spell)
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

function status_change(new,tab)

end

function self_command(command)
	if command == 'toggle Nuke set' then
		Nuke_Index = Nuke_Index +1
		if Nuke_Index > 2 then
			Nuke_Index = 1
			send_command('input /echo Equipped normal nuke set')
		else
			send_command('input /echo Equipped accurate nuke set')
		end
	elseif (command == 'toggle Idle set') then
		Idle_Index = Idle_Index +1
		if Idle_Index > 2 then
			Idle_Index = 1
			send_command('input /echo Equipped Nares Legs')
		else
			send_command('input /echo Equipped Tatsu Legs')
		end
	
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
			send_command('input /item "Silt Pouch" <me>')
			cycle = 1
		elseif player.inventory["Bead Pouch"] then
			send_command('input /item "Bead Pouch" <me>')
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
	
	elseif command == 'switch MP' then
		MPSet = not MPSet
		add_to_chat(140, 'Elemental Magic: '..(MPSet and 'MP' or 'Damage'))
	elseif command == 'switch mb' then
		if (MBSet) then
			MBSet = false
			add_to_chat(140,'Magic Burst: Off')
		else
			MBSet = true
			add_to_chat(140,'Magic Burst: On')
		end
	elseif command == 'switch pdt' then
		if (PDTSet) then
			PDTSet = false
			add_to_chat(140,'PDT Set Off')
			if not buffactive["Mana Wall"] then
				enable("Feet")
			end
			equip(sets.aftercast_Idle)
		else
			PDTSet = true
			add_to_chat(140,'PDT Set On')
			equip(sets.aftercast_PDT)
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

function use_MB(equip_set)
	if (MBSet) then
		equip_set = set_combine(equip_set, sets.midcast_MagicBurst)
	end
	return equip_set
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
        equip_set = set_combine(equip_set, sets.midcast_ElementalDay)
    end
 
    return equip_set
end