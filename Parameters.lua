-- START EDITABLE STUFF --
-- determines the amount of spawned stuff when creating the sides
--
-- NEW GRID BASED SECTOR MAPS
-- All Sectors follow this naming convention
-- XX##Square
-- All Polygon Restrictions by non-activated flight plans are
-- XX##Square
-- start blue zones


BlueSectorSquaresAmount = 7
BlueSectorSquares = {
[1] = 'KM57Square',
[2] = 'KM67Square',
[3] = 'KM78Square',
[4] = 'KM79Square',
[5] = 'KM89Square',
[6] = 'GG37Square',
[7] = 'KM99Square'
}

BlueLRSAM_SectorSquaresAmount = 1
BlueLRSAM_SectorSquares = {
[1] = 'FH84Square'
}

BlueSRSAM_SectorSquaresAmount = 2
BlueSRSAM_SectorSquares = {
[1] = 'GH21Square',
[2] = 'GG37Square'
}
-- end blue zones

-- start red zones
RedSectorSquaresAmount = 7
RedSectorSquares = {
[1] = 'KM77Square',
[2] = 'GG46Square',
[3] = 'KM56Square',
[4] = 'KM66Square',
[5] = 'KM86Square',
[6] = 'GG36Square',
[7] = 'KM98Square'
}

RedLRSAM_SectorSquaresAmount = 2
RedLRSAM_SectorSquares = {
[1] = 'GC10Square',
[2] = 'KM98Square'
}

RedSRSAM_SectorSquaresAmount = 4
RedSRSAM_SectorSquares = {
[1] = 'KM98Square',
[2] = 'KM86Square',
[3] = 'GG36Square',
[4] = 'GG33Square'
}
-- end red zones

-- START DYNAFRONT EDITABLE STUFF
-- END GROUNDATTACK, SEADATTACK and GCICAP options
--
--

 -- group template names for assets used
 
	--Blue_Group_Names = 1; -- amount of blue entries in the group names
	
	Blue_Names_AAA = {
	  [1] = 'Blue AAA Asset-1',
	  [2] = 'Blue AAA Asset-2',
	  [3] = 'Blue AAA Asset-3',
	  [4] = 'Blue AAA Asset-4',
	}
	
	Blue_Names_TRUCK = {
	  [1] = 'Blue TRUCK Asset-1',
	  [2] = 'Blue TRUCK Asset-2',
	  [3] = 'Blue TRUCK Asset-3',
	}
	
	Blue_Names_LRSAM = {
	  [1] = 'Blue LRSAM Asset-1',
	  [2] = 'Blue LRSAM Asset-2',
	}
	
	Blue_Names_SRSAM = {
	  [1] = 'Blue SRSAM Asset-1',
	  [2] = 'Blue SRSAM Asset-2',
	}
	
	Blue_Names_SHORAD = {
	  [1] = 'Blue SHORAD Asset-1',
	  [2] = 'Blue SHORAD Asset-2',
	}
	
	Blue_Names_APC = {
	  [1] = 'Blue APC Asset-1',
	  [2] = 'Blue APC Asset-2',
	  [3] = 'Blue APC Asset-3',
	}
	
	Blue_Names_TANK = {
	  [1] = 'Blue TANK Asset-1',
	  [2] = 'Blue TANK Asset-2',
	  [3] = 'Blue TANK Asset-3',
	}
	
	--Blue_Names_AF = {
	--  [1] = 'Blue AF Asset #000',
	--}
	
	Blue_Names_INF = {
	  [1] = 'Blue INF Asset-1',
	}
	
	Blue_Names_CP = {
	  [1] = 'Blue CP Asset-1',
	}
	
	
-- end Red template names
	
	--Red_Group_Names = 1; -- amount of red entries in the group names
	
	Red_Names_AAA = {
	  [1] = 'Red AAA Asset-1',
	  [2] = 'Red AAA Asset-2',
	  [3] = 'Red AAA Asset-3',
	  [4] = 'Red AAA Asset-4',
	}
	
	Red_Names_TRUCK = {
	  [1] = 'Red TRUCK Asset-1',
	  [2] = 'Red TRUCK Asset-2',
	  [3] = 'Red TRUCK Asset-3',
	}
	
	Red_Names_LRSAM = {
	  [1] = 'Red LRSAM Asset-1',
	  [2] = 'Red LRSAM Asset-2',
	}
	
	Red_Names_SRSAM = {
	  [1] = 'Red SRSAM Asset-1',
	  [2] = 'Red SRSAM Asset-2',
	}
	
	Red_Names_SHORAD = {
	  [1] = 'Red SHORAD Asset-1',
	  [2] = 'Red SHORAD Asset-2',
	}
	
	Red_Names_APC = {
	  [1] = 'Red APC Asset-1',
	  [2] = 'Red APC Asset-2',
	  [3] = 'Red APC Asset-3',
	  [4] = 'Red APC Asset-4',
	}
	
	Red_Names_TANK = {
	  [1] = 'Red TANK Asset-1',
	  [2] = 'Red TANK Asset-2',
	  [3] = 'Red TANK Asset-3',
	}
	
	--Red_Names_AF = {
	--  [1] = 'Red AF Asset #000',
	--}
	
	Red_Names_INF = {
	  [1] = 'Red INF Asset-1',
	}
	
	Red_Names_CP = {
	  [1] = 'Red CP Asset-1',
	}

updateMarkerSpeed = 60 -- 1 minute smoke marker update
--- Sets how verbose the log output will be.
-- Possible values are "none", "info", "warning" and "error".
-- I recommend "error" for production.
heloattack.log_level = "none"
groundattack.log_level = "none"
seadattack.log_level = "none"
gcicap.log_level = "none"
--- Interval, in seconds, of main function.
-- Default 30 seconds
heloattack.interval = 30
groundattack.interval = 30
seadattack.interval = 30
gcicap.interval = 30
--- Interval, in seconds, GCI flights get vectors on targets.
-- AI GCI flights don't use their radar, to be as stealth as
-- possible, relying on those vectors.
-- Default 15 seconds.
gcicap.vector_interval = 15
--- Initial spawn delay between planes
-- Default 30 seconds.
heloattack.initial_spawn_delay = 30
groundattack.initial_spawn_delay = 30
seadattack.initial_spawn_delay = 30
gcicap.initial_spawn_delay = 30
-- After inital spawn delay
heloattack.next_spawn_delay = 300
groundattack.next_spawn_delay = 300
seadattack.next_spawn_delay = 300
gcicap.next_spawn_delay = 300
---Minimum altitudes in meters.
-- Default 4500
heloattack.cas.min_alt = 100
groundattack.cas.min_alt = 300
seadattack.sead.min_alt = 1500
gcicap.cap.min_alt = 2500
--- Maximum altitudes in meters.
-- Default 7500
heloattack.cas.max_alt = 850
groundattack.cas.max_alt = 1500
seadattack.sead.max_alt = 4500
gcicap.cap.max_alt = 6000
--- Speed during their route
-- speed is in m/s. Default 220.
heloattack.cas.speed = 60
groundattack.cas.speed = 155
seadattack.sead.speed = 240
gcicap.cap.speed = 260
gcicap.gci.speed = 280
--- Maximum engage distance for flights as long as they are on patrol.
-- this might be overruled by an intercept vector given from
-- ground control (EWR) in the case of GCI. Default 15000.
heloattack.cas.max_engage_distance = 15000
groundattack.cas.max_engage_distance = 15000
seadattack.sead.max_engage_distance = 15000
gcicap.cap.max_engage_distance = 30000
--- Minimum red CAS VUL time in minutes.
-- Minimum time the red CAS flight will orbit on station.
heloattack.red.cas.vul_time_min = 25
groundattack.red.cas.vul_time_min = 25
seadattack.red.sead.vul_time_min = 25
gcicap.red.cap.vul_time_min = 25
--- Maximum red CAS VUL time in minutes.
-- Maximum time the red CAS flight will orbit on station.
heloattack.red.cas.vul_time_max = 40
groundattack.red.cas.vul_time_max = 40
seadattack.red.sead.vul_time_max = 40
gcicap.red.cap.vul_time_max = 40
--- Minimum blue CAS VUL time in minutes.
heloattack.blue.cas.vul_time_min = 25
groundattack.blue.cas.vul_time_min = 25
seadattack.blue.sead.vul_time_min = 25
gcicap.blue.cap.vul_time_min = 25
--- Maximum blue CAS VUL time in minutes.
heloattack.blue.cas.vul_time_max = 30
groundattack.blue.cas.vul_time_max = 30
seadattack.blue.sead.vul_time_max = 30
gcicap.blue.cap.vul_time_max = 30
--- Use race-track orbit for flights
-- If true will use a race-track pattern for orbit
-- between two points in the zone.
heloattack.cas.race_track_orbit = false
groundattack.cas.race_track_orbit = false
seadattack.sead.race_track_orbit = false
gcicap.cap.race_track_orbit = true
-- if race track orbit what is the minimum distance from center of the zone for the end waypoint in meters
heloattack.cas.orbit_end_min_dist = 2500 -- 2.5km
groundattack.cas.orbit_end_min_dist = 5000 -- 5km
seadattack.sead.orbit_end_min_dist = 5000 -- 5km 
gcicap.cap.orbit_end_min_dist = 20000 -- 20km
-- if race track orbit what is the maximum distance from center of the zone for the end waypoint in meters
heloattack.cas.orbit_end_max_dist = 10000 -- 10km
groundattack.cas.orbit_end_max_dist = 20000 -- 20km
seadattack.sead.orbit_end_max_dist = 20000 -- 20km 
gcicap.cap.orbit_end_max_dist = 35000 -- 35km
--- Enable/disable red flights airborne start.
-- set to true for flights to start airborne at script initialisation
-- (mission start), false for taking off from the airfield.
-- Default false. for the heloattack if airborne is set to true it will spawn above FARP location
heloattack.red.cas.start_airborne = true
groundattack.red.cas.start_airborne = false
seadattack.red.sead.start_airborne = false
gcicap.red.cap.start_airborne = false
--- Enable/disable blue CAS flights airborne start.
heloattack.blue.cas.start_airborne = true
groundattack.blue.cas.start_airborne = false
seadattack.blue.sead.start_airborne = false
gcicap.blue.cap.start_airborne = false
--- Amount of red patrol zones.
-- do not adjust with dyanFRONT as it pulls new zones via a function (leave at 1)
heloattack.red.cas.zones_count = 1
groundattack.red.cas.zones_count = 1
seadattack.red.sead.zones_count = 1
gcicap.red.cap.zones_count = 1
--- Amount of blue patrol zones.
heloattack.blue.cas.zones_count = 1
groundattack.blue.cas.zones_count = 1
seadattack.blue.sead.zones_count = 1
gcicap.blue.cap.zones_count = 1
--- Amount of red CAS groups concurrently in the air.
heloattack.red.cas.groups_count = 1
groundattack.red.cas.groups_count = 1
seadattack.red.sead.groups_count = 1
gcicap.red.cap.groups_count = 2
gcicap.red.gci.groups_count = 1
--- Amount of blue CAS groups concurrently in the air.
heloattack.blue.cas.groups_count = 1
groundattack.blue.cas.groups_count = 1
seadattack.blue.sead.groups_count = 1
gcicap.blue.cap.groups_count = 2
gcicap.blue.gci.groups_count = 1
--- Group size of red flights.
-- If "2" it consists of 2 planes, if "4" it consists of 4 planes
-- if "randomized", the CAS groups consist of either 2 or 4 planes
heloattack.red.cas.group_size = "2"
groundattack.red.cas.group_size = "2"
seadattack.red.sead.group_size = "2"
gcicap.red.cap.group_size = "randomized"
gcicap.red.gci.group_size = "2"
--- Group size of blue flights.
heloattack.blue.cas.group_size = "2"
groundattack.blue.cas.group_size = "2"
seadattack.blue.sead.group_size = "2"
gcicap.blue.cap.group_size = "randomized"
gcicap.blue.gci.group_size = "2"
--- How red flights are spawned.
-- can be "parking", "takeoff" or "air" and defines the way the fighters spawn
-- takeoff is NOT RECOMMENDED currently since their occur timing issues with tasking
-- if a flight is queued for takeoff and not already in the game world while getting tasked
-- Default 'parking'
heloattack.red.cas.spawn_mode = "air"
groundattack.red.cas.spawn_mode = "parking"
seadattack.red.sead.spawn_mode = "parking"
gcicap.red.cap.spawn_mode = "parking"
gcicap.red.gci.spawn_mode = "parking"
--- How blue flights are spawned.
heloattack.blue.cas.spawn_mode = "air"
groundattack.blue.cas.spawn_mode = "parking"
seadattack.blue.sead.spawn_mode = "parking"
gcicap.blue.cap.spawn_mode = "parking"
gcicap.blue.gci.spawn_mode = "parking"
--- Group size of red GCI flights.
-- Can be "2", "4" or "dynamic"
-- If "2" it consists of 2 planes, if "4" it consists of 4 planes
-- if "dynamic", the GCI groups consist of as much aircrafts
-- as the intruder group.
gcicap.red.gci.group_size = "2"
--- Group size of blue GCI flights.
-- See @{gcicap.red.gci.group_size}
gcicap.blue.gci.group_size = "2"
--- Enable/disable GCI messages for red
gcicap.red.gci.messages = true
--- Enable/disable GCI messages for blue
gcicap.blue.gci.messages = true
--- How long a GCI message will be shown in seconds.
gcicap.gci.message_time = 15
--- Display GCI messages with metric measurment for red.
-- If false the imperial system is used.
gcicap.red.gci.messages_metric = true
--- Display GCI messages with metric measurment for blue.
-- If false the imperial system is used.
gcicap.blue.gci.messages_metric = false
--- Names of red groups which will receive GCI messages.
-- Leave blank for all groups of coalition
-- @usage gcicap.red.gci.messages_to = { "my group 1", "GCI Flight" }
gcicap.red.gci.messages_to = {}
--- Names of blue groups which will receive GCI messages.
-- See @{gcicap.red.gci.messages_to} for format.
gcicap.blue.gci.messages_to = {}
--- Hide or reveal blue air units in the mission.
heloattack.blue.hide_groups = false
groundattack.blue.hide_groups = false
seadattack.blue.hide_groups = false
gcicap.blue.hide_groups = false
--- Hide or reveal red air units in the mission.
heloattack.red.hide_groups = false
groundattack.red.hide_groups = false
seadattack.red.hide_groups = false
gcicap.red.hide_groups = false
--- Enable/disable red flights.
heloattack.red.cas.enabled = true
groundattack.red.cas.enabled = true
seadattack.red.sead.enabled = true
gcicap.red.cap.enabled = true
gcicap.red.gci.enabled = true
--- Enable/disable blue flights.
heloattack.blue.cas.enabled = true
groundattack.blue.cas.enabled = true
seadattack.blue.sead.enabled = true
gcicap.blue.cap.enabled = true
gcicap.blue.gci.enabled = true
--- Enable/disable resource limitation for red.
-- If set to true limits the amount of groups a side can spawn.
heloattack.red.limit_resources = true
groundattack.red.limit_resources = true
seadattack.red.limit_resources = true
gcicap.red.limit_resources = true
--- Enable/disable resource limitation for blue.
heloattack.blue.limit_resources = true
groundattack.blue.limit_resources = true
seadattack.blue.limit_resources = true
gcicap.blue.limit_resources = true
--


--- Name of the trigger zone which defines red CAS zones.
-- This will be postfixed with the number of the zone in previous versions of GCICAP but this has been removed for dynaFRONT since it dynamically choose a zone with no .. # added to end of zone name.
-- Default: 'redCASzone'. set to a zone that is present at mission start
--heloattack.red.cas.zone_name = BlueSectorSquares[mist.random(1,#BlueSectorSquares)]
--groundattack.red.cas.zone_name = BlueSectorSquares[mist.random(1,#BlueSectorSquares)]
--seadattack.red.sead.zone_name = BlueLRSAM_SectorSquares[mist.random(1,#BlueLRSAM_SectorSquares)]
--gcicap.red.cap.zone_name =- RedLRSAM_SectorSquares[mist.random(1,#RedLRSAM_SectorSquares)]
heloattack.red.cas.zone_name = 'CAS'
groundattack.red.cas.zone_name = 'CAS'
seadattack.red.sead.zone_name = 'SEADREDTARGET'
gcicap.red.cap.zone_name = 'CAP'
--- Name of the trigger zone which defines blue zones.
-- Default: 'blueCASzone'.
--heloattack.blue.cas.zone_name = RedSectorSquares[mist.random(1,#RedSectorSquares)]
--groundattack.blue.cas.zone_name = RedSectorSquares[mist.random(1,#RedSectorSquares)]
--seadattack.blue.sead.zone_name = RedLRSAM_SectorSquares[mist.random(1,#RedLRSAM_SectorSquares)]
--gcicap.blue.cap.zone_name = BlueLRSAM_SectorSquares[mist.random(1,#BlueLRSAM_SectorSquares)]
heloattack.blue.cas.zone_name = 'CAS'
groundattack.blue.cas.zone_name = 'CAS'
seadattack.blue.sead.zone_name = 'SEADBLUETARGET'
gcicap.blue.cap.zone_name = 'CAP'
--- Name of group which waypoints define the red border.
-- Default: 'redborder'.
gcicap.red.border_group = 'redborder'
--- Name of group which waypoints define the blue border.
-- Default: 'blueborder'.
gcicap.blue.border_group = 'blueborder'
--- CAS template unit's names prefix.
heloattack.cas.template_prefix = '__HELO__'
groundattack.cas.template_prefix = '__CAS__'
seadattack.sead.template_prefix = '__SEAD__'
gcicap.cap.template_prefix = '__CAP__'
gcicap.gci.template_prefix = '__GCI__'
--- Count of template units.
-- Remember that this means you need that many
-- template units for each type.
heloattack.template_count = 2
groundattack.template_count = 3
seadattack.template_count = 6
gcicap.template_count = 5
--- Wether red will also acquire targets by AWACS aircraft.
-- This is is currently broken since isTargetDetected doesn't
-- seem to work with AWACS airplanes. Needs a workaround.
-- Default false.
heloattack.red.awacs = false
groundattack.red.awacs = false
seadattack.red.awacs = false
gcicap.red.awacs = false
--- Wether blue will also acquire targets by AWACS aircraft.
-- @see groundattack.red.awacs
heloattack.blue.awacs = false
groundattack.blue.awacs = false
seadattack.blue.awacs = false
gcicap.blue.awacs = false
--- Garbage collector move timeout
-- If a unit (aircraft) is on the ground and didn't move
-- since this timeout, in seconds, it will be removed.
-- This applies only to aircraft spawned by SEADCAS.
heloattack.move_timeout = 300
groundattack.move_timeout = 300
seadattack.move_timeout = 300
gcicap.move_timeout = 300
-- shortcut to the bullseye
-- END EDITABLE FOR GROUNDATTACK/SEADATTACK and GCICAP
heloattack.red.bullseye = coalition.getMainRefPoint(coalition.side.RED)
groundattack.red.bullseye = coalition.getMainRefPoint(coalition.side.RED)
seadattack.red.bullseye = coalition.getMainRefPoint(coalition.side.RED)
gcicap.red.bullseye = coalition.getMainRefPoint(coalition.side.RED)
groundattack.blue.bullseye = coalition.getMainRefPoint(coalition.side.BLUE)
seadattack.blue.bullseye = coalition.getMainRefPoint(coalition.side.BLUE)
gcicap.blue.bullseye = coalition.getMainRefPoint(coalition.side.BLUE)

heloattack.sides = { "red", "blue" }
groundattack.sides = { "red", "blue" }
seadattack.sides = { "red", "blue" }
gcicap.sides = { "red", "blue" }

heloattack.tasks = { "cas" }
groundattack.tasks = { "cas" }
seadattack.tasks = { "sead" }
gcicap.tasks = { "cap", "gci" }

heloattack.log = mist.Logger:new("GROUNDATTACK", groundattack.log_level)
groundattack.log = mist.Logger:new("GROUNDATTACK", groundattack.log_level)
seadattack.log = mist.Logger:new("SEADATTACK", groundattack.log_level)
gcicap.log = mist.Logger:new("GCICAP", groundattack.log_level)

