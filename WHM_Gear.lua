function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
    state.CursnaMode = M{['description']='Cursna', 'AoE', 'Potency'}	
    send_command('bind f7 gs c cycle CursnaMode')
    select_default_macro_book()
end

function init_gear_sets()
	------------------------------------------------------------------------------------------------
	-------------------------------------- Alaunus's Cape ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	Alaunus = {}
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    sets.precast.FC = {
		main="Grioavolr", --10%
		sub="Enki strap", 
		ammo="Incantor Stone",--2%
        head="Nahtirah Hat",--10%
		neck="Orison Locket",--5%
		ear1="Loquacious earring",--2%
		ear2="Enchanter's Earring",--2%
        body="Inyanga Jubbah",--14%
		hands="Fanatic Gloves",--7%
		ring1="Lebeche Ring",
		ring2="Kishar Ring",--4%
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}},--10%
		waist="Embla Sash",--3% 
		legs="Pinga Pants",--11%
		feet="Regal Pumps +1"}--5 to 7%
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat", hands="Carapacho cuffs", legs="Doyen Pants",})
    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		head="Piety Cap +1",
		ear2="Nourishing earring +1",
		neck="Aceso's Choker +1",
		waist="Embla sash",
		legs="Ebers Pantaloons +1",
		feet="Hygieia Clogs +1"})
    	sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure

	------------------------------------------------------------------------------------------------
	---------------------------------- Job Abilities Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
    sets.precast.JA.Benediction = {body="Piety Briault +1"}
	sets.precast.JA.Devotion = {head="Piety Cap +1"}
    sets.precast.Waltz = {}
	
	------------------------------------------------------------------------------------------------
	------------------------------------ Weaponskill Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

    sets.precast.WS = {}
    sets.precast.WS['Flash Nova'] = {}
    
	------------------------------------------------------------------------------------------------
	---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    
    sets.midcast.FastRecast = {feet="Theophany duckbills +3"}
    sets.midcast.CureSolace = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Impatiens",
        head="Vanya Hood",
		neck="Incanter's Torque",
		ear1="Glorious Earring",	
		ear2="Mendicant's earring",
        body="Ebers Bliaud +1",
		hands="Theophany Mitts +3",
		ring1="Lebeche Ring",
		ring2="Janniston Ring",
        back="Alaunus's Cape",
		waist="Austerity Belt +1",
		legs="Ebers Pantaloons +1",
		feet="Vanya Clogs"}
    sets.midcast.Cure = {
		main="Queller Rod",--CP II 2%
		sub="Sors Shield",--3%
		ammo="Impatiens",
        head="Vanya Hood",--10%
		neck="Incanter's Torque",
		ear1="Glorious Earring",--CP II 2%
		ear2="Mendicant's earring",--5%
        body="Theo. Briault +3",--Cp II 6%
		hands="Theophany Mitts +3",--Cp II 4%
		ring1="Lebeche Ring", --3%
		ring2="Janniston Ring",--Cp II 5%
        back="Alaunus's Cape",
		waist="Austerity Belt +1",
		legs="Ebers Pantaloons +1",
		feet="Vanya Clogs"}--10%
    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.CureSolace, {
		main="Chatoyant Staff",
		sub="Achaq Grip",
		back="Twilight Cape",
		waist="Hachirin-no-Obi"})
    sets.midcast.Curaga = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Impatiens",
        head="Vanya Hood",
		neck="Nuna Gorget +1",
		ear1="Glorious Earring",
		ear2="Nourishing earring +1",
        body="Theo. Briault +3",
		hands="Theophany Mitts +3",
		ring1="Leviathan ring +1",
		ring2="Janniston Ring",
        back="Oretania's Cape +1",
		waist="Austerity Belt +1",
		legs="Ebers Pantaloons +1",
		feet="Vanya Clogs"}
    sets.midcast.CuragaWithLightWeather = set_combine(sets.midcast.Curaga, {
		main="Chatoyant Staff",
		sub="Achaq Grip",
		back="Twilight Cape",
		waist="Hachirin-no-Obi"})
    sets.midcast.CureMelee = {
		ammo="Impatiens",
        head="Vanya Hood",
		neck="Incanter's Torque",
		ear1="Glorious Earring",
		ear2="Nourishing earring +1",
        body="Theo. Briault +3",
		hands="Theophany Mitts +3",
		ring1="Lebeche Ring",
		ring2="Janniston Ring",
        back="Alaunus's Cape",
		waist="Austerity Belt +1",
		legs="Ebers Pantaloons +1",
		feet="Piety Duckbills +1"}
    sets.midcast.Cursna = {
		--main="Gambanteinn",
		sub="Sors Shield",
		ammo="Impatiens",
        head="Ebers Cap +1",
		neck="Malison Medallion",
        body="Ebers Bliaud +1",
		hands="Fanatic Gloves",
		ring1="Haoma's Ring",
		ring2="Sirona's Ring",
        back="Alaunus's Cape",
		waist="Witful Belt",
		legs="Theophany Pantaloons +3",
		feet="Gendewitha galoshes +1"}
    sets.midcast.StatusRemoval = {main="Yagrush",
		sub="Sors Shield", head="Ebers Cap +1",legs="Ebers Pantaloons +1"}
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})	
    sets.midcast['Enhancing Magic'] = {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Brachyura Earring",
        ring1="Stikini Ring",
		ring2="Stikini Ring",
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
        back="Mending Cape",
		waist="Embla Sash",
		legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
		feet="Theophany Duckbills +3"}
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})	
    sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {ear2="Regal earring",})
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		ear2="Earthcry Earring",
		waist="Siegel Sash",
		legs="Shedir Seraweels",})   
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",
		head="Chironic Hat",
		waist="Emphatikos Rope",
		legs="Shedir Seraweels",})
    sets.midcast.Auspice =  set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +1"})
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        head="Ebers Cap +1",
        body="Ebers Bliaud +1",
		hands="Ebers Mitts +1",
		legs="Piety pantaloons +2",
		feet="Ebers Duckbills +1"})
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga",
        body="Piety Briault +1",
		hands="Ebers Mitts +1",
        legs="Theophany Pantaloons +3"})
    sets.midcast.Protectra =  set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring",feet="Piety Duckbills +1"})
    sets.midcast.Shellra =  set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring",legs="Piety Pantaloons +2"})
    sets.midcast['Divine Magic'] = {
		main="Bolelabunga",
		sub="Sors Shield",
        head="Nahtirah Hat",
		neck="Colossus's Torque",
		ear1="Psystorm Earring",
		ear2="Lifestorm Earring",
        body="Inyanga Jubbah",
		hands="Yaoyotl Gloves",
		ring2="Sangoma Ring",
        back="Refraction Cape",
		waist="Hachirin-no-Obi",
		legs="Theophany Pantaloons +3",
		feet="Gendewitha Galoshes +1"}
    sets.midcast['Dark Magic'] = {
		main="Bolelabunga",
		sub="Sors Shield",
        head="Nahtirah Hat",
		neck="Aesir Torque",
		ear1="Psystorm Earring",
		ear2="Lifestorm Earring",
        body="Inyanga Jubbah",
		hands="Yaoyotl Gloves",
		ring1="Strendu Ring",
		ring2="Sangoma Ring",
        back="Refraction Cape",
		waist="Demonry Sash",
		legs="Bokwus Slops",
		feet="Piety Duckbills +1"}
    sets.midcast.MndEnfeebles = {
		main="Gada", --gada md and enf 18 maagacc 215
		sub="Ammurapi Shield", --ammurapi mnd 13 magacc 38
        head="Inyanga Tiara +1", --33 MND
		neck="Incanter's Torque", -- all +10
		ear1="Gwati Earring", --mag acc 8
		ear2="Dignitary's Earring", -- magacc 10
        body="Theophany Briault +3", --39 mnd
		hands="Inyanga Dastanas +1", -- mnd 47 macc 43 all +20
		ring1="Stikini Ring", --8mnd
		ring2="Stikini Ring",-- 8mnd
        back="Alaunus's Cape", 
		waist="Rumination Sash", --mnd 4 enf 7
		legs="Chironic Hose",-- mnd 29 enf 13
		feet="Theophany Duckbills +3"} --enf 21 mnd 34
    sets.midcast.IntEnfeebles = sets.midcast.MndEnfeebles
	
	------------------------------------------------------------------------------------------------
	----------------------------------------- Idle Sets --------------------------------------------
	------------------------------------------------------------------------------------------------
	
    sets.resting = {}
    sets.idle = {
		main="Bolelabunga", 
		sub="Genmei Shield",
		ammo="Homiliary",
        head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Hearty Earring",
		ear2="Etiolation Earring",
        body="Ebers Bliaud +1",
		hands="Chironic Gloves",
		ring1="Sheltered Ring",
		ring2="Defending Ring",
        back="Solemnity Cape",
		waist="Slipor Sash",
		legs="Assiduity pants +1",
		feet="Chironic Slippers"}
    sets.idle.PDT = {
		main="Bolelabunga",
		sub="Genmei's Shield",
		ammo="Homiliary",
		head="Aya. Zucchetto",
		neck="Twilight Torque",
		ear1="Hearty Earring",
		ear2="Etiolation Earring",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Moonbeam Cape",
		waist="Slipor Sash",
		legs="Ayanmo Cosciales",
		feet="Aya. Gambieras"}
    sets.idle.Town = sets.idle
    sets.idle.Weak = sets.idle
    
	------------------------------------------------------------------------------------------------
	---------------------------------------- Defense Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

    sets.defense.PDT = {}
    sets.defense.MDT = {}
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

	------------------------------------------------------------------------------------------------
	---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {}

	------------------------------------------------------------------------------------------------
	------------------------------------------- Misc Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif default_spell_map == 'Cure' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CuragaWithLightWeather'
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end

function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(10, 1)
end