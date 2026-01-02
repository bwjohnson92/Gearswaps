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
current = ""
command_casting = false

song_queue = {}
time = 3.2

stikini1={name="Stikini Ring", bag="wardrobe2"}
stikini2={name="Stikini Ring", bag="wardrobe3"}

castingCape = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+5',}}
meleeCape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
wsCape = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}


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
        ring1="Murky Ring",
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
        feet="Brioso Slippers +4",
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
        back=castingCape,
        feet="Fili Cothurnes +2"
    })

    sets.Songs.Prelude = set_combine(sets.midcast.Song, {
        back=castingCape,
        feet="Fili Cothurnes +2"
    })

    sets.Songs.Debuff = set_combine(sets.midcast.Song, {
        sub="Ammurapi Shield",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +2",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +2",
        feet="Brioso Slippers +4",
        back=castingCape,
        ring1=stikini1,
        ring2=stikini2,
        ear1="",
        ear2="Darkside Earring",
        waist="Luminary Sash"
    })

    sets.Songs.Lullaby = set_combine(sets.Songs.Debuff, {
        body="Fili Hongreline +2",
        hands="Brioso Cuffs +3",
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

    sets.Melee = {}
    sets.Melee.Standard = {
        main="Naegling",
        sub="Genmei Shield",
        range="Gjallarhorn",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck={ name="Bard's Charm +1", augments={'Path: A',}},
        waist="Sailfi Belt",
        left_ear="Cessance Earring",
        right_ear="Telos Earring",
        left_ring="Murky Ring",
        right_ring="Ilabrat Ring",
        back=meleeCape
    }

    sets.WS = set_combine(sets.Melee.Standard, {
        back=wsCape,
        left_ear="Moonshade Earring"
    })

    send_command('bind f10 gs c auto')
    send_command('bind f12 gs c sing')
    send_command('bind ^f12 gs c clear')
    send_command('bind !f12 gs c reset')
    send_command('bind ^f11 gs c removefront')
    send_command('bind !f11 gs c removeback')
    updateTable()
end

function updateTable()
    clear_table()
    addToTable("(Ctrl/Alt + F11)", "Remove First/Last")
    addToTable("(Ctrl + F12)", "Clear Queue")
    addToTable("(Alt + F12)", "Reset Busy")
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
    if (string.find(spell.type,'Song') and midaction()) then
        add_to_chat(140, "Spell cancelled - "..spell.name)
        cancel_spell()
        return
    end

    if (command_casting == true) then
        song_queue[1] = spell.english
    end
    
    set = {}
    if string.find(spell.type,'Song') and (spell.target.type == "PLAYER" or spell.target.type == "SELF") then
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
    current = ""
    if (spell.interrupted == false and song_queue[1] == spell.english) then
        table.remove(song_queue, 1)
    end
    command_casting = false
    equip(sets.Idle.Standard)

    if (auto_song) then
        time = 1.3
        if (string.find(spell.action_type,'Magic')) then
            time = 3
        end
        send_command('wait '..time..';gs c sing')
    end

    updateTable()
end

-- Status Change - ie. Resting

function self_command(command)
    if string.sub(command:lower(),1,3)=="add" and string.len(command) > 3 then
        move_to_auto = false
        if (queue_length() == 0 and auto_song) then
            move_to_auto = true
        end        

        spell = string.sub(command,5,string.len(command))
        
        table.insert(song_queue, spell)
        song_queue = remove_duplicates(song_queue)
        if (move_to_auto) then
            command = "sing"
        end

    end

    if (command == "reset") then
        current = ""
        if (auto_song) then
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
        if (auto_song and not midaction()) then
            command = "sing"
        end
    end

    if (command == "sing") then
        if (queue_length() > 0) then
            song = song_queue[0] or song_queue[1]

            action = ""
            if (string.sub(song,1,3) == "(p)") then
                action = "Pianissimo"
                song = string.sub(song,5,string.len(song))
                table.insert(song_queue, 2, song)
            elseif (string.sub(song,1,3) == "(m)") then
                action = "Marcato"
                song = string.sub(song,5,string.len(song))
                table.insert(song_queue, 2,song)
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