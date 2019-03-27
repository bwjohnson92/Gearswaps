require('ClosetCleaner')
include('organizer-lib.lua')
include('Merlinic.lua')
-- Local Settings, setting the zones prior to use
Nuke_Index = 1
Idle_Index = 1

--currentWeapon = { name="Grioavolr", augments={'Magic burst dmg.+6%','INT+6','Mag. Acc.+14','"Mag.Atk.Bns."+30',}}
currentWeapon = { name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}}
TaranusINT = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}
TaranusMP = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

MPSet = false
MBSet = false
AccSet = false
PDTSet = false
IdleSet = 0
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

DotDebuffs = S{"Burn", "Choke", "Shock", "Drown", "Frost", "Rasp"}

-- Start Functions here
-- Gear Sets
function get_sets()

	send_command('bind f10 gs c switch MP')
	send_command('bind f11 gs c switch mb')
	send_command('bind f12 gs c switch pdt')
	send_command('bind end gs c lockWeapon')
	send_command('bind ^f11 gs c acc')

	sets.aftercast_Idle = {main="Bolelabunga",sub="Genbu's Shield",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Witching Robe",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Dark Ring",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Herald's Gaiters"}
		
	sets.aftercast_PDT = set_combine(sets.aftercast_Idle, {ammo="Staunch Tathlum", neck="Loricate Torque +1", ring1="defending Ring", ring2="Dark Ring", 
		body="Vrikodara Jupon", feet="Wicce Sabots +1"  })
	
	sets.aftercast_IdleHighMP = set_combine(sets.aftercast_Idle, { ammo="Strobilus",
		head="Pixie Hairpin +1", body="Weatherspoon Robe +1", hands="Amalric Gages +1", legs="Amalric Slops", feet="Weatherspoon Souliers +1",
		neck="Sanctity Necklace", ear1="Etiolation Earring", ear2="Loquacious Earring", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
		back="Bane Cape", waist="Yamabuki-no-obi"})
		
	sets.precast_FastCast = {
		head="Nahtirah Hat",neck="Orunmila's Torque", ear1="Etiolation Earring", ear2="Loquacious Earring",
		body=MerlinicBody, hands="Amalric Gages +1", ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",feet=MerlinicFeet}
	
	sets.precast_FastCure = set_combine(sets.precast_FastCast, {})
	
	sets.precast_FastCastImpact = set_combine(sets.precast_FastCast, {head=empty, body="Twilight Cloak"})
	
	sets.precast_FastCastHighMP = set_combine(sets.precast_FastCast, {
		hands="Amalric Gages +1", ring2="Sangoma Ring",back="Bane Cape",})
		
	sets.midcast_EnfeeblingMagic = {main=currentWeapon,sub="Enki Strap",ammo="pemphredo tathlum",
		head="Befouled Crown",neck="Voltsurge Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
		body="Spaekona's Coat +2",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Kishar Ring",
		back=TaranusINT,waist="Refoccilation Stone",legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}},feet="Skaoi Boots"}

	sets.midcast_ElementalMagic = {main=currentWeapon,sub="Niobid Strap", ammo="Pemphredo Tathlum",
		head="Archmage's Petasos +3",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=TaranusINT,waist="Refoccilation Stone",legs="Amalric slops +1",feet="Amalric Nails +1"}
		
	sets.midcast_ElementalMagicHighMP = {main=currentWeapon,sub="Niobid Strap", ammo="Strobilus",
		head=MerlinicHead, neck="Eddy Necklace",ear1="Etiolation Earring",ear2="Barkarole Earring",
		body="Spaekona's Coat +2",hands="Spaekona's gloves +3",ring1="Mephitas's Ring +1",ring2="Sangoma Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}

	sets.midcast_ElementalMagicAcc = {
	    main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+6','Mag. Acc.+14','"Mag.Atk.Bns."+30',}},
	    sub="Enki Strap",
	    ammo="Pemphredo Tathlum",
	    head="Archmage's Petasos +3",
	    body="Amalric Doublet +1",
	    hands="Jhakri Cuffs +2",
	    legs=MerlinicLegs,
	    feet="Archmage's Sabots +2",
	    neck="Sanctity Necklace",
	    waist="Refoccilation Stone",
	    left_ear="Barkaro. Earring",
	    right_ear="Digni. Earring",
	    left_ring="Jhakri Ring",
	    right_ring="Sangoma Ring",
	    back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast_ElementalMagicMP = set_combine(sets.midcast_ElementalMagic, {body="Spaekona's Coat +2"})
		
	sets.midcast_Impact = set_combine(sets.midcast_ElementalMagicAcc, {head=empty, body="Twilight Cloak", feet="Archmage's Sabots +2"})	
		
	sets.midcast_Stun = {main=currentWeapon,sub="Enki Strap",ammo="pemphredo tathlum",
		head=MerlinicHead,neck="Voltsurge Torque",ear1="Barkarole Earring",ear2="Gwati Earring",
		body="Vanir Cotehardie",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet=MerlinicFeet}
		
	sets.midcast_EnhancingMagic = {
		head="Befouled Crown",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		waist="Cascade Belt",}

	sets.midcast_MagicBurst = { neck="Mizukage-no-Kubikazari",
	hands="Spaekona's gloves +3", ring1="Locus Ring", ring2="Mujin Band",
	back=TaranusINT
	}
		
	sets.midcast_ElementalDay = {back="Twilight Cape", waist="Hachirin-no-obi",}
		
	sets.midcast_Cure = {main="Chatoyant Staff",sub="Achaq Grip",ammo="pemphredo tathlum",
			neck="Lasaia Pendant",
			body="Vanir Cotehardie",ring1="Sirona's Ring",ring2="Haoma's Ring",
			waist="Cascade Belt",feet="Umbani Boots"}
			
	sets.ManaWall = {back=TaranusMP, feet="Wicce Sabots +1"}
	
	sets.midcast_Death = {main=currentWeapon,sub="Niobid Strap", ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Static Earring",
		body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric slops +1",feet="Amalric Nails +1"}
	
	sets.midcast_DeathHighMP = {main=currentWeapon,sub="Niobid Strap", ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric Slops +1",feet="Amalric Nails +1"}
	
	sets.midcast_DeathHighMPMB = {main=currentWeapon,sub="Niobid Strap", ammo="Strobilus",
		head="Pixie Hairpin +1",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Static Earring",
		body="Ea Houppelande",hands="Amalric Gages +1",ring1="Mephitas's Ring +1",ring2="Archon Ring",
		back=TaranusMP,waist="Yamabuki-no-obi",legs="Amalric slops +1",feet="Amalric Nails +1"}
	
	sets.midcast_DrainAspir = set_combine(sets.midcast_ElementalMagic, {
	head="Pixie Hairpin +1",neck="Voltsurge Torque",  ear1="Gwati Earring", ear2="Barkarole Earring",	
	ring2="Archon Ring",back="Taranus's Cape", waist="Fucho-no-obi",feet=MerlinicFeet})
	
	sets.WS_Myrkr = set_combine(sets.aftercast_IdleHighMP, {})

	organizer_items = {
	echos="Echo Drops",
	holy="Holy Water",
	RREar="Reraise Earring",
	InstRR="Instant Reraise",
	Warp="Warp Ring",
	WarpItem="Instant Warp",
	CP="Trizek Ring",
	Exp="Echad Ring",
	CPMantle="Mecistopins Mantle",
	Prism="Prism Powder",
	Oils="Silent Oil",
	Puffs="Cream Puffs",
	Crepe="Pear Crepe",
	}

	sets.ElementalDebuff = {feet="Archmage's Sabots +2"}

sets.a = sets.midcast_ElementalMagic
sets.b = sets.midcast_MagicBurst

end

-- --- Precast ---

function precast(spell)
if (IdleSet == 3) then
	IdleSet = 2
end
if (IdleSet == 2) then
	if spell.english == 'Myrkr' then
		equip(sets.WS_Myrkr)
	else 
		equip(sets.precast_FastCastHighMP)
	end
else
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
		disable("Feet")
		disable("back")
    end
end
end
-- --- MidCast ---
function midcast(spell)
	if (IdleSet == 2) then
		if spell.english == 'Death' then
			if (MBSet == true) then
				equip(use_obi(spell, sets.midcast_DeathHighMPMB))
			else
				equip(use_obi(spell, sets.midcast_DeathHighMP))
			end
		elseif spell.english == 'Myrkr' then
			equip(sets.WS_Myrkr)
		elseif string.find(spell.type,'BlackMagic') then
			equip(sets.midcast_ElementalMagicHighMP)
		else
			equip(sets.precast_FastCastHighMP)
		end
	else
		if spell.english == 'Impact' then
			equip(sets.midcast_Impact)
		elseif spell.english == 'Death' then
			equip(set_combine(use_MB(use_obi(spell, sets.midcast_Death))), {head="Pixie Hairpin +1"})
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
				if DotDebuffs:contains(spell.english) then 
					equip(set_combine(sets.midcast_EnfeeblingMagic, sets.ElementalDebuff))
				elseif (MPSet) then
                    equip(use_MB(use_acc(use_obi(spell, sets.midcast_ElementalMagicMP))))
                else
                    equip(use_MB(use_acc(use_obi(spell, sets.midcast_ElementalMagic))))
                end
			elseif string.find(spell.skill, 'Dark Magic') then
				if spell.english ~= 'Stun' then
					equip(sets.midcast_DrainAspir)
				else
					equip(sets.midcast_Stun)
				end
			else
				equip(sets.precast_FastCast)
			end
			
		end
	end
end	

-- --- Aftercast ---

function aftercast(spell)
	if spell.english ~= 'Mana Wall' then
		if not buffactive["Mana Wall"] then
			enable("feet")
			enable("back")
		end
		if(IdleSet == 1) then
			equip(sets.aftercast_PDT)
		elseif (IdleSet == 2) then
			equip(sets.aftercast_IdleHighMP)
		else
			equip(sets.aftercast_Idle)
		end
	else
		if (IdleSet == 2) then
			equip(set_combine(sets.aftercast_IdleHighMP, sets.ManaWall))
		else
			equip(set_combine(sets.aftercast_Idle, sets.ManaWall))
		end
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

-- Status Change - ie. Resting

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
	
	elseif command == 'switch MP' then
		if (MPSet) then
			MPSet = false
			add_to_chat(140,'Elemental Magic: Damage')
		else
			MPSet = true
			add_to_chat(140,'Elemental Magic: MP')
		end
	elseif command == 'acc' then
        AccSet = not AccSet
        add_to_chat(140, 'Elemental Magic: '..(AccSet and 'Acc' or 'Damage'))
	elseif command == 'switch mb' then
		if (MBSet) then
			MBSet = false
			add_to_chat(140,'Magic Burst: Off')
		else
			MBSet = true
			add_to_chat(140,'Magic Burst: On')
		end
	elseif command == 'switch pdt' then
		IdleSet = IdleSet +1
		if (IdleSet == 4) then
			IdleSet = 0
			add_to_chat(140,'Idle Set: Standard')
			if not buffactive["Mana Wall"] then
				enable("Feet")
			end
			equip(sets.aftercast_Idle)
		elseif (IdleSet == 3) then 
			add_to_chat(140, 'Idle Set: High MP.')
			add_to_chat(5, 'IDLE WARNING: Hit F12 again to exit your High MP Set')
		elseif (IdleSet == 1) then
			add_to_chat(140,'Idle Set: PDT')
			equip(sets.aftercast_PDT)
		elseif (IdleSet == 2) then
			add_to_chat(140, 'Idle Set: High MP (Use for Death)')
			equip(sets.aftercast_IdleHighMP)
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
			equip({main=currentWeapon, sub="Enki Strap"})
			disable("Main")
			disable("Sub")
			add_to_chat(140,'Weapon is being locked')
		else
			weaponLocked = false
			enable("Main")
			enable("Sub")
			add_to_chat(140,'Weapon is now unlocked')
		end
	end
	
end

function use_MB(equip_set)
	if (MBSet) then
		equip_set = set_combine(equip_set, sets.midcast_MagicBurst)
	end
	return equip_set
end

function use_acc(equip_set)
    if (AccSet) then
        equip_set = set_combine(equip_set, sets.midcast_ElementalMagicAcc)
    end
    return equip_set
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