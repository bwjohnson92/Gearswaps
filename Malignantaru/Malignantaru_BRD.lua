require('ClosetCleaner')
include('displayBox/displayBox.lua')
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
auto_song = false
busy = false
current = ""
command_casting = false

song_queue = {}
time = 3.2

stikini1={name="Stikini Ring", bag="wardrobe2"}
stikini2={name="Stikini Ring", bag="wardrobe3"}


function get_sets()

    sets.Instrument = {}
    sets.Instrument.Index = {"Gjallarhorn", "Daurdabla"}

    sets.precast = {};
    sets.midcast = {};
    sets.aftercast = {};
    sets.horn = {}

    sets.Idle = {}
    sets.Idle.Index = {"Standard", "DT", "Move"}
    sets.Idle.Standard =  {
        main="Kali",
        sub="Genmei Shield",
        head="Inyanga Tiara +2",
        neck="Loricate Torque +1",
        ear1="Infused Earring",
        ear2="Genmei Earring",
        body="Ayanmo Corazza +2",
        hands="Ayanmo Manopolas +2",
        feet="Fili Cothurnes +2",
        back="Repulse Mantle",
        waist="Flume Belt +1",
        ring1="Vocane Ring",
        ring2="Defending Ring"
    }
    
    sets.precast.FastCast = {main="Kali",ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Voltsurge Torque",ear2="Loquacious Earring",
        body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Kishar Ring",
        waist="Witful Belt",legs="Doyen Pants", feet="Fili Cothurnes +2"}

    sets.precast.Song = set_combine(sets.precast.FastCast, {
        head="Fili Calot +1",ear1="Aoidos' Earring"
    })

    sets.midcast.Song = {
        main="Kali",
        ranged="Gjallarhorn",
        head="Fili Calot +1",
        body="Fili Hongreline +2",
        hands="Fili Manchettes +1",
        neck="Moonbow Whistle",
        ear2="Darkside Earring",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
    }

    sets.midcast.Song.Dummy = set_combine(sets.Idle.Standard, {
        ranged="Daurdabla"
    })

    sets.midcast.Song.Potency = set_combine(sets.midcast.Song, {
        neck="Moonbow Whistle"
    })

    sets.HonorMarch = {
        ranged="Marsyas",
        ammo=empty
    }

    sets.Songs = {}
    sets.Songs.Carol = set_combine(sets.midcast.Song, {
        hands="Mousai Gages"
    })

    sets.Songs.Scherzo = set_combine(sets.midcast.Song, {
        feet="Fili Cothurnes +2"
    })

    sets.Songs.Madrigal = set_combine(sets.midcast.Song, {
        back="Intarabus's Cape",
        feet="Fili Cothurnes +2"
    })

    sets.Songs.Prelude = set_combine(sets.midcast.Song, {
        back="Intarabus's Cape",
        feet="Fili Cothurnes +2"
    })

    sets.Songs.Debuff = set_combine(sets.midcast.Song, {
        sub="Ammurapi Shield",
        head="Brioso Roundlet +2",
        body="Brioso Justau. +2",
        hands="Brioso Cuffs +2",
        legs="Brioso Cannions +2",
        feet="Brioso Slippers +3",
        back="Intarabus's Cape",
        ring1=stikini1,
        ring2=stikini2,
        ear1="",
        ear2="Darkside Earring",
        waist="Luminary Sash"
    })

    sets.Songs.Lullaby = set_combine(sets.Songs.Debuff, {
        body="Fili Hongreline +2",
        hands="Brioso Cuffs +2",
        legs="Inyanga Shalwar +2",
    })

    sets.Songs["Foe Lullaby"] = set_combine(sets.Songs.Lullaby)
    sets.Songs["Foe Lullaby II"] = set_combine(sets.Songs.Lullaby)
    sets.Songs["Horde Lullaby"] = set_combine(sets.Songs.Lullaby)

    sets.Songs["Horde Lullaby II"] = set_combine(sets.Songs.Lullaby, {
        -- hands="Inyanga Dastanas +2",
        legs="Inyanga Shalwar +2",
        ranged="Daurdabla"
    })

    send_command('bind f10 gs c auto')
    send_command('bind f12 gs c sing')
    send_command('bind ^f12 gs c clear')
    send_command('bind ^f11 gs c removefront')
    send_command('bind !f11 gs c removeback')
    updateTable()
end

function updateTable()
    clear_table()
    addToTable("(Ctrl/Alt + F11)", "Remove First/Last")
    addToTable("(Ctrl + F12)", "Clear Queue")
    addToTable("(F12)", "Sing Next")
    addToTable("Song Queue ("..queue_length()..") - (F10) Automatic", auto_song)
    addToTable("________________________________________\n")
    addToTable("Current", current.." ")
    addToTable("----------------------------------------\n")

    if queue_length() == 0 then
        addToTable("Empty")
    else
        for _,name in ipairs(song_queue) do
            addToTable(name.."\n")
        end
    end

    update_message()
end
-- --- Precast ---

function precast(spell)
    if (string.find(spell.type,'Song') and busy == true) then
        add_to_chat(140, "Spell cancelled - "..spell.name)
        cancel_spell()
    end
    busy = true
    set = {}
    if string.find(spell.type,'Song') then
        current = spell.name
        updateTable()
    end
    if  string.find(spell.type,'Magic') or string.find(spell.type,'Trust')  or string.find(spell.type,'Song') then
        set = sets.precast.FastCast
    end
    if (string.find(spell.name,'Honor')) then
        set = set_combine(set, sets.HonorMarch)
    end

    equip(set)

end
-- --- MidCast ---
function midcast(spell)
    busy = true
    if string.find(spell.type,'Magic') or string.find(spell.type,'Song')  then
        set = sets.midcast.Song
        if (string.find(spell.name, 'Carol')) then
            set = sets.Songs.Carol
        elseif (string.find(spell.name, 'Scherzo')) then
            set = sets.Songs.Scherzo
        elseif (string.find(spell.name, 'Prelude')) then
            set = sets.Songs.Prelude
        elseif (string.find(spell.name, 'Madrigal')) then
            set = sets.Songs.Madrigal
        end

        inst = set.ranged
        if (spell.name == "Army's Paeon") then
            set = sets.midcast.Song.Dummy
            inst = "Daurdabla"
        elseif (spell.name == "Knight's Minne") then
            set = sets.midcast.Song.Dummy
            inst = "Daurdabla"
        end
        
        if (spell.name == "Honor March") then
            inst = sets.HonorMarch.ranged
        end

        if (spell.target.type == "MONSTER") then
            set = sets.Songs.Debuff
        end

        if (string.find(spell.name, "Lullaby")) then
            set = sets.Songs[spell.name]
            inst = sets.Songs[spell.name].ranged
        end

        equip(set_combine(set, {
            ranged=inst
        }))
    end 
end

-- --- Aftercast ---

function aftercast(spell)
    busy = false
    current = ""
    if (spell.interrupted == true and command_casting == true) then
        table.insert(song_queue, 1, spell.english)
    end
    command_casting = false
    equip(sets.Idle.Standard)

    if (auto_song) then
        time = 1.2
        if (string.find(spell.type,'Song')) then
            time = 3.2
        end
        send_command('wait '..time..';gs c sing')
    end

    updateTable()
end

-- Status Change - ie. Resting

function self_command(command)
    if string.sub(command:lower(),1,3)=="add" and string.len(command) > 3 then

        spell = string.sub(command,5,string.len(command))
        
        table.insert(song_queue, spell)
        song_queue = remove_duplicates(song_queue)
        if (auto_song and not busy) then
            command = "sing"
        end

    end
    
    if (command == "removefront") then
        table.remove(song_queue, 1)
    end
    if (command == "removeback") then
        table.remove(song_queue)
    end

    if (command == "clear") then
        song_queue = {}
    end

    if (command == "auto") then
        auto_song = not auto_song
        if (auto_song and not busy) then
            command = "sing"
        end
    end

    if (command == "sing") then
        if (busy) then
            send_command('wait '..time..';gs c sing')
            return
        end
        if (queue_length() > 0) then
            song = table.remove(song_queue, 1)

            action = ""
            if (string.sub(song,1,3) == "(p)") then
                action = "Pianissimo"
                song = string.sub(song,5,string.len(song))
                table.insert(song_queue, 1, song)
            elseif (string.sub(song,1,3) == "(m)") then
                action = "Marcato"
                song = string.sub(song,5,string.len(song))
                table.insert(song_queue, 1,song)
            else
                action = song
            end
            command_casting = true
            send_command(action)
        end
    end

    updateTable()
end

function remove_duplicates(Table)
    local EndTable = {}
    for i, v in pairs(Table) do
        if not table.find(EndTable, v) then
            table.insert(EndTable, v)
        end
    end
    return EndTable
end

function queue_length()
    return table.getn(song_queue)
end