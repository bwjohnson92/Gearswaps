--[[    Custom strategem commands:
        Shorthand versions for each strategem type that uses the version appropriate for the current Arts.
									Light Arts	             Dark Arts
        gs c light             		Light Arts/Addendum
        gs c dark                   	               		 Dark Arts/Addendum
        gs c StratCost               Penury                  Parsimony
        gs c StratSpeed              Celerity                Alacrity
        gs c StratAoE                Accession               Manifestation
        gs c StratPower              Rapture                 Ebullience
        gs c StratDuration           Perpetuance
        gs c StratAccuracy           Altruism                Focalization
        gs c StratEnmity             Tranquility             Equanimity
        gs c StratSkillchain                                 Immanence		--]]
		
--[[	Custom nuking commands:		--Fit all nukes, helices, storms, cures, and more into one macro set!--
		First, select the element for the spell you want to cast using the command in the Element Commands collumn below.
		Then to cast a spell of that element, use the commands from the 2nd collumn labled Casting Commands.
		
		Example: Say you want to cast Aero IV. First you'd toggle to Aero mode with a 'gs c Aero' macro.
		Then you'd trigger the casting of Aero IV with a 'gs c T4' macro. If you wanted to cast Fire IV next
		you'd use a 'gs c Fire' macro followed by the exact same 'gs c T4' macro you just used to cast Aero IV.
		
		Notes:
		Selecting an element will never cast anything.
		Element selection will stay in effect until you toggle a new one. This means you don't have to reselect an element every cast.
		To the right of the commands is a list of all the available spells while toggled to that element.
		Dark element's available spells is unusual. T1 casts Aspir, T2 casts Aspir II, T3 casts Drain, T4 casts Dispel and T5 is unused.
		Cures use <stal> targeting, storms use <stpt> targeting and everything else is <t>.
		
		Element Commands:		 Available spells: (T1-T5, Helix, Weather)
		gs c Stone				[Stone 1-5, Geohelix, Sandstorm]
		gs c Water				[Water 1-5, Hydrohelix, Rainstorm]
		gs c Aero				[Aero 1-5, Anemohelix, Windstorm]
		gs c Fire				[Fire 1-5, Pyrohelix, Firestorm]
		gs c Blizzard			[Blizzard 1-5, Cryohelix, Hailstorm]
		gs c Thunder			[Thunder 1-5, Ionohelix, Thunderstorm]
		gs c Cure				[Cure 1-4 (with <stal> targeting), Luminohelix, Aurorastorm]
		gs c Dark				[Aspir I&II(T1,T2),Drain(T3), Dispel(T4), Noctohelix, Voidstorm]

		Casting Commands: (T is short for Tier)
		gs c T1
		gs c T2
		gs c T3
		gs c T4
		gs c T5
		gs c Helix
		gs c Weather		--]]

include('organizer-lib')
organizer_items = {CPring = "Capacity Ring",
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
        remedy="Remedy",
        Crepe="Pear Crepe",}

-- send_command('input /macro book 2;input /macro set 8;wait 1;input /lockstyleset 21')--Automatically sets lockstyle and macro book/set one time upon loading.
function get_sets()
	--Automatically swap to movement speed shoes in town. Equips refresh feet after first cast of any spell besides Sneak, Invisible or Trusts.
	Cities = S{"Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno","Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower",
		"Port San d'Oria","Northern San d'Oria","Southern San d'Oria","Port Bastok","Bastok Markets","Bastok Mines","Metalworks","Aht Urhgan Whitegate",
		"Tavanazian Safehold","Nashmau","Selbina","Mhaura","Norg","Eastern Adoulin","Western Adoulin","Kazham"}
	windower.register_event('zone change', function()
		if RefreshFeet_ind == 1 then
			if Cities[world.area] and not world.area:contains('Dynamis') then
			RefreshFeet_ind = 0 send_command('wait 1;gs c Update')
			end
		end
    end)
--Precast sets
	-- FC_head = {name="Merlinic Hood",augments={'Mag. Acc.+6','"Fast Cast"+7','MND+8'}}
	FC_head = "Nahtirah Hat"
	-- FC_legs = {name="Psycloth Lappas",augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}}
	FC_legs = "Psycloth Lappas"
	FC_feet = { name="Merlinic Crackows", augments={'Mag. Acc.+5 "Mag.Atk.Bns."+5','"Fast Cast"+4','Mag. Acc.+13','"Mag.Atk.Bns."+6',}}
	-- FC_feet = {name="Merlinic Crackows",augments={'"Fast Cast"+7','Mag. Acc.+9'}}
	-- FC_back = {name="Lugh's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','MND+5'}}
	FC_back = "Swith Cape +1"

	sets.precast = {
	-- main="Sucellus",
	ammo="Incantor Stone",
	head=FC_head,
	neck="Voltsurge Torque",
	lear="Etiolation Earring",
	rear="Loquac. Earring",
	body="Merlinic Jubbah",
	-- hands="Otomi Gloves",
	hands="Gendewitha Gages +1",
	lring="Weatherspoon Ring",
	rring="Kishar Ring",
	back=FC_back,
	waist="Channeler's Stone",
	legs=FC_legs,
	feet=FC_feet
		}--74%; w/ Kishar Ring 78%; Mer hands?
	
	sets.precast.Elemental = {lear="Barkaro. Earring"}
    sets.precast.Cure = {lear="Mendi. Earring"}
    sets.precast.Impact = {head=empty,body="Twilight Cloak"}
--Midcast sets

	Nuke_head = { name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+2','MND+9','Mag. Acc.+7',}}
	Nuke_body = { name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','MND+5','"Mag.Atk.Bns."+15',}}
	Nuke_hands = { name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
	Nuke_legs = "Gyve Trousers"
	Nuke_feet = { name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-3','CHR+9','Mag. Acc.+3','"Mag.Atk.Bns."+5',}}
	Nuke_back = {name="Lugh's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','INT+10'}}
	MB_feet = { name="Merlinic Crackows", augments={'Mag. Acc.+29','Magic burst dmg.+8%','"Mag.Atk.Bns."+5',}}
	
	sets.midcast = {}
	
	sets.midcast.ConserveMP = {head="Vanya Hood",neck="Incanter's Torque",lear="Gifted Earring",rear="Magnetic Earring",body="Vanya Robe",
		back="Solemnity Cape",waist="Austerity Belt +1",legs="Lengo Pants",feet="Medium's Sabots"}--28 base + 44 gear + 12 Grioavolr
	
	sets.midcast.Nuke = {
		-- main="Grioavolr",
		-- sub="Enki Strap",
		ammo="Phantom Tathlum",
		head=Nuke_head,
		neck="Mizu. Kubikazari",
		lear="Barkaro. Earring",
		rear="Friomisi Earring",
		body=Nuke_body,
		hands=Nuke_hands,
		lring="Shiva Ring",
		rring="Shiva Ring +1",
		back=Nuke_back,
		waist="Channeler's Stone",
		legs=Nuke_legs,
		feet=Nuke_feet
	}
	
	sets.midcast.NukeMP = {body="Seidr Cotehardie"}
	NukeMP_ind = 1
	
	sets.midcast.Nuke.Klimaform = {feet="Arbatel Loafers +1"}
	
	sets.midcast.Obi = {waist="Hachirin-no-Obi"}
	
	sets.midcast.Day = {lring="Zodiac Ring"}
	
	sets.midcast.MB = {neck="Mizu. Kubikazari",lring="Locus Ring",rring="Mujin Band",back="Seshaw Cape",feet=MB_feet} -- 39% + 10% II
	
	sets.midcast.Impact = {head=empty,neck="Incanter's Torque",lear="Barkaro. Earring",rear="Gwati Earring",body="Twilight Cloak",hands="Amalric Gages +1",
		rring="Stikini Ring",lring="Stikini Ring",back=Nuke_back,waist="Channeler's Stone",legs=Nuke_legs,feet=Nuke_feet}
	
	sets.midcast.Kaustra = set_combine(sets.midcast.Nuke,{head="Pixie Hairpin +1"})
	
	sets.midcast.Stun = {main="Grioavolr",sub="Enki Strap",ammo="Hydrocera",head=FC_head,neck="Voltsurge Torque",lear="Gwati Earring",rear="Loquac. Earring",
		body="Anhur Robe",hands="Otomi Gloves",lring="Prolix Ring",rring="Stikini Ring",back="Merciful Cape",waist="Goading Belt",legs=FC_legs,feet=FC_feet}
	
	sets.midcast.Drain = {main="Rubicundity",sub=empty,ammo="Hydrocera",head="Pixie Hairpin +1",neck="Incanter's Torque",lear="Barkaro. Earring",
		rear="Gwati Earring",body="Witching Robe",hands="Amalric Gages +1",lring="Excelsis Ring",rring="Evanescence Ring",
		back="Merciful Cape",waist="Fucho-no-Obi",legs=Nuke_legs,feet=Nuke_feet}
	
	sets.midcast.MaxMND = {main="Grioavolr",sub="Enki Strap",ammo="Hydrocera",head="Chironic Hat",neck="Mizu. Kubikazari",lear="Barkaro. Earring",
		rear="Gwati Earring",body="Vanya Robe",hands="Amalric Gages +1",lring="Stikini Ring",rring="Stikini Ring",back=FC_back,waist="Cascade Belt",
		legs={name="Psycloth Lappas",augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},feet="Medium's Sabots"}--Gada+Amm
	
	sets.midcast.Enfeebling = {neck="Incanter's Torque"}
	
	sets.midcast.Cure = {main="Tamaxchi",sub="Sors Shield",ammo="Psilomene",head="Gende. Caubeen",neck="Lasaia Pendant",lear="Novia Earring",body="Vanya Robe",
		hands="Otomi Gloves",lring="Stikini Ring",rring="Sirona's Ring",back="Solemnity Cape",legs=MB_legs,feet="Vanya Clogs"}--Potency=53,Enm-=51
	
	sets.midcast.CureMe = set_combine(sets.midcast.Cure,{lring="Vocane Ring +1"})
	
	sets.midcast.Cursna = {head="Vanya Hood",neck="Incanter's Torque",lring="Stikini Ring",rring="Sirona's Ring",waist="Goading Belt",feet="Vanya Clogs"}
	
	sets.midcast.Regen = {main="Bolelabunga",head="Arbatel Bonnet +1",back=FC_back}--back=Bookworm
	
	sets.midcast.Enhancing = {head="Befouled Crown",neck="Incanter's Torque",lear="Andoaa Earring",body="Telchine Chas.",lring="Stikini Ring",
		rring="Stikini Ring",back="Merciful Cape",waist="Olympus Sash"}--519 skill(/w all gifts), main="Gada" or "Grioavolr"
	
	sets.midcast.EnhancingDuration = {sub="Ammurapi Shield",head="Telchine Cap",body="Telchine Chas.",legs="Telchine Braconi",feet="Telchine Pigaches"}
	
	sets.midcast.Perpetuance = {hands="Arbatel Bracers +1"}
	
	sets.midcast.Storm = {feet="Argute Loafers +2"}
	
	sets.midcast['Protect V'] = {lring="Sheltered Ring"}
	
	sets.midcast['Shell V'] = {lring="Sheltered Ring"}
	
	sets.midcast.Aquaveil = {head="Chironic Hat"}
	
	sets.midcast.Ninjutsu = {head="Vanya Hood",waist="Goading Belt"}
	
	sets.Doom = {lring="Purity Ring"}
	
	sets.TH = {waist="Chaac Belt",legs={name="Merlinic Shalwar",augments={'"Repair" potency +1%','Pet: Accuracy+20 Pet: Rng. Acc.+20','"Treasure Hunter"+1'}}}
--Idle sets
	Idle_feet = {name="Merlinic Crackows",augments={'AGI+9','"Mag.Atk.Bns."+18','"Refresh"+1','Accuracy+11 Attack+11','Mag. Acc.+1 "Mag.Atk.Bns."+1'}}
	
	sets.Idle = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",head="Befouled Crown",neck="Loricate Torque +1",
		lear="Hearty Earring",rear="Infused Earring",body="Witching Robe",hands="Merlinic Dastanas",lring="Sheltered Ring",
		rring="Defending Ring",back="Moonbeam Cape",waist="Eschan Stone",legs="Assid. Pants +1",feet="Herald's Gaiters"}
	
	sets.Idle.RefreshFeet = {feet=Idle_feet}
	
	sets.Idle.RefreshWaist = {body="Jhakri Robe +2",waist="Fucho-no-obi"}
	RefreshFeet_ind = 0
	
	sets.Idle.FullMP = {body="Mallquis Saio +2"}
--	
sets.Idle.Sublimation = {rear="Savant's Earring"}
	
	sets.Idle.Rest = set_combine(sets.Idle,{lear="Magnetic Earring",waist="Austerity Belt +1"})
--TP sets
	
	sets.TP = {}
	
	sets.TP.Off = {}
	
	sets.TP.DT = {ammo="Staunch Tathlum",neck="Loricate Torque +1",body="Mallquis Saio +2",lring="Vocane Ring +1",rring="Defending Ring",back="Moonbeam Cape"}
	
	sets.TP.DT.index = {'Off','DT'}
	DT_ind = 1
--WS sets
	
	sets.WS = {ammo="Floestone",head="Chironic Hat",neck="Fotia Gorget",lear="Moonshade Earring",rear="Brutal Earring",body="Onca Suit",hands=empty,
		lring="Shukuyu Ring",rring="Rajas Ring",back="Rancorous Mantle",waist="Grunfeld Rope",legs=empty,feet=empty}
	
	sets.WS.Myrkr = {ammo="Psilomene",head="Pixie Hairpin +1",neck="Eddy Necklace",lear="Moonshade Earring",rear="Etiolation Earring",
		body="Witching Robe",hands="Otomi Gloves",lring="Mephitas's Ring +1",rring="Mephitas's Ring",
		back="Merciful Cape",waist="Shinjutsu-no-Obi +1",legs="Amalric Slops",feet="Medium's Sabots"}
--JA sets
	
	sets.JA = {}
	
	sets.JA['Tabula Rasa'] = {legs="Argute Pants +2"}
	
--Nuking shortcut tables
	
	sets.Element = {'Stone','Water','Aero','Fire','Blizzard','Thunder','Cure','Aspir'}
	
	sets.Helix = {'Geohelix','Hydrohelix','Anemohelix','Pyrohelix','Cryohelix','Ionohelix','Luminohelix','Noctohelix'}
	
	sets.Weather = {'Sandstorm','Rainstorm','Windstorm','Firestorm','Hailstorm','Thunderstorm','Aurorastorm','Voidstorm'}
	Element_ind = 5
end
MB_ind = 0
Weapon_ind = 1
TH_ind = 0

-- Precast
function precast(spell)
	if spell.type~="JobAbility" and spell.type~="WeaponSkill" and spell.type~="Scholar" then
		equip(sets.precast)
		if spell.skill=="Elemental Magic" then
			equip(sets.precast.Elemental)
			if spell.name == "Impact" then
				equip(sets.precast.Impact)
			end
		elseif spell.type=="WhiteMagic" then
			if string.find(spell.name,'Cure') or string.find(spell.name,'Curaga') then
				equip(sets.precast.Cure)
			elseif string.find(spell.name,'Reraise') and buffactive.reraise then
				windower.ffxi.cancel_buff(113)
			elseif spell.name == 'Stoneskin' and buffactive.stoneskin then
				windower.ffxi.cancel_buff(37)
			end
		end
		if RefreshFeet_ind == 0 then
			if spell.english~="Sneak" and spell.english~="Invisible" and spell.english~="Reraise" and spell.english~="Reraise III" and spell.type~="Trust" then 
			RefreshFeet_ind=1 end
		end
	elseif spell.type=="JobAbility" then
		equip(sets.JA[spell.english])
	elseif spell.type=="WeaponSkill" then
		if sets.WS[spell.english] then equip(sets.WS,sets.WS[spell.english])
		else
			equip(sets.WS)
		end
	elseif spell.type=="Jig" then
		if spell.name == 'Spectral Jig' and buffactive.sneak then
			windower.ffxi.cancel_buff(71)
		end
	end
end

-- Midcast
function midcast(spell)
	if spell.type~="JobAbility" and spell.type~="WeaponSkill" and spell.type~="Scholar" then
		equip(sets.midcast.ConserveMP)
		if spell.type=="BlackMagic" then
			if spell.skill=="Elemental Magic" then
				equip(sets.midcast.Nuke)
				weathercheck(spell.element)
				if MB_ind == 1 then
					equip(sets.midcast.MB)
				end
				if NukeMP_ind == 1 then
					equip(sets.midcast.NukeMP)
				end
--				if buffactive.Klimaform then equip(sets.midcast.Nuke.Klimaform) end
				if spell.name == "Impact" then equip(sets.midcast.Impact) end
			elseif spell.skill=="Enfeebling Magic" then
				equip(sets.midcast.MaxMND)
				if string.find(spell.name,"Poison") or string.find(spell.name,'Sleep') or spell.name=='Gravity' or spell.name=="Bind" then
					equip(sets.midcast.Enfeebling)
				end
			elseif spell.skill=="Dark Magic" then
				if spell.name=="Drain" or string.find(spell.name,"Aspir") then
					equip(sets.midcast.Drain)
				elseif spell.name=="Stun" then equip(sets.midcast.Stun) 
				elseif spell.name=="Kaustra" then equip(sets.midcast.Kaustra)
				end
			elseif spell.skill=="Enhancing Magic" then
				equip(sets.midcast.EnhancingDuration)
			end
		elseif spell.type=="WhiteMagic" then
			if spell.skill=="Healing Magic" then
				if string.find(spell.name,'Cure') or string.find(spell.name,'Curaga') then
					equip(sets.midcast.Cure)
					weathercheck(spell.element)
					if spell.target.type=="SELF" then equip(sets.midcast.CureMe) end
				elseif spell.name=="Cursna" then equip(sets.midcast.Cursna)
				end
			elseif spell.skill=="Enhancing Magic" then
				equip(sets.midcast.EnhancingDuration)
				if sets.midcast[spell.english] then equip(sets.midcast[spell.english])
				elseif string.find(spell.name,'Regen') then
					equip(sets.midcast.Regen)
				elseif string.find(spell.name,'storm') then
					equip(sets.midcast.Storm)
				elseif spell.name=="Phalanx" or spell.name=="Embrava" or string.find(spell.name,'Bar') then
					equip(sets.midcast.Enhancing,sets.midcast.EnhancingDuration)
				elseif string.find(spell.name,'En') then
					equip(sets.midcast.Enhancing)
				end
				if buffactive.Perpetuance then equip(sets.midcast.Perpetuance) end
			elseif spell.skill=="Enfeebling Magic" then
				if spell.name=="Slow" or spell.name=="Paralyze" then
					equip(sets.midcast.MaxMND)
				elseif spell.name=="Silence" then
					equip(sets.midcast.MaxMND,sets.midcast.Enfeebling)
				end
			elseif spell.skill=="Divine Magic" then
				equip(sets.midcast.MaxMND)
			end
		elseif spell.type=="Ninjutsu" then
			equip(sets.midcast.Ninjutsu)
		end
	end
end

-- Aftercast
function aftercast(spell)
	if TH_ind == 1 then
		enable('waist','legs')
		TH_ind = 0
	end
	equip(sets.Idle,sets.TP[sets.TP.DT.index[DT_ind]])
	if buffactive.Shell and buffactive.Protect then equip({lring="Vocane Ring +1"}) end
--	if buffactive['Sublimation: Activated'] then equip(sets.Idle.Sublimation) end
	if player.mpp < 45 then equip(sets.Idle.RefreshWaist) end
	if RefreshFeet_ind==1 then equip(sets.Idle.RefreshFeet) end
	if player.status=="Resting" then equip(sets.Idle.Rest) end
	if player.mpp > 90 then equip(sets.Idle.FullMP)	end
end

function status_change(new,old)
	if new=="Resting" then
		equip(sets.Idle.Rest)
	else
		equip(sets.Idle,sets.TP[sets.TP.DT.index[DT_ind]])
		if buffactive.Shell and buffactive.Protect then equip({lring="Vocane Ring +1"}) end
--		if buffactive['Sublimation: Activated'] then equip(sets.Idle.Sublimation) end
		if player.mpp < 45 then equip(sets.Idle.RefreshWaist) end
		if RefreshFeet_ind==1 then equip(sets.Idle.RefreshFeet) end
		if player.mpp > 90 then equip(sets.Idle.FullMP)	end
	end
end

function buff_change(buff,gain_or_loss)
	if buff=="Doom" then
		if buffactive.Doom then
			equip(sets.Doom)
			disable('lring')
		else
			enable('lring')
			aftercast()
		end
	end
	if buff=="Light Arts" then
		if buffactive['Light Arts'] then
			-- send_command('input /lockstyleset 23')
		end
	elseif buff=="Dark Arts" then
		if buffactive['Dark Arts'] then
			-- send_command('input /lockstyleset 22')
		end
	end
end

function weathercheck(spell_element)
	if spell_element == world.day_element then
		equip(sets.midcast.Day,sets.midcast.Obi)
	end
	if  spell_element == world.weather_element or
		(spell_element == 'Lightning' and buffactive['Thunderstorm']) or 
		(spell_element == 'Ice' and buffactive['Hailstorm']) or 
		(spell_element == 'Water' and buffactive['Rainstorm']) or 
		(spell_element == 'Fire' and buffactive['Firestorm']) or 
		(spell_element == 'Earth' and buffactive['Sandstorm']) or 
		(spell_element == 'Wind' and buffactive['Windstorm']) or 
		(spell_element == 'Light' and buffactive['Aurorastorm']) or 
		(spell_element == 'Dark' and buffactive['Voidstorm']) then 
			equip(sets.midcast.Obi)
			if buffactive.Klimaform then equip(sets.midcast.Nuke.Klimaform) end --May want to remove MB check  and MB_ind == 0
	end	
end

--Variable controls
function self_command(command)
	if command == "T1" then
		if Element_ind == 7 then send_command('input /ma "'..sets.Element[Element_ind]..'" <stal>')
		else send_command('input /ma "'..sets.Element[Element_ind]..'" <t>') end
	elseif command == "T2" then
		if Element_ind == 7 then send_command('input /ma "'..sets.Element[Element_ind]..' II" <stal>')
		else send_command('input /ma "'..sets.Element[Element_ind]..' II" <t>') end
	elseif command == "T3" then
		if Element_ind == 7 then send_command('input /ma "'..sets.Element[Element_ind]..' III" <stal>')
		elseif Element_ind==8 then send_command('input /ma "Drain" <t>')
		else send_command('input /ma "'..sets.Element[Element_ind]..' III" <t>') end
	elseif command == "T4" then
		if Element_ind == 7 then send_command('input /ma "'..sets.Element[Element_ind]..' IV" <stal>')
		elseif Element_ind==8 then send_command('input /ma "Dispel" <t>')
		else send_command('input /ma "'..sets.Element[Element_ind]..' IV" <t>')
		end
	elseif command == "T5" then
		send_command('input /ma "'..sets.Element[Element_ind]..' V" <t>')
	elseif command == "Helix" then
		send_command('input /ma "'..sets.Helix[Element_ind]..' II" <t>')
	elseif command == "Weather" then
		send_command('input /ma "'..sets.Weather[Element_ind]..' II" <stpt>')
    elseif command == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif command == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
	elseif string.find(command,"Strat") then
		if buffactive['light arts'] or buffactive['addendum: white'] then
			if command == 'StratAoE' then
				send_command('input /ja Accession <me>')
			elseif command == 'StratDuration' then
				send_command('input /ja Perpetuance <me>')
			elseif command == 'StratCost' then
				send_command('input /ja Penury <me>')
			elseif command == 'StratSpeed' then
				send_command('input /ja Celerity <me>')
			elseif command == 'StratAccuracy' then
				send_command('input /ja Altruism <me>')
			elseif command == 'StratPower' then
				send_command('input /ja Rapture <me>')
			elseif command == 'StratEnmity' then
				send_command('input /ja Tranquility <me>')
			elseif command == 'StratSkillchain' then
				add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
			end
		elseif buffactive['dark arts']  or buffactive['addendum: black'] then
			if command == 'StratSkillchain' then
				send_command('input /ja Immanence <me>')
			elseif command == 'StratAoE' then
				send_command('input /ja Manifestation <me>')
			elseif command == 'StratCost' then
				send_command('input /ja Parsimony <me>')
			elseif command == 'StratPower' then
				send_command('input /ja Ebullience <me>')
			elseif command == 'StratSpeed' then
				send_command('input /ja Alacrity <me>')
			elseif command == 'StratAccuracy' then
				send_command('input /ja Focalization <me>')
			elseif command == 'StratEnmity' then
				send_command('input /ja Equanimity <me>')
			elseif command == 'StratDuration' then
				add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
			end
		else
			add_to_chat(123,'No arts has been activated yet.')
		end
	elseif command == "Stone" then Element_ind = 1 send_command('input /echo Stone!')
	elseif command == "Water" then Element_ind = 2 send_command('input /echo Water!')
	elseif command == "Aero" then Element_ind = 3 send_command('input /echo Aero!')
	elseif command == "Fire" then Element_ind = 4 send_command('input /echo Fire!')
	elseif command == "Blizzard" then Element_ind = 5 send_command('input /echo Blizzard!')
	elseif command == "Thunder" then Element_ind = 6 send_command('input /echo Thunder!')
	elseif command == "Cure" then Element_ind = 7 send_command('input /echo Cure!')
	elseif command == "Dark" then Element_ind = 8 send_command('input /echo Dark! Aspir 1, 2, Drain, Dispel')
	elseif command == "MB" then
		if MB_ind == 0 then 
			MB_ind = 1
			windower.add_to_chat(8,'----MB mode on!----')
		else
			MB_ind = 0 
			windower.add_to_chat(8,'----MB gear off.----')
		end
	elseif command == "Update" then
		aftercast()
	elseif command == "TH" then
		if NukeMP_ind == 0 then
			NukeMP_ind = 1
			windower.add_to_chat(8,'----Seidr mode on!----')
		else
			NukeMP_ind = 0
			windower.add_to_chat(8,'----Seidr mode off.----')
		end
	elseif command == "Treasure" then
		equip(sets.TH)
		disable('waist','legs')
		send_command('input /ma "Aspir" <t>')
		TH_ind = 1
	elseif command == "Speed" then
		if RefreshFeet_ind==1 then RefreshFeet_ind=0 windower.add_to_chat(8,'----Movement speed gear on.----')
		else RefreshFeet_ind=1 windower.add_to_chat(8,'----Refresh feet on.----')
		end
		aftercast()
	elseif command == "Sub" then
		if Weapon_ind==1 then
			Weapon_ind = 0
			equip({main="Grioavolr",sub="Enki Strap"})
			disable('main','sub')
			windower.add_to_chat(8,'----Weapon locked!----')
		else
			Weapon_ind = 1
			enable('main','sub')
			aftercast()
			windower.add_to_chat(8,'----Weapon unlocked.----')
		end
	elseif command == "DT" then
		DT_ind = DT_ind +1
		if DT_ind > #sets.TP.DT.index then DT_ind = 1 end
		windower.add_to_chat(8,'----'..sets.TP.DT.index[DT_ind]..'----')
		aftercast()
	end
end