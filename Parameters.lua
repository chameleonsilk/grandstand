-- version 1.04
-- START EDITABLE STUFF --
-- determines the amount of spawned stuff when creating the sides
--

GROUND_RESPAWN_DELAY = 600 -- 10 minutes for normal ground stuff
GROUND_RESPAWN_DELAY = 3600 -- 1 hour for SAMs
DISBAND_PERCENT = 50 -- when a group is this hurt it is removed
DISBAND_SAM_PERCENT = 80 -- when a group is this hurt it is removed for SAMS
-- NEW GRID BASED SECTOR MAPS
-- All Sectors follow this naming convention
-- XX##Square
-- All Polygon Restrictions by non-activated flight plans are
-- XX##Square
-- start blue zones

MasterList = {
[1] = 'KM56Square',
[2] = 'KM58Square',
[3] = 'KM66Square',
[4] = 'KM68Square',
[5] = 'KM77Square',
[6] = 'KM78Square',
[7] = 'KM79Square',
[8] = 'KM86Square',
[9] = 'KM88Square',
[10] = 'KM89Square',
[11] = 'KM97Square',
[12] = 'KM98Square',
[13] = 'KM99Square',
[14] = 'GC10Square',
[15] = 'GG33Square',
[16] = 'GG36Square',
[17] = 'GG37Square',
[18] = 'FH84Square',
[19] = 'GH21Square',
[20] = 'GG46Square',
[21] = 'KM56Square',
[22] = 'EHSquare',
[23] = 'FHSquare',
[24] = 'FGSquare',
[25] = 'EGSquare',
[26] = 'GGSquare',
[27] = 'GHSquare'
}

MasterList = {
[1] = 'FF67',
[2] = 'FF68',
[3] = 'FF69',
[4] = 'FG60',
[5] = 'FG61', 
[6] = 'FG62',
[7] = 'FG63',
[8] = 'FG64',
[9] = 'FG65',
[10] = 'FG66',
[11] = 'FG67',
[12] = 'FG68',
[13] = 'FG69',
[14] = 'FH60',
[15] = 'FH61',
[16] = 'FH62',
[17] = 'FH63',
[18] = 'FH64',

[19] = 'FF77',
[20] = 'FF78',
[21] = 'FF79',
[22] = 'FG70',
[23] = 'FG71', 
[24] = 'FG72',
[25] = 'FG73',
[26] = 'FG74',
[27] = 'FG75',
[28] = 'FG76',
[29] = 'FG77',
[30] = 'FG78',
[31] = 'FG79',
[32] = 'FH70',
[33] = 'FH71',
[34] = 'FH72',
[35] = 'FH73',
[36] = 'FH74',

[37] = 'FF88',
[38] = 'FF89',
[39] = 'FG80',
[40] = 'FG81', 
[41] = 'FG82',
[42] = 'FG83',
[43] = 'FG84',
[44] = 'FG85',
[45] = 'FG86',
[46] = 'FG87',
[47] = 'FG88',
[48] = 'FG89',
[49] = 'FH80',
[50] = 'FH81',
[51] = 'FH82',
[52] = 'FH83',
[53] = 'FH84',

[54] = 'FF98',
[55] = 'FF99',
[56] = 'FG90',
[57] = 'FG91', 
[58] = 'FG92',
[59] = 'FG93',
[60] = 'FG94',
[61] = 'FG95',
[62] = 'FG96',
[63] = 'FG97',
[64] = 'FG98',
[65] = 'FG99',
[66] = 'FH90',
[67] = 'FH91',
[68] = 'FH92',
[69] = 'FH93',
[70] = 'FH94',

[71] = 'GF08',
[72] = 'GF09',
[73] = 'GG00',
[74] = 'GG01', 
[75] = 'GG02',
[76] = 'GG03',
[77] = 'GG04',
[78] = 'GG05',
[79] = 'GG06',
[80] = 'GG07',
[81] = 'GG08',
[82] = 'GG09',
[83] = 'GH00',
[84] = 'GH01',
[85] = 'GH02',
[86] = 'GH03',
[87] = 'GH04',

[88] = 'GG10',
[89] = 'GG11', 
[90] = 'GG12',
[91] = 'GG13',
[92] = 'GG14',
[93] = 'GG15',
[94] = 'GG16',
[95] = 'GG17',
[96] = 'GG18',
[97] = 'GG19',
[98] = 'GH10',
[99] = 'GH11',
[100] = 'GH12',
[101] = 'GH13',
[102] = 'GH14',

[103] = 'GG20',
[104] = 'GG21',
[105] = 'GG22', 
[106] = 'GG23',
[107] = 'GG24',
[108] = 'GG25',
[109] = 'GG26',
[110] = 'GG27',
[111] = 'GG28',
[112] = 'GG29',
[113] = 'GH20',
[114] = 'GH21',
[115] = 'GH22',
[116] = 'GH23',


[117] = 'GG32', 
[118] = 'GG33',
[119] = 'GG34',
[120] = 'GG35',
[121] = 'GG36',
[122] = 'GG37',
[123] = 'GG38',
[124] = 'GG39',
[125] = 'GH30',
[126] = 'GH31',
[127] = 'GH32',

[128] = 'GG43',
[129] = 'GG44',
[130] = 'GG45',
[131] = 'GG46',
[132] = 'GG47',
[133] = 'GG48',
[134] = 'GG49',
[135] = 'GH40',
[136] = 'GH41',
[137] = 'GH42',

[138] = 'KM54',
[139] = 'KM55',
[140] = 'KM56',
[141] = 'KM57',
[142] = 'KM58',
[143] = 'KM59',
[144] = 'KN50',
[145] = 'KN51',
[146] = 'KN52',

[147] = 'KM65',
[148] = 'KM66',
[149] = 'KM67',
[150] = 'KM68',
[151] = 'KM69',
[152] = 'KN60',
[153] = 'KN61',
[154] = 'KN62',

[155] = 'KM75',
[156] = 'KM76',
[157] = 'KM77',
[158] = 'KM78',
[159] = 'KM79',
[160] = 'KN70',
[161] = 'KN71',

[162] = 'KM86',
[163] = 'KM87',
[164] = 'KM88',
[165] = 'KM89',
[166] = 'KN80',

[167] = 'KM96',
[168] = 'KM97',
[169] = 'KM98',
[170] = 'KM99'
}

SeaList = {
[1] = 'FF66',
[2] = 'FH65',
[3] = 'FH66',
[4] = 'FH56',
[5] = 'FH55',
[6] = 'FH54',
[7] = 'FH53',
[8] = 'FH52',
[9] = 'FH51',
[10] = 'FH50',
[11] = 'FG59',
[12] = 'FG58',
[13] = 'FG57',
[14] = 'FG56',
[15] = 'FG55',
[16] = 'FG54',
[17] = 'FG53',
[18] = 'FG52',
[19] = 'FG51',
[20] = 'FG50',
[21] = 'FF59',
[22] = 'FF58',
[23] = 'FF57',
[24] = 'FF56',
[25] = 'FF55',

[26] = 'FH47',
[27] = 'FH46',
[28] = 'FH45',
[29] = 'FH44',
[30] = 'FH43',
[31] = 'FH42',
[32] = 'FH41',
[33] = 'FH40',
[34] = 'FG49',
[35] = 'FG48',
[36] = 'FG47',
[37] = 'FG46',
[38] = 'FG45',
[39] = 'FG44',
[40] = 'FG43',
[41] = 'FG42',
[42] = 'FG41',
[43] = 'FG40',
[44] = 'FF49',
[45] = 'FF48',
[46] = 'FF47',
[47] = 'FF46',

[48] = 'FH37',
[49] = 'FH36',
[50] = 'FH35',
[51] = 'FH34',
[52] = 'FH33',
[53] = 'FH32',
[54] = 'FH31',
[55] = 'FH30',
[56] = 'FG39',
[57] = 'FG38',
[58] = 'FG37',
[59] = 'FG36',
[60] = 'FG35',
[61] = 'FG34',
[62] = 'FG33',
[63] = 'FG32',
[64] = 'FG31',
[65] = 'FG30',
[66] = 'FF39',
[67] = 'FF38',
[68] = 'FF37',
[69] = 'FF36',
[70] = 'FF35',

[71] = 'FH27',
[72] = 'FH26',
[73] = 'FH25',
[74] = 'FH24',
[75] = 'FH23',
[76] = 'FH22',
[77] = 'FH21',
[78] = 'FH20',
[79] = 'FG29',
[80] = 'FG28',
[81] = 'FG27',
[82] = 'FG26',
[83] = 'FG25',
[84] = 'FG24',
[85] = 'FG23',
[86] = 'FG22',
[87] = 'FG21',
[88] = 'FG20',
[89] = 'FF29',
[90] = 'FF28',
[91] = 'FF27',
[92] = 'FF26',
[93] = 'FF25',
[94] = 'FF24',

[95] = 'FH17',
[96] = 'FH16',
[97] = 'FH15',
[98] = 'FH14',
[99] = 'FH13',
[100] = 'FH12',
[101] = 'FH11',
[102] = 'FH10',
[103] = 'FG19',
[104] = 'FG18',
[105] = 'FG17',
[106] = 'FG16',
[107] = 'FG15',
[108] = 'FG14',
[109] = 'FG13',
[110] = 'FG12',
[111] = 'FG11',
[112] = 'FG10',
[113] = 'FF19',
[114] = 'FF18',
[115] = 'FF17',
[116] = 'FF16',
[117] = 'FF15',
[118] = 'FF14',

[119] = 'FH07',
[120] = 'FH06',
[121] = 'FH05',
[122] = 'FH04',
[123] = 'FH03',
[124] = 'FH02',
[125] = 'FH01',
[126] = 'FH00',
[127] = 'FG09',
[128] = 'FG08',
[129] = 'FG07',
[130] = 'FG06',
[131] = 'FG05',
[132] = 'FG04',
[133] = 'FG03',
[134] = 'FG02',
[135] = 'FG01',
[136] = 'FG00',
[137] = 'FF09',
[138] = 'FF08',
[139] = 'FF07',
[140] = 'FF06',
[141] = 'FF05',
[142] = 'FF04',
[143] = 'FF03',

[144] = 'FF45'
}






--BlueSectorSquaresAmount = 7
BlueSectorSquares = {
[1] = 'KM58',
[2] = 'KM68',
[3] = 'KM78',
[4] = 'KM79',
[5] = 'KM89',
[6] = 'GG37',
[7] = 'KM99'
}

--BlueLRSAM_SectorSquaresAmount = 1
BlueLRSAM_SectorSquares = {
[1] = 'FH84'
}

--BlueSRSAM_SectorSquaresAmount = 2
BlueSRSAM_SectorSquares = {
[1] = 'GH21',
[2] = 'GG37',
[3] = 'KM58'
}

BlueTRUCK_SectorSquares = {
[1] = 'GH21',
[2] = 'GG37',
[3] = 'FH84'
}

BlueNAVAL_SectorSquares = {
[1] = 'FH07',
[2] = 'FH17',
[3] = 'FH27',
[4] = 'FH06',
[5] = 'FH16',
[6] = 'FH26',
[7] = 'FH36',
[8] = 'FH46',
[8] = 'FH56'
}

BlueSHALLOWNAVAL_SectorSquares = {
[1] = 'GG18',
[2] = 'GG08',
[3] = 'GG09',
[4] = 'FG99',
[5] = 'FG98'
}

-- end blue zones

-- start red zones
RedSectorSquares = {
[1] = 'KM77',
[2] = 'GG46',
[3] = 'KM56',
[4] = 'KM66',
[5] = 'KM88',
[6] = 'KM86',
--[x] = 'GG36Square',
[7] = 'KM98',
[8] = 'KM97'
}


RedLRSAM_SectorSquares = {
[1] = 'GG10',
[2] = 'KM98'
}


RedSRSAM_SectorSquares = {
[1] = 'KM98',
[2] = 'KM86',
[3] = 'GG36',
[4] = 'GG33',
[5] = 'KM96'
}

--currently places with SAM areas
RedTRUCK_SectorSquares = {
[1] = 'KM98',
[2] = 'KM86',
[3] = 'GG36',
[4] = 'GG33',
[5] = 'GC10',
[6] = 'KM98'
}

RedNAVAL_SectorSquares = {
[1] = 'FF35',
[2] = 'FF25',
[3] = 'FF15',
[4] = 'FF05',
[5] = 'FF04',
[6] = 'FF14',
[7] = 'FF24',
[8] = 'FF03'
}

RedSHALLOWNAVAL_SectorSquares = {
[1] = 'GG14',
[2] = 'GG15',
[3] = 'GG16',
[4] = 'GG24',
[5] = 'GG25'
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
	
	Blue_Naval_SHIPS = {
	[1] = 'Blue Naval Asset-1',
	[2] = 'Blue Naval Asset-2',
	[3] = 'Blue Naval Asset-3'
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
	
	Red_Naval_SHIPS = {
	[1] = 'Red Naval Asset-1',
	[2] = 'Red Naval Asset-2',
	[3] = 'Red Naval Asset-3'
	}
	
	

updateMarkerSpeed = 30 -- 30sec smoke marker update
--- Interval, in seconds, of main function.
-- Default 30 seconds
heloattack.interval = 30
groundattack.interval = 30
seadattack.interval = 30
gcicap.interval = 30
bmbrstrike.interval = 30
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
bmbrstrike.initial_spawn_delay = 30
-- After inital spawn delay
heloattack.next_spawn_delay = 900 -- 15 minute helo delay between respawning groups
groundattack.next_spawn_delay = 900 -- 15 minute ground attack delay between respawning groups
seadattack.next_spawn_delay = 900 -- 15 minute SEAD delay between respawning groups
gcicap.next_spawn_delay = 900 -- 15 minute CAP/GCI delay between respawning groups
bmbrstrike.next_spawn_delay = 900 -- 15 minute CAP/GCI delay between respawning groups
---Minimum altitudes in meters.
-- Default 4500
heloattack.cas.min_alt = 90
groundattack.cas.min_alt = 2500
seadattack.sead.min_alt = 2500
gcicap.cap.min_alt = 4000
bmbrstrike.bomb.min_alt = 5000
--- Maximum altitudes in meters.
-- Default 7500
heloattack.cas.max_alt = 1000
groundattack.cas.max_alt = 3500
seadattack.sead.max_alt = 5000
gcicap.cap.max_alt = 6000
bmbrstrike.bomb.max_alt = 7000
--- Speed during their route
-- speed is in m/s. Default 220.
heloattack.cas.speed = 60
groundattack.cas.speed = 155
seadattack.sead.speed = 240
gcicap.cap.speed = 260
gcicap.gci.speed = 280
bmbrstrike.bomb.speed = 190
--- Maximum engage distance for flights as long as they are on patrol.
-- this might be overruled by an intercept vector given from
-- ground control (EWR) in the case of GCI. Default 15000.
heloattack.cas.max_engage_distance = 25000
groundattack.cas.max_engage_distance = 50000
seadattack.sead.max_engage_distance = 25000
gcicap.cap.max_engage_distance = 20000
bmbrstrike.bomb.max_engage_distance = 999999
--- Minimum red CAS VUL time in minutes.
-- Minimum time the red CAS flight will orbit on station.
heloattack.red.cas.vul_time_min = 25
groundattack.red.cas.vul_time_min = 25
seadattack.red.sead.vul_time_min = 25
gcicap.red.cap.vul_time_min = 25
bmbrstrike.red.bomb.vul_time_min = 25
--- Maximum red CAS VUL time in minutes.
-- Maximum time the red CAS flight will orbit on station.
heloattack.red.cas.vul_time_max = 40
groundattack.red.cas.vul_time_max = 40
seadattack.red.sead.vul_time_max = 40
gcicap.red.cap.vul_time_max = 40
bmbrstrike.red.bomb.vul_time_max = 40
--- Minimum blue CAS VUL time in minutes.
heloattack.blue.cas.vul_time_min = 25
groundattack.blue.cas.vul_time_min = 25
seadattack.blue.sead.vul_time_min = 25
gcicap.blue.cap.vul_time_min = 25
bmbrstrike.blue.bomb.vul_time_min = 25
--- Maximum blue CAS VUL time in minutes.
heloattack.blue.cas.vul_time_max = 30
groundattack.blue.cas.vul_time_max = 30
seadattack.blue.sead.vul_time_max = 30
gcicap.blue.cap.vul_time_max = 30
bmbrstrike.blue.bomb.vul_time_max = 25
--- Use race-track orbit for flights
-- If true will use a race-track pattern for orbit
-- between two points in the zone.
heloattack.cas.race_track_orbit = false
groundattack.cas.race_track_orbit = false
seadattack.sead.race_track_orbit = false
gcicap.cap.race_track_orbit = true
bmbrstrike.bomb.race_track_orbit = true
-- if race track orbit what is the minimum distance from center of the zone for the end waypoint in meters
heloattack.cas.orbit_end_min_dist = 2500 -- 2.5km
groundattack.cas.orbit_end_min_dist = 5000 -- 5km
seadattack.sead.orbit_end_min_dist = 5000 -- 5km 
gcicap.cap.orbit_end_min_dist = 20000 -- 20km
bmbrstrike.bomb.orbit_end_min_dist = 20000 -- 20km
-- if race track orbit what is the maximum distance from center of the zone for the end waypoint in meters
heloattack.cas.orbit_end_max_dist = 10000 -- 10km
groundattack.cas.orbit_end_max_dist = 20000 -- 20km
seadattack.sead.orbit_end_max_dist = 20000 -- 20km 
gcicap.cap.orbit_end_max_dist = 35000 -- 35km
bmbrstrike.bomb.orbit_end_max_dist = 20000 -- 20km
--- Enable/disable red flights airborne start.
-- set to true for flights to start airborne at script initialisation
-- (mission start), false for taking off from the airfield.
-- Default false. for the heloattack if airborne is set to true it will spawn above FARP location
heloattack.red.cas.start_airborne = true
groundattack.red.cas.start_airborne = false
seadattack.red.sead.start_airborne = false
gcicap.red.cap.start_airborne = false
bmbrstrike.red.bomb.start_airborne = false
--- Enable/disable blue CAS flights airborne start.
heloattack.blue.cas.start_airborne = true
groundattack.blue.cas.start_airborne = false
seadattack.blue.sead.start_airborne = false
gcicap.blue.cap.start_airborne = false
bmbrstrike.blue.bomb.start_airborne = false
--- Amount of red patrol zones.
-- do not adjust with dyanFRONT as it pulls new zones via a function (leave at 1)
heloattack.red.cas.zones_count = 1
groundattack.red.cas.zones_count = 1
seadattack.red.sead.zones_count = 1
gcicap.red.cap.zones_count = 1
bmbrstrike.red.bomb.zones_count = 1
--- Amount of blue patrol zones.
heloattack.blue.cas.zones_count = 1
groundattack.blue.cas.zones_count = 1
seadattack.blue.sead.zones_count = 1
gcicap.blue.cap.zones_count = 1
bmbrstrike.blue.bomb.zones_count = 1
--- Amount of red CAS groups concurrently in the air.
heloattack.red.cas.groups_count = 1
groundattack.red.cas.groups_count = 2
seadattack.red.sead.groups_count = 1
gcicap.red.cap.groups_count = 2
gcicap.red.gci.groups_count = 1
bmbrstrike.red.bomb.groups_count = 1
--- Amount of blue CAS groups concurrently in the air.
heloattack.blue.cas.groups_count = 1
groundattack.blue.cas.groups_count = 2
seadattack.blue.sead.groups_count = 1
gcicap.blue.cap.groups_count = 2
gcicap.blue.gci.groups_count = 1
bmbrstrike.blue.bomb.groups_count = 1
--- Group size of red flights.
-- If "2" it consists of 2 planes, if "4" it consists of 4 planes
-- if "randomized", the CAS groups consist of either 2 or 4 planes, for GCI use dynamic to match interceptors launched to target size (gci can't use randomized)
heloattack.red.cas.group_size = "2"
groundattack.red.cas.group_size = "randomized"
seadattack.red.sead.group_size = "2"
gcicap.red.cap.group_size = "randomized"
gcicap.red.gci.group_size = "dynamic"
bmbrstrike.red.bomb.group_size = "2"
--- Group size of blue flights.
heloattack.blue.cas.group_size = "2"
groundattack.blue.cas.group_size = "randomized"
seadattack.blue.sead.group_size = "2"
gcicap.blue.cap.group_size = "randomized"
gcicap.blue.gci.group_size = "dynamic"
bmbrstrike.blue.bomb.group_size = "2"
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
bmbrstrike.red.bomb.spawn_mode = "parking"
--- How blue flights are spawned.
heloattack.blue.cas.spawn_mode = "air"
groundattack.blue.cas.spawn_mode = "parking"
seadattack.blue.sead.spawn_mode = "parking"
gcicap.blue.cap.spawn_mode = "parking"
gcicap.blue.gci.spawn_mode = "parking"
bmbrstrike.blue.bomb.spawn_mode = "parking"
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
bmbrstrike.blue.hide_groups = false
--- Hide or reveal red air units in the mission.
heloattack.red.hide_groups = false
groundattack.red.hide_groups = false
seadattack.red.hide_groups = false
gcicap.red.hide_groups = false
bmbrstrike.red.hide_groups = false
--- Enable/disable red flights.
heloattack.red.cas.enabled = true
groundattack.red.cas.enabled = true
seadattack.red.sead.enabled = true
gcicap.red.cap.enabled = true
gcicap.red.gci.enabled = true
bmbrstrike.red.bomb.enabled = true
--- Enable/disable blue flights.
heloattack.blue.cas.enabled = true
groundattack.blue.cas.enabled = true
seadattack.blue.sead.enabled = true
gcicap.blue.cap.enabled = true
gcicap.blue.gci.enabled = true
bmbrstrike.blue.bomb.enabled = true
--- Enable/disable resource limitation for red.
-- If set to true limits the amount of groups a side can spawn.
heloattack.red.limit_resources = true
groundattack.red.limit_resources = true
seadattack.red.limit_resources = true
gcicap.red.limit_resources = true
bmbrstrike.red.limit_resources = true
--- Enable/disable resource limitation for blue.
heloattack.blue.limit_resources = true
groundattack.blue.limit_resources = true
seadattack.blue.limit_resources = true
gcicap.blue.limit_resources = true
bmbrstrike.blue.limit_resources = true
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
bmbrstrike.red.bomb.zone_name = 'CAS'
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
bmbrstrike.blue.bomb.zone_name = 'CAS'
seadattack.blue.sead.zone_name = 'SEADBLUETARGET'
gcicap.blue.cap.zone_name = 'CAP'
--- Name of group which waypoints define the red border.
-- Default: 'redborder'.
gcicap.red.border_group = 'redborder'
--- Name of group which waypoints define the blue border.
-- Default: 'blueborder'.
gcicap.blue.border_group = 'blueborder'
heloattack.template_count = 2
groundattack.template_count = 3
seadattack.template_count = 2
gcicap.template_count = 3
bmbrstrike.template_count = 2
--- Wether red will also acquire targets by AWACS aircraft.
-- This is is currently broken since isTargetDetected doesn't
-- seem to work with AWACS airplanes. Needs a workaround.
-- Default false.
heloattack.red.awacs = false
groundattack.red.awacs = false
seadattack.red.awacs = false
gcicap.red.awacs = false
bmbrstrike.red.awacs = false
--- Wether blue will also acquire targets by AWACS aircraft.
-- @see groundattack.red.awacs
heloattack.blue.awacs = false
groundattack.blue.awacs = false
seadattack.blue.awacs = false
gcicap.blue.awacs = false
bmbrstrike.blue.awacs = false
--- Garbage collector move timeout
-- If a unit (aircraft) is on the ground and didn't move
-- since this timeout, in seconds, it will be removed.
-- This applies only to aircraft spawned by SEADCAS.
heloattack.move_timeout = 300
groundattack.move_timeout = 300
seadattack.move_timeout = 300
gcicap.move_timeout = 300
bmbrstrike.move_timeout = 800
-- shortcut to the bullseye
-- END EDITABLE FOR GROUNDATTACK/SEADATTACK and GCICAP
heloattack.red.bullseye = coalition.getMainRefPoint(coalition.side.RED)
groundattack.red.bullseye = coalition.getMainRefPoint(coalition.side.RED)
seadattack.red.bullseye = coalition.getMainRefPoint(coalition.side.RED)
gcicap.red.bullseye = coalition.getMainRefPoint(coalition.side.RED)
bmbrstrike.red.bullseye = coalition.getMainRefPoint(coalition.side.BLUE)
groundattack.blue.bullseye = coalition.getMainRefPoint(coalition.side.BLUE)
seadattack.blue.bullseye = coalition.getMainRefPoint(coalition.side.BLUE)
gcicap.blue.bullseye = coalition.getMainRefPoint(coalition.side.BLUE)
bmbrstrike.blue.bullseye = coalition.getMainRefPoint(coalition.side.BLUE)

heloattack.sides = { "red", "blue" }
groundattack.sides = { "red", "blue" }
seadattack.sides = { "red", "blue" }
gcicap.sides = { "red", "blue" }
bmbrstrike.sides = { "red", "blue" }

heloattack.tasks = { "cas" }
groundattack.tasks = { "cas" }
seadattack.tasks = { "sead" }
bmbrstrike.tasks = { "bomb" }
gcicap.tasks = { "cap", "gci" }


--- Sets how verbose the log output will be.
-- Possible values are "none", "info", "warning" and "error".
-- I recommend "error" for production.
heloattack.log_level = "none"
groundattack.log_level = "none"
seadattack.log_level = "none"
gcicap.log_level = "none"
bmbrstrike.log_level = "none"

heloattack.log = mist.Logger:new("GROUNDATTACK", groundattack.log_level)
groundattack.log = mist.Logger:new("GROUNDATTACK", groundattack.log_level)
seadattack.log = mist.Logger:new("SEADATTACK", groundattack.log_level)
gcicap.log = mist.Logger:new("GCICAP", groundattack.log_level)
bmbrstrike.log = mist.Logger:new("BMBRSTRIKE", bmbrstrike.log_level)



