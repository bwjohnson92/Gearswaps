include('organizer-lib.lua')
-- Local Settings, setting the zones prior to use
toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}


-- Start Functions here
-- Gear Sets
movePDT = false

function get_sets()

	sets.aftercast_Idle = {main="Queller Rod",sub="Genbu's Shield",ammo="Homiliary",
		head="Befouled Crown",neck="Twilight Torque",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Witching Robe",hands="Gendewitha Gages +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Repulse Mantle",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet="Vanya Clogs"}

	sets.aftercast_Move = set_combine(sets.aftercast_Idle,{feet="Herald's Gaiters"})
	
	sets.precast_FastCast = {ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
		body="Inyanga Jubbah",hands="Fanatic Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Alaunus's Cape", waist="Witful Belt"}
	
	sets.precast_FastCure = set_combine(sets.precast_FastCast, 
	{back="Pahtli Cape",legs="Ebers Pantaloons +1",feet="Hygieia Clogs"})

	--sets.Resting = {main="Boonwell Staff",sub="Mephitis Grip",
		--head="Orvail Corona +1",neck="Grandiose Chain",ear1="Antivenom Earring",ear2="Loquacious Earring",
		--body="Bokwus Robe",back="Umbra Cape",legs="Nares Trews",feet="Chelona Boots +1"}

	sets.midcast_EnfeeblingMagic = {main="Grioavolr",sub="Mephitis Grip", ranged="Aureole",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Chironic Doublet",hands="Inyanga Dastanas",ring1="Etana Ring",ring2="Sangoma Ring",
		back="Alaunus's Cape",waist="Rumination Sash",legs="Chironic Hose",feet="Skaoi Boots"}

	sets.midcast_BarSpells_Solace = {main="Kirin's Pole",
		head="Befouled Crown",neck="Colossus's Torque",
		body="Ebers Bliaud +1",hands="Inyanga Dastanas",
		waist="Cascade Belt",legs="Cleric's Pantaloons +2",feet="Orison Duckbills +1"}
	--sets.midcast_Barspells_noSolace = set_combine(sets.midcast_BarSpells_Solace,{body="Blessed Briault"})

	sets.midcast_EnhancingMagic = {main="Kirin's Pole",ammo="Incantor Stone",
		head="Befouled Crown",neck="Colossus's Torque",ear1="Novia Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Inyanga Dastanas",ring2="Prolix Ring",
		back="Swith Cape",waist="Cascade Belt",legs="Cleric's Pantaloons +2",feet="Orison Duckbills +1"}

	sets.midcast_Regen = set_combine(sets.precast_FastCast, {
		main="Bolelabunga",
		head="Inyanga Tiara",body="Piety Briault +1",
		hands="Orison Mitts +1",legs="Theophany pantaloons"})
	
	sets.midcast_Auspice = {feet="Orison Duckbills +2"}
	
	sets.midcast_Cursna = {main="Queller Rod",
		head="Nahtirah Hat",neck="Malison medallion", ear2="Loquacious Earring",
		body="Ebers Bliaud +1",hands="Fanatic Gloves",ring1="Haoma's ring", ring2="Haoma's ring",
		back="Mending cape",waist="Witful Belt",legs="Theophany Pantaloons",feet="Gendewitha Galoshes"	}
		
	sets.midcast_DebuffRemoval = {
		main="",
		head="Nahtirah Hat", neck="Malison medallion",ear2="Loquacious Earring",
		body="Ebers Bliaud +1",hands="Orison Mitts +2",
		back="Swith Cape",waist="Witful Belt",legs="Theophany Pantaloons",feet='Gendewitha Galoshes'	}

	sets.midcast_Cure = {main="Queller Rod",sub="Sors Shield", ammo="Hydrocera",
			head="Gendewitha caubeen +1",neck="Nodens gorget",ear1="Nourishing Earring +1",ear2="Glorious Earring",--10% 3%--
			body="Ebers Bliaud +1",hands="Theophany Mitts +1",ring1="Sirona's Ring",ring2="Janniston Ring +1", --13%--
			back="Alaunus's Cape",waist="Cascade Belt",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}

	sets.midcast_Curaga = {main="Queller Rod",sub="Sors Shield", ammo="Hydrocera",
			head="Ebers Cap +1",neck="Nuna Gorget +1",ear1="Nourishing Earring +1",ear2="Glorious Earring",--10% 3%--
			body="Theophany briault +2",hands="Theophany Mitts +1",ring1="Aquasoul Ring",ring2="Janniston Ring +1", --13%--
			back="Alaunus's Cape",waist="Cascade Belt",legs="Ebers Pantaloons +1",feet="Vanya Clogs"}
			
	sets.midcast_CureWeather = set_combine(sets.midcast_Cure, {main="Chatoyant Staff", sub="Achaq Grip", 
		back="Twilight Cape", waist="Hachirin-no-obi"})
			
	sets.midcast_Stoneskin = {main="Kirin's Pole",neck="Stone Gorget",waist="Siegel Sash",legs="Shedir Seraweels"}

	sets.midcast_Shellra = {legs="Cleric's Pantaloons +2"}
	
	sets.midcast_Recast = {
	    ammo="Incantor Stone",
	    head="Nahtirah Hat",
	    body="Inyanga Jubbah",
	    hands="Blessed Mitts",
	    legs="Ebers Pant. +1",
	    feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
	    waist="Witful Belt",
	    left_ear="Sortiarius Earring",
	    right_ear="Loquac. Earring",
	    left_ring="Weather. Ring",
	}
	
	
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

	send_command('bind f12 gs c toggle pdt')
end

-- --- Precast ---

function precast(spell)
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cur') then 
				equip(sets.precast_FastCure)
			else		
				equip(sets.precast_FastCast)
			end
		else		
			equip(sets.precast_FastCast)
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
		if string.find(spell.english, 'Cura') then
			equip(use_obi(spell, sets.midcast_Curaga))
		elseif string.find(spell.english, 'Cure') then 
			equip(use_obi(spell, sets.midcast_Cure))
		elseif string.find(spell.english,'Cursna') then
			equip(sets.midcast_Cursna)
		elseif string.find(spell.english, 'na') then 
			equip(sets.midcast_DebuffRemoval)
		elseif string.find(spell.english, 'Raise') then
			equip(sets.midcast_Recast)
		end
		
	elseif spell.english == 'Erase' then
			equip(sets.midcast_DebuffRemoval)

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
			equip(sets.midcast_Recast)
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
	if(MovePDT) then
		equip(sets.aftercast_Idle)
	else
		equip(sets.aftercast_Move)
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

function self_command(command)
	if command == 'toggle pdt' then
		if (MovePDT) then
			MovePDT = false
			add_to_chat(140,'Herald\'s Gaiters')
		else
			MovePDT = true
			add_to_chat(140,'PDT Set')
		end
	end
end

function status_change(new,tab)
	--if new == 'Resting' then
	--	equip(sets['Resting'])
	--else
--	equip(sets['aftercast_Idle'])
	--end
end

function use_obi(spell, equip_set)
    local use_obi = false
    -- first check to see if any elemental obi rule matches
    if(S{world.weather_element}:contains(spell.element)) then
		use_obi = true
	end
 
    if (use_obi) then
        equip_set = set_combine(equip_set, sets.midcast_CureWeather)
    end
 
    return equip_set
end