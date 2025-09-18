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


-- Start Functions here
-- Gear Sets
function get_sets()

end

-- --- Precast ---

function precast(spell)

end
-- --- MidCast ---
function midcast(spell)

end	

-- --- Aftercast ---

function aftercast(spell)

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
	elseif command == 'book' then
		cycle = 0
		invCount = windower.ffxi.get_bag_info(0).count
		if player.inventory["Astral Homeland"] then
			send_command('input /item "Astral Homeland" <me> ')
			cycle = 1
		else
			add_to_chat(140,'No Books found in inv.')
			send_command('findall Astral Homeland')
		end
		if cycle == 1 then
			send_command('wait 3;gs c book')
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
		IdleSet = IdleSet +1
		if (IdleSet == 4) then
			IdleSet = 0
			add_to_chat(140,'Idle Set: Standard')
			if not buffactive["Mana Wall"] then
				enable("Feet")
			end

		elseif (IdleSet == 3) then 
			add_to_chat(140, 'Idle Set: High MP.')
			add_to_chat(5, 'IDLE WARNING: Hit F12 again to exit your High MP Set')
		elseif (IdleSet == 1) then
			add_to_chat(140,'Idle Set: PDT')
		elseif (IdleSet == 2) then
			add_to_chat(140, 'Idle Set: High MP (Use for Death)')
				end
	elseif command == 'lockCape' then
		if capeLocked == false then
			capeLocked = true
		
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
			-
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

function buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Reive Mark" and gain then
       		disable("neck")
	elseif buff == "Reive Mark" and not gain then
		enable("neck")
    end
end


function use_MB(equip_set)
	if (MBSet) then
		equip_set = set_combine(equip_set, sets.midcast_MagicBurst)
	end
	return equip_set
end

function use_MB_death(equip_set)

		equip_set = sets.midcast_DeathMagicBurst
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