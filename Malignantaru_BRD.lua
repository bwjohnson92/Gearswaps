require('ClosetCleaner')
include('displayBox.lua')
include('organizeritems.lua')
-- Local Settings, setting the zones prior to use
toau_zones = S{"Leujaoam Sanctum","Mamool Ja Training Grounds","Lebros Cavern","Periqia","Ilrusi Atoll",
        "Nyzul Isle","Bhaflau Remnants","Arrapago Remnants","Silver Sea Remnants","Zhayolm Remnants"}

naSpells = S{"Paralyna","Silena","Viruna","Erase","Stona","Blindna","Poisona"}

resSpells = S{"Barstonra","Barwatera","Baraera","Barfira","Barblizzara","Barthundra",
    "Barstone","Barwater","Baraero","Barfire","Barblizzard","Barthunder"}


-- Start Functions here
-- Gear Sets
allowWeaponSwap = true

Instrument_Index = 1

function get_sets()

    sets.Instrument = {}
    sets.Instrument.Index = {"Gjallarhorn", "Terpander"}

    sets.precast = {};
    sets.midcast = {};
    sets.aftercast = {};
    sets.horn = {}

    sets.Idle = {}
    sets.Idle.Index = {"Standard", "DT", "Move"}
    sets.Idle.Standard =  {
        main="Kali",
        sub="Genmei Shield",
        head="Inyanga Tiara +1",
        neck="Loricate Torque +1",
        -- ear1=""
        ear2="Genmei Earring",
        body="Ayanmo Corazza +1",
        hands="Ayanmo Manopolas",
        feet="Ayanmo Gambieras +1",
        back="Repulse Mantle",
        waist="Flume Belt +1",
        ring1="Vocane Ring",
        ring2="Defending Ring"
    }
    
    sets.precast.FastCast = {main="Kali",ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Voltsurge Torque",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Kishar Ring",ring2="Lebeche Ring",
        waist="Witful Belt",legs="Doyen Pants", feet="Telchine Pigaches"}

    sets.precast.Song = set_combine(sets.precast.FastCast, {
        head="Fili Calot +1"
    })

    sets.midcast.Song = {
        main="Kali",
        -- ranged="Gjallarhorn",
        -- body="Brioso Justacorps +1",
        head="Fili Calot +1",
        body="Fili Hongreline +1",
        hands="Fili Manchettes +1",
        neck="Moonbow Whistle",
        ear2="Darkside Earring",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +2",
        back="Intarabus's Cape"

    }

    send_command('bind end send @others input /follow Malignantaru')
    send_command('bind f10 gs c instrument')
    text_setup()
    addNewColors()
    updateTable()
end

function addNewColors()
    addTextColorPair("DT", "yellow")
    addTextColorPair("Standard", "green")
end

function updateTable()
    addToTable("(F10) Instrument", sets.Instrument.Index[Instrument_Index])
    -- addToTable("(F12) Idle Set", sets.Idle.index[Idle_Index])
    update_message()
end
-- --- Precast ---

function precast(spell)
    if string.find(spell.type,'Song') or string.find(spell.type,'Magic') or string.find(spell.type,'Trust') then
        equip(sets.precast.FastCast)
    end
end
-- --- MidCast ---
function midcast(spell)
    if string.find(spell.type,'Magic') or string.find(spell.type,'BardSong')  then
        -- add_to_chat(140, sets.Instrument.Index[Instrument_Index])
        equip(set_combine(sets.midcast.Song, {
            ranged=sets.Instrument.Index[Instrument_Index]
        }))
    end 
end

-- --- Aftercast ---

function aftercast(spell)
    equip(sets.Idle.Standard)
end

-- Status Change - ie. Resting

function self_command(command)
    if (command == "instrument") then
        Instrument_Index = Instrument_Index +1
        if Instrument_Index > #sets.Instrument.Index then Instrument_Index = 1 end
    end
    updateTable()
end