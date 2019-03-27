require('closetCleaner')
include('organizer-lib.lua')

--To toggle gearsets:
--Main command: //gs c toggle x set       where x = set name variable. Variables are as follows: --
--Idle sets: Idle, Melee TP sets: MTP, Ranged TP sets: RTP--
--Shoha sets: Shoha, Fudo sets: Fudo, Kaiten sets: Kaiten, Apex Arrow sets: Apex, Namas Arrow sets: Namas--

--TO ADD YOUR OWN WEAPON-SPECIFIC SETS:--
--Change the TP set index, toggle information at the bottom of the lua, and set names to your desired weapon. For example,--
--sets.AmanoTP.Standard for the Amanomurakumo standard TP set. Duplicate this as many times as you need to for your desired effect.--

capeLocked = false
weaponLocked = false

function get_sets()

		--Idle Sets--
		sets.Idle = {}		

		sets.Idle.index = {'Standard', 'Town'}
		
		Idle_ind = 1
		
		sets.Idle.Standard = {ammo="Potestas bomblet",
				      head="Otronif mask",neck="Loricate Torque +1", ear1="Steelflash earring", ear2="Bladeborn earring",
				      body="Miki. breastplate",hands="Otronif gloves",ring1="Dark ring",ring2="Defending Ring",
				      back="Repulse mantle",waist="Flume belt",legs="Otronif brais +1",feet="Danzo Sune-Ate"}
							  
		--sets.Idle.Town = {ammo="Potestas bomblet",
				--  head="Ogier's Helm",neck="Loricate Torque +1", ear1="Steelflash earring", ear2="Bladeborn earring",
				--  body="Nocturnus mail",hands="Sao. kote +2",ring1="Dark ring",ring2="Defending Ring",
				--  back="Shadow mantle",waist="Flume belt",legs="Wakido haidate",feet="Danzo Sune-Ate"}
	
		
				
				
				
				
		--TP Sets--
		sets.TP = {}

		sets.TP.index = {'Standard', 'AccuracyFull'}
		--1=Standard, 2=AccuracyLite, 3=AccuracyFull, 4=DT, 5=DTAccuracy--
		TP_ind = 1
	
		sets.TP.Standard = {ammo="Hagneia stone",
				    head="Yaoyotl Helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",
				    body="Sakonji Domaru +1",hands="Wakido Kote +1",ring1="K'ayres ring",ring2="Rajas ring",
				    back="Takaha mantle",waist="Windbuffet Belt +1",legs="Otronif Brais +1",feet="Otronif Boots +1"}						
		--sets.TP.AccuracyLite = {ammo="Hagneia stone",
		--			head="Otomi helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",
		--			body="Sakonji domaru",hands="Otronif gloves",ring1="K'ayres ring",ring2="Rajas ring",
		--			back="Takaha mantle",waist="Dynamic belt +1",legs="Wakido haidate",feet="Wakido Sune-Ate"}
	
		sets.TP.AccuracyFull = {ammo="Jukukik feather",
					head="Yaoyotl helm",neck="Houyi's Gorget", ear1="Steelflash earring", ear2="Bladeborn earring",
					body="Mikinaak Breastplate",hands="Buremte gloves",ring1="K'ayres ring",ring2="Rajas ring",
					back="Takaha mantle",waist="Anguinus Belt",legs="Xaddi Cuisses",feet="Ejekamal Boots"}
							
		--sets.TP.DT = {ammo="Hagneia stone",
		-- 	      head="Yaoyotl helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",
		--	      body="Miki. breastplate",hands="Otronif gloves",ring1="K'ayres ring",ring2="Rajas ring",
		--	      back="Takaha mantle",waist="Cetl belt",legs="Otronif brais",feet="Wakido Sune-Ate"}
				  
		--sets.TP.DTAccuracy = {ammo="Hagneia stone",
		--		      head="Yaoyotl helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",
		--			  body="Miki. breastplate",hands="Otronif gloves",ring1="K'ayres ring",ring2="Rajas ring",
		--		      back="Takaha mantle",waist="Cetl belt",legs="Wakido haidate",feet="Wakido Sune-Ate"}

		--Weaponskill Sets--
		sets.WS = {}
	
		sets.Shoha = {}
	
		sets.Shoha.index = {'Attack','Accuracy'}
		Shoha_ind = 1
	
		sets.Shoha.Attack = {ammo="Thew bomblet",
				    head="Otomi helm",neck="Asperity Necklace",ear1="Brutal earring",ear2="Moonshade earring",
				    body="Phorcys korazin",hands="Boor Bracelets",ring1="Candent Ring",ring2="Rajas ring",
				    back="Buquwik cape",waist="Metalsinger Belt",legs="Scuffler's Cosciales",feet="Sakonji Sune-Ate +1"}
								  
		--sets.Shoha.Accuracy = {ammo="Cheruski needle",
			--	       head="Yaoyotl helm",neck="Shadow gorget",ear1="Brutal earring",ear2="Moonshade earring",
				--       body="Phorcys korazin",hands="Buremte gloves",ring1="Vulcan's ring",ring2="Rajas ring",
				  --     back="Buquwik cape",waist="Windbuffet belt +1",legs="Wakido haidate",feet="Wakido Sune-Ate"}
							 
		sets.Fudo = {}
	
		sets.Fudo.index = {'Attack','Accuracy'}
		Fudo_ind = 1
	
		sets.Fudo.Attack = {ammo="Thew bomblet",
				    head="Otomi helm",neck="Asperity Necklace",ear1="Brutal earring",ear2="Moonshade earring",
				    body="Phorcys korazin",hands="Boor Bracelets",ring1="Candent Ring",ring2="Rajas ring",
				    back="Buquwik cape",waist="Metalsinger Belt",legs="Scuffler's Cosciales",feet="Sakonji Sune-Ate +1"}
							   
	--	sets.Fudo.Accuracy = {ammo="Potestas bomblet",
		--		      head="Yaoyotl helm",neck="Flame gorget",ear1="Brutal earring",ear2="Moonshade earring",
		--		      body="Phorcys korazin",hands="Phorcys mitts",ring1="Vulcan's ring",ring2="Rajas ring",
			--	      back="Buquwik cape",waist="Light belt",legs="Wakido haidate",feet="Gor. sollerets +1"}
									  
									  
		--Utility Sets--
		sets.Utility = {}
		
		--sets.Utility.PDT = {head="Otronif mask",neck="Loricate Torque +1",
			--	    body="Miki. breastplate",hands="Otronif gloves",ring1="Dark ring",ring2="Dark ring",
				--    back="Mollusca mantle",waist="Flume belt",legs="Otronif brais",feet="Otronif boots"}
						
	--	sets.Utility.MDT = {head="Ogier's helm",neck="Loricate Torque +1",
		--		    body="Nocturnus mail",hands="Buremte gloves",ring1="Dark ring",ring2="Dark ring",
			--	    back="Mollusca mantle",legs="Wakido haidate",feet="Wakido Sune-Ate"}
							
				
				
				
				
				
		--Job Ability Sets--
		sets.JA = {}
	
		sets.JA.Meditate = {head="Wakido Kabuto",
				   hands="Sakonji Kote"}
end



		
		
		
function precast(spell)
	if spell.english == 'Meditate' then
		equip(sets.JA.Meditate)
	end
		
	if spell.english == 'Tachi: Shoha' then
		equip(sets.Shoha[sets.Shoha.index[Shoha_ind]])
	end
	
	if spell.english == 'Tachi: Fudo' then
		equip(sets.Fudo[sets.Fudo.index[Fudo_ind]])
 	end

end

function aftercast(spell,act)
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function status_change(new,old)
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
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