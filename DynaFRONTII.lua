		--revision .42
		dynaFRONT = {}
		dynaFRONT.log_level = "info"
		dynaFRONT.log = mist.Logger:new("DynaFRONT", dynaFRONT.log_level)

		-- intro function
		function Introduce_Mission() -- standard mission introduction function
			local msg = {}
			msg.text = 'OPERATION GRANDSTAND 0.45'
			msg.displayTime = 29  
			msg.msgFor = {coa = {'all'}} 
			mist.message.add(msg)
			msg = {}
			msg.text = 'Created by Chameleon_Silk'
			msg.displayTime = 10 
			msg.msgFor = {coa = {'all'}} 
			mist.message.add(msg)
			msg = {}
			msg.text = 'Powered by MIST 4.5.107, DynaFRONTII, DynaLEADER and GCICAP Autonomous Airfield.' 
			msg.displayTime = 19  
			msg.msgFor = {coa = {'all'}} 
			mist.message.add(msg)
			msg = {}
			mist.scheduleFunction(displayLeaderInfo, {"BLUE"}, timer.getTime() + 10, 1200) -- display our blue leader info 10 seconds after launch and every 1200 seconds afterwards
			mist.scheduleFunction(displayLeaderInfo, {"RED"}, timer.getTime() + 31, 1200) -- display our red leader info 10 seconds after launch and every 1200 seconds afterwards
			mist.scheduleFunction(showResources, {"BLUE"}, timer.getTime() + 60, 2400) -- show our flights remaining for each side
			mist.scheduleFunction(showResources, {"RED"}, timer.getTime() + 90, 2400)
		end
				
			
		function BuildForce(iterations, whichSide, unitType, attempts, terrainType)
		local zoneUsed = {} -- local variables that we use a lot further down
		local randsquare = 0
		local restrictPoly = ""
		local useSide = ""
		local spawnPsn = {}
		local failedAttempts = 0
		local groupCalled = ""
		local rand = 0




		-- since there is a lot of repeated stuff in the next section I will only comment the first block
		for nomber = 1, iterations do	-- from 1 to ARG1 amount do a loop
			-- START OF RED SPAWN LOGIC
			if whichSide == "RED" then -- if ARG2 is "RED"
				useSide = "RED" -- useSide is "RED" (used later on)
				if unitType == "AAA" then  -- if the ARG3 is "AAA" 
				randsquare = mist.random(1,#RedSectorSquares) -- we want a redsector square randomly selected from 1 to the amount of redsector squares in the table
				zoneUsed = RedSectorSquares[randsquare] -- make the zoneUsed equal the randomly picked one
				restrictPoly = zoneUsed -- the restrictPoly is named the same as the triggerzone, so set that as well
				rand = mist.random(1,#Red_Names_AAA) -- now randomly select a template out of the amount of templates we have of that type
					groupCalled = Red_Names_AAA[rand] -- set the groupCalled to be that randomly selected string
					if restrictPoly == nil then -- if we don't have a poly there is a problem with a missing polygon flight path
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'}) -- these debug messages currently don't serialize the square (must fix sometime)
					end
					if zoneUsed == nil then -- if we don't have a zone then houston we have a problem with triggerzones
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
					if unitType == "TRUCK" then -- now do the exact same logic for every other type of group for each side...
				randsquare = mist.random(1,#RedTRUCK_SectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_TRUCK)
					groupCalled = Red_Names_TRUCK[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
					if unitType == "SHORAD" then
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_SHORAD)
					groupCalled = Red_Names_SHORAD[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
							if unitType == "TANK" then 
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_TANK)
					groupCalled = Red_Names_TANK[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
									if unitType == "INF" then
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_INF)
					groupCalled = Red_Names_INF[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
									if unitType == "APC" then
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_APC)
					groupCalled = Red_Names_APC[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
									if unitType == "CP" then 
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_CP)
					groupCalled = Red_Names_CP[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
				if unitType == "LRSAM" then
				randsquare = mist.random(1,#RedLRSAM_SectorSquares)
				zoneUsed = RedLRSAM_SectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_LRSAM)
					groupCalled = Red_Names_LRSAM[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedLRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedLRSAM_SectorSquares[randsquare]'})
					end
				end
				if unitType == "SRSAM" then
				randsquare = mist.random(1,#RedSRSAM_SectorSquares)
				zoneUsed = RedSRSAM_SectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_SRSAM)
					groupCalled = Red_Names_SRSAM[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSRSAM_SectorSquares[randsquare]'})
					end
			end	
				if unitType == "NAVY" then
				randsquare = mist.random(1,#RedNAVAL_SectorSquares)
				zoneUsed = RedNAVAL_SectorSquares[randsquare]
				restrictPoly = "WATERSPAWN"
					rand = mist.random(1,#Red_Naval_WARSHIPS)
					groupCalled = Red_Naval_WARSHIPS[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
						if unitType == "SHIP" then
				randsquare = mist.random(1,#RedSHALLOWNAVAL_SectorSquares)
				zoneUsed = RedSHALLOWNAVAL_SectorSquares[randsquare]
				restrictPoly = "WATERSPAWN"
					rand = mist.random(1,#Red_Naval_SHIPS)
					groupCalled = Red_Naval_SHIPS[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
			end
			
				-- START OF BLUE SPAWN LOGIC --
			if whichSide == "BLUE" then
					useSide = "BLUE"
				if unitType == "AAA" then 
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_AAA)
					groupCalled = Blue_Names_AAA[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
					if unitType == "TRUCK" then 
				randsquare = mist.random(1,#BlueTRUCK_SectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_TRUCK)
					groupCalled = Blue_Names_TRUCK[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
					if unitType == "SHORAD" then
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_SHORAD)
					groupCalled = Blue_Names_SHORAD[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
							if unitType == "TANK" then
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_TANK)
					groupCalled = Blue_Names_TANK[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
									if unitType == "INF" then
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_INF)
					groupCalled = Blue_Names_INF[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
									if unitType == "APC" then
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_APC)
					groupCalled = Blue_Names_APC[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
									if unitType == "CP" then 
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_CP)
					groupCalled = Blue_Names_CP[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
				if unitType == "LRSAM" then
				randsquare = mist.random(1,#BlueLRSAM_SectorSquares)
				zoneUsed = BlueLRSAM_SectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_LRSAM)
					groupCalled = Blue_Names_LRSAM[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueLRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueLRSAM_SectorSquares[randsquare]'})
					end
				end
				if unitType == "SRSAM" then
				randsquare = mist.random(1,#BlueSRSAM_SectorSquares)
				zoneUsed = BlueSRSAM_SectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_SRSAM)
					groupCalled = Blue_Names_SRSAM[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
				if unitType == "NAVY" then
				randsquare = mist.random(1,#BlueNAVAL_SectorSquares)
				zoneUsed = BlueNAVAL_SectorSquares[randsquare]
				restrictPoly = "WATERSPAWN"
					rand = mist.random(1,#Blue_Naval_WARSHIPS)
					groupCalled = Blue_Naval_WARSHIPS[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
					if unitType == "SHIP" then
				randsquare = mist.random(1,#BlueSHALLOWNAVAL_SectorSquares)
				zoneUsed = BlueSHALLOWNAVAL_SectorSquares[randsquare]
				restrictPoly = "WATERSPAWN"
					rand = mist.random(1,#Blue_Naval_SHIPS)
					groupCalled = Blue_Naval_SHIPS[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
			end
			
			
				for i = 0, attempts do -- keep looping from 0 to the placement limit we set with ARG4
				local restriction = false -- reset restriction to false
				local landgood = false -- resete landgood value
				spawnPsn = mist.getRandomPointInZone(zoneUsed, zoneUsed.radius) -- get a random point from the triggerzone we got from earlier logic
				
				if restrictPoly ~= "WATERSPAWN" then
				restriction = mist.pointInPolygon(spawnPsn, mist.getGroupPoints(restrictPoly)) -- check that point to see if it landed inside the polygon
				else
				restriction = true
				end
				
					if mist.isTerrainValid(spawnPsn, {terrainType}) == true then -- if that point was a valid terrain type as set in ARG
					landgood = true -- the land was good
					else
					landgood = false -- otherwise the land is no good
					end
							if restriction == true and landgood == true then -- polygon restriction has been met and land valid	so
							break -- break out of the loop since we have found a valid location
							end
				end
				
				
					local groupvars = {} -- ready our groupvars
					
					gid = gid + 1 -- increment our group number
					groupvars.newGroupName = useSide .. " " .. unitType .. " " .. nomber + gid -- lets name our new group i.e "REDFOR AAA 1"
					
					
					groupvars.groupName = groupCalled -- set the group name to be the template we wanted
					--gdata = mist.getCurrentGroupData(groupCalled) -- get our templates group data
					ActiveForces[unitType][useSide][nomber] = groupvars.newGroupName -- now add this name to the active groups table, under the subcategory of its unit type
					ActiveForces[unitType][useSide].TEMPLATE[nomber] = groupCalled -- remember the template we used for this group
					ActiveForces[unitType][useSide].SQUARE[nomber] = zoneUsed -- store the MGRS SQUARE for this group
					ActiveForces[unitType][useSide].POS[nomber] = spawnPsn -- save this groups position in the table
					ActiveForces[unitType][useSide].INITSIZE[nomber] = Group.getInitialSize(Group.getByName(groupCalled)) -- set its initial size
					ActiveForces[unitType][useSide].SIZE[nomber] = Group.getInitialSize(Group.getByName(groupCalled)) -- set its current size
			end
		end -- end ManipulateForce Function
		
		
		function cloneGroup(grpType, useSide, disperse, moveSpeed)
	--msg = "attempt to spawn"
	--trigger.action.outText(msg,15, false)	
		for forces = 1, #ActiveForces[grpType][useSide] do
			--local unitName = Group.getByName(grpName):getUnit(1):getName()
			local newGroupData = mist.getGroupTable(ActiveForces[grpType][useSide].TEMPLATE[forces]) -- get our template group table
			
				
			
			local newCoord = ActiveForces[grpType][useSide].POS[forces] -- use the new location point
			--local ogCoord = mist.utils.deepCopy(newCoord)
			
				--local data = mist.utils.serialize("coord", newGroupData) -- debug to show us our table
				--trigger.action.outText(data,35, true)
			
			
				for unitNumber, unitData in pairs(newGroupData.units) do -- for each unit index, and unit data
				
				if disperse ~= 0 then -- if disperse is above 0 then get a random point off the coordinate
				local unitCoord = mist.getRandPointInCircle(newCoord, disperse) -- the new unit coord
				newGroupData.units[unitNumber].x = unitCoord.x -- use the randomized point
				newGroupData.units[unitNumber].y = unitCoord.y -- use the randomized point
				--local data = mist.utils.serialize("circle", ogCoord) -- debug to show us our table
				--trigger.action.outText(data,35, false)
				else
				local spacing = 20 * unitNumber
				newGroupData.units[unitNumber].x = newCoord.x - spacing -- place the unit offset by this much
				newGroupData.units[unitNumber].y = newCoord.y + spacing -- place the unit offset by this much
				end
				end
				
				if useSide == "BLUE" then
				newGroupData.country = "USA"
				--[[
				"USA"
				"Russia"
				--]]
				elseif useSide == "RED" then
				newGroupData.country = "Russia"
				end
				
			
				newGroupData.category = 2
					
				
				if grpType == "NAVY" then
					newGroupData.category = 3
				end
				
				if grpType == "SHIP" then
					newGroupData.category = 3
				end
				--[[
				AIRPLANE      = 0,
				HELICOPTER    = 1,
				GROUND_UNIT   = 2,
				SHIP          = 3,
				STRUCTURE     = 4
				--]]
				
				newGroupData.clone = true
				newGroupData.groupName = ActiveForces[grpType][useSide][forces]
				
				local newGroup = mist.dynAdd(newGroupData)
				Group.activate(Group.getByName(newGroupData.groupName))
				newGroup.lateActivation = false
				newGroup.visible = true
		
		
	--			local data = mist.utils.serialize("grp", newGroup) -- debug to show us our table
--				trigger.action.outText(data,35, true)
				--local data = mist.utils.serialize("data", newGroupData) -- debug to show us our table
				--trigger.action.outText(data,35, true)
				if grpType == "AAA" or "APC" or "INF" then
					local chanceToForm = mist.random(1,100)
					if chanceToForm <= 49 then
					mist.scheduleFunction(moveStuff, {newGroupData.groupName, 200, 1, 20, useSide}, timer.getTime() + 5) -- uses ARG7 and ARG8 from the ManipulateForce function to move the new units after 5 seconds wait time		
					end
				end
				
				if grpType == "NAVY" then
				--mist.scheduleFunction(moveStuff, {newGroupData.groupName, 4000, 0, 250, useSide}, timer.getTime() + 5) -- uses ARG7 and ARG8 from the ManipulateForce function to move the new units after 5 seconds wait time		
				mist.scheduleFunction(moveCargoPortPatrol, {newGroupData.groupName, useSide, "Cone", moveSpeed, newCoord}, timer.getTime() + 5) -- pick a random sector to attack
				end
				
				if grpType == "SHIP" then
				mist.scheduleFunction(moveCargoPort, {newGroupData.groupName, useSide, "Cone", moveSpeed, newCoord}, timer.getTime() + 5) -- pick a random sector to attack
				end
				
				if grpType == "TANK" then -- all other types of group use this movement function instead when moveSpeed is set to above 0
				
				
				local chanceToAttack = mist.random(1,100)
					if chanceToAttack <= 49 then
					mist.scheduleFunction(attackSector, {newGroupData.groupName, useSide, "Cone", moveSpeed, newCoord}, timer.getTime() + 5) -- pick a random sector to attack
					end
				end
				
			end
		--mist.cloneMoveGroup(ActiveGroups[unitType][useSide].TEMPLATE[forces], false, groupvars) -- modified mist function to clone and move it using our vars
			
		end	
		
		
		function setupCargo(sideUsed, zoneUsed)
		local v = {}
		
		if sideUsed == "BLUE" then
		v.units = {unit}
		v.flag = 2001
		end
		
		if sideUsed == "RED" then
		v.units = {unit}
		v.flag = 2002
		end
		
		v.zones = zoneUsed
		mist.flagFunc.units_in_zones(v)
		end
		


		function monitorGroup(tabCheck, sideUsed, grpType)
		-- TABLE arg tblCheck: check this ActiveGroups table
		-- STARING arg of which side "RED" or "BLUE"
		-- STRING arg of group type "AAA", "TANK" "APC" "INF" "CP" "SRSAM" "LRSAM" "SHORAD"
		local disbandThreshold = 1
		local respawnTimer = 1

		for element = 1, #tabCheck do -- for each element in the table from 1 to the amount that is in the table
			local checkThisGroup = tabCheck[element] -- get the string of the group name located at that index
			
			if grpType == "SRSAM" or "LRSAM" then
			disbandThreshold = DISBAND_SAM_PERCENT
			respawnTimer = GROUND_RESPAWN_SAM_DELAY
			elseif grpType == "AAA" or "TRUCK" or "APC" or "INF" or "CP" or "SHORAD" or "TANK" or "SHIP" or "NAVY" then
			disbandThreshold = DISBAND_PRECRENT
			respawnTimer = GROUND_RESPAWN_DELAY
			elseif grpType == "SHIP" then
			respawnTimer = SHIP_RESPAWN_DELAY
			elseif grpType == "NAVY" then
			respawnTimer = WARSHIP_RESPAWN_DELAY
			end
			
			if Group.getByName(checkThisGroup) then -- the group must be present (existing) in order for the checks to occur
			local is = tabCheck.INITSIZE[element] -- get its inital size using the data in the table
			tabCheck.SIZE[element] = Group.getSize(Group.getByName(checkThisGroup)) -- update the current size of the group, incase things have died since last check
			local cs = tabCheck.SIZE[element] -- get its current size using the data in the table
			
				-- DEBUG SECTION
				--local msg = {}	-- ready a message to say the group name its current size and how many it started with (for debug purposes)
				--msg.text = checkThisGroup .. ' ' .. cs .. ' units left from ' .. is
				--msg.displayTime = 10
				--msg.msgFor = {coa = {'all'}} 
				--mist.message.add(msg)
				--msg = {}
				-- END DEBUG SECTION

			local decimalval = cs / is -- size divided by initial size
			local percent = decimalval * 100 -- multiplied by 100 to get percentage
			
				if percent <= disbandThreshold then -- if the percentage is less that (set in paramters.lua) then
				Group.destroy(Group.getByName(checkThisGroup)) -- destroy the group 
				
				
				local msg = {} -- message that the group has been rendered ineffective
				msg.text = checkThisGroup .. ' has been rendered combat ineffective '
				msg.displayTime = 10
				msg.msgFor = {coa = {'all'}} 
				mist.message.add(msg)
				msg = {}
			
				if sideUsed == "RED" then
				 if grpType == "TRUCK" then REDSCORE = REDSCORE + 25 -- if it was a red unit removed then red scores
				  disperse = 500
				 end
				 if grpType == "AAA" then REDSCORE = REDSCORE + 25 -- if it was a red unit removed then red scores
				  disperse = 0
				 end
				 if grpType == "TANK" then BLUESCORE = BLUESCORE - 50 -- if it was a red unit removed then red scores
				  disperse = 0
				 end
				 if grpType == "CP" then REDSCORE = REDSCORE + 150 -- if it was a red unit removed then red scores
				  disperse = 200
				 end
				 if grpType == "INF" then REDSCORE = REDSCORE + 50 -- if it was a red unit removed then red scores
				  disperse = 100
				 end
				 if grpType == "APC" then BLUESCORE = BLUESCORE - 25 -- if it was a red unit removed then red scores
				  disperse = 300
				 end
				 if grpType == "SHORAD" then REDSCORE = REDSCORE + 100 -- if it was a red unit removed then red scores
				  disperse = 0
				 end
				 if grpType == "LRSAM" then REDSCORE = REDSCORE + 200 -- if it was a red unit removed then red scores
				  disperse = 500
				 end
				 if grpType == "SRSAM" then REDSCORE = REDSCORE + 200 -- if it was a red unit removed then red scores
				  disperse = 500
				 end
				 if grpType == "NAVY" then BLUESCORE = BLUESCORE - 500 -- if it was a red unit removed then red scores
				  disperse = 1000
				 end
				 if grpType == "SHIP" then BLUESCORE = BLUESCORE - 100 -- if it was a red unit removed then red scores
				  disperse = 0
				 end
				end	
	
				if sideUsed == "BLUE" then
				 if grpType == "TRUCK" then BLUESCORE = BLUESCORE + 25 -- if it was a red unit removed then red scores
				 disperse = 500
				 end
				 if grpType == "AAA" then BLUESCORE = BLUESCORE + 25 -- if it was a red unit removed then red scores
				 disperse = 0
				 end
				 if grpType == "TANK" then REDSCORE = REDSCORE - 50 -- if it was a red unit removed then red scores
				  disperse = 0
				 end
				 if grpType == "CP" then BLUESCORE = BLUESCORE + 150 -- if it was a red unit removed then red scores
				  disperse = 200
				 end
				 if grpType == "INF" then BLUESCORE = BLUESCORE + 50 -- if it was a red unit removed then red scores
				  disperse = 100
				 end
				 if grpType == "APC" then REDSCORE = REDSCORE - 25 -- if it was a red unit removed then red scores
				 disperse = 300
				 end
				 if grpType == "SHORAD" then BLUESCORE = BLUESCORE + 100 -- if it was a red unit removed then red scores
				 disperse = 0
				 end
				 if grpType == "LRSAM" then BLUESCORE = BLUESCORE + 200 -- if it was a red unit removed then red scores
				 disperse = 500
				 end
				 if grpType == "SRSAM" then BLUESCORE = BLUESCORE + 200 -- if it was a red unit removed then red scores
				 disperse = 500
				 end
				 if grpType == "NAVY" then REDSCORE = REDSCORE - 500 -- if it was a red unit removed then red scores
				 disperse = 1000
				 end
				 if grpType == "SHIP" then REDSCORE = REDSCORE - 100 -- if it was a red unit removed then red scores
				 disperse = 0
				 end
				end
				
				local terrain = "LAND"
				
				if grpType == "NAVY" then
				local terrain = "WATER"
				end
				
				if grpType == "SHIP" then
				local terrain = "WATER"
				end
				
				mist.scheduleFunction(respawnGroup, {grpType, element, sideUsed, disperse}, timer.getTime() + respawnTimer)
				end
				end
			end
		end
		
		function respawnGroup(grpType, placeOnList, whichSide, disperse)
			--msg = "attempt to spawn"
	--trigger.action.outText(msg,15, false)	
		--for forces = 1, #ActiveForces[grpType][useSide] do
			--local unitName = Group.getByName(grpName):getUnit(1):getName()
			local usePoly, terrainType
			
			
	if whichSide == "RED" then -- if ARG2 is "RED"
				useSide = "RED" -- useSide is "RED" (used later on)
				if grpType == "AAA" then  -- if the ARG3 is "AAA" 
				randsquare = mist.random(1,#RedSectorSquares) -- we want a redsector square randomly selected from 1 to the amount of redsector squares in the table
				zoneUsed = RedSectorSquares[randsquare] -- make the zoneUsed equal the randomly picked one
				restrictPoly = zoneUsed -- the restrictPoly is named the same as the triggerzone, so set that as well
				rand = mist.random(1,#Red_Names_AAA) -- now randomly select a template out of the amount of templates we have of that type
					groupCalled = Red_Names_AAA[rand] -- set the groupCalled to be that randomly selected string
					if restrictPoly == nil then -- if we don't have a poly there is a problem with a missing polygon flight path
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'}) -- these debug messages currently don't serialize the square (must fix sometime)
					end
					if zoneUsed == nil then -- if we don't have a zone then houston we have a problem with triggerzones
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
					if grpType == "TRUCK" then -- now do the exact same logic for every other type of group for each side...
				randsquare = mist.random(1,#RedTRUCK_SectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_TRUCK)
					groupCalled = Red_Names_TRUCK[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
					if grpType == "SHORAD" then
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_SHORAD)
					groupCalled = Red_Names_SHORAD[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
							if grpType == "TANK" then 
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_TANK)
					groupCalled = Red_Names_TANK[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
									if grpType == "INF" then
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_INF)
					groupCalled = Red_Names_INF[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
									if grpType == "APC" then
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_APC)
					groupCalled = Red_Names_APC[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
									if grpType == "CP" then 
				randsquare = mist.random(1,#RedSectorSquares)
				zoneUsed = RedSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_CP)
					groupCalled = Red_Names_CP[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
					end
				end
				if grpType == "LRSAM" then
				randsquare = mist.random(1,#RedLRSAM_SectorSquares)
				zoneUsed = RedLRSAM_SectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_LRSAM)
					groupCalled = Red_Names_LRSAM[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedLRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedLRSAM_SectorSquares[randsquare]'})
					end
				end
				if grpType == "SRSAM" then
				randsquare = mist.random(1,#RedSRSAM_SectorSquares)
				zoneUsed = RedSRSAM_SectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Red_Names_SRSAM)
					groupCalled = Red_Names_SRSAM[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSRSAM_SectorSquares[randsquare]'})
					end
			end	
				if grpType == "NAVY" then
				randsquare = mist.random(1,#RedNAVAL_SectorSquares)
				zoneUsed = RedNAVAL_SectorSquares[randsquare]
				restrictPoly = "WATERSPAWN"
					rand = mist.random(1,#Red_Naval_WARSHIPS)
					groupCalled = Red_Naval_WARSHIPS[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
				if grpType == "SHIP" then
				randsquare = mist.random(1,#RedSHALLOWNAVAL_SectorSquares)
				zoneUsed = RedSHALLOWNAVAL_SectorSquares[randsquare]
				restrictPoly = "WATERSPAWN"
					rand = mist.random(1,#Red_Naval_SHIPS)
					groupCalled = Red_Naval_SHIPS[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
			end
			
				-- START OF BLUE SPAWN LOGIC --
			if whichSide == "BLUE" then
					useSide = "BLUE"
				if grpType == "AAA" then 
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_AAA)
					groupCalled = Blue_Names_AAA[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
					if grpType == "TRUCK" then 
				randsquare = mist.random(1,#BlueTRUCK_SectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_TRUCK)
					groupCalled = Blue_Names_TRUCK[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
					if grpType == "SHORAD" then
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_SHORAD)
					groupCalled = Blue_Names_SHORAD[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
							if grpType == "TANK" then
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_TANK)
					groupCalled = Blue_Names_TANK[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
									if grpType == "INF" then
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_INF)
					groupCalled = Blue_Names_INF[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
									if grpType == "APC" then
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_APC)
					groupCalled = Blue_Names_APC[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
									if grpType == "CP" then 
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_CP)
					groupCalled = Blue_Names_CP[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[randsquare]'})
					end
				end
				if grpType == "LRSAM" then
				randsquare = mist.random(1,#BlueLRSAM_SectorSquares)
				zoneUsed = BlueLRSAM_SectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_LRSAM)
					groupCalled = Blue_Names_LRSAM[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueLRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueLRSAM_SectorSquares[randsquare]'})
					end
				end
				if grpType == "SRSAM" then
				randsquare = mist.random(1,#BlueSRSAM_SectorSquares)
				zoneUsed = BlueSRSAM_SectorSquares[randsquare]
				restrictPoly = zoneUsed
					rand = mist.random(1,#Blue_Names_SRSAM)
					groupCalled = Blue_Names_SRSAM[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
				if grpType == "NAVY" then
				randsquare = mist.random(1,#BlueNAVAL_SectorSquares)
				zoneUsed = BlueNAVAL_SectorSquares[randsquare]
				restrictPoly = "WATERSPAWN"
					rand = mist.random(1,#Blue_Naval_WARSHIPS)
					groupCalled = Blue_Naval_WARSHIPS[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
						if grpType == "SHIP" then
				randsquare = mist.random(1,#BlueSHALLOWNAVAL_SectorSquares)
				zoneUsed = BlueSHALLOWNAVAL_SectorSquares[randsquare]
				restrictPoly = "WATERSPAWN"
					rand = mist.random(1,#Blue_Naval_SHIPS)
					groupCalled = Blue_Naval_SHIPS[rand]
					if restrictPoly == nil then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
					if zoneUsed == nil then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[randsquare]'})
					end
			end
			end

			
				for i = 0, 100 do -- keep looping if we don't find a position till 100 attempts
				local restriction = false -- reset restriction to false
				local landgood = false -- resete landgood value
				newCoord = mist.getRandomPointInZone(zoneUsed, zoneUsed.radius) -- get a random point from the triggerzone we got from earlier logic
				
				
				
				if restrictPoly == "WATERSPAWN" then
					terrainType = "WATER"
					restriction = true
					else
					terrainType = "LAND"
						if restrictPoly ~= nil then
						restriction = mist.pointInPolygon(newCoord, mist.getGroupPoints(restrictPoly)) -- check that point to see if it landed inside the polygon
						end
					end
				
					
				
				
				
					if mist.isTerrainValid(newCoord, {terrainType}) == true then -- if that point was a valid terrain type as set in ARG
					landgood = true -- the land was good
					else
					landgood = false -- otherwise the land is no good
					end
							if restriction == true and landgood == true then -- polygon restriction has been met and land valid	so
							break -- break out of the loop since we have found a valid location
							end
				end
				
				
					local groupvars = {} -- ready our groupvars
					
					gid = gid + 1 -- increment our group number
					groupvars.newGroupName = useSide .. " " .. grpType .. " " .. gid -- lets name our new group i.e "REDFOR AAA 1"
					
					
					groupvars.groupName = groupCalled -- set the group name to be the template we wanted
					--gdata = mist.getCurrentGroupData(groupCalled) -- get our templates group data
					ActiveForces[grpType][useSide][placeOnList] = groupvars.newGroupName -- now add this name to the active groups table, under the subcategory of its unit type
					ActiveForces[grpType][useSide].TEMPLATE[placeOnList] = groupCalled -- remember the template we used for this group
					ActiveForces[grpType][useSide].SQUARE[placeOnList] = zoneUsed -- store the MGRS SQUARE for this group
					ActiveForces[grpType][useSide].POS[placeOnList] = newCoord -- save this groups position in the table
					ActiveForces[grpType][useSide].INITSIZE[placeOnList] = Group.getInitialSize(Group.getByName(groupCalled)) -- set its initial size
					ActiveForces[grpType][useSide].SIZE[placeOnList] = Group.getInitialSize(Group.getByName(groupCalled)) -- set its current size
			
			
			
			
			local moveSpeed = mist.random(10,22) -- for now just randomly assign a speed since we are unsure of what speed it was at before
			
				--local data = mist.utils.serialize("coord", ogCoord) -- debug to show us our table
				--trigger.action.outText(data,35, false)
			
				local newGroupData = mist.getGroupTable(ActiveForces[grpType][useSide].TEMPLATE[placeOnList]) -- get our template group table
				for unitNumber, unitData in pairs(newGroupData.units) do -- for each unit index, and unit data
				
				if disperse ~= 0 then -- if disperse is above 0 then get a random point off the coordinate
				local unitCoord = mist.getRandPointInCircle(newCoord, disperse) -- the new unit coord
				newGroupData.units[unitNumber].x = unitCoord.x -- use the randomized point
				newGroupData.units[unitNumber].y = unitCoord.y -- use the randomized point
				--local data = mist.utils.serialize("circle", ogCoord) -- debug to show us our table
				--trigger.action.outText(data,35, false)
				else
				local spacing = 20 * unitNumber
				newGroupData.units[unitNumber].x = newCoord.x - spacing -- place the unit offset by this much
				newGroupData.units[unitNumber].y = newCoord.y + spacing -- place the unit offset by this much
				end
				end
				
				if useSide == "BLUE" then
				newGroupData.country = "USA"
				--[[
				"USA"
				"Russia"
				--]]
				elseif useSide == "RED" then
				newGroupData.country = "Russia"
				end
				
				newGroupData.category = 2
					
				
				if grpType == "NAVY" then
					newGroupData.category = 3
				end
				
				if grpType == "SHIP" then
					newGroupData.category = 3
				end
				--[[
				AIRPLANE      = 0,
				HELICOPTER    = 1,
				GROUND_UNIT   = 2,
				SHIP          = 3,
				STRUCTURE     = 4
				--]]
				
				--[[
				AIRPLANE      = 0,
				HELICOPTER    = 1,
				GROUND_UNIT   = 2,
				SHIP          = 3,
				STRUCTURE     = 4
				--]]
				
				newGroupData.clone = true
				newGroupData.groupName = ActiveForces[grpType][useSide][placeOnList]
				
				local newGroup = mist.dynAdd(newGroupData)
				Group.activate(Group.getByName(newGroupData.groupName))
				newGroup.lateActivation = false
				newGroup.visible = true
				
				
				local msg = {}
				msg.text = useSide .. ' ' .. grpType .. ' has been redeployed'
				msg.displayTime = 10
				msg.msgFor = {coa = {'all'}} 
				mist.message.add(msg)
				msg = {}
		
		
	--			local data = mist.utils.serialize("grp", newGroup) -- debug to show us our table
--				trigger.action.outText(data,35, true)
				
				--if grpType == "NAVY" or "SHIP" then
				--local data = mist.utils.serialize("data", newGroupData) -- debug to show us our table
				--trigger.action.outText(data,35, true)
				--end
				
				
				if grpType == "AAA" or "APC" or "INF" then
					local chanceToForm = mist.random(1,100)
					if chanceToForm <= 49 then
					mist.scheduleFunction(moveStuff, {newGroupData.groupName, 200, 1, 20, useSide}, timer.getTime() + 5) -- uses ARG7 and ARG8 from the ManipulateForce function to move the new units after 5 seconds wait time		
					end
				end
				
				if grpType == "NAVY" then
				--mist.scheduleFunction(moveStuff, {newGroupData.groupName, 4000, 0, 250, useSide}, timer.getTime() + 5) -- uses ARG7 and ARG8 from the ManipulateForce function to move the new units after 5 seconds wait time		
				mist.scheduleFunction(moveCargoPortPatrol, {newGroupData.groupName, useSide, "Cone", moveSpeed, newCoord}, timer.getTime() + 5) -- pick a random sector to attack
				end
				
				if grpType == "SHIP" then
				mist.scheduleFunction(moveCargoPort, {newGroupData.groupName, useSide, "Cone", moveSpeed, newCoord}, timer.getTime() + 5) -- pick a random sector to attack
				end
				
				if grpType == "TANK" then -- all other types of group use this movement function instead when moveSpeed is set to above 0
				local chanceToAttack = mist.random(1,100)
					if chanceToAttack <= 49 then
					mist.scheduleFunction(attackSector, {newGroupData.groupName, useSide, "Cone", moveSpeed, newCoord}, timer.getTime() + 5) -- pick a random sector to attack
					end
				end
				
			end
		
		
				function attackSector(grpName, forSide, formationUsed, moveSpeed, startPos)
		-- for now it selects a random enemy sector to attack
		local restrictions, sectorAttack
		local sector = {}
		local attackWP = {}
		local attackWP2 = {}
		local attackWP3 = {}
		local attackWP4 = {}
		local attackWP5 = {}
		
		if forSide == "RED" then
			sectorAttack = mist.random(1, #BlueSectorSquares)
			sector = BlueSectorSquares[sectorAttack]
		end
		if forSide == "BLUE" then
			sectorAttack = mist.random(1, #RedSectorSquares)
			sector = RedSectorSquares[sectorAttack]
		end
		
		
		
			--local data = mist.utils.serialize("wp1", sector) -- debug to show us our table
			--	trigger.action.outText(data,55, false)	
		
		
		local restrictPoly = sector
		--local controller = ctrl:getByName(grpName)
		local group = Group.getByName(grpName)
		--local grpData = getGroupTable(group)
		--local ctl = group:getController()
		
		
			for i = 0, 25 do -- for 1000 attempts
				local restriction = false -- reset restriction
				local restriction2 = false -- reset restriction
				local restriction3 = false -- reset restriction
				local restriction4 = false -- reset restriction
				local restriction5 = false -- reset restriction
				local landgood = false -- reset landgood
			
				attackWP = mist.getRandomPointInZone(sector, sector.radius) -- get a point from that zone
				attackWP2 = {y = attackWP.y - 500, x = attackWP.x - 500}
				attackWP3 = {y = attackWP.y + 500, x = attackWP.x + 500}
				attackWP4 = {y = attackWP.y - 500, x = attackWP.x + 500}
				attackWP5 = {y = attackWP.y + 500, x = attackWP.x - 500}
				
				--restriction = mist.pointInPolygon(attackWP, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction2 = mist.pointInPolygon(attackWP2, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction3 = mist.pointInPolygon(attackWP3, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction4 = mist.pointInPolygon(attackWP4, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction5 = mist.pointInPolygon(attackWP5, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				
					if mist.isTerrainValid(attackWP, {"LAND"}) == true then -- if the land is valid
					landgood = true -- land is good
					--else -- otherwise
					--landgood = false -- land is bad, mmm kay
					end
					
					if landgood == true then 
					-- all restrictions met
					restrictions = true
					else
					restrictions = false
					end
					
						if landgood == true and restrictions == true then--and restriction2 == true and restriction3 == true and restriction4 == true and restriction5 == true then-- polygon restriction has been met and land valid	
							break -- break out of the loop
							end
				end
		
				--local data2 = mist.utils.serialize("wp2", attackWP) -- debug to show us our table
				--trigger.action.outText(data2,55, true)	
				
		
		
		--if restrictions ~= false then
		local path = {} 
		path[#path + 1] = mist.ground.buildWP(startPos, formationUsed, moveSpeed) 
		path[#path + 1] = mist.ground.buildWP(attackWP, formationUsed, moveSpeed) 
		--trigger.action.outText("tried to do a route",55, true)	
		mist.goRoute(group, path)
		--end
		

				--local buildPsn = mist.utils.makeVec3(spawnPsn) -- vec3 of the spawnPsn
				--local buildPsnFarp = mist.utils.makeVec2(spawnPsn) -- vec2 of the spawnPsn

		
		end
		
		function moveCargoPort(grpName, forSide, formationUsed, moveSpeed, startPos)
		-- for now it selects a random enemy sector to attack
		local restrictions, sectorAttack
		local sector = {}
		local attackWP = {}
		local attackWP2 = {}
		local attackWP3 = {}
		local attackWP4 = {}
		local attackWP5 = {}
		
		if forSide == "RED" then
			--sectorAttack = mist.random(1, #BlueSectorSquares)
			sector = "redPort"
		end
		if forSide == "BLUE" then
			--sectorAttack = mist.random(1, #RedSectorSquares)
			sector = "bluePort"
		end
		
		
		
			--local data = mist.utils.serialize("wp1", sector) -- debug to show us our table
			--	trigger.action.outText(data,55, false)	
		
		
		local restrictPoly = sector
		--local controller = ctrl:getByName(grpName)
		local group = Group.getByName(grpName)
		--local grpData = getGroupTable(group)
		--local ctl = group:getController()
		
		
			for i = 0, 100 do -- for 1000 attempts
				local restriction = false -- reset restriction
				local restriction2 = false -- reset restriction
				local restriction3 = false -- reset restriction
				local restriction4 = false -- reset restriction
				local restriction5 = false -- reset restriction
				local landgood = false -- reset landgood
			
				attackWP = mist.getRandomPointInZone(sector, sector.radius) -- get a point from that zone
				attackWP2 = {y = attackWP.y - 100, x = attackWP.x - 100}
				attackWP3 = {y = attackWP.y + 100, x = attackWP.x + 100}
				attackWP4 = {y = attackWP.y - 100, x = attackWP.x + 100}
				attackWP5 = {y = attackWP.y + 100, x = attackWP.x - 100}
				
				--restriction = mist.pointInPolygon(attackWP, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction2 = mist.pointInPolygon(attackWP2, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction3 = mist.pointInPolygon(attackWP3, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction4 = mist.pointInPolygon(attackWP4, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction5 = mist.pointInPolygon(attackWP5, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				
					if mist.isTerrainValid(attackWP, {"WATER"}) == true then -- if the land is valid
					landgood = true -- land is good
					--else -- otherwise
					--landgood = false -- land is bad, mmm kay
					end
					
					if landgood == true then 
					-- all restrictions met
					restrictions = true
					else
					restrictions = false
					end
					
						if landgood == true and restrictions == true then--and restriction2 == true and restriction3 == true and restriction4 == true and restriction5 == true then-- polygon restriction has been met and land valid	
							break -- break out of the loop
							end
				end
		
				--local data2 = mist.utils.serialize("wp2", attackWP) -- debug to show us our table
				--trigger.action.outText(data2,55, true)	
				
		
		
		--if restrictions ~= false then
		local path = {} 
		path[#path + 1] = mist.ground.buildWP(startPos, formationUsed, moveSpeed) 
		path[#path + 1] = mist.ground.buildWP(attackWP, formationUsed, moveSpeed) 
		--trigger.action.outText("tried to do a route",55, true)	
		mist.goRoute(group, path)
		--end
		local unit = Group.getByName(cargoShip):getUnit(1)
		
		setupCargo(forSide, moveWP, unit)

				--local buildPsn = mist.utils.makeVec3(spawnPsn) -- vec3 of the spawnPsn
				--local buildPsnFarp = mist.utils.makeVec2(spawnPsn) -- vec2 of the spawnPsn

		
		end
		
		function moveCargoPortPatrol(grpName, forSide, formationUsed, moveSpeed, startPos)
		-- for now it selects a random enemy sector to attack
		local restrictions, sectorAttack
		local sector = {}
		local attackWP = {}
		local attackWP2 = {}
		local attackWP3 = {}
		local attackWP4 = {}
		local attackWP5 = {}
		
		if forSide == "RED" then
			--sectorAttack = mist.random(1, #BlueSectorSquares)
			sector = "redPort"
		end
		if forSide == "BLUE" then
			--sectorAttack = mist.random(1, #RedSectorSquares)
			sector = "bluePort"
		end
		
		
		
			--local data = mist.utils.serialize("wp1", sector) -- debug to show us our table
			--	trigger.action.outText(data,55, false)	
		
		
		local restrictPoly = sector
		--local controller = ctrl:getByName(grpName)
		local group = Group.getByName(grpName)
		--local grpData = getGroupTable(group)
		--local ctl = group:getController()
		
		
			for i = 0, 100 do -- for 1000 attempts
				local restriction = false -- reset restriction
				local restriction2 = false -- reset restriction
				local restriction3 = false -- reset restriction
				local restriction4 = false -- reset restriction
				local restriction5 = false -- reset restriction
				local landgood = false -- reset landgood
			
				attackWP = mist.getRandomPointInZone(sector, sector.radius) -- get a point from that zone
				attackWP2 = {y = attackWP.y - 100, x = attackWP.x - 100}
				attackWP3 = {y = attackWP.y + 100, x = attackWP.x + 100}
				attackWP4 = {y = attackWP.y - 100, x = attackWP.x + 100}
				attackWP5 = {y = attackWP.y + 100, x = attackWP.x - 100}
				
				--restriction = mist.pointInPolygon(attackWP, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction2 = mist.pointInPolygon(attackWP2, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction3 = mist.pointInPolygon(attackWP3, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction4 = mist.pointInPolygon(attackWP4, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				--restriction5 = mist.pointInPolygon(attackWP5, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				
					if mist.isTerrainValid(attackWP, {"WATER"}) == true then -- if the land is valid
					landgood = true -- land is good
					--else -- otherwise
					--landgood = false -- land is bad, mmm kay
					end
					
					if landgood == true then 
					-- all restrictions met
					restrictions = true
					else
					restrictions = false
					end
					
						if landgood == true and restrictions == true then--and restriction2 == true and restriction3 == true and restriction4 == true and restriction5 == true then-- polygon restriction has been met and land valid	
							break -- break out of the loop
							end
				end
		
				--local data2 = mist.utils.serialize("wp2", attackWP) -- debug to show us our table
				--trigger.action.outText(data2,55, true)	
				
		
		
		--if restrictions ~= false then
		local path = {} 
		path[#path + 1] = mist.ground.buildWP(startPos, formationUsed, moveSpeed) 
		path[#path + 1] = mist.ground.buildWP(attackWP, formationUsed, moveSpeed) 
		--trigger.action.outText("tried to do a route",55, true)	
		mist.goRoute(group, path)
		--end
		--local unit = Group.getByName(cargoShip):getUnit(1)
		
		local v = {}
		v.groupName = grpName
		v.useGroupRoute = grpName
		v.speed = moveSpeed
		v.patrolType = "doubleBack"
		
		mist.ground.patrolRoute(v)
		--setupCargo(forSide, moveWP, unit)

				--local buildPsn = mist.utils.makeVec3(spawnPsn) -- vec3 of the spawnPsn
				--local buildPsnFarp = mist.utils.makeVec2(spawnPsn) -- vec2 of the spawnPsn

		
		end
		


		function CreateArmy(forSide, unitType) -- create initial spawns for each force (I call CreateArmy in miz on a mission trigger)

		if forSide == "blue" or "BLUE" or "b" or "B" then
		mist.scheduleFunction(BuildForce, {bAAAamount, "BLUE", "AAA", 100, "LAND"}, timer.getTime() + 1) -- space out each spawn in by 2 seconds to lessen the impact on server performance
		mist.scheduleFunction(BuildForce, {bTRUCKamount, "BLUE", "TRUCK", 50, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bSHORADamount, "BLUE", "SHORAD", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bINFamount, "BLUE", "INF", 10, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bTANKamount, "BLUE", "TANK", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bAPCamount, "BLUE", "APC", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bCPamount, "BLUE", "CP", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bSRSAMamount, "BLUE", "SRSAM", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bLRSAMamount, "BLUE", "LRSAM", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bNAVYamount, "BLUE", "NAVY", 100, "WATER"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {bSHIPamount, "BLUE", "SHIP", 100, "WATER"}, timer.getTime() + 1)
		end

		if forSide == "red" or "RED" or "r" or "R" then
		mist.scheduleFunction(BuildForce, {rAAAamount, "RED", "AAA", 100, "LAND"}, timer.getTime() + 1) -- space out each spawn in by 2 seconds to lessen the impact on server performance
		mist.scheduleFunction(BuildForce, {rTRUCKamount, "RED", "TRUCK", 50, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rSHORADamount, "RED", "SHORAD", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rINFamount, "RED", "INF", 10, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rTANKamount, "RED", "TANK", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rAPCamount, "RED", "APC", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rCPamount, "RED", "CP", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rSRSAMamount, "RED", "SRSAM", 100, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rLRSAMamount, "RED", "LRSAM", 300, "LAND"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rNAVYamount, "RED", "NAVY", 100, "WATER"}, timer.getTime() + 1)
		mist.scheduleFunction(BuildForce, {rSHIPamount, "RED", "SHIP", 100, "WATER"}, timer.getTime() + 1)
		end
		
		mist.scheduleFunction(SpawnForce, {}, timer.getTime() + 3)
		end
		
		function SpawnForce()
		mist.scheduleFunction(cloneGroup, {"AAA", "BLUE", 300, 0}, timer.getTime() + 1)
		mist.scheduleFunction(cloneGroup, {"TRUCK", "BLUE", 300, 0}, timer.getTime() + 2)
		mist.scheduleFunction(cloneGroup, {"SHORAD", "BLUE", 0, 0}, timer.getTime() + 3)
		mist.scheduleFunction(cloneGroup, {"INF", "BLUE", 300, mist.random(4,7)}, timer.getTime() + 4)
		mist.scheduleFunction(cloneGroup, {"TANK", "BLUE", 300, mist.random(12,22)}, timer.getTime() + 5)
		mist.scheduleFunction(cloneGroup, {"APC", "BLUE", 300, mist.random(12,22)}, timer.getTime() + 6)
		mist.scheduleFunction(cloneGroup, {"CP", "BLUE", 300, 0}, timer.getTime() + 7)
		mist.scheduleFunction(cloneGroup, {"SRSAM", "BLUE", 300, 0}, timer.getTime() + 8)
		mist.scheduleFunction(cloneGroup, {"LRSAM", "BLUE", 300, 0}, timer.getTime() + 9)
		mist.scheduleFunction(cloneGroup, {"NAVY", "BLUE", 1000, mist.random(20,21)}, timer.getTime() + 10)
		mist.scheduleFunction(cloneGroup, {"SHIP", "BLUE", 1000, mist.random(20,21)}, timer.getTime() + 11)
		
		mist.scheduleFunction(cloneGroup, {"AAA", "RED", 300, 0}, timer.getTime() + 20)
		mist.scheduleFunction(cloneGroup, {"TRUCK", "RED", 300, 0}, timer.getTime() + 21)
		mist.scheduleFunction(cloneGroup, {"SHORAD", "RED", 0, 0}, timer.getTime() + 22)
		mist.scheduleFunction(cloneGroup, {"INF", "RED", 300, mist.random(4,7)}, timer.getTime() + 23)
		mist.scheduleFunction(cloneGroup, {"TANK", "RED", 300, mist.random(12,22)}, timer.getTime() + 24)
		mist.scheduleFunction(cloneGroup, {"APC", "RED", 300, mist.random(12,22)}, timer.getTime() + 25)
		mist.scheduleFunction(cloneGroup, {"CP", "RED", 300, 0}, timer.getTime() + 26)
		mist.scheduleFunction(cloneGroup, {"SRSAM", "RED", 300, 0}, timer.getTime() + 27)
		mist.scheduleFunction(cloneGroup, {"LRSAM", "RED", 300, 0}, timer.getTime() + 28)
		mist.scheduleFunction(cloneGroup, {"NAVY", "RED", 1000, mist.random(20,21)}, timer.getTime() + 29)
		mist.scheduleFunction(cloneGroup, {"SHIP", "RED", 1000, mist.random(20,21)}, timer.getTime() + 30)
		end
		
		
function BuildFARP(side, ownedBy)
		-- ARG1 STRING, red or blue
		-- ARG2 STRING, country of origin
		local forWhom = ""
		local farpName = ""
		local zoneUsed = {}
		local randsquare = 0
		local restrictPoly = ""
		local useSide = ""
		local spawnPsn = {}
		local failedAttempts = 0

		if side == "RED" then
				forWhom = "Russia" -- country name of the FAP
				farpName = "FARPRED" -- FARP name as placed in mission editor
				randsquare = mist.random(1,#RedTRUCK_SectorSquares) -- put it in a random truck square by getting a random string from the table
				zoneUsed = RedSectorSquares[randsquare] -- get that triggerzone
				restrictPoly = zoneUsed -- get the poly for that zone
		end
		if side == "BLUE" then -- same as red logic
				forWhom = "USA"
				farpName = "FARPBLUE"
				randsquare = mist.random(1,#BlueTRUCK_SectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
		end

						for i = 0, 100 do -- for 1000 attempts
				local restriction = false -- reset restriction
				local restriction2 = false
				local restriction3 = false
				local restriction4 = false
				local restriction5 = false
				local landgood = false -- reset landgood
			
				spawnPsn = mist.getRandomPointInZone(zoneUsed, zoneUsed.radius) -- get a point from that zone
				local spawnPsn2 = {y = spawnPsn.y - 200, x = spawnPsn.x - 200}
				local spawnPsn3 = {y = spawnPsn.y + 200, x = spawnPsn.x + 200}
				local spawnPsn4 = {y = spawnPsn.y - 200, x = spawnPsn.x + 200}
				local spawnPsn5 = {y = spawnPsn.y + 200, x = spawnPsn.x - 200}
				
				restriction = mist.pointInPolygon(spawnPsn, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				restriction2 = mist.pointInPolygon(spawnPsn2, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				restriction3 = mist.pointInPolygon(spawnPsn3, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				restriction4 = mist.pointInPolygon(spawnPsn4, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				restriction5 = mist.pointInPolygon(spawnPsn5, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				
					if mist.isTerrainValid(spawnPsn, {terrainType}) == true then -- if the land is valid
					landgood = true -- land is good
					else -- otherwise
					landgood = false -- land is bad, mmm kay
					end
					
					if restriction and restriction2 and restriction3 and restriction4 and restriction5 then
					-- all restrictions met
					restrictions = true
					else
					restrictions = false
					end
					
							if landgood == true and restrictions == true then--and restriction2 == true and restriction3 == true and restriction4 == true and restriction5 == true then-- polygon restriction has been met and land valid	
							break -- break out of the loop
							end	
				end
				
				local buildPsn = mist.utils.makeVec3(spawnPsn) -- vec3 of the spawnPsn
				local buildPsnFarp = mist.utils.makeVec2(spawnPsn) -- vec2 of the spawnPsn
				
		--local vars = 
		--{
		-- type = "FARP", -- its of type FARP
		-- country = forWhom, -- country
		-- category = "Heliports", -- category 
		-- x = buildPsn.x, -- vec2 x value
		-- y = buildPsn.z, -- vec2 y value
		 --name = farpName,
		-- unitName = farpName, -- the farpName
		-- clone = false, -- clone it, we must clone an already existing FARP otherwise an error occurs (DCS limitation perhaps?)
		 --groupName = "FARP" .. side,
		-- heading = 0, -- probably should randomize the direction or have it face the right way in future
		--}
		
			 -- DEBUG STUFF
			--	local data = mist.utils.serialize("v3", spawnPsn) -- debug to show us our table
			--	trigger.action.outText(data,25, true)	
				
				--local data2 = mist.utils.serialize("v2", buildPsnFarp) -- debug to show us our table
				--trigger.action.outText(data2,25, false)	
				-- END DEBUG STUFF
		
		--[[
		local vars = {
		type = "Invisible FARP", -- its of type FARP
		country = forWhom, -- country
		category = "Heliports", -- category 
		x = buildPsn.x, -- vec2 x value
		y = buildPsn.z, -- vec2 y value
		 --name = farpName,
		unitName = farpName, -- the farpName
		clone = false, -- clone it, we must clone an already existing FARP otherwise an error occurs (DCS limitation perhaps?)
		--groupName = "FARP" .. side,
		heading = 0, -- probably should randomize the direction or have it face the right way in future
		heliport_callsign_id = 2,
		heliport_modulation = 0,
		heliport_frequency = "127.5",
		}
		mist.dynAddStatic(vars)	-- add the static item to the mission
		--]]
		local newx = buildPsn.x - 40
		local newy = buildPsn.z - 70
		
		
		local vars = {
		type = "FARP Ammo Dump Coating", -- its of type FARP
		country = forWhom, -- country
		category = "Fortifications", -- category 
		x = newx,
		y = newy,
		 --name = farpName,
		unitName = farpName, -- the farpName
		clone = false, -- clone it, we must clone an already existing FARP otherwise an error occurs (DCS limitation perhaps?)
		--groupName = "FARP" .. side,
		heading = 1.5708, -- probably should randomize the direction or have it face the right way in future
		}
		mist.dynAddStatic(vars)	-- add the static item to the mission
		
		local newx = buildPsn.x 
		local newy = buildPsn.z - 70
		
		local vars = {
		type = "FARP Fuel Depot", -- its of type FARP
		country = forWhom, -- country
		category = "Fortifications", -- category 
		x = newx,
		y = newy,
		 --name = farpName,
		unitName = farpName, -- the farpName
		clone = false, -- clone it, we must clone an already existing FARP otherwise an error occurs (DCS limitation perhaps?)
		--groupName = "FARP" .. side,
		heading = 1.5708, -- probably should randomize the direction or have it face the right way in future
		--heliport_callsign_id = 2,
		--heliport_modulation = 0,
		}
		mist.dynAddStatic(vars)	-- add the static item to the mission
		
		local newx = buildPsn.x + 40
		local newy = buildPsn.z - 70
		
		local vars = {
		type = "FARP CP Blindage", -- its of type FARP
		country = forWhom, -- country
		category = "Fortifications", -- category 
		x = newx,
		y = newy,
		 --name = farpName,
		--unitName = farpName, -- the farpName
		clone = false, -- clone it, we must clone an already existing FARP otherwise an error occurs (DCS limitation perhaps?)
		--groupName = "FARP" .. side,
		heading = 1.5708, -- probably should randomize the direction or have it face the right way in future
		--heliport_callsign_id = 2,
		--heliport_modulation = 0,
		}
		mist.dynAddStatic(vars)	-- add the static item to the mission
		
		local newx = buildPsn.x + 80
		local newy = buildPsn.z - 70
		
		local vars = {
		type = "FARP Tent", -- its of type FARP
		country = forWhom, -- country
		category = "Fortifications", -- category 
		x = newx,
		y = newy,
		 --name = farpName,
		--unitName = farpName, -- the farpName
		clone = false, -- clone it, we must clone an already existing FARP otherwise an error occurs (DCS limitation perhaps?)
		--groupName = "FARP" .. side,
		heading = 1.5708, -- probably should randomize the direction or have it face the right way in future
		--heliport_callsign_id = 2,
		--heliport_modulation = 0,
		}
		mist.dynAddStatic(vars)	-- add the static item to the mission
					
					local Strike_Area = {
					x = buildPsn.x,
					y = buildPsn.y,
					z = buildPsn.z,
					radius = 3000
					}
			
					
					if forWhom == "Russia" then
					redStartFarp = buildPsnFarp
					redFarpPos = Strike_Area -- store the vec3 in redFarpPos for use with the heloattack script
					mist.flagFunc.mapobjs_dead_point { locations = {Strike_Area_Zone}, flag = 1005, req_num = 4}
					end
					
					if forWhom == "USA" then
					blueStartFarp = buildPsnFarp
					blueFarpPos = Strike_Area -- store the vec3 in blueFarpPos for use with the heloattack script
					mist.flagFunc.mapobjs_dead_point { locations = {Strike_Area_Zone}, flag = 1006, req_num = 4}
					end
					
		end
		
			
		function moveStuff(thisGroupName, randomizerDist, formForce, spd, team)	-- this is old code from 7 years ago, will need to write a much better ground tasking script to attack sectors in the future, for now just have them randomly move around to create conflicts
			if thisGroupName == nil then
			return
			end
			
			
			
			
			
			local Name = Group.getByName(thisGroupName)
			local negativeheading = mist.random(0,1) -- quick hack to make things work with 0-360 degrees


				--local msg = {}
				--msg.text = team .. ' ' .. thisGroupName .. ' has been ordered' .. formForce .. ' ' .. randomizerDist
				--msg.displayTime = 50
				--msg.msgFor = {coa = {'all'}} 
				--mist.message.add(msg)
				--msg = {}
				
			
			if team == "RED" then
				if negativeheading == 0 then
				randomizer_dir = mist.random(0,60) 	-- red should be advancing north randomly at the very least, here we are just setting the direction they face after they move
				end
				if negativeheading == 1 then
				randomizer_dir = mist.random(300,360) 	-- red should be advancing north randomly at the very least, here we are just setting the direction they face after they move
				end		
			end
				
				
			if team == "BLUE" then	
			randomizer_dir = mist.random(120,240) -- blue should be advancing south randomly at the very least, here we are just setting the direction they face after they move
			end
			
			local radian = mist.utils.toRadian(randomizer_dir)
			
			--local randomizer_dist = randomizerDist --mist.random(randomizerDist / 2, randomizerDist)

			if formForce == 0 then
				local formationrand = mist.random(1,16)
					
				if formationrand == 1 then
				mist.groupRandomDistSelf(Name, randomizerDist, 'Rank', radian, spd)
				elseif formationrand == 2 then
				mist.groupRandomDistSelf(Name, randomizerDist, 'EchelonL', radian, spd)
				elseif formationrand == 3 then
				mist.groupRandomDistSelf(Name, randomizerDist, 'EchelonR', radian, spd)
				elseif formationrand == 4 then
				mist.groupRandomDistSelf(Name, randomizerDist, 'Vee', radian, spd)
				elseif formationrand == 5 then
				mist.groupRandomDistSelf(Name, randomizerDist, 'Cone', radian, spd)
				elseif formationrand == 6 then
				mist.groupRandomDistSelf(Name, randomizerDist, 'Diamond', radian, spd)
				elseif formationrand >= 7 and formationrand <= 12 then
				mist.groupRandomDistSelf(Name, randomizerDist, 'Off Road', radian, spd)
				elseif formationrand >= 12 and formationrand <= 16 then
				mist.groupRandomDistSelf(Name, randomizerDist, 'On Road', radian, spd)
				end
			end
			
			if formForce == 1 then
				local formationrand = mist.random(1,5)
				
				if formationrand == 1 then
				mist.groupRandomDistSelf(Name, 100, 'EchelonL', radian, spd)
				elseif formationrand == 2 then
				mist.groupRandomDistSelf(Name, 100, 'EchelonR', radian, spd)
				elseif formationrand == 3 then
				mist.groupRandomDistSelf(Name, 100, 'Diamond', radian, spd)
				elseif formationrand == 4 then
				mist.groupRandomDistSelf(Name, 100, 'Vee', radian, spd)
				elseif formationrand == 5 then
				mist.groupRandomDistSelf(Name, 100, 'Cone', radian, spd)
				end
			end
			
		mist.scheduleFunction(moveStuff, {thisGroupName, randomizerDist, formForce, spd, team}, timer.getTime + 900)
			
		end
			
		function random_markers(_mindistance, _maxdistance)
		decluster = mist.random(1,10) -- global used to randomly decluster smoke marker schedule
		local zonetouse = ""
		local mindist = 0
		local maxdist = 0
		local mindist2 = 0
		local maxdist2 = 0
		local mindist3 = 0
		local maxdist3 = 0
		local unitPos = {}
		local decision = ""
		local unitstouse = ""
		local direction = 0
		local delay = 0
		local groupToUse = {}
		local groupsInPlay = mist.DBs.dynGroupsAdded
		local groupchoice = mist.random(1, #groupsInPlay)
		groupToUse = groupsInPlay[groupchoice]
		unittouse = Group.getByName(groupToUse.groupName) 

		if unittouse == nil then
		return
		end

		mindist = _mindistance
		maxdist = _maxdistance
		mindist2 = mindist + 7
		maxdist2 = maxdist + 7
		mindist3 = mindist + 14
		maxdist3 = maxdist + 14
		direction = math.random(1,4)
		delay = math.random(5,15)

		local side = Group.getCoalition(unittouse)
		dynaFRONT.log:info("smoke marker for $1", side)


		unitPos = mist.getLeadPos(unittouse)

		if unitPos == nil then
		return
		end

		 if side == 1 then
			  trigger.action.smoke({x=unitPos.x + math.random(mindist,maxdist), y= land.getHeight({x = unitPos.x, y = unitPos.z}), z=unitPos.z + math.random(mindist,maxdist)}, trigger.smokeColor.Red)
		end
		end

		function random_markers2(_mindistance, _maxdistance)
		local zonetouse = ""
		local mindist = 0
		local maxdist = 0
		local mindist2 = 0
		local maxdist2 = 0
		local mindist3 = 0
		local maxdist3 = 0
		local unitPos = {}
		local decision = ""
		local unitstouse = ""
		local direction = 0
		local delay = 0
		local groupToUse = {}
		local groupsInPlay = mist.DBs.dynGroupsAdded
		local groupchoice = mist.random(1, #groupsInPlay)
		groupToUse = groupsInPlay[groupchoice]

		unittouse = Group.getByName(groupToUse.groupName) 
		--side = Group.getCoalition(groupToUse.groupName)

		if unittouse == nil then
		return
		end

		mindist = _mindistance
		maxdist = _maxdistance
		mindist2 = mindist + 7
		maxdist2 = maxdist + 7
		mindist3 = mindist + 14
		maxdist3 = maxdist + 14
		direction = math.random(1,4)
		delay = math.random(5,15)

		local side = Group.getCoalition(unittouse)
		dynaFRONT.log:info("Marker for $1", side)


		unitPos = mist.getLeadPos(unittouse)

		if unitPos == nil then
		return
		end

		 if side == 2 then
		   -- if direction == 1 then
			  trigger.action.smoke({x=unitPos.x + math.random(mindist,maxdist), y= land.getHeight({x = unitPos.x, y = unitPos.z}), z=unitPos.z + math.random(mindist,maxdist)}, trigger.smokeColor.Blue)
		end
		end

		function updateGrid(tableOfZones, startNo, endNo)
		local sectors = tableOfZones -- localize our argument
		
		for examinesector = startNo, endNo do -- for every sector up till the last sector in the table
			
			local rUnitList = mist.getUnitsInZones(mist.makeUnitTable({'[red][vehicles][ships]'}), {sectors[examinesector]}) -- get all the red units in that sector
			local bUnitList = mist.getUnitsInZones(mist.makeUnitTable({'[blue][vehicles][ships]'}), {sectors[examinesector]}) -- get all the blue units in that sector
			
			if sectors[examinesector] == nil then
			break
			end
			
			local zoneInQuestion = sectors[examinesector] -- we want the marker to use this zones verticies
			
			
			rus = #rUnitList
			bus = #bUnitList
			rushalfstr = rus / 2
			bushalfstr = bus / 2
			
			local markervars = {
			id = sectors[examinesector], -- make the marker ID the same as that zones names
			pos = getQTpoints(zoneInQuestion), -- get the table of verticies from that zone
			markType = 7,  -- use Quad
			markForCoa = -1,
			lineType = 0, -- type of line for the border
			readOnly = true -- users can't remove this marker`
			}
			
			 -- default color for no units in that sector
	
			markervars.color = {0,255,0,255} -- color green
			markervars.fillColor = {0,255,0,40} -- filled green with 40 alpha
			
			if rus >= bushalfstr and rus ~= 0 then -- red outnumbers blues half strength
				markervars.color = {255,0,0,255} -- color red
				markervars.fillColor = {255,0,0,80} -- filled red with 80 alpha
				elseif rus >= bus and rus ~= 0 then -- red outnumbers blues full strength
				markervars.color = {255,0,0,255} -- color red
				markervars.fillColor = {255,0,0,100} -- filled red with 120 alpha
				elseif rus ~= 0 and bus == 0 then
				markervars.color = {255,0,0,255} -- color red
				markervars.fillColor = {255,0,0,120} -- filled blue with 180 alpha
				REDSCORE = REDSCORE + 1
			end
			
			if bus >= rushalfstr and bus ~= 0 then -- blue outnumbers reds half strength
				markervars.color = {0,0,255,255} -- color blue
				markervars.fillColor = {0,0,255,80} -- filled blue with 140 alpha
				elseif bus >= rus and bus ~= 0 then -- if they outnumber its full strength
				markervars.color = {0,0,255,255} -- color blue
				markervars.fillColor = {0,0,255,100} -- filled blue with 80 alpha
				elseif bus ~= 0 and rus == 0 then
				markervars.color = {0,0,255,255} -- color blue
				markervars.fillColor = {0,0,255,120} -- filled blue with 180 alpha
				BLUESCORE = BLUESCORE + 1
			end
			mist.marker.add(markervars) -- add or modify the marker if already present
			end
		end
		
		function updateStrike()
		--local whatSide = side
		--local mission = task
		
		
		 -- for reds building
		if redStrikePos ~= nil then
			local markervars = {
			id = "redstrike", -- make the marker ID the same as that zones names
			pos = {x = redStrikePos.x, y = redStrikePos.z}, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = redStrikePos.radius,
			text = "Strike Target",
			lineType = 1, -- type of line for the border
			readOnly = true, -- users can't remove this marker`
			color = {0,0,0,255}, -- color silver
			fillColor = {128,0,128,180} -- filled purple with 180 alpha
			}
			mist.marker.add(markervars) -- add or modify the marker if already present	
		end
		--end
		
		
		if blueStrikePos ~= nil then
		-- for blues building
			local markervars = {
			id = "bluestrike", -- make the marker ID the same as that zones names
			pos = {x = blueStrikePos.x, y = blueStrikePos.z}, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = blueStrikePos.radius,
			lineType = 1, -- type of line for the border
			readOnly = true, -- users can't remove this marker`
			color = {0,0,0,255}, -- color silver
			fillColor = {128,0,128,180} -- filled purple with 180 alpha
			}
			mist.marker.add(markervars) -- add or modify the marker if already present	
		--	end
		end
		
		
		-- for blues building
		if redFarpPos ~= nil then
			local markervars = {
			id = "redfarp", -- make the marker ID the same as that zones names
			pos = {x = redFarpPos.x, y = redFarpPos.z}, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = redFarpPos.radius,
			lineType = 1, -- type of line for the border
			readOnly = true, -- users can't remove this marker`
			color = {0,0,0,255}, -- color silver
			fillColor = {255,255,0,180} -- filled yellow with 180 alpha
			}
			mist.marker.add(markervars) -- add or modify the marker if already present	
		--end
		end
		
		
		-- for blues building
		if blueFarpPos ~= nil then
			local markervars = {
			id = "bluefarp", -- make the marker ID the same as that zones names
			pos = {x = blueFarpPos.x, y = blueFarpPos.z}, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = blueFarpPos.radius,
			lineType = 1, -- type of line for the border
			readOnly = true, -- users can't remove this marker`
			color = {0,0,0,255}, -- color silver
			fillColor = {255,255,0,180} -- filled yellow with 180 alpha
			}
			mist.marker.add(markervars) -- add or modify the marker if already present	
		--end	
		end
		
				
		-- for blues building
		if redRigPos ~= nil then
			local markervars = {
			id = "redrig", -- make the marker ID the same as that zones names
			pos = {x = redRigPos.x, y = redRigPos.z}, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = redRigPos.radius,
			lineType = 1, -- type of line for the border
			readOnly = true, -- users can't remove this marker`
			color = {0,0,0,255}, -- color silver
			fillColor = {128,128,128,180} -- filled silver with 180 alpha
			}
			mist.marker.add(markervars) -- add or modify the marker if already present	
		--end
		end
		
		
		-- for blues building
		if blueRigPos ~= nil then
			local markervars = {
			id = "bluerig", -- make the marker ID the same as that zones names
			pos = {x = blueRigPos.x, y = blueRigPos.z}, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = blueRigPos.radius,
			lineType = 1, -- type of line for the border
			readOnly = true, -- users can't remove this marker`
			color = {0,0,0,255}, -- color purple
			fillColor = {128,128,128,180} -- filled silver with 180 alpha
			}
			mist.marker.add(markervars) -- add or modify the marker if already present	
		--end	
		end
		
		--if markervars ~= nil then
		
		--end
end		

		function getQTpoints(zoneTable) -- my nifty function to gather the points from a mission editor quad trigger zone

		local t = mist.DBs.zonesByName[zoneTable] -- get the specific triggerzone from the database of all zones added in the mission editor
		local copiedpoints = {} -- ready a table for its points

		for i = 1, #t.verticies do -- from 1 to the end of the verticies list (in this case its 4 points)
		copiedpoints[i] = t.verticies[i] -- copy the data to our copiedpoints table
		end
		return copiedpoints -- return the table of the copiedpoints
		end

		function scoreDisplay() -- straight forward score displayer
				local msg = {}
				msg.text = 'BLUE is commanded by ' .. blueLeader.name .. ' and their SCORE IS ' .. BLUESCORE .. ' ' .. '| RED is commanded by ' .. redLeader.name .. ' and their SCORE is ' .. REDSCORE -- compressed to a single line rather than multiple lines
				msg.displayTime = 10
				msg.msgFor = {coa = {'all'}} 
				mist.message.add(msg)
				msg = {}
		end
		
		
		function BuildOILRIGS(iterations, side, ownedBy)
		-- ARG1 STRING, red or blue
		-- ARG2 STRING, country of origin
		local forWhom = ""
		--local farpName = ""
		local zoneUsed = {}
		local randsquare = 0
		local restrictPoly = ""
		local useSide = ""
		local spawnPsn = {}
		local failedAttempts = 0
		local groupprefix = ""

		
		if side == "RED" then
				forWhom = "Russia" -- country name of the RIG
				groupprefix = "r"
				--farpName = "FARPRED" -- FARP name as placed in mission editor
				randsquare = mist.random(1,#RedSHALLOWNAVAL_SectorSquares) -- put it in a random truck square by getting a random string from the table
				zoneUsed = RedSHALLOWNAVAL_SectorSquares[randsquare] -- get that triggerzone
				--restrictPoly = zoneUsed -- get the poly for that zone
		end
		if side == "BLUE" then -- same as red logic
				forWhom = "USA"
				groupprefix = "b"
				--farpName = "FARPBLUE"
				randsquare = mist.random(1,#BlueSHALLOWNAVAL_SectorSquares)
				zoneUsed = BlueSHALLOWNAVAL_SectorSquares[randsquare]
				--restrictPoly = zoneUsed
		end

		for  cycles = 1, iterations do
			for i = 0, 25 do -- for 25 attempts
				local landgood = false -- reset landgood
			
				spawnPsn = mist.getRandomPointInZone(zoneUsed, zoneUsed.radius) -- get a point from that zone
				--restriction = mist.pointInPolygon(spawnPsn, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				
					if mist.isTerrainValid(spawnPsn, {"WATER"}) == true then -- if the land is valid
					landgood = true -- land is good
					else -- otherwise
					landgood = false -- land is bad, mmm kay
					end
					
							if landgood == true then -- polygon restriction has been met and land valid	
							break -- break out of the loop
							end
				end
				
				local buildPsn = mist.utils.makeVec3(spawnPsn) -- vec3 of the spawnPsn
				local buildPsnRig = mist.utils.makeVec2(spawnPsn) -- vec2 of the spawnPsn
				
		local vars = 
		{
		type = "Gas platform", -- its of type FARP
		country = forWhom, -- country
		category = "Heliports", -- category 
		x = buildPsn.x, -- vec2 x value
		y = buildPsn.z, -- vec2 y value
		unitId = 9000 + iterations,
		groupName = groupprefix .. "oil",
		--unitName = groupprefix .. "oil", -- the static name
		heliport_callsign_id = 1,
        heliport_modulation = 0,
		heliport_frequency = "127.5",
		rate = 100,
		clone = true, -- 
		 
		 --groupName = "FARP" .. side,
		 heading = 0.47123889803847, -- probably should randomize the direction or have it face the right way in future
		}
		
					local Strike_Area = {
					x = buildPsn.x,
					y = buildPsn.y,
					z = buildPsn.z,
					radius = 6000
					}
					
					local Strike_Area_Zone = {
					point = {x = buildPsn.x, y = buildPsn.y, z = buildPsn.z},
					radius = 2000
					}
		
					
					if forWhom == "Russia" then
					redStartRig = buildPsnRig
					redRigPos = Strike_Area -- store the vec3 in redFarpPos for use with the heloattack script
					mist.flagFunc.mapobjs_dead_point { locations = {Strike_Area_Zone}, flag = 1003, req_num = 1}
					end
					
					if forWhom == "USA" then
					blueStartRig = buildPsnRig
					blueRigPos = Strike_Area -- store the vec3 in blueFarpPos for use with the heloattack script
					mist.flagFunc.mapobjs_dead_point { locations = {Strike_Area_Zone}, flag = 1004, req_num = 1}
					end
					
					mist.dynAddStatic(vars)	-- add the static item to the mission
			end
		end
		
			function BuildSTRIKETARGET(iterations, side)
		-- ARG1 STRING, red or blue
		-- ARG2 STRING, country of origin
		local forWhom = ""
		--local farpName = ""
		local zoneUsed = {}
		local randsquare = 0
		local restrictPoly = ""
		local useSide = ""
		local spawnPsn = {}
		local failedAttempts = 0
		local groupprefix = ""
		local quantity = 99

		
		if side == "RED" then
				forWhom = "Russia" -- country name of the FAP
				groupprefix = "r"
				--farpName = "FARPRED" -- FARP name as placed in mission editor
				randsquare = mist.random(1,#RedSectorSquares) -- put it in a random truck square by getting a random string from the table
				zoneUsed = RedSectorSquares[randsquare] -- get that triggerzone
				restrictPoly = zoneUsed -- get the poly for that zone
		end
		if side == "BLUE" then -- same as red logic
				forWhom = "USA"
				groupprefix = "b"
				--farpName = "FARPBLUE"
				randsquare = mist.random(1,#BlueSectorSquares)
				zoneUsed = BlueSectorSquares[randsquare]
				restrictPoly = zoneUsed
		end

		for  cycles = 1, iterations do
			for i = 0, 1000 do -- for 25 attempts
				local landgood = false -- reset landgood
			
				spawnPsn = mist.getRandomPointInZone(zoneUsed, zoneUsed.radius) -- get a point from that zone
				restriction = mist.pointInPolygon(spawnPsn, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				
					if mist.isTerrainValid(spawnPsn, {"LAND"}) == true then -- if the land is valid
					landgood = true -- land is good
					else -- otherwise
					landgood = false -- land is bad, mmm kay
					end
					
							if landgood == true and restriction == true then -- polygon restriction has been met and land valid	
							break -- break out of the loop
							end
				end
				
				local buildPsn = mist.utils.makeVec3(spawnPsn) -- vec3 of the spawnPsn
				local buildPsnStrike = mist.utils.makeVec2(spawnPsn) -- vec2 of the spawnPsn
				
		--local vars = 
		--{
		--type = "Gas platform", -- its of type FARP
		--country = forWhom, -- country
		--category = "Heliports", -- category 
		--x = buildPsn.x, -- vec2 x value
		--y = buildPsn.z, -- vec2 y value
		--unitId = 9000 + iterations,
		--groupName = groupprefix .. "oil",
		--unitName = groupprefix .. "oil", -- the static name
		--heliport_callsign_id = 1,
        --heliport_modulation = 0,
		--heliport_frequency = "127.5",
		--rate = 100,
		--clone = true, -- 
		
		
			local buildPsn = mist.utils.makeVec3(buildPsn)		
			
			local randomobjects = mist.random(1,4)
			
			if randomobjects == 1 then
			quantity = 1
			local vars = 
			{
			 type = "Tech combine",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z + math.random(200,300),
			 --name = "Strike1", 
			 groupName = "Strike1",
			 clone = true,
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars)
			
				elseif randomobjects == 2 then
				quantity = 2
			local vars = 
			{
			 type = "Workshop A",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z + math.random(300, 600),
			 --name = "Strike2", 
			 groupName = "Strike2",
			 clone = true,
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars)
			local vars2 = 
			{
			 type = "Repair workshop",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x + math.random(300, 590),
			 y = buildPsn.z + math.random(300,600),
			 --name = "Strike3", 
			 clone = true,
			 groupName = "Strike3",
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars2)
			
				elseif randomobjects == 3 then
				quantity = 2
			local vars = 
			{
			 type = "TV tower",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z + math.random(200,300),
			 --name = "Strike1", 
			 groupName = "Strike1",
			 clone = true,
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars)
			local vars2 = 
			{
			 type = "TV tower",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x + math.random(300, 590),
			 y = buildPsn.z + math.random(300,600),
			 --name = "Strike3", 
			 groupName = "Strike3",
			 clone = true,
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars2)
		
			
					elseif randomobjects == 4 then
			local quantity = 4
			local vars = 
			{
			 type = "Command Center",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z,
			-- name = "Strike1", 
			-- groupName = "Strike1",
			 clone = false,
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars)
			local vars2 = 
			{
			 type = "outpost",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z + math.random(120,120),
			-- name = "Strike1", 
			-- groupName = "Strike1",
			 clone = false,
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars2)
			local vars3 = 
			{
			 type = "house2arm",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x + math.random(120,120),
			 y = buildPsn.z + math.random(120,120),
			-- name = "Strike1", 
			-- groupName = "Strike1",
			 clone = false,
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars3)
			local vars4 = 
			{
			 type = "house2arm",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x - math.random(120,120),
			 y = buildPsn.z - math.random(120,120),
			-- name = "Strike1", 
			-- groupName = "Strike1",
			 clone = false,
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars4)
			end
			
			
			
			
			
			
					local Strike_Area = {
					x = buildPsn.x,
					z = buildPsn.z,
					y = buildPsn.y,
					radius = 2000
					}
					
					
					if forWhom == "Russia" then
					redStrikePos = Strike_Area -- store the vec2 in redStrikePos for use with the bomber and scoring script
					--blueAttack = Strike_Area
					mist.flagFunc.mapobjs_dead_zones { zones = Strike_Area, flag = 1001, req_num = quantity}
					end
					
					if forWhom == "USA" then
					blueStrikePos = Strike_Area -- store the vec2 in blueStrikePos for use with the bomber and scoring script
					--redAttack = Strike_Area
					mist.flagFunc.mapobjs_dead_zones { zones = Strike_Area, flag = 1002, req_num = quantity}
					end
				
			end
			
		end
		

		
		
		function MonitorTask(whichTask, side)
		local msg = {}
			
			--trigger.action.setUserFlag('1001', true)
			
			local data = trigger.misc.getUserFlag('1001')
			local data2 = trigger.misc.getUserFlag('1002')
			local data3 = trigger.misc.getUserFlag('1003')
			local data4 = trigger.misc.getUserFlag('1004')
			local data5 = trigger.misc.getUserFlag('1005')
			local data6 = trigger.misc.getUserFlag('1006')
			
			msg.text = ' Monitoring... ' .. whichTask .. side .. data .. data2 .. data3 .. data4 .. data5 .. data6
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			--mist.message.add(msg)
			
			
		
		
		if side == "BLUE" and whichTask == "STRIKE" then
		if trigger.misc.getUserFlag('1001') == 1 then
			local msg = {}
			
			msg.text = ' Red structures have been demolished'
			msg.displayTime = 60
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				REDSCORE = REDSCORE - 500
				BLUESCORE = BLUESCORE + 500
				
				--trigger.action.setUserFlag('1001',0)
				trigger.action.setUserFlag('1001', 0)
				mist.marker.remove("redstrike")
				mist.scheduleFunction(BuildSTRIKETARGET, {1, "RED", "Russia"}, timer.getTime() + 1800)
			end
			end
			
		if side == "BLUE" and whichTask == "NAVAL_HELIPORT" then
		if trigger.misc.getUserFlag('1003') == 1 then
			local msg = {}
			
			msg.text = ' Red heliport has been demolished'
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				REDSCORE = REDSCORE - 500
				BLUESCORE = BLUESCORE + 500
				
				trigger.action.setUserFlag('1003',0)
				mist.scheduleFunction(BuildOILRIGS, {1, "RED", "Russia"}, timer.getTime() + 1800)
			end
		end
		
				if side == "BLUE" and whichTask == "FARP" then
		if trigger.misc.getUserFlag('1005') == 1 then
			local msg = {}
			
			msg.text = ' Red FARP has been demolished'
			msg.displayTime = 60
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				REDSCORE = REDSCORE - 500
				BLUESCORE = BLUESCORE + 500
				
				trigger.action.setUserFlag('1005',0)
				mist.marker.remove("redfarp")
				mist.scheduleFunction(BuildFARP, {1, "RED", "Russia"}, timer.getTime() + 1800)
			end
		end
	
			
			if side == "RED" and whichTask == "STRIKE" then
			if trigger.misc.getUserFlag('1002') == 1 then
			local msg = {}
			
			msg.text = ' Blue structures have been demolished'
			msg.displayTime = 60
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				BLUESCORE = BLUESCORE - 500
				REDSCORE = REDSCORE + 500
				trigger.action.setUserFlag('1002',0)
				mist.marker.remove("bluestrike")
				mist.scheduleFunction(BuildSTRIKETARGET, {1, "BLUE", "USA"}, timer.getTime() + 1800)
			end
		end
		
			if side == "RED" and whichTask == "NAVAL_HELIPORT" then
			if trigger.misc.getUserFlag('1004') == 1 then
			local msg = {}
			
			msg.text = ' Blue heliport has been demolished'
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				BLUESCORE = BLUESCORE - 500
				REDSCORE = REDSCORE + 500
				trigger.action.setUserFlag('1004',0)
				mist.scheduleFunction(BuildOILRIGS, {1, "BLUE", "USA"}, timer.getTime() + 1800)
			end
		end
		
		if side == "RED" and whichTask == "FARP" then
			if trigger.misc.getUserFlag('1006') == 1 then
			local msg = {}
			
			msg.text = ' Blue FARP has been demolished'
			msg.displayTime = 60
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				BLUESCORE = BLUESCORE - 500
				REDSCORE = REDSCORE + 500
				trigger.action.setUserFlag('1006',0)
				mist.marker.remove("bluefarp")
				mist.scheduleFunction(BuildFARP, {1, "BLUE", "USA"}, timer.getTime() + 1800)
			end
		end
		
		if side == "BLUE" and whichTask == "CARGO" then
			if trigger.misc.getUserFlag('2001') == 1 then
			local msg = {}
			
			msg.text = ' Blue Cargo has arrived via Port'
			msg.displayTime = 60
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				BLUESCORE = BLUESCORE + 1000
				trigger.action.setUserFlag('2001',0)
				
				if group.getByName("Blue Ship Asset-1") then
				group.destroy("Blue Ship Asset-1")
				end
				
				if group.getByName("Blue Ship Asset-2") then
				group.destroy("Blue Ship Asset-2")
				end
				
			end
		end
		
		if side == "RED" and whichTask == "CARGO" then
			if trigger.misc.getUserFlag('2002') == 1 then
			local msg = {}
			
			msg.text = ' Red Cargo has arrived via Port'
			msg.displayTime = 60
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				REDSCORE = REDSCORE + 1000
				trigger.action.setUserFlag('2002',0)
				
				if group.getByName("Red Ship Asset-1") then
				group.destroy("Red Ship Asset-1")
				end
				
				if group.getByName("Red Ship Asset-2") then
				group.destroy("Red Ship Asset-2")
				end
				
				
			end
		end
		
		end


		-- main
		mist.scheduleFunction(updateGrid, {SeaList, 125, 144}, timer.getTime() + 2, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {SeaList, 100, 124}, timer.getTime() + 4, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {SeaList, 75, 99}, timer.getTime() + 6, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {SeaList, 50, 74}, timer.getTime() + 8, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {SeaList, 25, 49}, timer.getTime() + 10, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {SeaList, 1, 24}, timer.getTime() + 12, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 1, 24}, timer.getTime() + 14, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 25, 49}, timer.getTime() + 16, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 50, 74}, timer.getTime() + 18, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 75, 99}, timer.getTime() + 20, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 100, 124}, timer.getTime() + 22, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 125, 149}, timer.getTime() + 24, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 150, 170}, timer.getTime() + 26, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 175, 199}, timer.getTime() + 28, 600) -- update grid every 60 seconds
		mist.scheduleFunction(updateStrike, {}, timer.getTime() + 29, 300) -- update strike targets every 5 minutes
		mist.scheduleFunction(BuildFARP, {"BLUE", "USA"}, timer.getTime() + 3) -- build a farp
		mist.scheduleFunction(BuildFARP, {"RED", "Russia"}, timer.getTime() + 6) -- build a farp
		--mist.scheduleFunction(BuildOILRIGS, {rNAVYSTATICamount, "RED", "Russia"}, timer.getTime() + 8)
		--mist.scheduleFunction(BuildOILRIGS, {bNAVYSTATICamount, "BLUE", "USA"}, timer.getTime() + 10)
		mist.scheduleFunction(BuildSTRIKETARGET, {1, "BLUE", "USA"}, timer.getTime() + 11)
		mist.scheduleFunction(BuildSTRIKETARGET, {1, "RED", "Russia"}, timer.getTime() + 12)
		
		mist.scheduleFunction(monitorGroup, {ActiveForces.AAA.RED, "RED", "AAA"}, timer.getTime() + 61, 45) -- begin monitoring all the red groups of each type of unit
		mist.scheduleFunction(monitorGroup, {ActiveForces.TANK.RED, "RED", "TANK"}, timer.getTime() + 62, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.APC.RED, "RED", "APC"}, timer.getTime() + 63, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.INF.RED, "RED", "INF"}, timer.getTime() + 64, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.CP.RED, "RED", "CP"}, timer.getTime() + 65, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.SHORAD.RED, "RED", "SHORAD"}, timer.getTime() + 66, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.TRUCK.RED, "RED", "TRUCK"}, timer.getTime() + 67, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.LRSAM.RED, "RED", "LRSAM"}, timer.getTime() + 68, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.SRSAM.RED, "RED", "SRSAM"}, timer.getTime() + 69, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.NAVY.RED, "RED", "NAVY"}, timer.getTime() + 70, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.SHIP.RED, "RED", "SHIP"}, timer.getTime() + 71, 45)

		mist.scheduleFunction(monitorGroup, {ActiveForces.AAA.BLUE, "BLUE", "AAA"}, timer.getTime() + 81, 45) -- begin monitoring all the blue groups of each type of unit
		mist.scheduleFunction(monitorGroup, {ActiveForces.TANK.BLUE, "BLUE", "TANK"}, timer.getTime() + 82, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.APC.BLUE, "BLUE", "APC"}, timer.getTime() + 83, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.INF.BLUE, "BLUE", "INF"}, timer.getTime() + 84, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.CP.BLUE, "BLUE", "CP"}, timer.getTime() + 85, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.SHORAD.BLUE, "BLUE", "SHORAD"}, timer.getTime() + 86, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.TRUCK.BLUE, "BLUE", "TRUCK"}, timer.getTime() + 87, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.LRSAM.BLUE, "BLUE", "LRSAM"}, timer.getTime() + 88, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.SRSAM.BLUE, "BLUE", "SRSAM"}, timer.getTime() + 89, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.NAVY.BLUE, "BLUE", "NAVY"}, timer.getTime() + 90, 45)
		mist.scheduleFunction(monitorGroup, {ActiveForces.SHIP.BLUE, "BLUE", "SHIP"}, timer.getTime() + 91, 45)
		
		mist.scheduleFunction(MonitorTask, {"STRIKE", "RED"}, timer.getTime() + 120, 30)
		mist.scheduleFunction(MonitorTask, {"STRIKE", "BLUE"}, timer.getTime() + 121, 30)
		--mist.scheduleFunction(MonitorTask, {"NAVAL_HELIPORT", "RED"}, timer.getTime() + 15, 10)
		--mist.scheduleFunction(MonitorTask, {"NAVAL_HELIPORT", "BLUE"}, timer.getTime() + 16, 10)
		mist.scheduleFunction(MonitorTask, {"FARP", "BLUE"}, timer.getTime() + 124, 30)
		mist.scheduleFunction(MonitorTask, {"FARP", "RED"}, timer.getTime() + 125, 30)
		mist.scheduleFunction(MonitorTask, {"CARGO", "BLUE"}, timer.getTime() + 126, 30)
		mist.scheduleFunction(MonitorTask, {"CARGO", "RED"}, timer.getTime() + 127, 30)
		
		


		mist.scheduleFunction(random_markers, {50,250}, timer.getTime() + 10, updateMarkerSpeed) -- add randoimized smoke markers (this is old code written 7 years ago, maybe replace with more modern take on it at some point)
		mist.scheduleFunction(random_markers2, {50,250}, timer.getTime() + 10, updateMarkerSpeed) -- add randoimized smoke markers
		mist.scheduleFunction(scoreDisplay, {}, timer.getTime() + 90, 120) -- schedule the score display after 90 seconds and every 2 minutes afterwards
		mist.scheduleFunction(Introduce_Mission, {}, timer.getTime() + 2) -- schedule the mission introduction after 2 seconds of miz running.






