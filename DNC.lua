function precast(spell)
    -- Automatically cancel Sneak when casting Spectral Jig
    windower.add_to_chat(140, "Jig")
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        send_command('cancel sneak')
        cancel_spell()
        send_command('wait 1.5; spectraljig')
    end
end
