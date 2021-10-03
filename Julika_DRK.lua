require('closetCleaner')
include('organizer-lib.lua')
include('displayBox.lua')

-- Local Settings, setting the zones prior to use
toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

areas = {}
areas.AdoulinCity = S{'Eastern Adoulin','Western Adoulin','Mog Garden','Celennia Memorial Library'}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
	"Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}

elements = {}
elements.use_on_single_conflict = false
elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}

capeLocked = false
weaponLocked = false


capeTP = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken -5%'}}
capeWS = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

-- Start Functions here
-- Gear Sets
function get_sets()

	-- Trishula = "Trishula"
	-- Chango = "Chango"
	Montante = "Montante +1"
	Grip = "Utu Grip"

	AFHead = "Ignominy Burgonet +2"
	AFBody = "Ignominy Cuirass +1"
	AFHands = "Ignominy Gauntlets +1"
	AFLegs = "Ignominy Flanchard +1"
	AFFeet = "Ignominy Sollerets +1"

	RelicHead = "Fallen's Burgeonet +2"
	RelicBody = "Fallen's Cuirass +2"
	RelicHands = "Fallen's Finger Gauntlets +2"
	RelicLegs = "Fallen's Flanchard +2"
	RelicFeet = "Fallen's Sollerets +2"

	EmpyHead = ""
	EmpyBody = ""
	EmpyHands = ""
	EmpyLegs = ""
	EmpyFeet = ""

	CapeTP = {}

	sets.Idle = {
	    ammo="Coiste Bodhar",
	    head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Carmine Cuisses +1",
	    feet="Sakpata's Leggings",
	    neck="Asperity Necklace",
	    left_ear="Cessance Earring",
	    right_ear="Telos Earring",
	    left_ring="Defending Ring",
	    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
	}

	sets.TP = {};
	sets.TP.index = {'Standard', 'DT'}
	TP_ind = 1
	
	sets.Weapons = {
		main="Shining One",
		sub="Utu Grip"
	}

	sets.TP.Standard = {
	    ammo="Coiste Bodhar",
	    head="Sakpata's Helm",
	    body="Sakpata's Plate",
	    hands="Sakpata's Gauntlets",
	    legs="Sakpata's Cuisses",
	    feet="Sakpata's Leggings",
	    neck="Asperity Necklace",
	    waist="Ioskeha Belt +1",
	    left_ear="Cessance Earring",
	    right_ear="Telos Earring",
	    left_ring="Chirich Ring +1",
	    right_ring="Niqmaddu Ring",
	    -- back="" --Ambu Cape
	}

	sets.DT = set_combine(sets.TP.Standard, {    
	
	})

	sets.TP.DT = sets.DT

	sets.WS = {}

	sets.WS = {
	    ammo="Knobkierrie",
	    head="Sakpata's Helm",
	    body="Sakpata's Breastplate",
	    hands="Sakpata's Gauntlets",
	    legs="Sakpata's Cuisses",
	    feet="Sakpata's Leggings",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Thrud Earring",
	    right_ear="Moonshade Earring",
	    left_ring="Niqmaddu Ring",
	    right_ring="Regal Ring",
	    -- back=capeWS
	}

	sets.WS["Resolution"] = set_combine(sets.WS, { --STR, Multi Attack
			left_ear="Telos Earring",

	})

	sets.WS["Torcleaver"] = set_combine(sets.WS, { --WSD

	})

	--SPELLS--

	sets.FastCast = {
		body=RelicBody,
		neck="Incanter's Torque",
		ear1="Etiolation Earring",
		ear2="Enchanter's Earring +1",
		ring1="Kishar Ring",

	}

	sets.FastCast.DarkMagic = set_combine(sets.FastCast, {
		head=RelicHead
	})


	sets.DarkMagic = {
		hands=RelicHands
	}

	sets.Absorb = set_combine(sets.DarkMagic,{
		head=AFHead,
		back="Ankou's Mantle"
	})

	sets.HP = set_combine(sets.Absorb, { --DREAD SPIKES

	})
	--JA--

	sets.JA = {}

	sets.JA["Souleater"] = {}
	sets.JA["Blood Weapon"] = {
		body=RelicBody
	}
	sets.JA["Arcane Circle"] = {
		feet=AFFeet
	}
	sets.JA["Arcane Crest"] = sets.JA["Arcane Circle"]

	sets.JA["Last Resort"] = {
		feet=RelicFeet,
		back="Ankou's Mantle"
	}
	sets.JA["Weapon Bash"] = {
		hands=AFHands
	}
	sets.JA["Dark Seal"] = {
		head=RelicHead
	}
	sets.JA["Diabolic Eye"] = {
		hands=RelicHands
	}
	sets.JA["Nether Void"] = {}
	sets.JA["Scarlet Delirium"] = {}
	sets.JA["Consume Mana"] = {}

    send_command('bind f10 gs c toggle TP set')

 	text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("Potency", "green")
    addTextColorPair("Accuracy", "yellow")
    addTextColorPair("DT", "yellow")
end

function updateTable()
    addToTable("(F10) TP Set", sets.TP.index[TP_ind])
    update_message()
end

-- --- Precast ---

function precast(spell)

	if spell.type == 'WeaponSkill' then
		if spell.name == "Torcleaver" then
			equip(sets.WS.Torcleaver)
		elseif spell.name == "Resolution" then
			equip(sets.WS.Resolution)
		else
			equip(sets.WS)
		end
	elseif spell.type == "JobAbility" then
		equip(sets.JA[spell.name])
	elseif spell.type == "BlackMagic" then
		if (spell.skill == "Dark Magic" or spell.skill == "DarkMagic") then
			equip(sets.FastCast.DarkMagic)
		else
			equip(sets.FastCast)
		end
	elseif spell.type == "Trust" then
		equip(sets.FastCast)
	else

	end

end
-- --- MidCast ---
function midcast(spell)
	if spell.type == "BlackMagic" then
		if (string.find(spell.name, "Absorb")) then
			equip(sets.Absorb)
		elseif (string.find(spell.name, "Drain II") or spell.name == "Dread Spikes") then
			equip(sets.HP)
		end
	end
end	

-- --- Aftercast ---



function aftercast(spell)
	if player.status == 'Engaged' then
        equip_TP()
    else
    	equip_Idle()
    end
end

-- Status Change - ie. Resting

function equip_TP()
	-- equip(sets.TP)
	equip(sets.TP[sets.TP.index[TP_ind]])
end

function equip_Idle()
    equip(sets.Idle)
end

function status_change(new,tab)
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
		--disable("Main")
	else
		equip(sets.Idle)
		--enable("Main")
	end
end

function self_command(command)
	 if command == 'toggle TP set' then
        TP_ind = TP_ind + 1
        if TP_ind > #sets.TP.index then TP_ind = 1 end
        send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
        equip(sets.TP[sets.TP.index[TP_ind]])
    end
    updateTable()
end