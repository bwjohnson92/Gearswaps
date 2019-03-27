require('closetCleaner')
include('organizer-lib.lua')
--To toggle gearsets:
--Main command: //gs c toggle x set       where x = set name variable. Variables are as follows: --
--Idle sets: Idle, Melee TP sets: MTP, Ranged TP sets: RTP--
--Rudra sets: Rudra, Evisceration sets: Evisceration, Kaiten sets: Kaiten, Apex Arrow sets: Apex, Namas Arrow sets: Namas--

--TO ADD YOUR OWN WEAPON-SPECIFIC SETS:--
--Change the TP set index, toggle information at the bottom of the lua, and set names to your desired weapon. For example,--
--sets.AmanoTP.Standard for the Amanomurakumo standard TP set. Duplicate this as many times as you need to for your desired effect.--

function get_sets()

		sets.weapons = {main="Atoyac", sub="Izhiikoh"}
		--Idle Sets--
		sets.Idle = {}		

		sets.Idle.index = {'Standard'}
		
		Idle_ind = 1
		
		sets.Idle.Standard = {}
							  
		--sets.Idle.Town = {ammo="Potestas bomblet",
				--  head="Ogier's Helm",neck="Loricate Torque +1", ear1="Steelflash earring", ear2="Bladeborn earring",
				--  body="Nocturnus mail",hands="Sao. kote +2",ring1="Dark ring",ring2="Defending Ring",
				--  back="Shadow mantle",waist="Flume belt",legs="Wakido haidate",feet="Danzo Sune-Ate"}
	
		
				
				
				
				
		--TP Sets--
		sets.TP = {}

		sets.TP.index = {'Standard', 'AccuracyFull'}
		--1=Standard, 2=AccuracyLite, 3=AccuracyFull, 4=DT, 5=DTAccuracy--
		TP_ind = 1
	
		sets.TP.Standard = {ammo="Ginsen",
				    head="Felistris Mask",neck="Asperity necklace", ear1="Suppanomimi", ear2="Brutal earring",
				    body="Dread Jupon",hands="Nilas Gloves",ring1="Epona's ring",ring2="Rajas ring",
				    back="Bleating mantle",waist="Windbuffet Belt +1",legs="Ighwa Trousers",feet="Horos Toe Shoes +1"}						
		--sets.TP.AccuracyLite = {ammo="Hagneia stone",
		--			head="Otomi helm",neck="Asperity necklace", ear1="Steelflash earring", ear2="Bladeborn earring",
		--			body="Sakonji domaru",hands="Otronif gloves",ring1="K'ayres ring",ring2="Rajas ring",
		--			back="Takaha mantle",waist="Dynamic belt +1",legs="Wakido haidate",feet="Wakido Sune-Ate"}
	
		--sets.TP.AccuracyFull = {ammo="Jukukik feather",
		--			head="Yaoyotl helm",neck="Houyi's Gorget", ear1="Steelflash earring", ear2="Bladeborn earring",
		--			body="Mikinaak Breastplate",hands="Buremte gloves",ring1="K'ayres ring",ring2="Rajas ring",
		--			back="Takaha mantle",waist="Anguinus Belt",legs="Xaddi Cuisses",feet="Ejekamal Boots"}
							
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
	
		sets.Rudra = {}
	
		sets.Rudra.index = {'Attack','Accuracy'}
		Rudra_ind = 1
	
		sets.Rudra.Attack = {ammo="Charis Feather",
				    head="Umbani Cap",neck="Asperity Necklace",ear1="Brutal earring",ear2="Moonshade earring",
				    body="Dread Jupon",hands="Buremte Gloves",ring1="Candent Ring",ring2="Rajas ring",
				    back="Kayapa Cape",waist="Wanion Belt",legs="Manibozho Brais",feet="Maxixi Toe Shoes +1"}
								  
		--sets.Rudra.Accuracy = {ammo="Cheruski needle",
			--	       head="Yaoyotl helm",neck="Shadow gorget",ear1="Brutal earring",ear2="Moonshade earring",
				--       body="Phorcys korazin",hands="Buremte gloves",ring1="Vulcan's ring",ring2="Rajas ring",
				  --     back="Buquwik cape",waist="Windbuffet belt +1",legs="Wakido haidate",feet="Wakido Sune-Ate"}
							 
		sets.Evisceration = {}
	
		sets.Evisceration.index = {'Attack','Accuracy'}
		Evisceration_ind = 1
	
		sets.Evisceration.Attack = {ammo="Charis Feather",
				    head="Umbani Cap",neck="Asperity Necklace",ear1="Brutal earring",ear2="Moonshade earring",
				    body="Qaaxo Harness",hands="Iuitl Wristbands",ring1="Candent Ring",ring2="Rajas ring",
				    back="Atheling Mantle",waist="Wanion Belt",feet="Maxixi Toe Shoes +1"}
							   
	--	sets.Evisceration.Accuracy = {ammo="Potestas bomblet",
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
	
		--sets.JA.Samba
		sets.random_Stuff = { main="Echo Drops", ranged="Cream Puff",
			head="Rabbit Cap",ear1="Reraise Earring",
			ring1="Warp Ring",ring2="Capacity Ring",
			back="Mecistopins Mantle"}
end



		
		
		
function precast(spell)
	if spell.english == 'Meditate' then
		equip(sets.JA.Meditate)
	end
		
	if spell.english == 'Rudra\'s Storm' then
		equip(sets.Rudra[sets.Rudra.index[Rudra_ind]])
	end
	
	if spell.english == 'Evisceration' then
		equip(sets.Evisceration[sets.Evisceration.index[Evisceration_ind]])
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
	elseif command == 'toggle Rudra set' then
		Rudra_ind = Rudra_ind +1
		if Rudra_ind > #sets.Rudra.index then Rudra_ind = 1 end
		send_command('@input /echo <----- Tachi: Rudra Set changed to '..sets.Rudra.index[Rudra_ind]..' ----->')
    elseif command == 'toggle Evisceration set' then
		Evisceration_ind = Evisceration_ind +1
		if Evisceration_ind > #sets.Evisceration.index then Evisceration_ind = 1 end
		send_command('@input /echo <----- Tachi: Evisceration Set changed to '..sets.Evisceration.index[Evisceration_ind]..' ----->')
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
	end
end