		--revision 1.34
		dynaFRONT = {}
		dynaFRONT.log_level = "info"
		dynaFRONT.log = mist.Logger:new("DynaFRONT", dynaFRONT.log_level)

		-- intro function
		function Introduce_Mission() -- standard mission introduction function
			local msg = {}
			msg.text = 'OPERATION GRANDSTAND 0.34'
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
				
			
		function ManipulateForce(iterations, whichSide, unitType, attempts, terrainType, placeDisperse, randomMove, moveSpeed, respawnGroup, placementList)
		-- ManipulateForce --
		-- ARG1 -- # of groups wanted (used with clone behaviorType, otherwise use 1 for a single group teleport or respawn)
		-- ARG2 -- STRING for which side (RED" or "red" or "r" or "R" or "REDFOR" or "redfor" or "redfore" or "REDFORE" or "ENEMY" or "enemy" / "BLUE" or "blue" or "b" or "B" or "BLUFOR" or "BLU" or "blufor" or "bluefore" or "BLUEFORE" or "NATO" or "nato" or "friendly" or "FRIENDLY" or "FRIEND" or "friend" use whichever you want they will all work.
		-- ARG3 -- STRING the type of units in the group ("AAA", "TRUCK", "TANK", "SRSAM", "LRSAM", "SHORAD", "APC", "INF" are the valid types
		-- ARG4 -- # coordinate attempts do not use to high a value or DCS can hang while it performs the placements (use 100 as default)
		-- ARG5 -- STRING the type of terrain "LAND", "WATER"
		-- ARG6 -- # use 0 if you wish no dispersion of the groups formation, otherwise the units will be randomly placed as far apart as this from each other (be weary of to far when using polygon to check a point for spawn restriction)
		-- ARG7 -- # use 0 for no movement otherwise will move this amount randomly from its initial placement
		-- ARG8 -- # speed of the randomzed movement if ARG7 has a value above 0
		-- the next 2 arguments are used internally always set them to nil
		-- ARG9 -- name of the group that will be respawned (used internally, use nil otherwise)
		-- ARG10 -- index number of the entry in the data table and is used to overwrite the previous data when a group is being respawnedm otherwise this data is discarded when respawnGroup is nil
		-- example ManipulateForce("clone", 5, "MyNamedGroupInMissionEditor", "MyTriggerZoneOrQuadName", 100, "RestrictSpawnAreaToThisGroupsNamesWaypointsAsPolygonShape", "LAND", 100, 1000, 15, nil, nil)

		local zoneUsed = {} -- local variables that we use a lot further down
		local randsquare = 0
		local restrictPoly = ""
		local useSide = ""
		local spawnPsn = {}
		local failedAttempts = 0
		local groupCalled = ""
		local rand = 0

		if placeDisperse ~= 0 then -- if ARG6 is not equal to 0 use that for the dispersion of the spawn in, done so that if its set to 0 it will remember the groups placement on the mission editor
			dispersionChoice = placeDisperse -- set the dispersion to that value otherwise
			else
			dispersionChoice = false -- if it isn't above 0 then it must be false
		end


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
					
					
					if respawnGroup == nil then -- if ARG8 is nil then its for the initial spawn
					groupvars.groupName = groupCalled -- set the group name to be the template we wanted
					gdata = mist.getCurrentGroupData(groupCalled) -- get our templates group data
					ActiveForces[unitType][useSide][nomber] = groupvars.newGroupName -- now add this name to the active groups table, under the subcategory of its unit type
					ActiveForces[unitType][useSide].TEMPLATE[nomber] = groupCalled -- remember the template we used for this group
					ActiveForces[unitType][useSide].SQUARE[nomber] = zoneUsed -- store the MGRS SQUARE for this group
					ActiveForces[unitType][useSide].POS[nomber] = spawnPsn -- save this groups position in the table
					ActiveForces[unitType][useSide].INITSIZE[nomber] = Group.getInitialSize(Group.getByName(groupCalled)) -- set its initial size
					ActiveForces[unitType][useSide].SIZE[nomber] = Group.getInitialSize(Group.getByName(groupCalled)) -- set its current size
					else -- otherwise it was for a spawn after the initial spawning of the miz
					groupvars.groupName = respawnGroup -- so the group we want to use is from the same template we used initially
					gdata = mist.getCurrentGroupData(respawnGroup) -- get our templates group data
					ActiveForces[unitType][useSide][placementList] = groupvars.newGroupName -- now overwrite this name to the active groups table, under the subcategory of its unit type
					ActiveForces[unitType][useSide].TEMPLATE[placementList] = respawnGroup -- maybe not needed but remember the template again
					ActiveForces[unitType][useSide].SQUARE[placementList] = zoneUsed -- store the MGRS SQUARE for this group now that its moved again
					ActiveForces[unitType][useSide].POS[placementList] = spawnPsn -- save this groups position again
					ActiveForces[unitType][useSide].INITSIZE[placementList] = Group.getInitialSize(Group.getByName(respawnGroup)) -- set its initial size
					ActiveForces[unitType][useSide].SIZE[placementList] = Group.getInitialSize(Group.getByName(respawnGroup)) -- overwrite its current size again since it was destroyed previously
					end
					
					
					groupvars.action = 'clone' -- we will always be cloning
					groupvars.point = spawnPsn -- set the point for which it will spawn
					--vars.route = path
					groupvars.disperse = dispersionChoice -- set dispersion based on ARG6
					groupvars.maxDisp = dispersionChoice -- the max dispersion is the same as the dispersion value (maybe change this to have another ARG in future)
					-- vars.radius = 100 
					groupvars.innerRadius = 0 
					groupvars.offsetRoute = false
					groupvars.offsetWP1 = false
					groupvars.initTasks = true -- remember its task from ME
					
					mist.cloneMoveGroup(groupCalled, false, groupvars) -- modified mist function to clone and move it using our vars
					trigger.action.deactivateGroup(groupCalled)
				
				-- DEBUG STUFF
				--local data = mist.utils.serialize("tblCheck", ActiveForces) -- debug to show us our table
				--trigger.action.outText(data,5, true)	
				-- END DEBUG STUFF
				
				if randomMove ~= 0 then -- will cause stuff to randomly move around if randomMove ARG7 is anything other than 0
				mist.scheduleFunction(moveStuff, {groupvars.newGroupName, randomMove, moveSpeed, useSide}, timer.getTime() + mist.random(1,60), mist.random(900,1200)) -- uses ARG7 and ARG8 from the ManipulateForce function to move the new units after 5 seconds wait time
				end
			end

		end -- end ManipulateForce Function


		function monitorGroup(tabCheck, sideUsed, grpType)
		-- TABLE arg tblCheck: check this ActiveGroups table
		-- STARING arg of which side "RED" or "BLUE"
		-- STRING arg of group type "AAA", "TANK" "APC" "INF" "CP" "SRSAM" "LRSAM" "SHORAD"

		for element = 1, #tabCheck do -- for each element in the table from 1 to the amount that is in the table
			local checkThisGroup = tabCheck[element] -- get the string of the group name located at that index

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
			

			if percent <= DISBAND_PERCENT then -- if the percentage is less that (set in paramters.lua) then
				Group.destroy(Group.getByName(checkThisGroup)) -- destroy the group 
				
				local msg = {} -- message that the group has been rendered ineffective
				msg.text = checkThisGroup .. ' has been rendered combat ineffective '
				msg.displayTime = 10
				msg.msgFor = {coa = {'all'}} 
				mist.message.add(msg)
				msg = {}
			
				if sideUsed == "RED" then REDSCORE = REDSCORE + 1 -- if it was a red unit removed then red scores
				end		
				if sideUsed == "BLUE" then BLUESCORE = BLUESCORE + 1 -- if it was a blue unit removed then red scores
				end
				
				if grpType ~= "NAVY" then
				local terrain = "LAND"
				else
				local terrain = "WATER"
				end
				
				mist.scheduleFunction(ManipulateForce, {1, sideUsed, grpType, 100, terrain, 500, 0, 0, tabCheck.TEMPLATE[element], element}, timer.getTime() + GROUND_RESPAWN_DELAY) -- clone the same template again and set it so that it updates the same position in the ActiveForces table after 2 minutes
				end
				end
			end
		end


		function CreateArmy(forSide, unitType) -- create initial spawns for each force (I call CreateArmy in miz on a mission trigger)

		if forSide == "blue" or "BLUE" or "b" or "B" then
		mist.scheduleFunction(ManipulateForce, {bAAAamount, "BLUE", "AAA", 100, "LAND", 500, 0, 0, nil, nil}, timer.getTime() + 2) -- space out each spawn in by 2 seconds to lessen the impact on server performance
		mist.scheduleFunction(ManipulateForce, {bTRUCKamount, "BLUE", "TRUCK", 50, "LAND", 500, 0, 0, nil, nil}, timer.getTime() + 4)
		mist.scheduleFunction(ManipulateForce, {bSHORADamount, "BLUE", "SHORAD", 100, "LAND", 500, 0, 0, nil, nil}, timer.getTime() + 6)
		mist.scheduleFunction(ManipulateForce, {bINFamount, "BLUE", "INF", 10, "LAND", 500, 5000, mist.random(4,7), nil, nil}, timer.getTime() + 8)
		mist.scheduleFunction(ManipulateForce, {bTANKamount, "BLUE", "TANK", 100, "LAND", 500, 5000, mist.random(28,42), nil, nil}, timer.getTime() + 10)
		mist.scheduleFunction(ManipulateForce, {bAPCamount, "BLUE", "APC", 100, "LAND", 500, 5000, mist.random(24,32), nil, nil}, timer.getTime() + 12)
		mist.scheduleFunction(ManipulateForce, {bCPamount, "BLUE", "CP", 100, "LAND", 500, 5000, 0, nil, nil}, timer.getTime() + 12)
		mist.scheduleFunction(ManipulateForce, {bSRSAMamount, "BLUE", "SRSAM", 100, "LAND", 400, 0, 0, nil, nil}, timer.getTime() + 14)
		mist.scheduleFunction(ManipulateForce, {bLRSAMamount, "BLUE", "LRSAM", 100, "LAND", 0, 0, 0, nil, nil}, timer.getTime() + 16)
		mist.scheduleFunction(ManipulateForce, {bNAVYamount, "BLUE", "NAVY", 100, "WATER", 0, 0, 0, nil, nil}, timer.getTime() + 17)
		end

		if forSide == "red" or "RED" or "r" or "R" then
		mist.scheduleFunction(ManipulateForce, {rAAAamount, "RED", "AAA", 100, "LAND", 500, 0, 0, nil, nil}, timer.getTime() + 20)
		mist.scheduleFunction(ManipulateForce, {rTRUCKamount, "RED", "TRUCK", 50, "LAND", 500, 0, 0, nil, nil}, timer.getTime() + 22)
		mist.scheduleFunction(ManipulateForce, {rSHORADamount, "RED", "SHORAD", 100, "LAND", 500, 0, 0, nil, nil}, timer.getTime() + 24)
		mist.scheduleFunction(ManipulateForce, {rINFamount, "RED", "INF", 10, "LAND", 500, 5000, mist.random(4,7), nil, nil}, timer.getTime() + 26)
		mist.scheduleFunction(ManipulateForce, {rTANKamount, "RED", "TANK", 100, "LAND", 500, 5000, mist.random(28,42), nil, nil}, timer.getTime() + 28)
		mist.scheduleFunction(ManipulateForce, {rAPCamount, "RED", "APC", 100, "LAND", 500, 5000, mist.random(24,32), nil, nil}, timer.getTime() + 30)
		mist.scheduleFunction(ManipulateForce, {rCPamount, "RED", "CP", 100, "LAND", 500, 5000, 0, nil, nil}, timer.getTime() + 32)
		mist.scheduleFunction(ManipulateForce, {rSRSAMamount, "RED", "SRSAM", 100, "LAND", 400, 0, 0, nil, nil}, timer.getTime() + 34)
		mist.scheduleFunction(ManipulateForce, {rLRSAMamount, "RED", "LRSAM", 100, "LAND", 0, 0, 0, nil, nil}, timer.getTime() + 36)
		mist.scheduleFunction(ManipulateForce, {rNAVYamount, "RED", "NAVY", 100, "WATER", 0, 0, 0, nil, nil}, timer.getTime() + 37)
		end
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

			for i = 0, 1000 do -- for 1000 attempts
				local restriction = false -- reset restriction
				local landgood = false -- reset landgood
			
				spawnPsn = mist.getRandomPointInZone(zoneUsed, zoneUsed.radius) -- get a point from that zone
				restriction = mist.pointInPolygon(spawnPsn, mist.getGroupPoints(restrictPoly)) -- is that point within the associated polygon
				
					if mist.isTerrainValid(spawnPsn, {terrainType}) == true then -- if the land is valid
					landgood = true -- land is good
					else -- otherwise
					landgood = false -- land is bad, mmm kay
					end
					
							if restriction == true and landgood == true then -- polygon restriction has been met and land valid	
							break -- break out of the loop
							end
				end
				
				local buildPsn = mist.utils.makeVec3(spawnPsn) -- vec3 of the spawnPsn
				local buildPsnFarp = mist.utils.makeVec2(spawnPsn) -- vec2 of the spawnPsn
				
		local vars = 
		{
		 type = "FARP", -- its of type FARP
		 country = forWhom, -- country
		 category = "Heliports", -- category 
		 x = buildPsn.x, -- vec2 x value
		 y = buildPsn.z, -- vec2 y value
		 --name = farpName,
		unitName = farpName, -- the farpName
		 clone = true, -- clone it, we must clone an already existing FARP otherwise an error occurs (DCS limitation perhaps?)
		 --groupName = "FARP" .. side,
		 heading = 0.47123889803847, -- probably should randomize the direction or have it face the right way in future
		}
					
					if forWhom == "Russia" then
					redFarpPos = buildPsnFarp -- store the vec3 in redFarpPos for use with the heloattack script
					end
					
					if forWhom == "USA" then
					blueFarpPos = buildPsnFarp -- store the vec3 in blueFarpPos for use with the heloattack script
					end
					
					mist.dynAddStatic(vars)	-- add the static item to the mission
		end
		
			
		function moveStuff(thisGroupName, randomizerDist, spd, team)	-- this is old code from 7 years ago, will need to write a much better ground tasking script to attack sectors in the future, for now just have them randomly move around to create conflicts
			if thisGroupName == nil then
			return
			end
			
			local randomizer_dist = 0
			local Name = thisGroupName
			local negativeheading = mist.random(0,1) -- quick hack to make things work with 0-360 degrees

			
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
			
			randomizer_dist = mist.random(randomizerDist, randomizerDist * 2)

				local formationrand = mist.random(1,16)
					
				if formationrand == 1 then
				mist.groupRandomDistSelf(Name, randomizer_dist, 'Rank', randomizer_dir, spd)
				elseif formationrand == 2 then
				mist.groupRandomDistSelf(Name, randomizer_dist, 'EchelonL', randomizer_dir, spd)
				elseif formationrand == 3 then
				mist.groupRandomDistSelf(Name, randomizer_dist, 'EchelonR', randomizer_dir, spd)
				elseif formationrand == 4 then
				mist.groupRandomDistSelf(Name, randomizer_dist, 'Vee', randomizer_dir, spd)
				elseif formationrand == 5 then
				mist.groupRandomDistSelf(Name, randomizer_dist, 'Cone', randomizer_dir, spd)
				elseif formationrand == 6 then
				mist.groupRandomDistSelf(Name, randomizer_dist, 'Diamond', randomizer_dir, spd)
				elseif formationrand >= 7 and formationrand <= 12 then
				mist.groupRandomDistSelf(Name, randomizer_dist, 'Off Road', randomizer_dir, spd)
				elseif formationrand >= 12 and formationrand <= 16 then
				mist.groupRandomDistSelf(Name, randomizer_dist, 'On Road', randomizer_dir, spd)
				end
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
			lineType = 1, -- type of line for the border
			readOnly = true -- users can't remove this marker`
			}
			
			 -- default color for no units in that sector
	
			markervars.color = {0,255,0,255} -- color green
			markervars.fillColor = {0,255,0,20} -- filled green with 20 alpha
			
			if rus >= bushalfstr and rus ~= 0 then -- red outnumbers blues half strength
				markervars.color = {255,0,0,255} -- color red
				markervars.fillColor = {255,0,0,80} -- filled red with 80 alpha
				elseif rus >= bus and rus ~= 0 then -- red outnumbers blues full strength
				markervars.color = {255,0,0,255} -- color red
				markervars.fillColor = {255,0,0,120} -- filled red with 120 alpha
			end
			
			if bus >= rushalfstr and bus ~= 0 then -- blue outnumbers reds half strength
				markervars.color = {0,0,255,255} -- color blue
				markervars.fillColor = {0,0,255,80} -- filled blue with 80 alpha
				elseif bus >= rus and bus ~= 0 then -- if they outnumber its full strength
				markervars.color = {0,0,255,255} -- color blue
				markervars.fillColor = {0,0,255,120} -- filled blue with 120 alpha
			end
			mist.marker.add(markervars) -- add or modify the marker if already present
			end
		end
		
		function updateStrike(side, task)
		local whatSide = side
		local mission = task
		
		if whatSide == "RED" and task == "STRIKE" then
		-- for blues building
			local markervars = {
			id = "redstrike", -- make the marker ID the same as that zones names
			pos = redAttack, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = 3000,
			lineType = 1, -- type of line for the border
			readOnly = true -- users can't remove this marker`
			}
		end
		
		if whatSide == "BLUE" and task == "STRIKE" then
		-- for reds building
			local markervars = {
			id = "bluestrike", -- make the marker ID the same as that zones names
			pos = blueAttack, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = 3000,
			lineType = 1, -- type of line for the border
			readOnly = true -- users can't remove this marker`
			}
		end
		
		if whatSide == "RED" and task == "FARP" then
		-- for blues building
			local markervars = {
			id = "redfarp", -- make the marker ID the same as that zones names
			pos = redFarpPos, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = 3000,
			lineType = 1, -- type of line for the border
			readOnly = true -- users can't remove this marker`
			}
		end
		
		if whatSide == "BLUE" and task == "FARP" then
		-- for reds building
			local markervars = {
			id = "bluefarp", -- make the marker ID the same as that zones names
			pos = blueFarpPos, -- get the table of verticies from that zone
			markType = 2,  -- use circle
			markForCoa = -1,
			radius = 3000,
			lineType = 1, -- type of line for the border
			readOnly = true -- users can't remove this marker`
			}
		end
		
			markervars.color = {128,0,128,255} -- color purple
			markervars.fillColor = {128,0,128,20} -- filled purple with 20 alpha
			mist.marker.add(markervars) -- add or modify the marker if already present
			
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
				msg.text = 'BLUE SCORE IS ' .. BLUESCORE .. ' ' .. '| RED SCORE IS ' .. REDSCORE -- compressed to a single line rather than multiple lines
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
				forWhom = "Russia" -- country name of the FAP
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
		unitName = groupprefix .. "oil", -- the static name
		heliport_callsign_id = 1,
        heliport_modulation = 0,
		heliport_frequency = "127.5",
		rate = 100,
		clone = true, -- 
		 
		 --groupName = "FARP" .. side,
		 heading = 0.47123889803847, -- probably should randomize the direction or have it face the right way in future
		}
		
					local Strike_Area = {}
					Strike_Area.x = buildPsn.x
					Strike_Area.y = buildPsn.y
					Strike_Area.z = buildPsn.z
					radius = 2000
		
					
					if forWhom == "Russia" then
					redRigPos = buildPsnRig -- store the vec3 in redFarpPos for use with the heloattack script
					mist.flagFunc.mapobjs_dead_zones { zones = Strike_Area, flag = 1003, req_num = 3}
					end
					
					if forWhom == "USA" then
					blueRigPos = buildPsnRig -- store the vec3 in blueFarpPos for use with the heloattack script
					mist.flagFunc.mapobjs_dead_zones { zones = Strike_Area, flag = 1004, req_num = 3}
					end
					
					mist.dynAddStatic(vars)	-- add the static item to the mission
			end
		end
		
		function BuildSTRIKETARGET(iterations, side, ownedBy)
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
			
			local randomobjects = mist.random(1,2)
			
			if randomobjects == 1 then
			local vars = 
			{
			 type = "Tech combine",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z + math.random(200,300),
			 --name = "Strike1", 
			 groupName = "Strike1",
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars)
			local vars2 = 
			{
			 type = "Workshop A",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z + math.random(300, 600),
			 --name = "Strike2", 
			 groupName = "Strike2",
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars2)
			local vars3 = 
			{
			 type = "Repair workshop",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x + math.random(300, 590),
			 y = buildPsn.z + math.random(300,600),
			 --name = "Strike3", 
			 groupName = "Strike3",
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars3)
			
			elseif randomobjects == 2 then
			local vars = 
			{
			 type = "TV tower",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z + math.random(200,300),
			 --name = "Strike1", 
			 groupName = "Strike1",
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars)
			local vars2 = 
			{
			 type = "Supermarket A",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x,
			 y = buildPsn.z + math.random(300, 600),
			 --name = "Strike2", 
			 groupName = "Strike2",
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars2)
			local vars3 = 
			{
			 type = "TV tower",
			 country = forWhom,
			 category = "Fortifications", 
			 x = buildPsn.x + math.random(300, 590),
			 y = buildPsn.z + math.random(300,600),
			 --name = "Strike3", 
			 groupName = "Strike3",
			 heading = 0.47123889803847
			}
			mist.dynAddStatic(vars3)
			end
			
					local Strike_Area = {}
					Strike_Area.x = buildPsn.x
					Strike_Area.y = buildPsn.y
					Strike_Area.z = buildPsn.z
					radius = 2000
					
					if forWhom == "Russia" then
					blueStrikePos = buildPsn -- store the vec2 in redStrikePos for use with the bomber and scoring script
					blueAttack = Strike_Area
					mist.flagFunc.mapobjs_dead_zones { zones = Strike_Area, flag = 1001, req_num = 3}
					end
					
					if forWhom == "USA" then
					blueStrikePos = buildPsn -- store the vec2 in blueStrikePos for use with the bomber and scoring script
					redAttack = Strike_Area
					mist.flagFunc.mapobjs_dead_zones { zones = Strike_Area, flag = 1002, req_num = 3}
					end
					
					mist.dynAddStatic(vars)	-- add the static item to the mission
			end
		end
		
		
		function MonitorTask(whichTask, side)
		if side == "BLUE" and whichTask == "STRIKE" then
		if trigger.misc.getUserFlag('1001') == 1 then
			local msg = {}
			
			msg.text = ' Red structures have been demolished'
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				BLUESCORE = BLUESCORE + 10
				--trigger.action.setUserFlag('1001',0)
				mist.scheduleFunction(BuildSTRIKETARGET, {1, "RED", "Russia"}, timer.getTime() + 1)
			end
			end
			
		if side == "BLUE" and whichTask == "NAVAL_HELIPORT" then
		if trigger.misc.getUserFlag('1003') == 1 then
			local msg = {}
			
			msg.text = ' Red heliport has been demolished'
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				BLUESCORE = BLUESCORE + 10
				--trigger.action.setUserFlag('1001',0)
				mist.scheduleFunction(BuildOILRIGS, {1, "RED", "Russia"}, timer.getTime() + 1)
			end
		end
		
				if side == "BLUE" and whichTask == "FARP" then
		if trigger.misc.getUserFlag('1005') == 1 then
			local msg = {}
			
			msg.text = ' Red heliport has been demolished'
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				BLUESCORE = BLUESCORE + 10
				--trigger.action.setUserFlag('1001',0)
			--	mist.scheduleFunction(BuildOILRIGS, {1, "RED", "Russia"}, timer.getTime() + 1)
			end
		end
	
			
			if side == "RED" and whichTask == "STRIKE" then
			if trigger.misc.getUserFlag('1002') == 1 then
			local msg = {}
			
			msg.text = ' Blue structures have been demolished'
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				REDSCORE = REDSCORE + 10
				--trigger.action.setUserFlag('1002',0)
				--mist.scheduleFunction(BuildSTRIKETARGET, {1, "BLUE", "USA"}, timer.getTime() + 1)
			end
		end
		
			if side == "RED" and whichTask == "NAVAL_HELIPORT" then
			if trigger.misc.getUserFlag('1004') == 1 then
			local msg = {}
			
			msg.text = ' Blue heliport has been demolished'
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				REDSCORE = REDSCORE + 10
				--trigger.action.setUserFlag('1002',0)
				--mist.scheduleFunction(BuildOILRIGS, {1, "BLUE", "USA"}, timer.getTime() + 1)
			end
		end
		
		if side == "RED" and whichTask == "FARP" then
			if trigger.misc.getUserFlag('1006') == 1 then
			local msg = {}
			
			msg.text = ' Blue FARP has been demolished'
			msg.displayTime = 10
			msg.msgFor = {coa = {'ALL'}}
			mist.message.add(msg)
				
				REDSCORE = REDSCORE + 10
				--trigger.action.setUserFlag('1002',0)
				--mist.scheduleFunction(BuildFARP, {1, "BLUE", "USA"}, timer.getTime() + 1)
			end
		end
		
		end

	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	function Move_Ships(_Boats)
	------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	local randomizer_speed = 0
	local randomizer_dir = 0
	local randomizer_dist = 0
	local Infantry_Name = {}
	Boat_Name = _Boats
	randomizer_speed = math.random(7,14)
	randomizer_dir = math.random(90,270)
	randomizer_dist = math.random(1500, 2000)

	mist.groupRandomDistSelf(Boat_Name, randomizer_dist, 'Rank', randomizer_dir, randomizer_speed)
	end

		-- main
		mist.scheduleFunction(updateGrid, {MasterList, 1, 24}, timer.getTime() + 1, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 25, 49}, timer.getTime() + 2, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 50, 74}, timer.getTime() + 3, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 75, 99}, timer.getTime() + 4, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 100, 124}, timer.getTime() + 5, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 125, 149}, timer.getTime() + 6, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 150, 174}, timer.getTime() + 7, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateGrid, {MasterList, 175, 199}, timer.getTime() + 8, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateStrike, {"RED", "STRIKE"}, timer.getTime() + 9, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateStrike, {"BLUE", "STRIKE"}, timer.getTime() + 10, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateStrike, {"RED", "FARP"}, timer.getTime() + 9, 60) -- update grid every 60 seconds
		mist.scheduleFunction(updateStrike, {"BLUE", "FARP"}, timer.getTime() + 10, 60) -- update grid every 60 seconds
		mist.scheduleFunction(BuildFARP, {"BLUE", "USA"}, timer.getTime() + 3) -- build a farp
		mist.scheduleFunction(BuildFARP, {"RED", "Russia"}, timer.getTime() + 6) -- build a farp
		mist.scheduleFunction(BuildOILRIGS, {rNAVYSTATICamount, "RED", "Russia"}, timer.getTime() + 8)
		mist.scheduleFunction(BuildOILRIGS, {bNAVYSTATICamount, "BLUE", "USA"}, timer.getTime() + 10)
		mist.scheduleFunction(BuildSTRIKETARGET, {1, "BLUE", "USA"}, timer.getTime() + 11)
		mist.scheduleFunction(BuildSTRIKETARGET, {1, "RED", "Russia"}, timer.getTime() + 12)
		mist.scheduleFunction(MonitorTask, {"STRIKE", "RED"}, timer.getTime() + 13, 30)
		mist.scheduleFunction(MonitorTask, {"STRIKE", "BLUE"}, timer.getTime() + 14, 30)
		mist.scheduleFunction(MonitorTask, {"NAVAL_STATIC", "RED"}, timer.getTime() + 15, 30)
		mist.scheduleFunction(MonitorTask, {"NAVAL_STATIC", "BLUE"}, timer.getTime() + 16, 30)
		mist.scheduleFunction(MonitorTask, {"FARP", "RED"}, timer.getTime() + 17, 30)
		mist.scheduleFunction(MonitorTask, {"FARP", "BLUE"}, timer.getTime() + 18, 30)
		
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


		mist.scheduleFunction(random_markers, {50,250}, timer.getTime() + 10, updateMarkerSpeed) -- add randoimized smoke markers (this is old code written 7 years ago, maybe replace with more modern take on it at some point)
		mist.scheduleFunction(random_markers2, {50,250}, timer.getTime() + 10, updateMarkerSpeed) -- add randoimized smoke markers
		mist.scheduleFunction(scoreDisplay, {}, timer.getTime() + 90, 120) -- schedule the score display after 90 seconds and every 2 minutes afterwards
		mist.scheduleFunction(Introduce_Mission, {}, timer.getTime() + 2) -- schedule the mission introduction after 2 seconds of miz running.






