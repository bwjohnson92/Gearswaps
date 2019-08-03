 include('organizer-lib.lua')
include('displayBox.lua')

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

AFHead = "Geomancy Galero"
AFBody = "Geomancy Tunic"
AFHands = "Geomancy Mitaines +1"
AFLegs = "Geomancy Pants"
AFFeet = "Geomancy Sandals"

RelicHead = "Bagua "
RelicBody = "Bagua Tunic"
RelicHands = "Bagua Mitaines"
RelicLegs = "Bagua Pants"
RelicFeet = "Bagua Sandals +1 "

EmpyHead = "Azimuth Hood +1"
EmpyBody = "Azimuth Coat +1"
EmpyHands = "Azimuth Gloves +1"
EmpyLegs = "Azimuth Tights +1"
EmpyFeet = "Azimuth Gaiters +1"

capeLocked = false
weaponLocked = false
nextTH = false
Idle_Index = 1

-- Start Functions here
-- Gear Sets
function get_sets()

	sets.Reive = {neck="Arciela's Grace +1"}

	sets.Idle = {}
    sets.Idle.index = {"Standard", "DamageTaken", "PetRegen"}
	sets.precast = {}
	sets.midcast = {}

	sets.Idle.PetRegen ={
	main="Solstice",
    sub="Genmei Shield",
    head="Azimuth Hood +1",
    body={ name="Telchine Chas.", augments={'Pet: DEF+5','Pet: "Regen"+2',}},
    hands="Geomancy mittaines +1",
    legs={ name="Telchine Braconi", augments={'Pet: "Regen"+3',}},
    feet={ name="Bagua Sandals +1", augments={'Enhances "Radial Arcana" effect',}},
    neck="Twilight Torque",
    waist="Isa Belt",
    left_ear="Handler's Earring +1",
    left_ring="Defending Ring",
    right_ring="Warden's Ring",
    back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
}

	sets.Idle.Standard = {main="Solstice",sub="Genbu's Shield",ranged="Dunna",
		head="Befouled Crown",neck="Sanctity necklace",ear1="Etiolation Earring",ear2="Hearty Earring",
		body=EmpyBody,hands=RelicHands,ring1="Defending Ring",ring2="Warden's Ring",
		back="Lifestream Cape",waist="Fucho-no-obi",legs="Assiduity Pants +1",feet=AFFeet}

	sets.Idle.DamageTaken = {}

	sets.Speed = {feet="Geomancy Sandals"}	
		
	sets.precast.FastCast = { main="Solstice", sub="Genbu's Shield", 
		head="Merlinic Hood", ear1="Etiolation Earring",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Repartie Gloves",ring2="Prolix Ring",
		back="Lifestream Cape",waist="Witful Belt",legs=AFLegs,feet="Merlinic Crackows"}
	
	sets.precast.FastCure = set_combine(sets.precast.FastCast,{ ear2="Loquacious Earring",
		ring2="Weatherspoon Ring",	back="Disperser's Cape",waist="Witful Belt",legs=AFLegs})

	--sets.Melee = {main="Solstice",sub="Genbu's Shield",
	--	head="Umuthi Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
	--	body="Artsieq Jubbah",hands="Umuthi Gloves", 
	--	back="Atheling Mantle",waist="Cetl Belt", legs="Hagondes Pants",feet="Umbani Boots"}	
		
	sets.midcast.EnfeeblingMagic = {main="Grioavolr",sub="Clerisy Strap",ammo="Hydrocera",
		head="Merlinic Hood",neck="Incanter's torque",ear1="Enchanter Earring +1",ear2="Gwati Earring",
		body="Merlinic Jubbah",hands="EmpyHands",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Yamabuki-no-Obi",legs=EmpyLegs,feet="Merlinic Crackows"}

	sets.midcast.ElementalMagic = {main="Grioavolr",sub="Niobid Strap", ammo="Hydrocera",
		head="Merlinic Hood",neck="Eddy necklace",ear1="Friomisi Earring",ear2="Sortiarius Earring",
		body="Azimuth Coat +1",hands="Amalric Gages",ring1="Shiva Ring",ring2="Shiva Ring",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs=EmpyLegs,feet="Merlinic Crackows"}	
		
	--sets.midcast.Stun = {main="Twebuliij",sub="Benthos Grip",ammo="Plumose Sachet",
		--head="Atrophy Chapeau +1",neck="Voltsurge Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		--body="Vanir Cotehardie",hands="Lurid Mitts",ring1="Sangoma Ring",ring2="Weatherspoon Ring",
		--back="Ogapepo Cape",waist="Yamabuki-no-Obi",legs="Artsieq Hose",feet="Helios Boots"}
		
	sets.midcast.EnhancingMagic = {
		head="Befouled Crown",neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		ring2="Weatherspoon Ring", hands="Telchine gloves", back="Fi Follet cape",
		waist="Cascade Belt"}

		
	sets.midcast.IndiSpells = {main="Solstice",
	head=EmpyHead, 	body=EmpyBody,	hands=AFHands, 
	back="Lifestream Cape", legs=RelicLegs,feet=EmpyFeet}
	
	sets.midcast.GeoSpells = set_combine(sets.midcast.IndiSpells, {legs=EmpyLegs})
	
	--sets.midcast.Cursna = {main="Beneficus",
	--	head="Orison Cap +2",neck="Malison medallion", ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",ring1="Ephedra ring", ring2="Sirona's ring",
	--	back="Mending cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}
		
	--sets.midcast.DebuffRemoval = {	
	--	head="Orison Cap +2",neck="Malison medallion",ear2="Loquacious Earring",
	--	body="Orison Bliaud +2",hands="Orison Mitts +2",
	--	back="Swith Cape",waist="Cetl Belt",legs="Orison Pantaloons +2",feet='Gendewitha Galoshes'	}

	sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Hydrocera",
			head="Vanya Hood",neck="Incanter's torque",ear1="Etiolation earring",ear2="Loquacious earring",
			hands="Telchine gloves",ring1="Sirona's Ring",ring2="Ephedra Ring",body="Helios Jacket",
			back="Pahtli cape",waist="Cascade belt",legs="Doyen pants",feet="Vanya Clogs"}
		
	sets.TH = {waist="Chaac Belt"}

		
	organizer_items = { 	echos="Echo Drops",
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
	Oils="Silent Oil",}

	send_command('bind f12 input /equip Feet "Geomancy Sandals"')

	send_command('bind f9 gs c nextTH')
	send_command('bind pause send @others "input /follow Julika"')
	send_command('bind f10 gs c changeStaff')

	windower.register_event('zone change', function()
		hasPet = false
		equip(sets.Idle.Standard)
		end)

	send_command('bind f12 gs c switch pdt')

	text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("DamageTaken", "yellow")
end

function updateTable()
    addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    update_message()
end

-- --- Precast ---

function precast(spell)
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') or string.find(spell.type, 'Geomancy') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cur') then 
				equip(sets.precast.FastCure)
				--send_command('input /echo "Cure"')
			else		
				equip(sets.precast['FastCast'])
				--send_command('input /echo "FC"')
			end
		else		
			equip(sets.precast['FastCast'])
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
		equip(sets.precast['FastCast'])
	end
	if (string.find(spell.name,'Bolster')) then
		equip({body="Bagua Tunic"})
	end
	if (spell.english == "Life Cycle") then 
		equip({body="Geomancy Tunic"})
	end
	if (spell.english == "Radial Arcana") then
		equip({Feet="Bagua Sandals +1"})
	end
end
-- --- MidCast ---
function midcast(spell)
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if string.find(spell.skill,'Healing Magic') then
			if string.find(spell.english, 'Cura') or string.find(spell.english, 'Cure') then 
				set = set_combine(sets.midcast.Cure, {})
			elseif string.find(spell.english,'Cursna') then
				set = set_combine(sets.precast.FastCast, {})
			elseif string.find(spell.english, 'na') then 
				set = set_combine(sets.precast.FastCast, {})
			elseif string.find(spell.english, 'Erase') then
				set = set_combine(sets.precast.FastCast, {})
			elseif string.find(spell.english, 'Raise') then
				set = set_combine(sets.precast.FastCast	, {})
			else
				set = set_combine(sets.precast.FastCast, {})
			end
		
		elseif string.find(spell.skill,'Enhancing Magic') then
			set = set_combine(sets.midcast.EnhancingMagic, {})

		elseif string.find(spell.skill,'Enfeebling Magic') or string.find(spell.skill, 'Divine Magic') then
			set = set_combine(sets.midcast.EnfeeblingMagic, {})
			
		elseif string.find(spell.skill,'Elemental Magic') then
			set = use_obi(spell, sets.midcast.ElementalMagic)
		else
			set = set_combine(sets.precast.FastCast, {})
		end
	elseif string.find(spell.type, 'Geomancy') then
		if string.find(spell.english, 'Indi') then
			set = set_combine(sets.midcast.IndiSpells, {})
		else
			set = set_combine(sets.midcast.GeoSpells, {})
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
    equip_idle()    
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
		equip(sets.Idle['Standard'])
		--enable("Main")
	end
end

function equip_idle()
	equip(sets.Idle[sets.Idle.index[Idle_Index]])
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
	if command == 'switch pdt' then
		Idle_Index = Idle_Index +1
        if Idle_Index > #sets.Idle.index then Idle_Index = 1 end
        add_to_chat(140, '<----- Idle Set changed to '..sets.Idle.index[Idle_Index]..' ----->')
        equip(sets.Idle[sets.Idle.index[Idle_Index]])
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