-- Setup your Key Bindings here:  
    windower.send_command('bind f7 gs c toggle mb')
    windower.send_command('bind f9 gs c avatar mode')
    windower.send_command('bind f10 gs c toggle auto')
    windower.send_command('bind f12 gs c toggle melee')
    windower.send_command('bind f11 gs c toggle favor')
     
     
-- Setup your Gear Sets below:
function get_sets()
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.weapons = {
        main = "Nirvana",
        sub = "Elan Strap +1",
    }

    CampestresAttack = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Fast Cast +10%'}}
    CampestresMagic = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10',}} 
    Grioavolr = { name="Grioavolr", augments={'Blood Pact Dmg.+5','Pet: VIT+13','Pet: Mag. Acc.+24','Pet: "Mag.Atk.Bns."+30',}}

    sets.me = {}        -- leave this empty
    sets.avatar = {}    -- leave this empty
      
    sets.avatar.perp = {
        main="Nirvana",
        ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",
        body="Shomonjijoe +1",
        legs="Assiduity Pants +1",
        back=CampestresAttack,
        waist="Lucidity Sash",
        feet="Convoker's Pigaches +3",
        rear="Cath Palug Earring"
    }

    -- Your idle set when you DON'T have an avatar out
    sets.me.idle = set_combine(sets.avatar.perp, {
        ammo="Sancus Sachet +1",
        hands="Inyanga Dastanas +1",
        ear2="Cath Palug Earring",
        ring1="Murky Ring",
        ring2="Defending Ring",
        feet="Herald's Gaiters",
        neck="Loricate Torque +1"
    })
      
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
        ammo="Sancus Sachet +1",
    }
      
    -----------------------
    -- Perpetuation Related
    -----------------------
      
    -- Avatar's Out --  
    -- This is the base for all perpetuation scenarios, as seen below

  
    -- The following sets base off of perpetuation, so you can consider them idle sets.
    -- Set the relevant gear, bearing in mind it will overwrite the perpetuation item for that slot!
    sets.avatar["Carbuncle"] = {hands="Asteria Mitts +1"}
    sets.avatar["Cait Sith"] = {hands="Lamassu Mitts +1"}
    -- When we want our avatar to stay alive
    sets.avatar.tank = set_combine(sets.avatar.perp,{
        ammo="Sancus Sachet +1",
        back=CampestresAttack,
    })
      
    -- When we want our avatar to shred
    sets.avatar.melee = set_combine(sets.avatar.perp,{
        ammo="Sancus Sachet +1",
        back=CampestresAttack,
    })
      
    -- When we want our avatar to hit
    sets.avatar.acc = set_combine(sets.avatar.perp,{
        ammo="Sancus Sachet +1",
        back=CampestresAttack,
    })
      
    -- When Avatar's Favori s active
    sets.avatar.favor = set_combine(sets.avatar.perp,{
        ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",
        back=CampestresAttack,
    })
      
    ----------------------------
    -- Summoning Skill Related
    -- Including all blood pacts
    ----------------------------
      
    -- + Summoning Magic. This is a base set for max skill and blood pacts and we'll overwrite later as and when we need to
    sets.avatar.skill = {
        main="Nirvana",
        ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",
        body="Convoker's Doublet +2",
        neck="Melic Torque",
        lear="Andoaa Earring",
        rear="Cath Palug Earring",
        hands="Baayami Cuffs",
        ring1={name="Globidonta Ring"},
        ring2={name="Stikini Ring"},
        back="Conveyance Cape",
        waist="Regal Belt",
        legs="Apogee Slacks +1",
        feet="Apogee Pumps +1"
    }
      
    -------------------------
    -- Individual Blood Pacts
    -------------------------
      
    -- Physical damage
    sets.avatar.atk = set_combine(sets.avatar.skill,{
        head="Apogee Crown +1",
        ring1="Cath Palug Ring",
        ammo="Sancus Sachet +1",
        lear="Gelos Earring",
        rear="Lugalbanda Earring",
        back=CampestresAttack,
        neck="Summoner's Collar +1",
        hands="Apogee Mitts +1",
        feet="Convoker's Pigaches +3",
        waist="Regal Belt"
    })

    sets.avatar.pacc = set_combine(sets.avatar.atk,{
        head="Apogee Crown +1",
        -- ring1="Varar Ring",
        ammo="Sancus Sachet +1",
        lear="Gelos Earring",
        rear="Lugalbanda Earring",
        rear="Gelos Earring",
        back=CampestresAttack,
        waist="Incarnation Sash",
        feet="Convoker's Pigaches +3"

    })
      
    -- Magic Attack
    sets.avatar.mab = set_combine(sets.avatar.skill,{
        main=Grioavolr,
        ammo="Sancus Sachet +1",
        lear="Gelos Earring",
        rear="Lugalbanda Earring",
        body="Apogee Dalmatica +1",
        feet="Apogee Pumps +1",
        legs="Enticer's Pants",
        hands="Merlinic Dastanas",
        waist="Regal Belt",
        back=CampestresMagic,
        neck="Summoner's Collar +1",
        head="Cath Palug Crown",
        ring1="Varar Ring"
    })
    sets.avatar.mb = set_combine(sets.avatar.mab,{hands="Glyphic Bracers"})
    -- Hybrid
    sets.avatar.hybrid = set_combine(sets.avatar.skill,{
        head="Cath Palug Crown",
        -- ring1="Varar Ring",
        ring1="Cath Palug Ring",
        hands="Baayami Cuffs",
        ammo="Sancus Sachet +1",
        lear="Gelos Earring",
        rear="Lugalbanda Earring",
        feet="Apogee Pumps +1",
        back=CampestresMagic,
        neck="Summoner's Collar +1"
    })
      
    -- Magic Accuracy
    sets.avatar.macc = set_combine(sets.avatar.skill,{
        head="Cath Palug Crown",
        ring1="Varar Ring",
        main=Grioavolr,
        hands="Inyanga Dastanas +1",
        ammo="Sancus Sachet +1",
        legs="Glyphic Spats",
        feet="Convoker's Pigaches +3",
        rear="Lugalbanda Earring",
        back=CampestresMagic,
    })
      
    -- Buffs
    sets.avatar.buff = set_combine(sets.avatar.skill,{
        ammo="Sancus Sachet +1",
        back=CampestresMagic,
    })
      
    -- Other
    sets.avatar.other = set_combine(sets.avatar.skill,{
        ammo="Sancus Sachet +1",
        rear="Lugalbanda Earring",
        back=CampestresMagic,
    })
      
    -- Combat Related Sets
      
    -- Melee
    -- The melee set combines with perpetuation, because we don't want to be losing all our MP whilst we swing our Staff
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
    sets.me.melee = set_combine(sets.avatar.perp,{
        ammo="Sancus Sachet +1",
    })
      
    -- Shattersoul. Weapon Skills do not work off perpetuation as it only stays equipped for a moment
    sets.me["Shattersoul"] = {
        ammo="Sancus Sachet +1",
    }
    sets.me["Garland of Bliss"] = {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ammo="Sancus Sachet +1",
    }
      
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ---------------
    -- Casting Sets
    ---------------
      
    sets.precast = {}
    sets.midcast = {}
    sets.aftercast = {}
      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
        main="Grioavolr",
        sub="Clerisy Strap",
        head="Amalric Coif +1",
        body="Inyanga Jubbah +2",
        hands="Volte Gloves",
        legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
        feet="Regal Pumps +1",
        neck="Voltsurge Torque",
        left_ear="Etiolation Earring",
        right_ear="Loquac. Earring",
        left_ring="Weather. Ring +1",
        right_ring="Kishar Ring",
        back=CampestresAttack
    }
      
    -- Summoning Magic Cast time - gear
    sets.precast.summoning = set_combine(sets.precast.casting,{
        ammo="Sancus Sachet +1",
    })
      
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
        ammo="Sancus Sachet +1",
        head="Telchine Cap",neck="Colossus's Torque",ear1="Dignitary's Earring",ear2="Loquacious Earring",
        hands="Telchine Gloves",ring2="Weatherspoon Ring +1",
        waist="Cascade Belt",legs="Telchine Braconi",feet="Telchine Pigaches"
    })

    sets.precast.refresh = set_combine(sets.precast.enhancing,{
        waist="Gishdubar Sash",
        head = "Amalric Coif +1"
        })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
        ammo="Sancus Sachet +1",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
        ammo="Sancus Sachet +1",
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------
      
    -- Blood Pact Ability Delay
    sets.precast.bp = {
        ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",
        body="Glyphic Doublet +1",
        hands="Baayami Cuffs",
        back="Conveyance Cape",
        legs="Glyphic Spats",
        feet="Glyphic Pigaches +1",
        waist="Lucidity Sash",
        neck="Melic Torque",
        ring1="Stikini Ring",
        ring2="Globidonta Ring"

    }
      
    -- Mana Cede
    sets.precast["Mana Cede"] = {
        ammo="Sancus Sachet +1",
    }
      
    -- Astral Flow  
    sets.precast["Astral Flow"] = {
        head="Glyphic Horn",
        ammo="Sancus Sachet +1",
    }
      
    ----------
    -- Midcast
    ----------
      
    -- We handle the damage and etc. in Pet Midcast later
      
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
        ammo="Sancus Sachet +1",
    }
      
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
        ammo="Sancus Sachet +1",
    })
      
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
        ammo="Sancus Sachet +1",
    })
    -- Elemental Siphon, eg, Tatsumaki Thingies, Esper Stone, etc
    sets.midcast.siphon = set_combine(sets.avatar.skill,{
        ammo="Sancus Sachet +1",
        feet="Beckoner's Pigaches",
    })
        
    -- Cure Potency
    sets.midcast.cure = set_combine(sets.midcast.casting,{
        ammo="Sancus Sachet +1",
    })
      
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have an avatar out?
  
end
