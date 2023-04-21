require('ClosetCleaner')
include('displayBox.lua')
include('organizeritems.lua')

-- Owner: AlanWarren, aka ~ Orestes 
-- current file resides @ https://github.com/AlanWarren/gearswap
--[[ 

 === Notes ===
 -- Set format is as follows:
    sets.midcast.RA.[CustomClass][CombatForm][CombatWeapon][RangedMode][CustomRangedGroup]
    ex: sets.midcast.RA.SAM.Stave.Nobility.Mid.SamRoll = {}
    you can also append CustomRangedGroups to each other
 
 -- These are the available sets per category
 -- CustomClass = SAM
 -- CombatForm = Stave, DW
 -- CombatWeapon = weapon name, ex: Nobility  (you can make new sets for any ranged weapon)
 -- RangedMode = Normal, Mid, Acc
 -- CustomRangedGroup = SamRoll

 -- Gear.Stave should be set to your 2-handed weapon of choice if you wish to take advantage of sets.midcast.RA.Stave
 -- SamRoll is applied automatically whenever you have the roll on you. 
 -- SAM is used when you're RNG/SAM 

 * Auto RA
 - You can use the built in hotkey (CTRL -) or create a macro. (like below) Note "AutoRA" is case sensitive
   /console gs c toggle AutoRA
 - You have to shoot once after toggling autora for it to begin.
 - AutoRA will use weaponskills @ 1000TP, depending on which weapon you're using. However, this will only
   work if you set gear.Gun or gear.Bow to the weapon you're using. You also have to specify the desired
   ws it should use, with the settings auto_gun_ws and auto_bow_ws. 
 
 === Helpful Commands ===
    //gs validate
    //gs showswaps
    //gs debugmode

--]]
 

lastShotPosition = {x=0, y=0, z=0}
currentPosition = {x=0, y=0, z=0}
counter = 0;

function get_sets()
        mote_include_version = 2
        -- Load and initialize the include file.
        include('Mote-Include.lua')
        include('organizer-lib')
end

-- setup vars that are user-independent.
function job_setup()
end
 
-- setup vars that are user-dependent. 
function user_setup()
        -- Options: Override default values
        state.OffenseMode:options('Normal', 'Melee')
        state.RangedMode:options('Normal', 'Acc', 'Crit')
        state.HybridMode:options('Normal', 'PDT')
        state.IdleMode:options('Normal', 'PDT')
        state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
        state.PhysicalDefenseMode:options('PDT')
        state.MagicalDefenseMode:options('MDT')

        state.Buff.Barrage = buffactive.Barrage or false
        state.Buff.Camouflage = buffactive.Camouflage or false
        state.Buff.Overkill = false
        state.Buff.HoverShot = "Good"

        -- settings
        state.CapacityMode = M(false, 'Capacity Point Mantle')

        auto_gun_ws = "Last Stand"
        auto_bow_ws = "Jishnu's Radiance"


        gear.Gun = "Fomalhaut"
        gear.Crossbow = "Gastraphetes"
        gear.Bow = "Yoichinoyumi"
        gear.Gun2 = "Annihilator"
        --gear.Bow = "Steinthor"
       
        rng_sub_weapons = S{'Perun +1','Nusku Shield', 
        { name="Malevolence", augments={'INT+9','Mag. Acc.+10','"Mag.Atk.Bns."+9','"Fast Cast"+4',}},
        { name="Malevolence", augments={'INT+2','Mag. Acc.+1','"Mag.Atk.Bns."+3','"Fast Cast"+1',}}}
        
        sam_sj = player.sub_job == 'SAM' or false

        BelenusTP = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
        BelenusDexCrit = { name="Belenus's Cape", augments={'DEX+20','Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+10',}}
        BelenusAgiCrit = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
        BelenusMagicWS = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
        BelenusPreshot = { name="Belenus's Cape", augments={'"Snapshot"+10',}}
        BelenusAgiWS = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}


      	DefaultAmmo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Achiyalabopa bullet"}
	    U_Shot_Ammo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Achiyalabopa bullet"} 

        get_combat_form()
        get_custom_ranged_groups()
        select_default_macro_book()

        send_command('bind != gs c toggle CapacityMode')
        send_command('bind f9 gs c cycle RangedMode')
        send_command('bind !f9 gs c cycle OffenseMode')
        send_command('bind ^f9 gs c cycle HybridMode')
        send_command('bind f10 gs c cycle WeaponskillMode')
        
    text_setup()
    addTextPairs()
    updateTable()
end

function addTextPairs()
    addTextColorPair("Standard", "green")
    addTextColorPair("HighMP", "yellow")
    addTextColorPair("Good", "green")
    addTextColorPair("Bad", "yellow")
end

function updateTable()
    addToTable("(F9)  Ranged Mode", state.RangedMode.value)
    addToTable("(F10) Weaponskill Mode", state.WeaponskillMode.value)
    addToTable("\n")
    addToTable("Hover Shot", get_hover_shot_state())
    -- addToTable("Player X", currentPosition.x)
    -- addToTable("Player Y", currentPosition.y)
    -- addToTable("Player Z", currentPosition.z)
    update_message()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind !=')
    send_command('unbind ^=')
    send_command('unbind @=')
    send_command('unbind ^-')
end
 
function get_hover_shot_state()
    if not buffactive["Hover Shot"] then
        return false
    else
        return state.Buff.HoverShot
    end
end

function init_gear_sets()

        organizer_items = set_combine(organizerItems(), {
            gun1=gear.Gun,
            crossbow=gear.Crossbow,
            ammo1="Chrono Bullet",
            ammo2="Quelling Bolt",
            waist1="Quelling Bolt Quiver",
            waist2="Chrono Bullet Pouch"
            })

        sets.gunAndAmmo = {}
        sets.gunAndAmmo.Gun = {ranged="Fomalhaut", ammo="Chrono Bullet", waist="Chrono Bullet Pouch"}
        sets.gunAndAmmo.Crossbow = {ranged="Gastraphetes", ammo="Quelling Bolt", waist="Quelling Bolt Quiver"}

        -- Misc. Job Ability precasts
        sets.precast.JA['Bounty Shot'] = {hands="Amini Glovelettes +1"}
        sets.precast.JA['Double Shot'] = {head="Amini Gapette +1"}
        sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2"}
        sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +2"}
        sets.precast.JA['Velocity Shot'] = {body="Amini Caban +1"}
        sets.precast.JA['Scavenge'] = {feet="Orion Socks +2"}
        sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}

        sets.CapacityMantle = {back="Mecistopins Mantle"}

        sets.precast.JA['Eagle Eye Shot'] = set_combine(sets.midcast.RA, {
            -- head="Uk'uxkaj Cap", 
            -- neck="Rancor Collar",
            -- back="Buquwik Cape",
            hands="Amini Glovelettes +1",
            ring1="Ifrit Ring",
            ring2="Apate ring",
            -- legs="Amini Bragues +2" 
            --feet="Arcadian Socks +1"
        })
        sets.precast.JA['Eagle Eye Shot'].Mid = set_combine(sets.precast.JA['Eagle Eye Shot'], {
            back="Lutian Cape",
            ring2="Paqichikaji Ring",
            feet="Orion Socks +2"
        })
        sets.precast.JA['Eagle Eye Shot'].Acc = set_combine(sets.precast.JA['Eagle Eye Shot'].Mid, {
            neck="Iqabi Necklace",
            waist="Elanid Belt"
        })

        sets.precast.FC = {
            -- head="Ejekamal Mask",
            ear1="Loquacious Earring",
            -- legs="Quiahuiz Trousers",
            -- hands="Buremte Gloves",
            ring1="Prolix Ring"
        }
        sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { 
            -- neck="Magoraga Beads" 
        })
        
        sets.idle = {
            head="Nyame Helm",
            neck="Loricate Torque +1",
            ear1="Enervating Earring",
            ear2="Telos Earring",
            body="Nyame Mail",
            hands="Nyame Gauntlets",
            ring1="Dark Ring",
            ring2="Defending Ring",
            back="Repulse Mantle",
            waist="Elanid Belt",
            legs="Nyame Flanchard", 
            feet="Skadi's Jambeaux +1"
        }
        sets.idle.Regen = set_combine(sets.idle, {})

        sets.idle.PDT = set_combine(sets.idle, {
            ring1="Dark Ring",
            ring2="Defending Ring"
        })
        sets.idle.Town = set_combine(sets.idle, {})
 
        -- Engaged sets
        sets.engaged =  {
            head="Malignance Chapeau",
            neck="Loricate Torque +1",
            ear1="Enervating Earring",
            ear2="Telos Earring",
            --body="Arcadian Jerkin +1", 
            body="Malignance Tabard",
            hands="Carmine Finger Gauntlets +1",
            ring1="Dark Ring",
            ring2="Defending Ring",
            waist="Impulse Belt",
            legs="Nahtirah Trousers", 
            feet="Malignance Boots"
        }
        sets.engaged.PDT = set_combine(sets.engaged, {
            neck="Loricate Torque +1",
            ring1="Dark Ring",
            -- ring2="Patricius Ring"
        })
        sets.engaged.Nobility = set_combine(sets.engaged, {})

        ------------------------------------------------------------------
        -- Preshot / Snapshot sets
        ------------------------------------------------------------------
        sets.precast.RA = {
            head="Amini Gapette +1", -- 5
            neck="Scout's Gorget +1",
            body={name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}},-- 6
			hands="Carmine Finger Gauntlets +1",
            back=BelenusPreshot, -- 3
            legs="Orion Braccae +2", -- 9
            waist="Yemaya Belt", -- 2
            left_ring="Crepuscular Ring",
            feet="Meghanada Jambeaux +2"
        }
        
        ------------------------------------------------------------------
        -- Default Base Gear Sets for Ranged Attacks. Geared for BOW
        ------------------------------------------------------------------
        sets.midcast.RA = {
            head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
            body="Mummu jacket +2", 
            hands="Carmine Finger Gauntlets +1",
            legs="Amini Bragues +2",
            feet="Orion socks +2",
            waist="Elanid Belt",
            neck="Iskur Gorget",
            left_ear="Telos Earring",
            right_ear="Enervating Earring",
            left_ring="Crepuscular Ring",
            right_ring="Regal Ring",
            back=BelenusTP
        }

        sets.midcast.RA.Mid = set_combine(sets.midcast.RA, {
            waist="Kwahu Kachina Belt",
            feet={ name="Herculean Boots", augments={'Rng.Acc.+14 Rng.Atk.+14','Enmity-6','DEX+8','Rng.Acc.+13','Rng.Atk.+7',}}
            })
		
            
        sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mid, {
            head="Orion Beret +3",
            body="Orion Jerkin +2",
            hands="Orion Socks +2",
            feet="Orion Socks +2",
            neck= "Iskur Gorget",
            left_ring="Hajduk Ring",
            right_ring="Cacoethic Ring +1",
            legs="Amini Bragues +2",
            waist="Kwahu Kachina Belt",
            })

        sets.midcast.RA.Crit = set_combine(sets.midcast.RA, {
            neck="Scout's Gorget +1",
            hands="Mummu Wrists +2",
            waist="Kwahu Kachina Belt",
            feet="Oshosi Leggings +1",
            left_ear="Odr Earring",
            left_ring="Mummu Ring",
            right_ring="Begrudging Ring",
            back=BelenusAgiCrit
        })

        sets.precast.WS = {
            head="Orion Beret +3",
            neck="Scout's Gorget +1",
            ear1="Moonshade Earring",
            ear2="Enervating Earring",
            body=HerculeanBodyWS,
            -- hands="Meghanada Gloves +2",
            hands="Nyame Gauntlets",
            ring1="Apate Ring",
            ring2="Petrov Ring",
            back=BelenusDexCrit,
            waist="Fotia Belt",
            legs="Arcadian Braccae +3", 
            feet="Nyame Sollerets"
        }
        sets.precast.WS.Mid = set_combine(sets.precast.WS, {
            body="Orion Jerkin +2"
            })

        sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
            legs="Meghanada Chausses +2",
            ring2="Hajduk Ring"
        })

        sets.LastStand = {
            head="Orion Beret +3",
            body="Nyame Mail",
            -- hands="Meghanada Gloves +2",
            hands="Nyame Gauntlets",
            legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
            feet="Nyame Sollerets",
            neck="Scout's Gorget +1",
            waist="Fotia Belt",
            left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
            right_ear="Ishvara Earring",
            right_ring="Regal Ring",
            left_ring="Ilabrat Ring",
            back=BelenusAgiWS,
        }

        sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, sets.LastStand)
        sets.precast.WS['Last Stand'].Mid = set_combine(sets.precast.WS.Mid, sets.LastStand)
        sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS.Acc, sets.LastStand)
        sets.precast.WS.LastStand = sets.precast.WS['Last Stand']

        sets.HeavyShot = sets.precast.WS['Last Stand']
        sets.precast.WS['Heavy Shot'] = sets.HeavyShot
        sets.precast.WS['Heavy Shot'].Mid = sets.precast.WS['Last Stand'].Mid
        sets.precast.WS['Heavy Shot'].Acc = sets.precast.WS['Last Stand'].Acc


        sets.Trueflight = {
            head="",
            body="Cohort Cloak +1",

            hands="Nyame Gauntlets",
            legs="Nyame Flanchard",
            feet="Nyame Sollerets",

            neck="Scout's Gorget +1",
            waist="Eschan Stone",
            left_ear="Friomisi Earring",
            right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
            left_ring="Ilabrat ring",
            right_ring="Dingir Ring",
            back=BelenusMagicWS
        }

        sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS, sets.Trueflight)
        sets.precast.WS['Trueflight'].Mid = set_combine(sets.precast.WS.Mid, sets.Trueflight)
        sets.precast.WS['Trueflight'].Acc = set_combine(sets.precast.WS.Acc, sets.Trueflight)
        sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, sets.Trueflight)
        sets.precast.WS['Wildfire'].Mid = set_combine(sets.precast.WS.Mid, sets.Trueflight)
        sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Acc, sets.Trueflight)
        -- DETONATOR
        -- DETONATOR

        -- JISHNUS
        sets.Jishnus = {
            head={ name="Herculean Helm", augments={'Rng.Acc.+15 Rng.Atk.+15','DEX+12','Rng.Acc.+10','Rng.Atk.+10',}},
            body="Meghanada Cuirie +2",
            hands="Kobo Kote",
            legs="Darraigner's Brais",
            --legs="Amini Bragues +2",
            --feet={ name="Herculean Boots", augments={'Rng.Acc.+14 Rng.Atk.+14','Enmity-6','DEX+8','Rng.Acc.+13','Rng.Atk.+7',}},
            feet="Thereoid Greaves",
            neck="Fotia Gorget",
            waist="Fotia Belt",
            left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
            right_ear="Sherida Earring",
            left_ring="Begrudging Ring",
            right_ring="Regal Ring",
            back=BelenusDexCrit
        }
        sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, sets.Jishnus)
        sets.precast.WS['Jishnu\'s Radiance'].Mid = set_combine(sets.precast.WS.Mid, sets.Jishnus)
        sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS.Acc, sets.Jishnus)


        sets.ApexArrow = {
            head={ name="Herculean Helm", augments={'Rng.Acc.+15 Rng.Atk.+15','DEX+12','Rng.Acc.+10','Rng.Atk.+10',}},
            body="Mummu Jacket +2",
            hands="Mummu Wrists +2",
            legs="Meghanada Chausses +2",
            feet="Meg. Jam. +2",
            neck="Iskur Gorget",
            waist="Kwahu Kachina Belt",
            left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
            right_ear="Enervating Earring",
            left_ring="Paqichikaji Ring",
            right_ring="Cacoethic Ring +1",
            back=BelenusAgiWS,
        }

        sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS, sets.ApexArrow)
        sets.precast.WS['Apex Arrow'].Mid = set_combine(sets.precast.WS.Mid, sets.ApexArrow)
        sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS.Acc, sets.ApexArrow)


        sets.NamasArrow = set_combine(sets.ApexArrow, {
            waist="Fotia Belt",
            neck="Fotia Gorget",
            ear1="Ishvara Earring",
            ear2="Sherida Earring",
            hands="Meghanada Gloves +2",
            head="Orion Beret +3",
            legs="Arcadian Braccae +3",
            body="Meghanada Cuirie +2",
            -- feet={ name="Herculean Boots", augments={'Rng.Atk.+7','Weapon skill damage +5%','AGI+4','Rng.Acc.+14',}},
            feet="Nyame Sollerets",
            ring1="Dingir Ring",
            ring2="Ilabrat Ring",
            back=BelenusAgiWS
            })
        sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, sets.NamasArrow)
        sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS.Mid, sets.NamasArrow)
        sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS.Acc, sets.NamasArrow)

        sets.Coronach = {
            head="Orion Beret +3",
            neck="Scout's gorget +1",
            ear1="Sherida Earring",
            ear2="Ishvara Earring",
            body="Meghanada cuirie +2",
            -- hands="Meg. Gloves +2",
            hands="Nyame Gauntlets",
            ring1="Dingir Ring",
            -- ring2="Karieyh Ring",
            ring2="Regal Ring",
            back=BelenusAgiWS,
            waist="Fotia Belt",
            legs="Arc. Braccae +3",
            feet="Nyame Sollerets",
        }

        sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, sets.Coronach)
        sets.precast.WS['Coronach'].Mid = set_combine(sets.precast.WS.Mid, sets.Coronach)
        sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS.Acc, sets.Coronach)

        sets.HotShot = set_combine(sets.Trueflight, {
            
            -- legs="Nyame Flanchard", --wsd
            hands="Nyame Gauntlets",
            legs="Arcadian Braccae +3",
            feet="Nyame Sollerets", --wsd
            waist="Fotia Belt"

        })

        sets.precast.WS["Hot Shot"] = set_combine(sets.precast.WS, sets.HotShot)
        sets.precast.WS["Hot Shot"].Mid = set_combine(sets.precast.WS.Mid, sets.HotShot)
        sets.precast.WS["Hot Shot"].Acc = set_combine(sets.precast.WS.Acc, sets.HotShot)
        
        sets.FlamingArrow = set_combine(sets.HotShot, {
            
            })

        sets.precast.WS["Flaming Arrow"] = set_combine(sets.precast.WS, sets.FlamingArrow)
        sets.precast.WS["Flaming Arrow"].Mid = set_combine(sets.precast.WS.Mid, sets.FlamingArrow)
        sets.precast.WS["Flaming Arrow"].Acc = set_combine(sets.precast.WS.Acc, sets.FlamingArrow)

        sets.EmpyrealArrow = set_combine(sets.ApexArrow, {

        })

        sets.precast.WS["Empyreal Arrow"] = set_combine(sets.precast.WS, sets.EmpyrealArrow)
        sets.precast.WS["Empyreal Arrow"].Mid = set_combine(sets.precast.WS.Mid, sets.EmpyrealArrow)
        sets.precast.WS["Empyreal Arrow"].Acc = set_combine(sets.precast.WS.Acc, sets.EmpyrealArrow)

        sets.Detonator = set_combine(sets.LastStand, {

        })

        sets.precast.WS["Detonator"] = set_combine(sets.precast.WS, sets.Detonator)
        sets.precast.WS["Detonator"].Mid = set_combine(sets.precast.WS.Mid, sets.Detonator)
        sets.precast.WS["Detonator"].Acc = set_combine(sets.precast.WS.Acc, sets.Detonator)

        sets.SavageBlade = set_combine(sets.precast.WS, {
            head="Orion Beret +3",
            -- neck="Fotia Gorget",
            neck="Scout's Gorget +1",
            ear1="Ishvara Earring",
            ear2="Moonshade Earring",
            -- hands="Meghanada Gloves +2",
            hands="Nyame Gauntlets",
            ring1="Metamorph Ring +1",
            ring2="Regal Ring",
            back=BelenusAgiWS,
            waist="Fotia Belt",
            legs="Nyame Flanchard",
            feet="Nyame Sollerets"
        })

        sets.precast.WS["Savage Blade"] = sets.SavageBlade

        -- Resting sets
        sets.resting = {}
       
        -- Defense sets
        sets.defense.PDT = set_combine(sets.idle, {})
        sets.defense.MDT = set_combine(sets.idle, {})
        --sets.Kiting = {feet="Fajin Boots"}
       
        sets.buff.Barrage = set_combine(sets.midcast.RA, {
            head="Orion Beret +3",
            neck="Iskur Gorget",
            ear1="Enervating Earring",
            ear2="Telos Earring",
            body="Orion Jerkin +2",
            hands="Orion Bracers +2",
            ring1="Cacoethic Ring +1",
            ring2="Regal Ring",
            back="Lutian Cape",
            waist="Kwahu Kachina Belt",
            legs="Amini Bragues +2", 
            feet="Orion Socks +2"
        })
        sets.buff.Barrage.Mid = set_combine(sets.buff.Barrage, {})
        sets.buff.Barrage.Acc = set_combine(sets.buff.Barrage, {})

        sets.buff.Camouflage =  {body="Orion Jerkin +2"}

        sets.Shadowbind = {hands="Orion Bracers +2"}

        sets.Overkill =  {
            -- body="Arcadian Jerkin +1"
        }
        sets.Overkill.Preshot = set_combine(sets.precast.RA, sets.Overkill)

        sets.Obi = {waist="Hachirin-no-obi"}

end

function job_pretarget(spell, action, spellMap, eventArgs)

end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
function job_precast(spell, action, spellMap, eventArgs)
        
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        --add_to_chat(8, state.CombatForm)
        if sam_sj then
            classes.CustomClass = 'SAM'
        end

        if spell.action_type == 'Ranged Attack' then
            state.CombatWeapon:set(player.equipment.range)
        end
        -- add support for RangedMode toggles to EES
        if spell.english == 'Eagle Eye Shot' then
            classes.JAMode = state.RangedMode.value
        end
        -- Safety checks for weaponskills 
        if spell.type:lower() == 'weaponskill' then
            if ((spell.target.distance >8 and spell.skill ~= 'Archery' and spell.skill ~= 'Marksmanship') or (spell.target.distance >23)) then
                -- Cancel Action if distance is too great, saving TP
                add_to_chat(122,"Outside WS Range! /Canceling")
                return
            end
        end
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
-- This is where you place gear swaps you want in precast but applied on top of the precast sets
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    elseif state.Buff.Overkill then
        equip(sets.Overkill.Preshot)
    end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        -- if (spell.name == "Last Stand") then
        --     equip (sets.precast.WS.LastStand)
        -- end
        if (spell.name == "Trueflight" or spell.name == "Wildfire") then
                use_obi(spell)
        end

    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    -- Barrage
    if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
        if state.RangedMode.current == 'Mid' then
            equip(sets.buff.Barrage.Mid)
        elseif state.RangedMode.current == 'Acc' then
            equip(sets.buff.Barrage.Acc)
        else
            equip(sets.buff.Barrage.Acc)
        end
        eventArgs.handled = true
    end
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        equip(sets.Overkill)
    end
    if spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.name] ~= nil then
        state.Buff[spell.name] = not spell.interrupted or buffactive[spell.english]
    end
    if spell.action_type == 'Ranged Attack' then
        local player = windower.ffxi.get_mob_by_target('me')
        lastShotPosition["x"] = player.x
        lastShotPosition["y"] = player.y
        lastShotPosition["z"] = player.z
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{"courser's roll"}:contains(buff:lower()) then
    --if string.find(buff:lower(), 'samba') then

    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end
    if buff == 'Velocity Shot' and gain then
        windower.send_command('wait 290;input /echo **VELOCITY SHOT** Wearing off in 10 Sec.')
    elseif buff == 'Double Shot' and gain then
        windower.send_command('wait 90;input /echo **DOUBLE SHOT OFF**;wait 90;input /echo **DOUBLE SHOT READY**')
    elseif buff == 'Decoy Shot' and gain then
        windower.send_command('wait 170;input /echo **DECOY SHOT** Wearing off in 10 Sec.];wait 120;input /echo **DECOY SHOT READY**')
    end

    if  buff == "Samurai Roll" or buff == "Courser's Roll" or string.find(buff:lower(), 'flurry') then
        classes.CustomRangedGroups:clear()

        if (buff == "Samurai Roll" and gain) or buffactive['Samurai Roll'] then
            classes.CustomRangedGroups:append('SamRoll')
        end
       
    end

    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

    if buff == "Hover Shot" then
        if not gain then
            state.Buff.HoverShot = false
        else
            state.Buff.HoverShot = "Good"
        end
        updateTable()
    end

    if buff == "Camouflage" or buff == "Overkill" or buff == "Samurai Roll" or buff == "Courser's Roll" then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    --select_earring()
end
 
function customize_idle_set(idleSet)
    if state.HybridMode.value == 'PDT' then
        state.IdleMode.value = 'PDT'
    elseif state.HybridMode.value ~= 'PDT' then
        state.IdleMode.value = 'Normal'
    end
	if state.Buff.Camouflage then
		idleSet = set_combine(idleSet, sets.buff.Camouflage)
	end
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Camouflage then
    	meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
    	meleeSet = set_combine(meleeSet, sets.Overkill)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
         state.CombatWeapon:set(player.equipment.range)
    end

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_custom_ranged_groups()
    sam_sj = player.sub_job == 'SAM' or false
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    -- state.Buff.Overkill = buffactive.overkill or false
    state.Buff.Overkill = false --Overkill FIX

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
    updateTable()

end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

    add_to_chat(122, 'Ranged: '..state.RangedMode.value..'/'..state.HybridMode.value..', WS: '..state.WeaponskillMode.value..', '..msg)
    
    eventArgs.handled = true
 
end
-- Special WS mode for Sam subjob
function get_custom_wsmode(spell, spellMap, ws_mode)
    if spell.skill == 'Archery' or spell.skill == 'Marksmanship' then
        if player.sub_job == 'SAM' then
            return 'SAM'
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if player.equipment.main == gear.Stave then
        state.CombatForm:set("Stave")
    else
        if S{'NIN', 'DNC'}:contains(player.sub_job) and rng_sub_weapons:contains(player.equipment.sub) then
            state.CombatForm:set("DW")
        else
            state.CombatForm:reset()
        end
    end
end

function get_custom_ranged_groups()
	classes.CustomRangedGroups:clear()
    
    if buffactive['Samurai Roll'] then
        --classes.CustomRangedGroups:append('SamRoll')
    end

end

function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "'..auto_bow_ws..'" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "'..auto_gun_ws..'" <t>')
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    end
end

function camo_active()
    return state.Buff['Camouflage']
end
-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end
-- Orestes uses Samurai Roll. The total comes to 5!
--function detect_cor_rolls(old,new,color,newcolor)
--    if string.find(old,'uses Samurai Roll. The total comes to') then
--        add_to_chat(122,"SAM Roll")
--    end
--end
-- Select default macro book on initial load or subjob change.




windower.register_event('postrender', function()
    local player = windower.ffxi.get_mob_by_target('me')
    if not player then
        return
    end
    currentPosition.x = player.x
    currentPosition.y = player.y
    currentPosition.z = player.z

    if (buffactive["Hover Shot"]) then
        xDiff = currentPosition.x - lastShotPosition.x;
        yDiff = currentPosition.y - lastShotPosition.y;
        zDiff = currentPosition.z - lastShotPosition.z;
        distance = math.sqrt(xDiff^2 + yDiff^2 + zDiff^2)
        if (state.Buff.HoverShot == "Bad") then
            if (distance > 1) then
                state.Buff.HoverShot = "Good"
                updateTable()
            end
        else
            if (distance < 1) then
                state.Buff.HoverShot = "Bad"
                updateTable()
            end
        end
    else
        -- add_to_chat(140, "No Hover Shot here")
    end
    updateTable()
end)


function select_default_macro_book()
	-- Default macro set/book
    set_macro_page(1, 9)
end

function use_obi(spell)

    local elements = {}
    elements.use_on_single_conflict = false
    elements.strong_against = {['Fire'] = 'Ice', ['Earth'] = 'Thunder', ['Water'] = 'Fire', ['Wind'] = 'Earth', ['Ice'] = 'Wind', ['Thunder'] = 'Water', ['Light'] = 'Dark', ['Dark'] = 'Light'}
    elements.weak_against = {['Fire'] = 'Water', ['Earth'] = 'Wind', ['Water'] = 'Thunder', ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Thunder'] = 'Earth', ['Light'] = 'Dark', ['Dark'] = 'Light'}


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
        equip(sets.Obi)
    end
 
end