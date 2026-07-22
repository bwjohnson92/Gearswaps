-- Initialization function for this job file.

local function T(values)
    return values or {}
end

local function S(values)
    local set = {}
    if values then
        for _,value in ipairs(values) do
            set[value] = true
        end
    end

    function set:add(value)
        self[value] = true
    end

    function set:remove(value)
        self[value] = nil
    end

    function set:contains(value)
        return self[value] ~= nil
    end

    return set
end

if not string.contains then
    function string.contains(str, pattern)
        return str ~= nil and str:find(pattern, 1, true) ~= nil
    end
end

local function pathsearch(files_list)
    local search_roots = {}
    local addon_path = (windower and windower.addon_path) or './'

    search_roots[#search_roots + 1] = addon_path .. 'data/'
    search_roots[#search_roots + 1] = addon_path
    search_roots[#search_roots + 1] = './'

    if windower and windower.ffxi and windower.ffxi.get_player then
        local player_name = (windower.ffxi.get_player() and windower.ffxi.get_player().name) or 'unknown'
        search_roots[#search_roots + 1] = addon_path .. 'data/' .. player_name .. '/'
    end

    for _,base_path in ipairs(search_roots) do
        if base_path and (not windower or not windower.dir_exists or windower.dir_exists(base_path)) then
            for _,file_name in ipairs(files_list or {}) do
                local candidate = base_path .. file_name
                if windower and windower.file_exists and windower.file_exists(candidate) then
                    return candidate
                elseif io and io.open and io.open(candidate, 'r') then
                    io.close(io.open(candidate, 'r'))
                    return candidate
                end
            end
        end
    end

    return false
end

local validate_keys = {
    sets = 'sets', set = 'sets', s = 'sets',
    inventory = 'inventory', inv = 'inventory', i = 'inventory',
    mogsafe = 'safe', safe = 'safe', ms = 'safe', bank = 'safe',
    mogsafe2 = 'safe2', safe2 = 'safe2', ms2 = 'safe2', bank2 = 'safe2',
    storage = 'storage', st = 'storage',
    moglocker = 'locker', locker = 'locker', ml = 'locker',
    mogsatchel = 'satchel', satchel = 'satchel', sa = 'satchel',
    mogsack = 'sack', sack = 'sack', sk = 'sack',
    mogcase = 'case', case = 'case', c = 'case',
    wardrobe = 'wardrobe', w = 'wardrobe',
    wardrobe1 = 'wardrobe', w1 = 'wardrobe',
    wardrobe2 = 'wardrobe2', w2 = 'wardrobe2',
    wardrobe3 = 'wardrobe3', w3 = 'wardrobe3',
    wardrobe4 = 'wardrobe4', w4 = 'wardrobe4',
    wardrobe5 = 'wardrobe5', w5 = 'wardrobe5',
    wardrobe6 = 'wardrobe6', w6 = 'wardrobe6',
    wardrobe7 = 'wardrobe7', w7 = 'wardrobe7',
    wardrobe8 = 'wardrobe8', w8 = 'wardrobe8',
}

local function ensure_validation_state(repository)
    if not items or type(items) ~= 'table' then
        items = {}
    end

    if not sets or type(sets) ~= 'table' then
        sets = {}
    end

    if windower and windower.ffxi and windower.ffxi.get_items then
        local ff_items = windower.ffxi.get_items()
        if type(ff_items) == 'table' then
            items = ff_items
        end
    end

    if not items[repository] then
        items[repository] = {}
    end

    return items, sets
end

local function lowercase_name(name)
    if type(name) == 'string' then
        return name:lower()
    end
    return name
end

local function tryfilter(itemname, filter)
    if not filter or #filter == 0 then
        return true
    end

    local pass = true
    for _,v in pairs(filter) do
        if v and type(v) == 'string' then
            if v:sub(1, 1) == '-' then
                pass = false
                v = v:sub(2)
            end
            if itemname and itemname:contains(lowercase_name(v)) then
                return pass
            end
        end
    end
    return not pass
end

local function get_item_resources()
    return res or (gearswap and gearswap.res)
end

local function get_log_name_by_item_id(id)
    local item_resources = get_item_resources()
    if type(item_resources) == 'table' and type(item_resources.items) == 'table' and item_resources.items[id] then
        return item_resources.items[id][language..'_log'] or item_resources.items[id][language] or ''
    end
    return ''
end

local function get_short_name_by_item_id(id)
    local item_resources = get_item_resources()
    if type(item_resources) == 'table' and type(item_resources.items) == 'table' and item_resources.items[id] then
        return item_resources.items[id][language] or ''
    end
    return ''
end

local function get_formal_name_by_item_id(id)
    local shortname = get_short_name_by_item_id(id)
    local logname = get_log_name_by_item_id(id)
    if not shortname or shortname == '' then
        return logname or tostring(id)
    elseif not logname or logname == '' then
        return shortname
    end
    return (#logname > #shortname) and logname or shortname
end

local function get_augment_string(item)
    local augments
    if item and item.extdata and extdata and extdata.decode then
        local decoded = extdata.decode(item)
        augments = decoded and decoded.augments or {}
    else
        augments = item and (item.augment or item.augments) or {}
    end

    if augments and #augments > 0 then
        local aug_str = ''
        local started = false
        for _,augment in pairs(augments) do
            if augment ~= 'none' then
                if started then
                    aug_str = aug_str .. ','
                end
                aug_str = aug_str .. "'" .. augment .. "'"
                started = true
            end
        end
        return aug_str
    end
end

local function get_item_name(item)
    local name = ''
    if type(item) == 'string' then
        name = item
    elseif type(item) == 'table' then
        if item.id then
            name = get_formal_name_by_item_id(item.id)
        elseif item.name then
            name = item.name
        end

        local aug = get_augment_string(item)
        if aug then
            name = name .. ' {' .. aug .. '}'
        end
    end
    return name
end

local function compare_item(item, name, aug, item_short_name, item_log_name)
    local item_resources = get_item_resources()
    if not item or not item.id or item.id == 0 or not item_resources or not item_resources.items or not item_resources.items[item.id] then
        return false
    end

    name = lowercase_name(name)
    item_short_name = lowercase_name(item_short_name or get_short_name_by_item_id(item.id))
    item_log_name = lowercase_name(item_log_name or get_log_name_by_item_id(item.id))

    if item_short_name == name or item_log_name == name then
        if not aug then
            return true
        end

        local decoded = extdata and extdata.decode and extdata.decode(item)
        if decoded and decoded.augments then
            return extdata.compare_augments(aug, decoded.augments)
        end
        return true
    end

    return false
end

local function find_in_sets(item, tab, stack)
    if stack and stack:contains(tab) then
        return false
    end

    local item_short_name = lowercase_name(get_short_name_by_item_id(item.id))
    local item_log_name = lowercase_name(get_log_name_by_item_id(item.id))

    for _,v in pairs(tab or {}) do
        local name = (type(v) == 'table' and v.name) or v
        local aug = (type(v) == 'table' and (v.augments or v.augment))
        if type(aug) == 'string' then aug = {aug} end
        if type(name) == 'string' then
            if compare_item(item, name, aug, item_short_name, item_log_name) then
                return true
            end
        elseif type(v) == 'table' then
            if not stack then stack = S{} end
            stack:add(tab)
            local try = find_in_sets(item, v, stack)
            stack:remove(tab)
            if try then
                return true
            end
        end
    end

    return false
end

local function search_sets_for_items_in_bag(bag, filter)
    local extra_items = {}
    for _,item in ipairs(bag or {}) do
        if item and item.id ~= 0 then
            local log_name = lowercase_name(get_log_name_by_item_id(item.id))
            if tryfilter(log_name, filter) and not find_in_sets(item, sets) then
                extra_items[#extra_items + 1] = item
            end
        end
    end
    return extra_items
end

local function validate_return(options)
    local validateType = 'sets'
    if options and #options > 0 then
        local match = validate_keys[options[1]:lower()]
        if match then
            validateType = match
            table.remove(options, 1)
        end
    else
        return nil
    end

    if validateType == 'sets' then
        return nil
    end

    ensure_validation_state(validateType)
    local extra_items = search_sets_for_items_in_bag(items[validateType], options)
    return extra_items
end

local slot_sort_order = {
    main = 1,
    sub = 2,
    range = 3,
    ammo = 4,
    head = 5,
    body = 6,
    hands = 7,
    legs = 8,
    feet = 9,
    neck = 10,
    waist = 11,
    back = 12,
    left_ear = 13,
    right_ear = 14,
    left_ring = 15,
    right_ring = 16,
}

local function get_item_slot_names(item)
    local names = {}
    local item_resources = get_item_resources()
    if type(item) == 'table' and item.id and item.id ~= 0 and item_resources and item_resources.items and item_resources.items[item.id] then
        local slots = item_resources.items[item.id].slots
        if slots then
            for slot_id in slots:it() do
                local slot_entry = item_resources.slots and item_resources.slots[slot_id]
                if slot_entry and slot_entry.english then
                    names[#names + 1] = slot_entry.english:gsub(' ', '_'):lower()
                end
            end
        end
    end
    return names
end

local function get_slot_sort_value(item)
    local slot_names = get_item_slot_names(item)
    local best_value = nil
    for _,slot_name in ipairs(slot_names) do
        local slot_value = slot_sort_order[slot_name]
        if slot_value then
            if not best_value or slot_value < best_value then
                best_value = slot_value
            end
        end
    end
    return best_value or 100
end

local function sort_inventory_entries(entries)
    if type(entries) ~= 'table' then
        return entries
    end

    table.sort(entries, function(a, b)
        local a_name = type(a) == 'table' and get_item_name(a) or tostring(a or '')
        local b_name = type(b) == 'table' and get_item_name(b) or tostring(b or '')
        local a_sort = get_slot_sort_value(a)
        local b_sort = get_slot_sort_value(b)

        if a_sort ~= b_sort then
            return a_sort < b_sort
        end

        if a_name ~= b_name then
            return a_name < b_name
        end

        return false
    end)

    return entries
end

local jobs = T{
     "WAR",
     "MNK",
     "WHM",
     "BLM",
     "RDM",
     "THF",
     "PLD",
     "DRK",
     "BST",
     "BRD",
     "RNG",
     "SAM",
     "NIN",
     "DRG",
     "SMN",
     "BLU",
     "COR",
     "PUP",
     "DNC",
     "SCH",
     "GEO",
     "RUN"
}

mysets = {}

search = function ()
    windower.add_to_chat(140, "Beginning search")
    export_items = {}
    inventory_items = {}
    inventory_order = {}

    for i = 1, 8 do
        local inventory_name = i == 1 and 'wardrobe' or 'wardrobe' .. i
        local found = find_in_wardrobe(i)
        local count = 0

        if type(found) == 'table' then
            if type(found.length) == 'function' then
                count = found:length()
            elseif type(found.length) == 'number' then
                count = found.length
            else
                for _ in pairs(found) do
                    count = count + 1
                end
            end

            inventory_items[inventory_name] = {}
            inventory_order[#inventory_order + 1] = inventory_name
            for j = 1, count do
                local entry = found[j]
                if entry ~= nil then
                    inventory_items[inventory_name][#inventory_items[inventory_name] + 1] = entry
                    export_items[#export_items + 1] = entry
                end
            end
            inventory_items[inventory_name] = sort_inventory_entries(inventory_items[inventory_name])
        end
    end
    local file_path = (windower and windower.addon_path and (windower.addon_path .. '/data/search/')) or './data/search/'
    if windower and windower.dir_exists and not windower.dir_exists(file_path) then
        windower.create_dir(file_path)
    end

    local player_name = (player and player.name) or 'unknown'
    local player_job = (player and player.main_job) or 'unknown'
    local export_path = file_path .. 'unused_items_%s.lua':format(player_name)
    local export = io.open(export_path, 'w')

    if export then
        local output_lines = {}
        output_lines[#output_lines + 1] = 'return {'

        for order_index = 1, #inventory_order do
            local inventory_name = inventory_order[order_index]
            local entries = inventory_items[inventory_name]
            output_lines[#output_lines + 1] = string.format('    %s = {', inventory_name)
            for i = 1, #entries do
                local entry = entries[i]
                local name = ''
                if type(entry) == 'table' then
                    name = get_item_name(entry)
                elseif type(entry) == 'string' and entry ~= '' then
                    name = entry
                end

                if name ~= '' then
                    output_lines[#output_lines + 1] = string.format('        %q,', name)
                end
            end
            output_lines[#output_lines + 1] = '    },'
        end

        output_lines[#output_lines + 1] = '}'
        windower.add_to_chat(140, 'Writing ' .. tostring(#export_items) .. ' items to export file')
        export:write(table.concat(output_lines, '\n'))
        export:close()
    windower.add_to_chat(140, "Search complete. Exported " .. tostring(#export_items) .. " items to " .. export_path)

    else
        windower.add_to_chat(123, 'Unable to write export file: ' .. export_path)
    end
    windower.add_to_chat(140, 'Reloading Gearswap.')
    windower.send_command('lua r gearswap')
end


loaded = {}
for k,v in pairs(jobs) do
    name = windower.ffxi.get_player().name
    file_name = name .. '_' .. v .. '.lua'
    if pathsearch({file_name}) then
        include(file_name)
        get_sets()
        mysets[v] = sets
        sets = {}
        loaded[#loaded +1] = v
    end
    text = ""
end
for i = 1, #loaded do
    text = text .. loaded[i] .. ", "
end
windower.add_to_chat(140, "Loaded " .. text)

coroutine.schedule(search, 2)

function get_sets()
	for k,v in pairs(mysets) do sets[k] = v end
end

function find_in_wardrobe(index)
    inventory_to_search = "wardrobe"
    if index > 1 then
        inventory_to_search = inventory_to_search .. index
    end
    local found_items = validate_return({inventory_to_search})
    if found_items and type(found_items) == 'table' then
        local count = 0
        if type(found_items.length) == 'function' then
            count = found_items:length()
        elseif type(found_items.length) == 'number' then
            count = found_items.length
        else
            for _ in pairs(found_items) do
                count = count + 1
            end
        end
        windower.add_to_chat(123,'Final count = '..tostring(count))
    else
        windower.add_to_chat(123,'Final count = 0')
    end
    return found_items
end