require('closetCleaner')
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

	sets.aftercast_Idle_refresh = {main="Bolelabunga",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Witching Robe",hands="Inyanga Dastanas +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Assiduity Pants",feet="Inyanga Crackows +1"}

	sets.aftercast_Move = set_combine(sets.aftercast_Idle_refresh,{legs="Tatsumaki Sitagoromo"})

	sets.aftercast_Idle = set_combine(sets.aftercast_Idle_refresh, {})

	sets.precast_FastCast = {ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",
		hands="Gendewitha Gages", ring1="Weatherspoon Ring",
		back="Swith Cape",waist="Witful Belt",legs="Artsieq Hose"}
	
	sets.precast_FastCure = {ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear2="Loquacious Earring",
		body="Inyanga Jubbah +1", hands="Gendewitha Gages",ring1="Weatherspoon Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Hygieia Clogs"}

	sets.midcast_EnfeeblingMagic = {main="Twebuliij",sub="Mephitis Grip",ammmo="Kalboron Stone",
		head="Buremte Hat",neck="Voltsurge Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Ischemia Chasuble",hands="Inyanga Dastanas +1",ring1="Sangoma Ring",ring2="Weatherspoon Ring",
		back="Ogapepo Cape",waist="Ovate Rope",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}

	sets.midcast_BarSpells_Solace = {main="Beneficus",
		head="Orison Cap +2",
		body="Orison Bliaud +2",hands="Orison Mitts +2",
		waist="Cascade Belt",legs="Piety Pantaloons",feet="Orison Duckbills +2"}
	sets.midcast_Barspells_noSolace = set_combine(sets.midcast_BarSpells_Solace,{body="Blessed Briault"})

	sets.midcast_EnhancingMagic = {main="Beneficus",ammo="Incantor Stone",
		head="Artsieq Hat",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",
		back="Swith Cape",waist="Cascade Belt",legs="Piety Pantaloons",feet="Orison Duckbills +2"}

	sets.midcast_EnhancingMagicDuration = {main="Beneficus",ammo="Incantor Stone",
		head="Telchine Cap",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Telchine Gloves",
		back="Swith Cape",waist="Cascade Belt",legs="Telchine Braconi",feet="Telchine Pigaches"}

	sets.midcast_Regen = set_combine(sets.midcast_EnhancingMagicDuration, {head="Inyanga Tiara +1",body="Cleric's Briault",legs="Theophany pantaloons"})
	sets.midcast_Auspice = {feet="Orison Duckbills +2"}
	sets.midcast_Cursna = {main="Beneficus",
		head="Orison Cap +2",neck="Malison medallion", ear2="Loquacious Earring",
		body="Orison Bliaud +2",hands="Orison Mitts +2",ring1="Ephedra ring", ring2="Sirona's ring",
		back="Mending cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}
		
	sets.midcast_DebuffRemoval = {
		head="Orison Cap +2",neck="Malison medallion",ear2="Loquacious Earring",
		body="Orison Bliaud +2",hands="Orison Mitts +2",
		back="Swith Cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}

	sets.midcast_Cure = {main="Tamaxchi",sub="Genbu's Shield",
		head="Orison Cap +2",neck="Fylgja Torque",ear1="Nourishing Earring",ear2="Glorious Earring",
		body="Orison Bliaud +2",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Ephedra Ring",
		back="Oretania's Cape",waist="Cascade Belt",legs="Orison Pantaloons +2",feet="Medium's Sabots"}
			
	sets.midcast_Stoneskin = set_combine(sets.midcast_EnhancingMagicDuration, {main="Kirin's Pole",neck="Stone Gorget",waist="Siegel Sash",legs="Shedir Seraweels"})

	sets.midcast_Shellra = set_combine(sets.midcast_EnhancingMagicDuration, {legs="Piety Pantaloons"})
	
	sets.midcast_Recast = {head="Artsieq Hat",ear2="Loquacious Earring",
	body="Artsieq Jubbah",neck="Orison Locket",
	hands="Gendewitha Gages",
	back="Swith Cape",waist="Cetl Belt",legs="Piety Pantaloons",feet="Gendewitha Galoshes"}
	


end

-- --- Precast ---

function precast(spell)
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cur') then 
				equip(sets.precast_FastCure)
				send_command('input /echo "Cure"')
			else		
				equip(sets['precast_FastCast'])
				send_command('input /echo "FC"')
			end
		else		
			equip(sets['precast_FastCast'])
			send_command('input /echo "FC"')
		end
		if string.find(spell.skill,'Enhancing Magic') then
			equip({waist="Siegel Sash"})
		end
	end
end
-- --- MidCast ---
function midcast(spell)
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
				equip(use_obi(spell, sets.midcast_Cure))
			elseif string.find(spell.english,'Cursna') then
				equip(sets.midcast_Cursna)
			elseif string.find(spell.english, 'na') then 
				equip(sets.midcast_DebuffRemoval)
			elseif string.find(spell.english, 'Erase') then
				equip(sets.midcast_DebuffRemoval)
			elseif string.find(spell.english, 'Raise') then
				equip(sets.midcast_Recast)
			else
				equip(sets.midcast_DebuffRemoval)
			end
			
		elseif string.find(spell.english,'Stoneskin') then
			equip(sets['midcast_Stoneskin'])
			
		elseif string.find(spell.skill,'Enhancing Magic') then
			if string.find(spell.english,'Bar') then
				equip(sets.midcast_BarSpells_Solace)
			elseif string.find(spell.english, 'Regen') then 
				equip(sets.midcast_Regen)
			elseif string.find(spell.english, 'Shellra') then
				equip(sets.midcast_Shellra)
			elseif string.find(spell.english, 'Boost') then
				equip(sets.midcast_EnhancingMagic)
			else
				equip(sets.midcast_EnhancingMagicDuration)
			end
			
		elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
			equip(sets.midcast_EnfeeblingMagic)	
		else
			equip(sets.midcast_EnfeeblingMagic)
		end
	end
end		

-- --- Aftercast ---

function aftercast(spell)
		if toau_zones:contains(zone) then
			equip(sets.aftercast_Idle,{ring1="Balrahn's Ring"})
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
	if new == 'Resting' then
		equip(sets['Resting'])
	else
		equip(sets['aftercast_Idle'])
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