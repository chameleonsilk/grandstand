--revision 1.18

decluster = mist.random(1,10) -- global used to randomly decluster smoke marker schedule
dynaFRONT = {}
dynaFRONT.log_level = "info"
dynaFRONT.log = mist.Logger:new("DynaFRONT", dynaFRONT.log_level)

REDSCORE = 1
BLUESCORE = 1

-- intro function
function Introduce_Mission()
	local msg = {}
    msg.text = 'OPERATION GRANDSTAND 0.23'
    msg.displayTime = 29  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	msg = {}
	msg.text = 'Created by Chameleon_Silk'
    msg.displayTime = 10 
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	msg = {}
	msg.text = 'Powered by MIST 4.5.107, DynaFRONTII and GCICAP Autonomous Airfield.' 
    msg.displayTime = 19  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	msg = {}
	mist.scheduleFunction(displayLeaderInfo, {"BLUE"}, timer.getTime() + 10, 1200)
	mist.scheduleFunction(displayLeaderInfo, {"RED"}, timer.getTime() + 31, 1200)
	mist.scheduleFunction(showResources, {"BLUE"}, timer.getTime() + 60, 2400)
	mist.scheduleFunction(showResources, {"RED"}, timer.getTime() + 90, 2400)
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
		forWhom = "Russia"
		farpName = "FARPRED"
		randsquare = mist.random(1,#RedTRUCK_SectorSquares)
		zoneUsed = RedSectorSquares[randsquare]
		restrictPoly = zoneUsed
end
if side == "BLUE" then
		forWhom = "USA"
		farpName = "FARPBLUE"
		randsquare = mist.random(1,#BlueTRUCK_SectorSquares)
		zoneUsed = BlueSectorSquares[randsquare]
		restrictPoly = zoneUsed
end

	for i = 0, 1000 do
		local restriction = false
		local landgood = false
	
		spawnPsn = mist.getRandomPointInZone(zoneUsed, zoneUsed.radius)
        restriction = mist.pointInPolygon(spawnPsn, mist.getGroupPoints(restrictPoly)) 		
		
			if mist.isTerrainValid(spawnPsn, {terrainType}) == true then 
			landgood = true
			else
			landgood = false
			end
			
					if restriction == true and landgood == true then -- polygon restriction has been met and land valid	
					break
					end
		end
		
		local buildPsn = mist.utils.makeVec3(spawnPsn)	
		local buildPsnFarp = mist.utils.makeVec2(spawnPsn)			
		
			local vars = 
			{
 type = "FARP",
 country = forWhom, 
 category = "Heliports", 
 x = buildPsn.x,
 y = buildPsn.z,
 --name = farpName,
unitName = farpName,
 clone = true,
 --groupName = "FARP" .. side,
 heading = 0.47123889803847,
			}
			
			if forWhom == "Russia" then
			redFarpPos = buildPsnFarp
			end
			
			if forWhom == "USA" then
			blueFarpPos = buildPsnFarp
			end
			
			mist.dynAddStatic(vars)		

end

		
	

	
function ManipulateForce(behaviorType, iterations, whichSide, unitType, attempts, terrainType, placeDisperse, randomMove, moveSpeed, respawnGroup)
-- ManipulateForce --
-- ARG1 -- STRING of "respawn", "clone", "teleport"
-- ARG2 -- # of groups wanted (used with clone behaviorType, otherwise use 1 for a single group teleport or respawn)
-- ARG3 -- STRING for which side (RED" or "red" or "r" or "R" or "REDFOR" or "redfor" or "redfore" or "REDFORE" or "ENEMY" or "enemy" / "BLUE" or "blue" or "b" or "B" or "BLUFOR" or "BLU" or "blufor" or "bluefore" or "BLUEFORE" or "NATO" or "nato" or "friendly" or "FRIENDLY" or "FRIEND" or "friend" use whichever you want they will all work.
-- ARG4 -- STRING the type of units in the group ("AAA", "TRUCK", "TANK", "SRSAM", "LRSAM", "SHORAD", "APC", "INF" are the valid types
-- ARG5 -- # coordinate attempts do not use to high a value or DCS can hang while it performs the placements (use 100 as default)
-- ARG6 -- # use 0 if you wish no dispersion of the groups formation, otherwise the units will be randomly placed as far apart as this from each other (be weary of to far when using polygon to check a point for spawn restriction)
-- ARG7 -- # use 0 for no movement otherwise will move this amount randomly from its initial placement
-- ARG8 -- # speed of the randomzed movement if arg9 has a value above 0
-- ARG9 -- STRING if its not equal to "NO" then use this argument as the group name instead.

-- example ManipulateForce("clone", 5, "MyNamedGroupInMissionEditor", "MyTriggerZoneOrQuadName", 100, "RestrictSpawnAreaToThisGroupsNamesWaypointsAsPolygonShape", "LAND", 100, 1000, 15)
local zoneUsed = {}
local randsquare = 0
local restrictPoly = ""
local useSide = ""
local spawnPsn = {}
local failedAttempts = 0
local groupCalled = ""
local rand = 0

if placeDisperse ~= 0 then
	dispersionChoice = placeDisperse
	else
	dispersionChoice = false
end



for nomber = 1, iterations do	
	if whichSide == "RED" then
			useSide = "RED"
		if unitType == "AAA" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
		randsquare = mist.random(1,#RedSectorSquares)
		zoneUsed = RedSectorSquares[randsquare]
		restrictPoly = zoneUsed
		rand = mist.random(1,#Red_Names_AAA)
			groupCalled = Red_Names_AAA[rand]
			if restrictPoly == nil then
			dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[randsquare]'})
			end
			if zoneUsed == nil then
			dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[randsquare]'})
			end
		end
			if unitType == "TRUCK" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
			if unitType == "SHORAD" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
					if unitType == "TANK" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
							if unitType == "INF" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
							if unitType == "APC" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
							if unitType == "CP" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
		--if nomber == iterations then return
	--end
	end
	
	
		if whichSide == "BLUE" then
			useSide = "BLUE"
		if unitType == "AAA" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
			if unitType == "TRUCK" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
			if unitType == "SHORAD" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
					if unitType == "TANK" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
							if unitType == "INF" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
							if unitType == "APC" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
							if unitType == "CP" then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
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
	--if nomber == iterations then return
	--end
	end
	
	gdata = mist.getCurrentGroupData(groupCalled)

	
			for i = 0, attempts do
		local restriction = false
		local landgood = false
		--failedAttempts = failedAttempts + 1
		spawnPsn = mist.getRandomPointInZone(zoneUsed, zoneUsed.radius)
        restriction = mist.pointInPolygon(spawnPsn, mist.getGroupPoints(restrictPoly)) 		
		
			if mist.isTerrainValid(spawnPsn, {terrainType}) == true then 
			landgood = true
			else
			landgood = false
			end

				if failedAttempts == lastAttempt then
				dynaFRONT.log:warn("Failed placement and exceeded attempts", {'lastAttempt'})
				return
				end
			
					if restriction == true and landgood == true then -- polygon restriction has been met and land valid	
					break
					end
		end
		
			local groupvars = {}
			
			--if respawnGroup ~= nil then
			--groupCalled = respawnGroup
			--end
			
			groupvars.newGroupName = useSide .. " " .. unitType .. " " .. nomber -- lets name a group i.e "REDFOR AAA 1"
			ActiveForces[unitType][useSide][nomber] = groupvars.newGroupName -- now add this name to the active groups table, under the subcategory of its unit type
			ActiveForces[unitType][useSide].TEMPLATE[nomber] = groupCalled
			ActiveForces[unitType][useSide].SQUARE[nomber] = zoneUsed -- store the MGRS SQUARE for this group
			ActiveForces[unitType][useSide].POS[nomber] = spawnPsn -- save this groups position
			ActiveForces[unitType][useSide].INITSIZE[nomber] = Group.getInitialSize(Group.getByName(groupCalled)) -- set its initial size
			ActiveForces[unitType][useSide].SIZE[nomber] = Group.getInitialSize(Group.getByName(groupCalled)) -- set its current size
			
			
		--local data = mist.utils.serialize("TANKS", ActiveForces.TANK.BLUE) -- debug to show us our table
		--trigger.action.outText(data,50, true) -- display table to screen
		--trigger.action.outText(mist.utils.tableShow(data), 25)
			
			

    groupvars.groupName = groupCalled
   groupvars.action = behaviorType
   groupvars.point = spawnPsn
    --vars.route = path
	groupvars.disperse = dispersionChoice
	groupvars.maxDisp = dispersionChoice
	-- vars.radius = 100 
	groupvars.innerRadius = 0 
	groupvars.offsetRoute = true 
	groupvars.offsetWP1 = false
	groupvars.initTasks = true

		mist.cloneMoveGroup(groupCalled, false, groupvars)
		

		
		if randomMove ~= 0 then
		mist.scheduleFunction(moveStuff, {groupvars.newGroupName, randomMove, moveSpeed, useSide}, timer.getTime() + 5, mist.random(300,900))
		--mist.scheduleFunction(advanceUnits, {vars.newGroupName, useSide}, timer.getTime() + 5)
		end
	end

end -- end ManipulateForce Function




function monitorGroup(tblCheck, sideUsed, grpType)
-- TABLE arg tblCheck: check this activegroups table
-- STRING arg tblCheck: check this activegroups table
-- STRING arg of group type "AAA", "TANK" "APC" "INF" "CP" "SRSAM" "LRSAM" "SHORAD"

--local tblCheck =  tabCheck[grpType][sideUsed]
--local data = mist.utils.serialize("tblCheck", tblCheck[grpType][sideUsed]) -- debug to show us our table
--trigger.action.outText(data,5, true)		

for element = 1, #tblCheck do -- for each element in the table from 1 to the amount that is in the table
	local checkThisGroup = tblCheck[grpType][sideUsed][element] -- get the string of the group name located at that index
	local msg = {}
	local initsize = tblCheck[grpType][sideUsed][element].INITSIZE[element]--tblCheck[grpType][sideUsed].INITSIZE[element]
	local currentsize = Group.getInitialSize(Group.getByName(checkThisGroup))--tblCheck[grpType][sideUsed].SIZE[element]
	local decimalvalue = currentsize / initsize -- convert to a decimal value
	local percentage = decimalvalue * 100 -- convert decimal into a percentage
	
	trigger.action.outText(initsize ,5, false)	
	trigger.action.outText(currentsize ,5, false)	
	
	if percentage <= 90 then -- if the percentage is less that 30 percent then
		Group.destroy(Group.getByName(checkThisGroup)) -- destroy the group
		msg.text = sideUsed .. ' ' .. grpType .. ' will recieve a reinforcement in 5 minutes '
		msg.displayTime = 10
		msg.msgFor = {coa = {'all'}} 
		mist.message.add(msg)
		msg = {}
		ActiveForces[grpType][sideUsed].DESTROYED = ActiveForces[grpType][sideUsed].DESTROYED + 1
		table.remove(tblCheck[Element])
		table.remove(tblCheck.POS[Element])
		table.remove(tblCheck.SQUARE[Element])
		local data = mist.utils.serialize("tblCheck", tabCheck) -- debug to show us our table
		trigger.action.outText(data,50, true) -- display table to screen

		if sideUsed == "RED" then dynaFRONT.RED.SCORE = dynaFRONT.RED.SCORE + 1
		end
		
		if sideUsed == "BLUE" then dynaFRONT.BLUE.SCORE = dynaFRONT.BLUE.SCORE + 1 
		end
		
		--local data = mist.utils.serialize("tblCheck", tblCheck) -- debug to show us our table
		local data = mist.utils.serialize("tblCheck", tblCheck) -- debug to show us our table
		trigger.action.outText(data,50, true)
		
		--mist.scheduleFunction(ManipulateForce, {"clone", 1, sideUsed, grpType, 100, "LAND", 500, 0, 0, checkThisGroup}, timer.getTime() + 300)
		end
	end
end


function CreateArmy(forSide, unitType)

if forSide == "blue" or "BLUE" or "b" or "B" then

mist.scheduleFunction(ManipulateForce, {"clone", bAAAamount, "BLUE", "AAA", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 2)
mist.scheduleFunction(ManipulateForce, {"clone", bTRUCKamount, "BLUE", "TRUCK", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 4)
mist.scheduleFunction(ManipulateForce, {"clone", bSHORADamount, "BLUE", "SHORAD", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 6)
mist.scheduleFunction(ManipulateForce, {"clone", bINFamount, "BLUE", "INF", 1000, "LAND", 500, 5000, mist.random(4,7), nil}, timer.getTime() + 8)
mist.scheduleFunction(ManipulateForce, {"clone", bTANKamount, "BLUE", "TANK", 1000, "LAND", 500, 5000, mist.random(42,60), nil}, timer.getTime() + 10)
mist.scheduleFunction(ManipulateForce, {"clone", bAPCamount, "BLUE", "APC", 1000, "LAND", 500, 5000, mist.random(38,50), nil}, timer.getTime() + 12)
mist.scheduleFunction(ManipulateForce, {"clone", bCPamount, "BLUE", "CP", 1000, "LAND", 500, 5000, 0, nil}, timer.getTime() + 12)
mist.scheduleFunction(ManipulateForce, {"clone", bSRSAMamount, "BLUE", "SRSAM", 1000, "LAND", 400, 0, 0, nil}, timer.getTime() + 14)
mist.scheduleFunction(ManipulateForce, {"clone", bLRSAMamount, "BLUE", "LRSAM", 1000, "LAND", 0, 0, 0, nil}, timer.getTime() + 16)
mist.scheduleFunction(Create_Friendly_AWAC, {"BlueAWAC", "bAWAC"}, timer.getTime() + 1)
end

if forSide == "red" or "RED" or "r" or "R" then

mist.scheduleFunction(ManipulateForce, {"clone", rAAAamount, "RED", "AAA", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 20)
mist.scheduleFunction(ManipulateForce, {"clone", rTRUCKamount, "RED", "TRUCK", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 22)
mist.scheduleFunction(ManipulateForce, {"clone", rSHORADamount, "RED", "SHORAD", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 24)
mist.scheduleFunction(ManipulateForce, {"clone", rINFamount, "RED", "INF", 1000, "LAND", 500, 5000, mist.random(4,7), nil}, timer.getTime() + 26)
mist.scheduleFunction(ManipulateForce, {"clone", rTANKamount, "RED", "TANK", 1000, "LAND", 500, 5000, mist.random(28,42), nil}, timer.getTime() + 28)
mist.scheduleFunction(ManipulateForce, {"clone", rAPCamount, "RED", "APC", 1000, "LAND", 500, 5000, mist.random(24,40), nil}, timer.getTime() + 30)
mist.scheduleFunction(ManipulateForce, {"clone", rCPamount, "RED", "CP", 1000, "LAND", 500, 5000, 0, nil}, timer.getTime() + 32)
mist.scheduleFunction(ManipulateForce, {"clone", rSRSAMamount, "RED", "SRSAM", 1000, "LAND", 400, 0, 0, nil}, timer.getTime() + 34)
mist.scheduleFunction(ManipulateForce, {"clone", rLRSAMamount, "RED", "LRSAM", 1000, "LAND", 0, 0, 0, nil}, timer.getTime() + 36)
mist.scheduleFunction(Create_Friendly_AWAC, {"RedAWAC", "rAWAC"}, timer.getTime() + 1)
end
end

function pickSAMzone(forWhichSide)
local LRorSR = mist.random(1,2)
local pickedZone = ""

--pickedZone "dummy"

if forWhichSide == "blue" or "BLUE" then
	if LRorSR == 1 then
	local choice = mist.random(1, #RedLRSAM_SectorSquares)
	pickedZone = RedLRSAM_SectorSquares[choice]
	end
	if LRorSR == 2 then
	local choice = mist.random(1, #RedSRSAM_SectorSquares)
	pickedZone = RedSRSAM_SectorSquares[choice]
	end
	seadattack.red.sead.zone_name = pickedZone
	dynaFRONT.log:info("BLUE SEAD is targeting $1", pickedzone)
end
if forWhichSide == "red" or "RED" then
	if LRorSR == 1 then
	local choice = mist.random(1, #BlueLRSAM_SectorSquares)
	pickedZone = BlueLRSAM_SectorSquares[choice]
	end
	if LRorSR == 2 then
	local choice = mist.random(1, #BlueSRSAM_SectorSquares)
	pickedZone = BlueSRSAM_SectorSquares[choice]
	end	
	seadattack.blue.sead.zone_name = pickedZone
	dynaFRONT.log:info("RED SEAD is targeting $1", pickedzone)
--return pickedZone
end
end


function pickSECTOR(forWho, forTask)
local pickedZone = ""

--pickedZone "dummy"


if forWho == "red" or "RED" then
	if forTask == "CAS" then
	local choice = mist.random(1, #BlueSectorSquares)
	pickedZone = BlueSectorSquares[choice]
	heloattack.red.cas.zone_name = pickedZone
	groundattack.red.cas.zone_name = pickedZone
	dynaFRONT.log:info("RED CAS is targeting $1", pickedzone)
	end
	if forTask == "CAP" then
	local choice = mist.random(1, #RedSectorSquares)
	pickedZone = BlueSectorSquares[choice]
	gcicap.red.cap.zone_name = pickedZone
	dynaFRONT.log:info("RED CAP is targeting $1", pickedzone)
	end
end
if forWho == "blue" or "BLUE" then
	if forTask == "CAS" then
	local choice = mist.random(1, #RedSectorSquares)
	pickedZone = RedSectorSquares[choice]
	groundattack.blue.cas.zone_name = pickedZone
	heloattack.blue.cas.zone_name = pickedZone
	dynaFRONT.log:info("BLUE CAS is targeting $1", pickedzone)
	end
	if forTask == "CAP" then
	local choice = mist.random(1, #RedSectorSquares)
	pickedZone = RedSectorSquares[choice]
	gcicap.blue.cap.zone_name = pickedZone
	dynaFRONT.log:info("BLUE CAP is targeting $1", pickedzone)
	end
end
end


function Create_Friendly_AWAC(_awacArea, fAwacName)
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- based off of Kutaisi Intercept script by akp, but modified for my own use.
	local awaczone = trigger.misc.getZone(_awacArea)
	--local rand = mist.random(1,Fighter_Names)
	--fAwactask = 1  
  

	  local spawnPsn = {}
    local movePsn = {}

     -- for i = 1, 1000 do
      spawnPsn = mist.getRandPointInCircle(awaczone.point, awaczone.radius * 1.00)
      movePsn = mist.getRandPointInCircle(awaczone.point, awaczone.radius * 2.00)
     --local InAwacZone = mist.pointInPolygon(movePsn, mist.getGroupPoints('fAwacZone')) 
     -- if InAwacZone == true then break
    --  end
     -- end
    

		
	trigger.action.activateGroup(Group.getByName(fAwacName))
	awacgrp = Group.getByName(fAwacName)
  

	
	local InitwpSpeed = mist.random(450,500)
	local wpSpeed = mist.utils.kmphToMps(InitwpSpeed)
	local wpAlt = mist.random(3000,4000)
  local wpAlt2 = mist.random(6000,7000)
	local wpPsn = mist.getRandPointInCircle(spawnPsn, awaczone.radius * 0.15, awaczone.radius * 0.01)
	local wpPsn2 = movePsn
  local path = {}
					path[1] = mist.fixedWing.buildWP(spawnPsn, wpSpeed, wpAlt, "BARO")
					path[2] = mist.fixedWing.buildWP(wpPsn2, wpSpeed, wpAlt2, "BARO")
        					path[1].task = {
					id = "ComboTask",
					params = {
						tasks = {
							[1] = {
	            number = 1,
	            auto = true,
	            id = "AWACS",
	            enabled = true,
	          }, -- end of [1]
            	          [2] = {
	            number = 2,
	            auto = false,
	            id = "Orbit",
	            enabled = true,
	            params = {
	              altitudeEdited = false,
	              pattern = "Race-Track",
	              speed = wpSpeed,
	              altitude = wpAlt2,
	              speedEdited = true,
	            }, -- end of params
	          }, -- end of [2]
          [3] = 
                                       {
                                                            number = 3,
                                                            auto = false,
                                                            id = "WrappedAction",
                                                            enabled = true,
                                                            params = 
                                                            {
                                                                action = 
                                                                {
                                                                    id = "SetFrequency",
                                                                    params = 
                                                                    {
                                                                        modulation = 0,
                                                                        frequency = 131000000,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [3]
                                                        },
                                                        },
                                                        }
            
       --             path[2].task = {
	     --     number = 1,
	      --    auto = false,
	      --    id = "Orbit",
	      --    enabled = true,
	      --    params = {
	      --      altitudeEdited = false,
	     --       pattern = "Circle",
	     --       speed = wpSpeed,
	     --       altitude = wpAlt,
	    --        speedEdited = true,
	    --      }, -- end of params
	      --  } -- end of [1]


	local vars = {} 
	vars.groupName = fAwacName
	vars.action = "respawn"
	vars.point = spawnPsn
	vars.route = path
	mist.teleportToPoint(vars)			
  


	local con = awacgrp:getController()
	con:setOption(AI.Option.Air.id.RTB_ON_BINGO, false)
	con:setOption(AI.Option.Air.id.RADAR_USING, AI.Option.Air.val.RADAR_USING.FOR_CONTINUOUS_SEARCH)
	--con:setOption(AI.Option.Air.id.ROE, AI.Option.Air.val.ROE.OPEN_FIRE_WEAPON_FREE)
	con:setOption(AI.Option.Air.id.FLARE_USING, AI.Option.Air.val.FLARE_USING.AGAINST_FIRED_MISSILE)
	con:setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air.val.REACTION_ON_THREAT.EVADE_FIRE)
  end
 
  
  	
function moveStuff(thisGroupName, randomizerDist, spd, team)	
	if thisGroupName == nil then
	return
	end
	
	--local randomizer_speed = 0
	--local randomizer_dir = 0
	local randomizer_dist = 0
	--local Infantry_Name = {}
	local Name = thisGroupName
	local negativeheading = mist.random(0,1) 
	
	--randomizer_speed = math.random(1,4)
	
	-- red should be advancing north randomly
	
	if team == "RED" then
		if negativeheading == 0 then
		randomizer_dir = mist.random(0,60)
		end
		if negativeheading == 1 then
		randomizer_dir = mist.random(300,360)
		end		
	end
		
		
	if team == "BLUE" then	
	-- blue should be advancing south randomly
	randomizer_dir = mist.random(120,240)
	end
	
	--randomizer_dir = randomizer_dir * math.pi / 180

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

--local side = gcicap.sideToCoalition(unittouse:getCoalition()) -- this is from the gcicapscript
local side = Group.getCoalition(unittouse)
--trigger.action.outText("SIDE" .. side, 1 , true)
dynaFRONT.log:info("smoke marker for $1", side)


unitPos = mist.getLeadPos(unittouse)

if unitPos == nil then
return
end

 if side == 1 then
   -- if direction == 1 then
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

--local side = gcicap.sideToCoalition(unittouse:getCoalition()) -- this is from the gcicapscript
local side = Group.getCoalition(unittouse)
--trigger.action.outText("SIDE" .. side, 1 , true)
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


function ColorZones(routine)
--trigger.action.markupToAll(numbr shapeId , number coalition , number id , vec3 point1 , anyValid param... , table color , table fillColor , number lineType , boolean readOnly, string message)
 --pos = table pos,
 --name/id = string/number name/id, 
 --markType = number/string markType, 
 --radius = number radius, 
 --text = string text, 
 --markFor = table markFor,
 --markForCoa = number/string markForCoa, 
 --color = table color,
 --fillColor = table fillColor, 
 --lineType = number lineType,
 --readOnly = boolean readOnly,
 --message = text message,
 --fontSize = number fontSize,
local coloredZoneID
local vars

if routine == "ADD" then
for i = 1, #RedSectorSquares do
 --colorID = colorID + 1
 coloredZoneID = colorID
 zoneInQuestion = RedSectorSquares[i]
   vars = {
  pos = getQTpoints(zoneInQuestion),
 name = "REDSEC",
 markType = 7,  -- use Quad
 --radius = number radius, 
 --text = "TEST", 
 --markFor = {coa = {'all'}},
markForCoa = -1,
 color = {255,0,0,255},
 fillColor = {255,0,0,80},
 lineType = 1,
 readOnly = true
 --message = text message,
 --fontSize = number fontSize,
 }
 mist.marker.add(vars)
 --trigger.action.outText(mist.utils.tableShow(zoneInQuestion), 25, true)
 end
 
 for i = 1, #RedSRSAM_SectorSquares do
 --colorID = colorID + 1
 coloredZoneID = colorID
 zoneInQuestion = RedSRSAM_SectorSquares[i]
   vars = {
 pos = getQTpoints(zoneInQuestion),
 name = "REDSRSAM",
 markType = 7,  -- use Quad
 --radius = number radius, 
 --text = string text, 
 --markFor = {coa = {'red'}, {'blue'}},
markForCoa = -1,
 color = {255,0,0,255},
 fillColor = {255,0,0,80},
 lineType = 1,
 readOnly = true
 --message = text message,
 --fontSize = number fontSize,
 }
 mist.marker.add(vars)
 end
 
 for i = 1, #RedLRSAM_SectorSquares do
--colorID = colorID + 1
 coloredZoneID = colorID
 zoneInQuestion = RedLRSAM_SectorSquares[i]
   vars = {
pos = getQTpoints(zoneInQuestion),
 name = "REDLRSAM", -- use our setup ID
 markType = 7,  -- use Quad
 --radius = number radius, 
 --text = string text, 
 --markFor = {coa = {'red'}, {'blue'}},
 markForCoa = -1,
 color = {255,0,0,255},
 fillColor = {255,0,0,80},
 lineType = 2,
 readOnly = true
 --message = text message,
 --fontSize = number fontSize,
 }
 mist.marker.add(vars)
 end
 
 for i = 1, #BlueSectorSquares do
 --colorID = colorID + 1
 coloredZoneID = colorID
 zoneInQuestion = BlueSectorSquares[i]
   vars = {
pos = getQTpoints(zoneInQuestion),
 name = "BLUESEC",  -- use our setup ID
 markType = 7,  -- use Quad
 --radius = number radius, 
 --text = string text, 
 --markFor = {coa = {'red'}, {'blue'}},
 markForCoa = -1,
 color = {0,0,255,255},
 fillColor = {0,0,255,80},
 lineType = 3,
 readOnly = true
 --message = text message,
 --fontSize = number fontSize,
 }
 mist.marker.add(vars)
 end
 
 for i = 1, #BlueSRSAM_SectorSquares do
-- colorID = colorID + 1
 coloredZoneID = colorID
 zoneInQuestion = BlueSRSAM_SectorSquares[i]
   vars = {
pos = getQTpoints(zoneInQuestion),
 name = "BLUESRSAM", -- use our setup ID
 markType = 7,  -- use Quad
 --radius = number radius, 
 --text = string text, 
markForCoa = -1,
 color = {0,0,255,255},
 fillColor = {0,0,255,80},
 lineType = 2,
 readOnly = true
 --message = text message,
 --fontSize = number fontSize,
 }
 mist.marker.add(vars)
 end
 
 for i = 1, #BlueLRSAM_SectorSquares do
 --colorID = colorID + 1
 coloredZoneID = colorID
 zoneInQuestion = BlueLRSAM_SectorSquares[i]
  vars = {
pos = getQTpoints(zoneInQuestion),
 name = "BLUELRSAM", -- use our setup ID
 markType = 7,  -- use Quad
 --radius = number radius, 
 --text = string text, 
 --markFor = {coa = {'red'}, {'blue'}},
 markForCoa = -1,
 color = {0,0,255,255},
 fillColor = {0,0,255,80},
 lineType = 3,
 readOnly = true
 --message = text message,
 --fontSize = number fontSize,
 }
 mist.marker.add(vars)
 end
end


if routine == "REMOVE" then
local val = mist.marker.get('REDSEC')
--mist.Marker.Remove(val)
local val = mist.marker.get('BLUESEC')
--mist.Marker.Remove(val)
local val = mist.marker.get('REDLRSAM')
--mist.Marker.Remove(val)
local val = mist.marker.get('REDSRSAM')
--mist.Marker.Remove(val)
local val = mist.marker.get('BLUELRSAM')
--mist.Marker.Remove(val)
local val = mist.marker.get('BLUESRSAM')
--mist.Marker.Remove(val)
end


--mist.scheduleFunction(ColorZones, {"REMOVE"}, timer.getTime() + 2, 29) -- remove marks before updating test
--mist.scheduleFunction(ColorZones, {"ADD"}, timer.getTime() + 3, 30)
--mist.scheduleFunction(ColorZones, {"REMOVE"}, timer.getTime() + 9, 9) -- remove marks before updating test

end -- end function


function getQTpoints(zoneTable)

local t = mist.DBs.zonesByName[zoneTable]
local copiedpoints = {}
--local copiedpoints = mist.utils.deepCopy(mist.utils.deepCopy(trigger.misc.getZone(zoneTable)))
--local copiedpoints = mist.utils.deepCopy(trigger.misc.getZone(zoneTable))


for i = 1, #t.verticies do
copiedpoints[i] = t.verticies[i]
end

 --local data = mist.utils.serialize("wtf", t)
 -- local data2 = mist.utils.serialize("wtf", copiedpoints)
 --trigger.action.outText(data,50, true)
 --trigger.action.outText(data2,50, false)
return copiedpoints
end

function scoreDisplay()
		local msg = {}
		msg.text = 'BLUE SCORE IS ' .. BLUESCORE
		msg.displayTime = 10
		msg.msgFor = {coa = {'all'}} 
		mist.message.add(msg)
		msg = {}
		msg.text = 'RED SCORE IS ' .. REDSCORE
		msg.displayTime = 10
		msg.msgFor = {coa = {'all'}} 
		mist.message.add(msg)
		msg = {}
end
mist.scheduleFunction(BuildFARP, {"BLUE", "USA"}, timer.getTime() + 3)
mist.scheduleFunction(BuildFARP, {"RED", "Russia"}, timer.getTime() + 6)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "AAA"}, timer.getTime() + 61, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "TANK"}, timer.getTime() + 62, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "APC"}, timer.getTime() + 63, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "INF"}, timer.getTime() + 64, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "CP"}, timer.getTime() + 65, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "SHORAD"}, timer.getTime() + 66, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "TRUCK"}, timer.getTime() + 67, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "LRSAM"}, timer.getTime() + 68, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "SRSAM"}, timer.getTime() + 69, 30)

mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "AAA"}, timer.getTime() + 70, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "TANK"}, timer.getTime() + 71, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "APC"}, timer.getTime() + 72, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "INF"}, timer.getTime() + 73, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "CP"}, timer.getTime() + 74, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "SHORAD"}, timer.getTime() + 75, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "TRUCK"}, timer.getTime() + 76, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "LRSAM"}, timer.getTime() + 77, 30)
mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "SRSAM"}, timer.getTime() + 78, 30)




--mist.scheduleFunction(changePOI, {""}, timer.getTime() + 1, 300) -- change POI every 5 minutes after initial call
mist.scheduleFunction(random_markers, {50,250}, timer.getTime() + 10, updateMarkerSpeed + decluster)
mist.scheduleFunction(random_markers2, {50,250}, timer.getTime() + 10, updateMarkerSpeed + decluster)
mist.scheduleFunction(scoreDisplay, {}, timer.getTime() + 70, 300) -- schedule the mission introduction after 4 seconds of miz running.
mist.scheduleFunction(ColorZones, {"ADD"}, timer.getTime() + 1)
mist.scheduleFunction(Introduce_Mission, {}, timer.getTime() + 2) -- schedule the mission introduction after 4 seconds of miz running.






