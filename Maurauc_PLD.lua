require('closetCleaner')
include('organizer-lib.lua')

capeLocked = false
weaponLocked = false
--To toggle gearsets:
--Main command: //gs c toggle x set       where x = set name variable. Variables are as follows: --
--Idle sets: Idle, Melee TP sets: MTP, Ranged TP sets: RTP--
--Shoha sets: Shoha, Fudo sets: Fudo, Kaiten sets: Kaiten, Apex Arrow sets: Apex, Namas Arrow sets: Namas--

--TO ADD YOUR OWN WEAPON-SPECIFIC SETS:--
--Change the TP set index, toggle information at the bottom of the lua, and set names to your desired weapon. For example,--
--sets.AmanoTP.Standard for the Amanomurakumo standard TP set. Duplicate this as many times as you need to for your desired effect.--

function get_sets()

		--Idle Sets--
	sets.Idle = {legs="Carmine Cuisses +1"}		
	sets.TP = {}
	
	sets.TP.Standard={
	    main={ name="Brilliance", augments={'Shield skill +6','Divine magic skill +13','Enmity+3',}},
    sub="Ochain",
    ammo="Vanir Battery",
    head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst mdg.+10%','"Refresh"+1',}},
    body="Chev. Cuirass +1",
    hands={ name="Yorium Gauntlets", augments={'Accuracy+18 Attack+18','"Regen"+2','Weapon skill damage +3%',}},
    legs="Chev. Cuisses +1",
    feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
    neck="Loricate Torque +1",
    waist="Nierenschutz",
    left_ear="Etiolation Earring",
    right_ear="Brutal Earring",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Magic dmg. taken -4%','Spell interruption rate down -3%',}},
    back={ name="Weard Mantle", augments={'VIT+1','DEX+2','Enmity+6',}}
	}
	
	sets.TP.Set2={
    main="Nixxer",
    sub="Ochain",
    ammo="Vanir Battery",
    head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst mdg.+10%','"Refresh"+1',}},
    body="Souveran Cuirass",
    hands="Reverence Gauntlets +1",
    legs="Chev. Cuisses +1",
    feet="Souveran Schuhs",
    neck="Loricate Torque +1",
    waist="Nierenschutz",
    left_ear="Etiolation Earring",
    right_ear="Thureous Earring",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -3%','Magic dmg. taken -4%','Spell interruption rate down -3%',}},
    back={ name="Weard Mantle", augments={'VIT+1','DEX+2','Enmity+6',}},
	}
	
	sets.WS = {}
	
	sets.WS.CDC = { head="Valorous Mask", neck="Rancor Collar", ear1="Moonshade Earring", ear2="Brutal Earring",
					body="Valorous Mail", hands="Odyssean Gauntlets", ring1="Patricius Ring", ring2="Rajas Ring",
					back="Kayapa Cape", waist="Olseni Belt", legs="Brontes Cuisses", feet="Founder's Greaves",}
	
	organizer_items = { 
	main="Echo Drops", ranged="Cream Puff",
	head="Rabbit Cap",ear1="Reraise Earring",
	ring1="Warp Ring",ring2="Capacity Ring",
	back="Mecistopins Mantle"}	
	
	sets.casting = {}
	
	sets.casting.FC = { 
	ammo="Incantor Stone", 
	head="Carmine Mask", neck="Voltsurge Torque", ear1="Etiolation Earring", ear2="Loquacious Earring", 
	body="Odyssean Chestplate",hands="Leyline Gloves",ring1="Stikini Ring", ring2="Weatherspoon Ring",
	waist="Siegel Sash", legs="Carmine Cuisses +1", feet="Carmine Greaves", }
	
	sets.casting.MAcc = set_combine(sets.casting.FC, {head="Jumalik Helm", body="Founder's Breastplate", hands="Leyline Gloves", neck="Voltsurge Torque", ear1="Lifestorm Earring", ear2="Psystorm Earring",
		ring1="Stikini Ring"})
	
	sets.DE = {feet="Creed Sabatons +2"}
	sets.Invincible = {legs="Caballarius Breeches"}
	sets.Sentinel = {feet="Valor Leggings +2"}
end

		
function precast(spell)
	
	if spell.english == 'Divine Emblem' then
		equip(sets.DE)
	end
	
	if spell.english == 'Chant du Cygne' or spell.english == 'Requiescat' or spell.english == 'Savage Blade' then
		equip(sets.WS.CDC)
 	end
	
	if spell.english == 'Sentinel' then
		equip(sets.Sentinel)
	end
	
	if spell.english == 'Invincible' then
		equip(sets.Invincible)
	end
	
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		equip(sets.casting.FC)
	end

end

function midcast(spell)
	if string.find(spell.type,'WhiteMagic') or string.find(spell.type,'BlackMagic') then
		if spell.english == 'Reprisal' then
			equip(sets.casting.FC)
		elseif string.find(spell.skill,'Healing Magic') then
			equip(sets.TP.Set2)
		elseif string.find(spell.skill,'Divine Magic') then
			equip(sets.casting.MAcc)
		else
			equip(sets.TP.Set2)
		end
	else
		equip(sets.TP.Set2)
	end
end

function aftercast(spell,act)
if player.status == 'Engaged' then
		equip(sets.TP.Set2)
	else
		equip(sets.TP.Set2)
	end
end

function status_change(new,old)
	if new == 'Engaged' then
		equip(sets.TP.Set2)
	else
		equip(sets.TP.Set2)
	end
end

function self_command(command)
	if command == 'toggle MTP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'toggle Idle set' then
		Idle_ind = 1
		if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
		send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == 'toggle Shoha set' then
		Shoha_ind = Shoha_ind +1
		if Shoha_ind > #sets.Shoha.index then Shoha_ind = 1 end
		send_command('@input /echo <----- Tachi: Shoha Set changed to '..sets.Shoha.index[Shoha_ind]..' ----->')
    elseif command == 'toggle Fudo set' then
		Fudo_ind = Fudo_ind +1
		if Fudo_ind > #sets.Fudo.index then Fudo_ind = 1 end
		send_command('@input /echo <----- Tachi: Fudo Set changed to '..sets.Fudo.index[Fudo_ind]..' ----->')
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