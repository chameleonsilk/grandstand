-- Mission Intro Function
function Introduce_Mission()
	local _msg = {}
    _msg.text = 'OPERATION G_randSTAND 0.23'
    _msg.displayTime = 29  
    _msg._msgFor = {coa = {'all'}} 
    mist.message.add(_msg)
	_msg = {}
	_msg.text = 'Created by Chameleon_Silk'
    _msg.displayTime = 10 
    _msg._msgFor = {coa = {'all'}} 
    mist.message.add(_msg)
	_msg = {}
	_msg.text = 'Powered by MIST 4.5.107, DynaFRONTII and GCICAP Autonomous Airfield.' 
    _msg.displayTime = 19  
    _msg._msgFor = {coa = {'all'}} 
    mist.message.add(_msg)
	_msg = {}
	mist.scheduleFunction(displayLeaderInfo, {"BLUE"}, timer.getTime() + 10, 1200)
	mist.scheduleFunction(displayLeaderInfo, {"RED"}, timer.getTime() + 31, 1200)
	mist.scheduleFunction(showResources, {"BLUE"}, timer.getTime() + 60, 2400)
	mist.scheduleFunction(showResources, {"RED"}, timer.getTime() + 90, 2400)
end

decluster = mist._random(1,10) -- Global used to _randomly decluster smoke marker schedule
dynaFRONT = {}
dynaFRONT.log_level = "info"
dynaFRONT.log = mist.Logger:new("DynaFRONT", dynaFRONT.log_level)

REDSCORE = 1
BLUESCORE = 1

-- No reason to make these _names small and hard to understand. Be vebose.
-- Some globals we will need for naming groups
blueGroup_nameAppend = 0 
redGroup_nameAppend = 0

-- What are these?	
--heloattack.blue.supply = 12
--groundattack.blue.supply = 24
--seadattack.blue.supply = 24
--gcicap.blue.supply = 24
	
-- What does this do. What is POI?
function changePOI(ourArg)
	pickSAMzone("RED")1
	pickSAMzone("BLUE")
	pickSECTOR("RED", "CAS")
	pickSECTOR("BLUE", "CAS")
	pickSECTOR("RED", "CAP")
	pickSECTOR("BLUE", "CAP")
end

-- ARG1 STRING, red or blue
-- ARG2 STRING, country of origin
function BuildFARP(_side, ownedBy)
	-- local/private variables could be preceded with '_' ie __forWhom. Common syntaxt
	-- to differentiate local afrom global variables.
	local _forWhom = ""
	local _farp_name = ""
	local _zoneUsed = {}
	local _randsquare = 0
	local _restrictPoly = ""
	local _use_side = ""
	local _spawnPsn = {}
	local _failedAttempts = 0

	if _side == "RED" 
	then
		_forWhom = "Russia"
		_farp_name = "FARPRED"
		_randsquare = mist._random(1,#RedTRUCK_SectorSquares)
		_zoneUsed = RedSectorSquares[_randsquare]
		_restrictPoly = _zoneUsed
	-- moved the below into elseif from it's own if/then
	elseif _side == "BLUE"
	then
		_forWhom = "USA"
		_farp_name = "FARPBLUE"
		_randsquare = mist._random(1,#BlueTRUCK_SectorSquares)
		_zoneUsed = BlueSectorSquares[_randsquare]
		_restrictPoly = _zoneUsed
	end

	for i = 0, 1000
	do
		local _restriction = false		
		local _landGood = false
		-- could redo this like this, this will set the bool to the _value of this
		-- argument. landgood will be true if mist.isterrain_valid is true, or false if
		-- it is false
		local _landGood = mist.isTerrain_valid(_spawnPsn, {terrainType})
		
		--_failedAttempts = _failedAttempts + 1
		_spawnPsn = mist.get_randomPointInZone(_zoneUsed, _zoneUsed.radius)
        _restriction = mist.pointInPolygon(_spawnPsn, mist.getGroupPoints(_restrictPoly)) 		
		
		if mist.isTerrain_valid(_spawnPsn, {terrainType}) == true then 
			_landGood = true
		else
			_landGood = false
		end

		--if _failedAttempts == lastAttempt then
		--dynaFRONT.log:warn("Failed BUILD placement and exceeded attempts", {'lastAttempt'})
		--return
		--end
			
		if _restriction == true and _landGood == true 
		then -- polygon _restriction has been met and land _valid	
			break
		--else
		end
	end
		
	local _buildPsn = mist.utils.makeVec3(_spawnPsn)	
	local _buildPsnFarp = mist.utils.makeVec2(_spawnPsn)			
		
	--local _vars = {
	-- type = "FARP",
	-- country = "RUSSIA",
	-- category = "Heliports", 
	-- x = _buildPsn.x,
	-- y = _buildPsn.z + math._random(200,300),
	--_name = "Strike1", 
	-- group_name = "Strike1",
	-- heading = 0.47123889803847
	--}
			
			
	local _vars = 
		{
			type = "FARP",
			country = _forWhom, 
			category = "Heliports", 
			x = _buildPsn.x,
			y = _buildPsn.z,
			--_name = _farp_name,
			unit_name = _farp_name,
			clone = true,
			--group_name = "FARP" .. _side,
			heading = 0.47123889803847,
		}
			
	if _forWhom == "Russia"
	then
		redFarpPos = _buildPsnFarp
	elseif _forWhom == "USA"
	then
		blueFarpPos = _buildPsnFarp
	end
			
	--if _forWhom == "USA" 
	--then
	--	blueFarpPos = _buildPsnFarp
	--end
			
	mist.dynAddStatic(_vars)						
	--trigger.action.outText("tried to place a static",2, true)
end

	
function ManipulateForce(behaviorType, iterations, which_side, unitType, attempts, terrainType, placeDisperse, _randomMove, moveSpeed, respawnGroup)
-- ManipulateForce --
-- ARG1 -- STRING of "respawn", "clone", "teleport"
-- ARG2 -- # of groups wanted (used with clone behaviorType, otherwise use 1 for a single group teleport or respawn)
-- ARG3 -- STRING for which _side (RED" or "red" or "r" or "R" or "REDFOR" or "redfor" or "redfore" or "REDFORE" or "ENEMY" or "enemy" / "BLUE" or "blue" or "b" or "B" or "BLUFOR" or "BLU" or "blufor" or "bluefore" or "BLUEFORE" or "NATO" or "nato" or "friendly" or "FRIENDLY" or "FRIEND" or "friend" use whichever you want they will all work.
-- ARG4 -- STRING the type of units in the group ("AAA", "TRUCK", "TANK", "SRSAM", "LRSAM", "SHORAD", "APC", "INF" are the _valid types
-- ARG5 -- # coordinate attempts do not use to high a _value or DCS can hang while it performs the placements (use 100 as default)
-- ARG6 -- # use 0 if you wish no dispersion of the groups formation, otherwise the units will be _randomly placed as far apart as this from each other (be weary of to far when using polygon to check a point for spawn _restriction)
-- ARG7 -- # use 0 for no movement otherwise will move this amount _randomly from its initial placement
-- ARG8 -- # speed of the _randomzed movement if arg9 has a _value above 0
-- ARG9 -- STRING if its not equal to "NO" then use this argument as the group _name instead.

-- example ManipulateForce("clone", 5, "My_namedGroupInMissionEditor", "MyTriggerZoneOrQuad_name", 100, "RestrictSpawnAreaToThisGroups_namesWaypointsAsPolygonShape", "LAND", 100, 1000, 15)
	local _zoneUsed = {}
	local _randsquare = 0
	local _restrictPoly = ""
	local _use_side = ""
	local _spawnPsn = {}
	local _failedAttempts = 0
	local _groupCalled = ""
	local _rand = 0

	if placeDisperse ~= 0 then
		dispersion_choice = placeDisperse
	else
		dispersion_choice = false
	end


-- is this VV  a spelling error
	for nomber = 1, iterations do	
		if which_side == "RED"
		then
			_use_side = "RED"
			if unitType == "AAA"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#RedSectorSquares)
				_zoneUsed = RedSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_AAA)
				_groupCalled = Red__names_AAA[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "TRUCK"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#RedTRUCK_SectorSquares)
				_zoneUsed = RedSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_TRUCK)
				_groupCalled = Red__names_TRUCK[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "SHORAD"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#RedSectorSquares)
				_zoneUsed = RedSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_SHORAD)
				_groupCalled = Red__names_SHORAD[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "TANK"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#RedSectorSquares)
				_zoneUsed = RedSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_TANK)
				_groupCalled = Red__names_TANK[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "INF"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#RedSectorSquares)
				_zoneUsed = RedSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_INF)
				_groupCalled = Red__names_INF[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
			end
			if unitType == "APC"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#RedSectorSquares)
				_zoneUsed = RedSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_APC)
				_groupCalled = Red__names_APC[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "CP"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#RedSectorSquares)
				_zoneUsed = RedSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_CP)
				_groupCalled = Red__names_CP[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "LRSAM" 
			then
				_randsquare = mist._random(1,#RedLRSAM_SectorSquares)
				_zoneUsed = RedLRSAM_SectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_LRSAM)
				_groupCalled = Red__names_LRSAM[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedLRSAM_SectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedLRSAM_SectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "SRSAM"
			then
				_randsquare = mist._random(1,#RedSRSAM_SectorSquares)
				_zoneUsed = RedSRSAM_SectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Red__names_SRSAM)
				_groupCalled = Red__names_SRSAM[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'RedSRSAM_SectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'RedSRSAM_SectorSquares[_randsquare]'})
				end
			end	
		--if nomber == iterations then return
	--end
		end
	
		if which_side == "BLUE" 
		then
			_use_side = "BLUE"
			if unitType == "AAA"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#BlueSectorSquares)
				_zoneUsed = BlueSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_AAA)
				_groupCalled = Blue__names_AAA[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
			end
		
			if unitType == "TRUCK"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#BlueTRUCK_SectorSquares)
				_zoneUsed = BlueSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_TRUCK)
				_groupCalled = Blue__names_TRUCK[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
			end
		
			if unitType == "SHORAD"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#BlueSectorSquares)
				_zoneUsed = BlueSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_SHORAD)
				_groupCalled = Blue__names_SHORAD[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "TANK"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#BlueSectorSquares)
				_zoneUsed = BlueSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_TANK)
				_groupCalled = Blue__names_TANK[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "INF"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#BlueSectorSquares)
				_zoneUsed = BlueSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_INF)
				_groupCalled = Blue__names_INF[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "APC"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#BlueSectorSquares)
				_zoneUsed = BlueSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_APC)
				_groupCalled = Blue__names_APC[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "CP"
			then --or "TRUCK" or "SHORAD" or "TANK" or "INF" or "APC" then
				_randsquare = mist._random(1,#BlueSectorSquares)
				_zoneUsed = BlueSectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_CP)
				_groupCalled = Blue__names_CP[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "LRSAM"
			then
				_randsquare = mist._random(1,#BlueLRSAM_SectorSquares)
				_zoneUsed = BlueLRSAM_SectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_LRSAM)
				_groupCalled = Blue__names_LRSAM[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueLRSAM_SectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueLRSAM_SectorSquares[_randsquare]'})
				end
			end
			
			if unitType == "SRSAM"
			then
				_randsquare = mist._random(1,#BlueSRSAM_SectorSquares)
				_zoneUsed = BlueSRSAM_SectorSquares[_randsquare]
				_restrictPoly = _zoneUsed
				_rand = mist._random(1,#Blue__names_SRSAM)
				_groupCalled = Blue__names_SRSAM[_rand]
				if _restrictPoly == nil
				then
					dynaFRONT.log:error("No polygon for that square was found $1", {'BlueSRSAM_SectorSquares[_randsquare]'})
				end
				if _zoneUsed == nil
				then
					dynaFRONT.log:error("No zone for that square was found $1", {'BlueSRSAM_SectorSquares[_randsquare]'})
				end
			end
		--if nomber == iterations then return
		--end
		end
	
		g_data = mist.getCurrentGroup_data(_groupCalled)

	
		for i = 0, attempts do
			local _restriction = false
			--local _landGood = false
			-- again here do this
			local _landGood = mist.isTerrain_valid(_spawnPsn, {terrainType})
			--_failedAttempts = _failedAttempts + 1
			_spawnPsn = mist.get_randomPointInZone(_zoneUsed, _zoneUsed.radius)
			_restriction = mist.pointInPolygon(_spawnPsn, mist.getGroupPoints(_restrictPoly)) 		
		
			--if mist.isTerrain_valid(_spawnPsn, {terrainType}) == true
			--then 
			--	_landGood = true
			--else
			--_landGood = false
			--end

			if _failedAttempts == lastAttempt
			then
				dynaFRONT.log:warn("Failed placement and exceeded attempts", {'lastAttempt'})
				return
			end			
			if _restriction == true and _landGood == true
			then -- polygon _restriction has been met and land _valid	
				break
			end
		end
		
		local _group_vars = {}			
		--if respawnGroup ~= nil then
		--_groupCalled = respawnGroup
		--end
			
		_group_vars.newGroup_name = _use_side .. " " .. unitType .. " " .. nomber -- lets _name a group i.e "REDFOR AAA 1"
		ActiveForces[unitType][_use_side][nomber] = _group_vars.newGroup_name -- now add this _name to the active groups table, under the subcategory of its unit type
		ActiveForces[unitType][_use_side].TEMPLATE[nomber] = _groupCalled
		ActiveForces[unitType][_use_side].SQUARE[nomber] = _zoneUsed -- store the MGRS SQUARE for this group
		ActiveForces[unitType][_use_side].POS[nomber] = _spawnPsn -- save this groups position
		ActiveForces[unitType][_use_side]._initSize[nomber] = Group.getInitialSize(Group.getBy_name(_groupCalled)) -- set its initial size
		ActiveForces[unitType][_use_side].SIZE[nomber] = Group.getInitialSize(Group.getBy_name(_groupCalled)) -- set its current size
					
		--local _data = mist.utils.serialize("TANKS", ActiveForces.TANK.BLUE) -- debug to show us our table
		--trigger.action.outText(_data,50, true) -- display table to screen
		--trigger.action.outText(mist.utils.tableShow(_data), 25)
			
		_group_vars.group_name = _groupCalled
		_group_vars.action = behaviorType
		_group_vars.point = _spawnPsn
		--_vars.route = _path
		_group_vars.disperse = dispersion_choice
		_group_vars.maxDisp = dispersion_choice
		-- _vars.radius = 100 
		_group_vars.innerRadius = 0 
		_group_vars.offsetRoute = true 
		_group_vars.offsetWP1 = false
		_group_vars.initTasks = true

		mist.cloneMoveGroup(_groupCalled, false, _group_vars)
		
		if _randomMove ~= 0
		then
			mist.scheduleFunction(moveStuff, {_group_vars.newGroup_name, _randomMove, moveSpeed, _use_side}, timer.getTime() + 5, mist._random(300,900))
			--mist.scheduleFunction(advanceUnits, {_vars.newGroup_name, _use_side}, timer.getTime() + 5)
		end
	end

end -- end ManipulateForce Function


function monitorGroup(tblCheck, _sideUsed, grpType)
-- TABLE arg tblCheck: check this activegroups table
-- STRING arg tblCheck: check this activegroups table
-- STRING arg of group type "AAA", "TANK" "APC" "INF" "CP" "SRSAM" "LRSAM" "SHORAD"

--local tblCheck =  tabCheck[grpType][_sideUsed]
	local _data = mist.utils.serialize("tblCheck", tblCheck) -- debug to show us our table
		
	for element = 1, #tblCheck do -- for each element in the table from 1 to the amount that is in the table
		local _checkThisGroup = tblCheck[element] -- get the string of the group _name located at that index
		local _msg = {}
		local _initSize = tblCheck[grpTYPE][_sideUsed]._initSize[element]
		local _currentSize = tblCheck[grpTYPE][_sideUsed].SIZE[element]
		local _decimal_value = _currentSize / _initSize -- _convert to a decimal _value
		local _percentage = _decimal_value * 100 -- _convert decimal into a _percentage
	
		if _percentage <= 90
		then -- if the _percentage is less that 30 percent then
			Group.destroy(Group.getBy_name(_checkThisGroup)) -- destroy the group
			_msg.text = _sideUsed .. ' ' .. grpType .. ' will recieve a reinforcement in 5 minutes '
			_msg.displayTime = 10
			_msg._msgFor = {coa = {'all'}} 
			mist.message.add(_msg)
			_msg = {}
			ActiveForces[grpType][_sideUsed].DESTROYED = ActiveForces[grpType][_sideUsed].DESTROYED + 1
			table.remove(tblCheck[Element])
			table.remove(tblCheck.POS[Element])
			table.remove(tblCheck.SQUARE[Element])
			local _data = mist.utils.serialize("tblCheck", tabCheck) -- debug to show us our table
			trigger.action.outText(_data,50, true) -- display table to screen
			
			if _sideUsed == "RED"
			then
				dynaFRONT.RED.SCORE = dynaFRONT.RED.SCORE + 1
			elseif _sideUsed == "BLUE"
			then
				dynaFRONT.BLUE.SCORE = dynaFRONT.BLUE.SCORE + 1
			end		
			--if _sideUsed == "BLUE"
			--then
			--	dynaFRONT.BLUE.SCORE = dynaFRONT.BLUE.SCORE + 1 
			--end
		
			local _data = mist.utils.serialize("tblCheck", tblCheck) -- debug to show us our table
			mist.scheduleFunction(ManipulateForce, {"clone", 1, _sideUsed, grpType, 100, "LAND", 500, 0, 0, _checkThisGroup}, timer.getTime() + 300)
		end
	end
end


function CreateArmy(for_side, unitType)

	if for_side == "blue" or "BLUE" or "b" or "B"
	then
		mist.scheduleFunction(ManipulateForce, {"clone", bAAAamount, "BLUE", "AAA", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 2)
		mist.scheduleFunction(ManipulateForce, {"clone", bTRUCKamount, "BLUE", "TRUCK", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 4)
		mist.scheduleFunction(ManipulateForce, {"clone", bSHORADamount, "BLUE", "SHORAD", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 6)
		mist.scheduleFunction(ManipulateForce, {"clone", bINFamount, "BLUE", "INF", 1000, "LAND", 500, 5000, mist._random(4,7), nil}, timer.getTime() + 8)
		mist.scheduleFunction(ManipulateForce, {"clone", bTANKamount, "BLUE", "TANK", 1000, "LAND", 500, 5000, mist._random(42,60), nil}, timer.getTime() + 10)
		mist.scheduleFunction(ManipulateForce, {"clone", bAPCamount, "BLUE", "APC", 1000, "LAND", 500, 5000, mist._random(38,50), nil}, timer.getTime() + 12)
		mist.scheduleFunction(ManipulateForce, {"clone", bCPamount, "BLUE", "CP", 1000, "LAND", 500, 5000, 0, nil}, timer.getTime() + 12)
		mist.scheduleFunction(ManipulateForce, {"clone", bSRSAMamount, "BLUE", "SRSAM", 1000, "LAND", 400, 0, 0, nil}, timer.getTime() + 14)
		mist.scheduleFunction(ManipulateForce, {"clone", bLRSAMamount, "BLUE", "LRSAM", 1000, "LAND", 0, 0, 0, nil}, timer.getTime() + 16)
		mist.scheduleFunction(Create_Friendly_AWAC, {"BlueAWAC", "bAWAC"}, timer.getTime() + 1)
	end
-- this could lilkey be included above in an elseif
	if for_side == "red" or "RED" or "r" or "R"
	then
		mist.scheduleFunction(ManipulateForce, {"clone", rAAAamount, "RED", "AAA", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 20)
		mist.scheduleFunction(ManipulateForce, {"clone", rTRUCKamount, "RED", "TRUCK", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 22)
		mist.scheduleFunction(ManipulateForce, {"clone", rSHORADamount, "RED", "SHORAD", 1000, "LAND", 500, 0, 0, nil}, timer.getTime() + 24)
		mist.scheduleFunction(ManipulateForce, {"clone", rINFamount, "RED", "INF", 1000, "LAND", 500, 5000, mist._random(4,7), nil}, timer.getTime() + 26)
		mist.scheduleFunction(ManipulateForce, {"clone", rTANKamount, "RED", "TANK", 1000, "LAND", 500, 5000, mist._random(28,42), nil}, timer.getTime() + 28)
		mist.scheduleFunction(ManipulateForce, {"clone", rAPCamount, "RED", "APC", 1000, "LAND", 500, 5000, mist._random(24,40), nil}, timer.getTime() + 30)
		mist.scheduleFunction(ManipulateForce, {"clone", rCPamount, "RED", "CP", 1000, "LAND", 500, 5000, 0, nil}, timer.getTime() + 32)
		mist.scheduleFunction(ManipulateForce, {"clone", rSRSAMamount, "RED", "SRSAM", 1000, "LAND", 400, 0, 0, nil}, timer.getTime() + 34)
		mist.scheduleFunction(ManipulateForce, {"clone", rLRSAMamount, "RED", "LRSAM", 1000, "LAND", 0, 0, 0, nil}, timer.getTime() + 36)
		mist.scheduleFunction(Create_Friendly_AWAC, {"RedAWAC", "rAWAC"}, timer.getTime() + 1)
	end
end

function pickSAMzone(forWhich_side)
	-- what is LRorSR? more verbose _name please
	local _LRorSR = mist._random(1,2)
	local _pickedZone = ""
	--_pickedZone "dummy"

	-- i think most of thse if thens can be made into if/then/elseif to make more
	-- efficient
	if forWhich_side == "blue" or "BLUE"
	then
		if _LRorSR == 1
		then
			local _choice = mist._random(1, #RedLRSAM_SectorSquares)
			_pickedZone = RedLRSAM_SectorSquares[_choice]
		end
		if _LRorSR == 2
		then
			local _choice = mist._random(1, #RedSRSAM_SectorSquares)
			_pickedZone = RedSRSAM_SectorSquares[_choice]
		end
		seadattack.red.sead.zone__name = _pickedZone
		dynaFRONT.log:info("BLUE SEAD is targeting $1", _pickedZone)
	end
	
	if forWhich_side == "red" or "RED"
	then
		if _LRorSR == 1
		then
			local _choice = mist._random(1, #BlueLRSAM_SectorSquares)
			_pickedZone = BlueLRSAM_SectorSquares[_choice]
		end
		if _LRorSR == 2
		then
			local _choice = mist._random(1, #BlueSRSAM_SectorSquares)
			_pickedZone = BlueSRSAM_SectorSquares[_choice]
		end	
		seadattack.blue.sead.zone__name = _pickedZone
		dynaFRONT.log:info("RED SEAD is targeting $1", _pickedZone)
	--return _pickedZone
	end
end


function pickSECTOR(forWho, forTask)
	local _pickedZone = ""
	--_pickedZone "dummy"

	-- make into if/then/elseif
	if forWho == "red" or "RED"
	then
		if forTask == "CAS"
		then
		local _choice = mist._random(1, #BlueSectorSquares)
			_pickedZone = BlueSectorSquares[_choice]
			heloattack.red.cas.zone__name = _pickedZone
			groundattack.red.cas.zone__name = _pickedZone
			dynaFRONT.log:info("RED CAS is targeting $1", _pickedZone)
		end
		if forTask == "CAP"
		then
			local _choice = mist._random(1, #RedSectorSquares)
			_pickedZone = BlueSectorSquares[_choice]
			gcicap.red.cap.zone__name = _pickedZone
			dynaFRONT.log:info("RED CAP is targeting $1", _pickedZone)
		end
	end
	
	if forWho == "blue" or "BLUE"
	then
		if forTask == "CAS"
		then
			local _choice = mist._random(1, #RedSectorSquares)
			_pickedZone = RedSectorSquares[_choice]
			groundattack.blue.cas.zone__name = _pickedZone
			heloattack.blue.cas.zone__name = _pickedZone
			dynaFRONT.log:info("BLUE CAS is targeting $1", _pickedZone)
		end
		if forTask == "CAP"
		then
			local _choice = mist._random(1, #RedSectorSquares)
			_pickedZone = RedSectorSquares[_choice]
			gcicap.blue.cap.zone__name = _pickedZone
			dynaFRONT.log:info("BLUE CAP is targeting $1", _pickedZone)
		end
	end
end


function Create_Friendly_AWAC(_awacArea, fAwac_name)
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- based off of Kutaisi Intercept script by akp, but modified for my own use.
	local awaczone = trigger.misc.getZone(_awacArea)
	--local _rand = mist._random(1,Fighter__names)
	--fAwactask = 1  
	local _spawnPsn = {}
    local _movePsn = {}
    -- for i = 1, 1000 do
    _spawnPsn = mist.get_randPointInCircle(awaczone.point, awaczone.radius * 1.00)
	_movePsn = mist.get_randPointInCircle(awaczone.point, awaczone.radius * 2.00)
    --local InAwacZone = mist.pointInPolygon(_movePsn, mist.getGroupPoints('fAwacZone')) 
    -- if InAwacZone == true then break
    -- end
    -- end		
	trigger.action.activateGroup(Group.getBy_name(fAwac_name))
	awacgrp = Group.getBy_name(fAwac_name)
	
	-- what are these variable can we cerbose these more, no need to make them small
	local _init_wpSpeed = mist._random(450,500)
	local _wpSpeed = mist.utils.kmphToMps(_init_wpSpeed)
	local _wpAlt = mist._random(3000,4000)
	local _wpAlt2 = mist._random(6000,7000)
	local _wpPsn = mist.get_randPointInCircle(_spawnPsn, awaczone.radius * 0.15, awaczone.radius * 0.01)
	local _wpPsn2 = _movePsn
	local _path = {}
		_path[1] = mist.fixedWing.buildWP(_spawnPsn, _wpSpeed, _wpAlt, "BARO")
		_path[2] = mist.fixedWing.buildWP(_wpPsn2, _wpSpeed, _wpAlt2, "BARO")
        _path[1].task = {
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
							speed = _wpSpeed,
							altitude = _wpAlt2,
							speedEdited = true,
						}, -- end of params
					}, -- end of [2]
					[3] = {
						number = 3,
                        auto = false,
                        id = "WrappedAction",
                        enabled = true,
                        params = {
							action = {
								id = "SetFrequency",
                                params = {
									modulation = 0,
                                    frequency = 131000000,
                                }, -- end of ["params"]
                            }, -- end of ["action"]
                        }, -- end of ["params"]
                    }, -- end of [3]
                },
            },
        }
            
        --             _path[2].task = {
	    --     number = 1,
	    --    auto = false,
	    --    id = "Orbit",
	    --    enabled = true,
	    --    params = {
	    --      altitudeEdited = false,
	    --       pattern = "Circle",
	    --       speed = _wpSpeed,
	    --       altitude = _wpAlt,
	    --        speedEdited = true,
	    --      }, -- end of params
	    --  } -- end of [1]

	local _vars = {} 
		_vars.group_name = fAwac_name
		_vars.action = "respawn"
		_vars.point = _spawnPsn
		_vars.route = _path
		mist.teleportToPoint(_vars)			
  


	local _con = awacgrp:get_controller()
		_con:setOption(AI.Option.Air.id.RTB_ON_BINGO, false)
		_con:setOption(AI.Option.Air.id.RADAR_USING, AI.Option.Air._val.RADAR_USING.FOR__conTINUOUS_SEARCH)
		--_con:setOption(AI.Option.Air.id.ROE, AI.Option.Air._val.ROE.OPEN_FIRE_WEAPON_FREE)
		_con:setOption(AI.Option.Air.id.FLARE_USING, AI.Option.Air._val.FLARE_USING.AGAINST_FIRED_MISSILE)
		_con:setOption(AI.Option.Air.id.REACTION_ON_THREAT, AI.Option.Air._val.REACTION_ON_THREAT.EVADE_FIRE)
end
 
  	
function moveStuff(thisGroup_name, _randomizerDist, spd, team)	
	--local _randomizer_speed = 0
	--local _randomizer_dir = 0
	local _randomizer_dist = 0
	--local Infantry__name = {}
	local _name = thisGroup_name
	local _negativeHeading = mist._random(0,1) 
	--_randomizer_speed = math._random(1,4)
	-- red should be advancing north _randomly
	
	if team == "RED" then
		if _negativeHeading == 0
		then
			local _randomizer_dir = mist._random(0,60)
		end
		if _negativeHeading == 1
		then
			local _randomizer_dir = mist._random(300,360)
		end		
	end
		
		
	if team == "BLUE"
	then	
		-- blue should be advancing south _randomly
		local _randomizer_dir = mist._random(120,240)
	end
	
	--_randomizer_dir = _randomizer_dir * math.pi / 180
	_randomizer_dist = mist._random(_randomizerDist, _randomizerDist * 2)

	local formation_rand = mist._random(1,16)
			
	if formation_rand == 1
	then
		mist.group_randomDistSelf(_name, _randomizer_dist, 'Rank', _randomizer_dir, spd)
	elseif formation_rand == 2
	then
		mist.group_randomDistSelf(_name, _randomizer_dist, 'EchelonL', _randomizer_dir, spd)
	elseif formation_rand == 3
	then
		mist.group_randomDistSelf(_name, _randomizer_dist, 'EchelonR', _randomizer_dir, spd)
	elseif formation_rand == 4
	then
		mist.group_randomDistSelf(_name, _randomizer_dist, 'Vee', _randomizer_dir, spd)
	elseif formation_rand == 5
	then
		mist.group_randomDistSelf(_name, _randomizer_dist, '_cone', _randomizer_dir, spd)
	elseif formation_rand == 6
	then
		mist.group_randomDistSelf(_name, _randomizer_dist, 'Diamond', _randomizer_dir, spd)
	elseif formation_rand >= 7 and formation_rand <= 12
	then
		mist.group_randomDistSelf(_name, _randomizer_dist, 'Off Road', _randomizer_dir, spd)
	elseif formation_rand >= 12 and formation_rand <= 16
	then
		mist.group_randomDistSelf(_name, _randomizer_dist, 'On Road', _randomizer_dir, spd)
	end
end
	
function _random_markers(__minDistance, __maxDistance)
	decluster = mist._random(1,10) -- global used to _randomly decluster smoke marker schedule
	local _zonetouse = ""
	local _minDist = 0
	local _maxDist = 0
	local _minDist2 = 0
	local _maxDist2 = 0
	local _minDist3 = 0
	local _maxDist3 = 0
	local _unitPos = {}
	local _decision = ""
	local _unitsToUse = ""
	local _direction = 0
	local _delay = 0
	local _groupToUse = {}
	local _groupsInPlay = mist.DBs.dynGroupsAdded
	local _groupChoice = mist._random(1, #_groupsInPlay)
	_groupToUse = _groupsInPlay[_groupChoice]
	unittouse = Group.getBy_name(_groupToUse.group_name) 
	--_side = Group.getCoalition(_groupToUse.group_name)

	if unittouse == nil
	then
		--return
	end

	_minDist = __minDistance
	_maxDist = __maxDistance
	_minDist2 = _minDist + 7
	_maxDist2 = _maxDist + 7
	_minDist3 = _minDist + 14
	_maxDist3 = _maxDist + 14
	_direction = math._random(1,4)
	_delay = math._random(5,15)
	--local _side = gcicap._sideToCoalition(unittouse:getCoalition()) -- this is from the gcicapscript
	local _side = Group.getCoalition(unittouse)
	--trigger.action.outText("_side" .. _side, 1 , true)
	dynaFRONT.log:info("smoke marker for $1", _side)
	_unitPos = mist.getLeadPos(unittouse)

	if _unitPos == nil
	then
		--return
	end

	if _side == 1
	then
		-- if _direction == 1 then
        trigger.action.smoke({x=_unitPos.x + math._random(_minDist,_maxDist), y= land.getHeight({x = _unitPos.x, y = _unitPos.z}), z=_unitPos.z + math._random(_minDist,_maxDist)}, trigger.smokeColor.Red)
	end
end

function _random_markers2(__minDistance, __maxDistance)
	local _zonetouse = ""
	local _minDist = 0
	local _maxDist = 0
	local _minDist2 = 0
	local _maxDist2 = 0
	local _minDist3 = 0
	local _maxDist3 = 0
	local _unitPos = {}
	local _decision = ""
	local _unitsToUse = ""
	local _direction = 0
	local _delay = 0
	local _groupToUse = {}
	local _groupsInPlay = mist.DBs.dynGroupsAdded
	local _groupChoice = mist._random(1, #_groupsInPlay)
	_groupToUse = _groupsInPlay[_groupChoice]

	unittouse = Group.getBy_name(_groupToUse.group_name) 
	--_side = Group.getCoalition(_groupToUse.group_name)

	if unittouse == nil
	then
		return
	end

	_minDist = __minDistance
	_maxDist = __maxDistance
	_minDist2 = _minDist + 7
	_maxDist2 = _maxDist + 7
	_minDist3 = _minDist + 14
	_maxDist3 = _maxDist + 14
	_direction = math._random(1,4)
	_delay = math._random(5,15)

	--local _side = gcicap._sideToCoalition(unittouse:getCoalition()) -- this is from the gcicapscript
	local _side = Group.getCoalition(unittouse)
	--trigger.action.outText("_side" .. _side, 1 , true)
	dynaFRONT.log:info("Marker for $1", _side)
	_unitPos = mist.getLeadPos(unittouse)

	if _unitPos == nil
	then
		return
	end

	if _side == 2
	then
		-- if _direction == 1 then
		trigger.action.smoke({x=_unitPos.x + math._random(_minDist,_maxDist), y= land.getHeight({x = _unitPos.x, y = _unitPos.z}), z=_unitPos.z + math._random(_minDist,_maxDist)}, trigger.smokeColor.Blue)
	end
end


function ColorZones(routine, coalition_side)
	--trigger.action.markupToAll(numbr shapeId , number coalition , number id , vec3 point1 , any_valid param... , table color , table fillColor , number lineType , boolean readOnly, string message)
	--pos = table pos,
	--_name/id = string/number _name/id, 
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
	local _vars

	if routine == "ADD"
	then
		for i = 1, #RedSectorSquares
		do
			--colorID = colorID + 1
			coloredZoneID = colorID
			zoneInQuestion = RedSectorSquares[i]
			_vars = {
				pos = getQTpoints(zoneInQuestion),
				_name = "REDSEC",
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
			mist.marker.add(_vars)
			--trigger.action.outText(mist.utils.tableShow(zoneInQuestion), 25, true)
		end
	 
		for i = 1, #RedSRSAM_SectorSquares
		do
			--colorID = colorID + 1
			coloredZoneID = colorID
			zoneInQuestion = RedSRSAM_SectorSquares[i]
			_vars = {
				pos = getQTpoints(zoneInQuestion),
				_name = "REDSRSAM",
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
			mist.marker.add(_vars)
		end
	 
	 for i = 1, #RedLRSAM_SectorSquares
	 do
		--colorID = colorID + 1
		 coloredZoneID = colorID
		 zoneInQuestion = RedLRSAM_SectorSquares[i]
		   _vars = {
				pos = getQTpoints(zoneInQuestion),
				_name = "REDLRSAM", -- use our setup ID
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
			mist.marker.add(_vars)
		end
	 
	 for i = 1, #BlueSectorSquares
	 do
		 --colorID = colorID + 1
		 coloredZoneID = colorID
		 zoneInQuestion = BlueSectorSquares[i]
		   _vars = {
				pos = getQTpoints(zoneInQuestion),
				_name = "BLUESEC",  -- use our setup ID
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
			mist.marker.add(_vars)
		end
	 
	 for i = 1, #BlueSRSAM_SectorSquares
	 do
		-- colorID = colorID + 1
		 coloredZoneID = colorID
		 zoneInQuestion = BlueSRSAM_SectorSquares[i]
		   _vars = {
				pos = getQTpoints(zoneInQuestion),
				_name = "BLUESRSAM", -- use our setup ID
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
			mist.marker.add(_vars)
		end
	 
	 for i = 1, #BlueLRSAM_SectorSquares
	 do
		 --colorID = colorID + 1
		 coloredZoneID = colorID
		 zoneInQuestion = BlueLRSAM_SectorSquares[i]
		  _vars = {
				pos = getQTpoints(zoneInQuestion),
				_name = "BLUELRSAM", -- use our setup ID
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
			mist.marker.add(_vars)
		end
	end

	if routine == "REMOVE"
	then
		local _val = mist.marker.get('REDSEC')
		--mist.Marker.Remove(_val)
		local _val = mist.marker.get('BLUESEC')
		--mist.Marker.Remove(_val)
		local _val = mist.marker.get('REDLRSAM')
		--mist.Marker.Remove(_val)
		local _val = mist.marker.get('REDSRSAM')
		--mist.Marker.Remove(_val)
		local _val = mist.marker.get('BLUELRSAM')
		--mist.Marker.Remove(_val)
		local _val = mist.marker.get('BLUESRSAM')
		--mist.Marker.Remove(_val)
	end

	--mist.scheduleFunction(ColorZones, {"REMOVE"}, timer.getTime() + 2, 29) -- remove marks before updating test
	--mist.scheduleFunction(ColorZones, {"ADD"}, timer.getTime() + 3, 30)
	--mist.scheduleFunction(ColorZones, {"REMOVE"}, timer.getTime() + 9, 9) -- remove marks before updating test

end -- end function


function getQTpoints(zoneTable)
	local t = mist.DBs.zonesBy_name[zoneTable]
	local _copiedPoints = {}
	--local _copiedPoints = mist.utils.deepCopy(mist.utils.deepCopy(trigger.misc.getZone(zoneTable)))
	--local _copiedPoints = mist.utils.deepCopy(trigger.misc.getZone(zoneTable))


	for i = 1, #t.verticies
	do
		_copiedPoints[i] = t.verticies[i]
	end

	 --local _data = mist.utils.serialize("wtf", t)
	 -- local _data2 = mist.utils.serialize("wtf", _copiedPoints)
	 --trigger.action.outText(_data,50, true)
	 --trigger.action.outText(_data2,50, false)
	return _copiedPoints
end

function scoreDisplay()
	local _msg = {}
	_msg.text = 'BLUE SCORE IS ' .. BLUESCORE
	_msg.displayTime = 10
	_msg._msgFor = {coa = {'all'}} 
	mist.message.add(_msg)
	_msg = {}
	_msg.text = 'RED SCORE IS ' .. REDSCORE
	_msg.displayTime = 10
	_msg._msgFor = {coa = {'all'}} 
	mist.message.add(_msg)
	_msg = {}
end

determineForceLeaders()
	mist.scheduleFunction(BuildFARP, {"BLUE", "USA"}, timer.getTime() + 3)
	mist.scheduleFunction(BuildFARP, {"RED", "Russia"}, timer.getTime() + 6)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "AAA"}, timer.getTime() + 1, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "TANK"}, timer.getTime() + 2, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "APC"}, timer.getTime() + 3, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "INF"}, timer.getTime() + 4, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "CP"}, timer.getTime() + 5, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "SHORAD"}, timer.getTime() + 6, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "TRUCK"}, timer.getTime() + 7, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "LRSAM"}, timer.getTime() + 8, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "RED", "SRSAM"}, timer.getTime() + 9, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "AAA"}, timer.getTime() + 10, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "TANK"}, timer.getTime() + 11, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "APC"}, timer.getTime() + 12, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "INF"}, timer.getTime() + 13, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "CP"}, timer.getTime() + 14, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "SHORAD"}, timer.getTime() + 15, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "TRUCK"}, timer.getTime() + 16, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "LRSAM"}, timer.getTime() + 17, 30)
	mist.scheduleFunction(monitorGroup, {ActiveForces, "BLUE", "SRSAM"}, timer.getTime() + 18, 30)
	--mist.scheduleFunction(changePOI, {""}, timer.getTime() + 1, 300) -- change POI every 5 minutes after initial call
	mist.scheduleFunction(_random_markers, {50,250}, timer.getTime() + 10, updateMarkerSpeed + decluster)
	mist.scheduleFunction(_random_markers2, {50,250}, timer.getTime() + 10, updateMarkerSpeed + decluster)
	mist.scheduleFunction(scoreDisplay, {}, timer.getTime() + 70, 300) -- schedule the mission introduction after 4 se_conds of miz running.
	mist.scheduleFunction(ColorZones, {"ADD"}, timer.getTime() + 1)
	mist.scheduleFunction(Introduce_Mission, {}, timer.getTime() + 2) -- schedule the mission introduction after 4 se_conds of miz running.





