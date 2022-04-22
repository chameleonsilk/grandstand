-- version 1.04
function determineForceLeaders()

if blueLeader.id == 1 then
blueLeader.name = "VLADIMIR PUTIN"
blueLeader.info = "Favors SAMS but lacking in other areas"
blueLeader.finfo1 = "GROUND:    ##"
blueLeader.finfo2 = "DEFENSES:  #####"
blueLeader.finfo3 = "LOGISTICS: ###"
blueLeader.finfo4 = "AIRFORCE:  ####"
blueLeader.access = "russia"
-- blue group amounts based on location
bAAAamount = 5
bTRUCKamount = 4
bSHORADamount = 4
bTANKamount = 6
bAPCamount = 6
bINFamount = 6
bSRSAMamount = 5
bLRSAMamount = 5
bCPamount = 3
bNAVYamount = 4
bNAVYSTATICamount = 1
heloattack.blue.supply = 40
groundattack.blue.supply = 40
seadattack.blue.supply = 40
gcicap.blue.supply = 40
bmbrstrike.blue.supply = 40
--
heloattack.cas.template_prefix.blue = '__HELOUSSR__'
groundattack.cas.template_prefix.blue = '__CASUSSR__'
seadattack.sead.template_prefix.blue = '__SEADUSSR__'
gcicap.cap.template_prefix.blue  = '__CAPUSSR__'
gcicap.gci.template_prefix.blue = '__GCIUSSR__'
bmbrstrike.bomb.template_prefix.blue = '__BMBRUSSR__'

end

if blueLeader.id == 2 then
blueLeader.name = "FRANKLIN ROOSEVELT"
blueLeader.info = "A balanced leader in every category"
blueLeader.access = "american"
blueLeader.finfo1 = "GROUND:    ####"
blueLeader.finfo2 = "DEFENSES:  ####"
blueLeader.finfo3 = "LOGISTICS: ####"
blueLeader.finfo4 = "AIRFORCE:  ####"
-- blue group amounts based on location
bAAAamount = 5
bTRUCKamount = 5
bSHORADamount = 5
bTANKamount = 7
bAPCamount = 5
bINFamount = 5
bSRSAMamount = 4
bLRSAMamount = 3
bCPamount = 2
bNAVYSTATICamount = 1
bNAVYamount = 4
heloattack.blue.supply = 40
groundattack.blue.supply = 40
seadattack.blue.supply = 40
gcicap.blue.supply = 40
bmbrstrike.blue.supply = 40
heloattack.cas.template_prefix.blue = '__HELOAMERICA__'
groundattack.cas.template_prefix.blue = '__CASAMERICA__'
seadattack.sead.template_prefix.blue = '__SEADAMERICA__'
gcicap.cap.template_prefix.blue = '__CAPAMERICA__'
gcicap.gci.template_prefix.blue = '__GCIAMERICA__'
bmbrstrike.bomb.template_prefix.blue = '__BMBRAMERICA__'
--
end

if blueLeader.id == 3 then
blueLeader.name = "GEORGE BUSH"
blueLeader.info = "Favors naval and air power"
blueLeader.access = "american"
blueLeader.finfo1 = "GROUND:    ###"
blueLeader.finfo2 = "DEFENSES:  ###"
blueLeader.finfo3 = "LOGISTICS: ####"
blueLeader.finfo4 = "AIRFORCE:  #####"
-- blue group amounts based on location
bAAAamount = 5
bTRUCKamount = 5
bSHORADamount = 5
bTANKamount = 5
bAPCamount = 5
bINFamount = 5
bSRSAMamount = 3
bLRSAMamount = 3
bCPamount = 1
bNAVYSTATICamount = 1
bNAVYamount = 6
heloattack.blue.supply = 40
groundattack.blue.supply = 40
seadattack.blue.supply = 40
gcicap.blue.supply = 40
bmbrstrike.blue.supply = 40
heloattack.cas.template_prefix.blue = '__HELOAMERICA__'
groundattack.cas.template_prefix.blue = '__CASAMERICA__'
seadattack.sead.template_prefix.blue = '__SEADAMERICA__'
gcicap.cap.template_prefix.blue = '__CAPAMERICA__'
gcicap.gci.template_prefix.blue = '__GCIAMERICA__'
bmbrstrike.bomb.template_prefix.blue = '__BMBRAMERICA__'
--
end

if blueLeader.id == 4 then
blueLeader.name = "XI JINPING"
blueLeader.info = "Favors infantry and APCs, less mobility but mighty in numbers "
blueLeader.access = "china"
blueLeader.finfo1 = "GROUND:    ###"
blueLeader.finfo2 = "DEFENSES:  ####"
blueLeader.finfo3 = "LOGISTICS: #####"
blueLeader.finfo4 = "AIRFORCE:  ###"
-- blue group amounts based on location
bAAAamount = 7
bTRUCKamount = 7
bSHORADamount = 3
bTANKamount = 7
bAPCamount = 7
bINFamount = 7
bSRSAMamount = 3
bLRSAMamount = 2
bCPamount = 1
bNAVYSTATICamount = 1
bNAVYamount = 4
heloattack.blue.supply = 40
groundattack.blue.supply = 40
seadattack.blue.supply = 40
gcicap.blue.supply = 40
bmbrstrike.blue.supply = 40
heloattack.cas.template_prefix.blue = '__HELOCHINA__'
groundattack.cas.template_prefix.blue = '__CASCHINA__'
seadattack.sead.template_prefix.blue = '__SEADCHINA__'
gcicap.cap.template_prefix.blue = '__CAPCHINA__'
gcicap.gci.template_prefix.blue = '__GCICHINA__'
bmbrstrike.bomb.template_prefix.blue = '__BMBRCHINA__'
--
end

if blueLeader.id == 5 then
blueLeader.name = "ADOLF HITLER"
blueLeader.info = "Strong panzer divsions and strong air force"
blueLeader.access = "germany"
blueLeader.finfo1 = "GROUND:    #####"
blueLeader.finfo2 = "DEFENSES:  #"
blueLeader.finfo3 = "LOGISTICS: ####"
blueLeader.finfo4 = "AIRFORCE:  #####"
-- blue group amounts based on location
bAAAamount = 5
bTRUCKamount = 5
bSHORADamount = 4
bTANKamount = 8
bAPCamount = 5
bINFamount = 5
bSRSAMamount = 2
bLRSAMamount = 2
bCPamount = 2
bNAVYSTATICamount = 1
bNAVYamount = 3
heloattack.blue.supply = 40
groundattack.blue.supply = 40
seadattack.blue.supply = 40
gcicap.blue.supply = 40
bmbrstrike.blue.supply = 40
heloattack.cas.template_prefix.blue = '__HELOCHINA__'
groundattack.cas.template_prefix.blue = '__CASUSSR__'
seadattack.sead.template_prefix.blue = '__SEADCHINA__'
gcicap.cap.template_prefix.blue = '__CAPAMERICA__'
gcicap.gci.template_prefix.blue = '__GCIUSSR__'
bmbrstrike.bomb.template_prefix.blue = '__BMBRAMERICA__'
--
end

if blueLeader.id == 6 then
blueLeader.name = "JOSEPH STALIN"
blueLeader.info = "Less air defense but strong infantry and tank divsions"
blueLeader.access = "soviet"
blueLeader.finfo1 = "GROUND:    ####"
blueLeader.finfo2 = "DEFENSES:  ##"
blueLeader.finfo3 = "LOGISTICS: ###"
blueLeader.finfo4 = "AIRFORCE:  ###"
-- blue group amounts based on location
bAAAamount = 5
bTRUCKamount = 5
bSHORADamount = 4
bTANKamount = 7
bAPCamount = 4
bINFamount = 7
bSRSAMamount = 3
bLRSAMamount = 2
bCPamount = 2
bNAVYSTATICamount = 1
bNAVYamount = 2
heloattack.blue.supply = 40
groundattack.blue.supply = 40
seadattack.blue.supply = 40
gcicap.blue.supply = 40
bmbrstrike.blue.supply = 40
heloattack.cas.template_prefix.blue = '__HELOUSSR__'
groundattack.cas.template_prefix.blue = '__CASUSSR__'
seadattack.sead.template_prefix.blue = '__SEADUSSR__'
gcicap.cap.template_prefix.blue = '__CAPUSSR__'
gcicap.gci.template_prefix.blue = '__GCIUSSR__'
bmbrstrike.bomb.template_prefix.blue = '__BMBRUSSR__'
--
end


if redLeader.id == 1 then
redLeader.name = "VLADIMIR PUTIN"
redLeader.info = "Favors SAMS but lacking in other areas"
redLeader.access = "russia"
redLeader.finfo1 = "GROUND:    ##"
redLeader.finfo2 = "DEFENSES:  #####"
redLeader.finfo3 = "LOGISTICS: ###"
redLeader.finfo4 = "AIRFORCE:  ####"
-- blue group amounts based on location
rAAAamount = 5
rTRUCKamount = 4
rSHORADamount = 4
rTANKamount = 5
rAPCamount = 5
rINFamount = 5
rSRSAMamount = 5
rLRSAMamount = 5
rCPamount = 3
rNAVYamount = 4
rNAVYSTATICamount = 1
heloattack.red.supply = 40
groundattack.red.supply = 40
seadattack.red.supply = 40
gcicap.red.supply = 40
bmbrstrike.red.supply = 40
heloattack.cas.template_prefix.red = '__HELOUSSR__'
groundattack.cas.template_prefix.red = '__CASUSSR__'
seadattack.sead.template_prefix.red = '__SEADUSSR__'
gcicap.cap.template_prefix.red = '__CAPUSSR__'
gcicap.gci.template_prefix.red = '__GCIUSSR__'
bmbrstrike.bomb.template_prefix.red = '__BMBRUSSR__'
--
end

if redLeader.id == 2 then
redLeader.name = "FRANKLIN ROOSEVELT"
redLeader.info = "A balanced leader in every category"
redLeader.access = "american"
redLeader.finfo1 = "GROUND:    ####"
redLeader.finfo2 = "DEFENSES:  ####"
redLeader.finfo3 = "LOGISTICS: ####"
redLeader.finfo4 = "AIRFORCE:  ####"
-- blue group amounts based on location
rAAAamount = 5
rTRUCKamount = 5
rSHORADamount = 5
rTANKamount = 6
rAPCamount = 5
rINFamount = 5
rSRSAMamount = 4
rLRSAMamount = 3
rCPamount = 1
rNAVYSTATICamount = 1
rNAVYamount = 2
heloattack.red.supply = 40
groundattack.red.supply = 40
seadattack.red.supply = 40
gcicap.red.supply = 40
bmbrstrike.red.supply = 40
heloattack.cas.template_prefix.red = '__HELOAMERICA__'
groundattack.cas.template_prefix.red = '__CASAMERICA__'
seadattack.sead.template_prefix.red = '__SEADAMERICA__'
gcicap.cap.template_prefix.red = '__CAPAMERICA__'
gcicap.gci.template_prefix.red = '__GCIAMERICA__'
bmbrstrike.bomb.template_prefix.red = '__BMBRAMERICA__'
--
end

if redLeader.id == 3 then
redLeader.name = "GEORGE BUSH"
redLeader.info = "Favors naval and air power"
redLeader.access = "american"
redLeader.finfo1 = "GROUND:    ###"
redLeader.finfo2 = "DEFENSES:  ###"
redLeader.finfo3 = "LOGISTICS: ####"
redLeader.finfo4 = "AIRFORCE:  #####"
-- blue group amounts based on location
rAAAamount = 5
rTRUCKamount = 6
rSHORADamount = 5
rTANKamount = 5
rAPCamount = 5
rINFamount = 5
rSRSAMamount = 3
rLRSAMamount = 3
rCPamount = 1
rNAVYSTATICamount = 1
rNAVYamount = 6
heloattack.red.supply = 40
groundattack.red.supply = 40
seadattack.red.supply = 40
gcicap.red.supply = 40
bmbrstrike.red.supply = 40
heloattack.cas.template_prefix.red = '__HELOAMERICA__'
groundattack.cas.template_prefix.red = '__CASAMERICA__'
seadattack.sead.template_prefix.red = '__SEADAMERICA__'
gcicap.cap.template_prefix.red = '__CAPAMERICA__'
gcicap.gci.template_prefix.red = '__GCIAMERICA__'
bmbrstrike.bomb.template_prefix.red = '__BMBRAMERICA__'
--
end

if redLeader.id == 4 then
redLeader.name = "XI JINPING"
redLeader.info = "Favors infantry and APCs, less mobility but mighty in numbers "
redLeader.access = "china"
redLeader.finfo1 = "GROUND:    ###"
redLeader.finfo2 = "DEFENSES:  ####"
redLeader.finfo3 = "LOGISTICS: #####"
redLeader.finfo4 = "AIRFORCE:  ###"
-- blue group amounts based on location
rAAAamount = 6
rTRUCKamount = 6
rSHORADamount = 3
rTANKamount = 7
rAPCamount = 7
rINFamount = 7
rSRSAMamount = 3
rLRSAMamount = 2
rCPamount = 1
rNAVYSTATICamount = 1
rNAVYamount = 1
heloattack.red.supply = 40
groundattack.red.supply = 40
seadattack.red.supply = 40
gcicap.red.supply = 40
bmbrstrike.red.supply = 40
heloattack.cas.template_prefix.red = '__HELOCHINA__'
groundattack.cas.template_prefix.red = '__CASCHINA__'
seadattack.sead.template_prefix.red = '__SEADCHINA__'
gcicap.cap.template_prefix.red  = '__CAPCHINA__'
gcicap.gci.template_prefix.red = '__GCICHINA__'
bmbrstrike.bomb.template_prefix.red = '__BMBRUSSR__'
--
end

if redLeader.id == 5 then
redLeader.name = "ADOLF HITLER"
redLeader.info = "Strong panzer divsions and strong air force"
redLeader.access = "germany"
redLeader.finfo1 = "GROUND:    #####"
redLeader.finfo2 = "DEFENSES:  #"
redLeader.finfo3 = "LOGISTICS: ####"
redLeader.finfo4 = "AIRFORCE:  #####"
-- blue group amounts based on location
rAAAamount = 5
rTRUCKamount = 5
rSHORADamount = 4
rTANKamount = 8
rAPCamount = 5
rINFamount = 5
rSRSAMamount = 3
rLRSAMamount = 2
rCPamount = 2
rNAVYSTATICamount = 1
rNAVYamount = 3
heloattack.red.supply = 40
groundattack.red.supply = 40
seadattack.red.supply = 40
gcicap.red.supply = 40
bmbrstrike.red.supply = 40
heloattack.cas.template_prefix.red = '__HELOCHINA__'
groundattack.cas.template_prefix.red = '__CASUSSR__'
seadattack.sead.template_prefix.red = '__SEADCHINA__'
gcicap.cap.template_prefix.red = '__CAPAMERICA__'
gcicap.gci.template_prefix.red = '__GCIUSSR__'
bmbrstrike.bomb.template_prefix.red = '__BMBRAMERICA__'
--
end

if redLeader.id == 6 then
redLeader.name = "JOSEPH STALIN"
redLeader.info = "Less air defense but strong infantry and tank divsions"
redLeader.access = "soviet"
redLeader.finfo1 = "GROUND:    ####"
redLeader.finfo2 = "DEFENSES:  ##"
redLeader.finfo3 = "LOGISTICS: ###"
redLeader.finfo4 = "AIRFORCE:  ###"
-- blue group amounts based on location
rAAAamount = 5
rTRUCKamount = 5
rSHORADamount = 4
rTANKamount = 7
rAPCamount = 4
rINFamount = 7
rSRSAMamount = 3
rLRSAMamount = 2
rCPamount = 1
rNAVYSTATICamount = 1
rNAVYamount = 2
heloattack.red.supply = 40
groundattack.red.supply = 40
seadattack.red.supply = 40
gcicap.red.supply = 40
bmbrstrike.red.supply = 40
heloattack.cas.template_prefix.red = '__HELOUSSR__'
groundattack.cas.template_prefix.red = '__CASUSSR__'
seadattack.sead.template_prefix.red = '__SEADUSSR__'
gcicap.cap.template_prefix.red  = '__CAPUSSR__'
gcicap.gci.template_prefix.red  = '__GCIUSSR__'
bmbrstrike.bomb.template_prefix.red = '__BMBRUSSR__'
end
end

function displayLeaderInfo(side)
if side == "RED" then
leaderANNOUNCE = leaderANNOUNCE + 1
	if leaderANNOUNCE <= 2 then	
		
		
		if redLeader.id == 1 or redLeader.id == 6 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'sovietAnthem.ogg')
		trigger.action.outSoundForCoalition(coalition.side.BLUE, 'sovietAnthem.ogg')
		end
		
		if redLeader.id == 5 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'germanAnthem.ogg')
		trigger.action.outSoundForCoalition(coalition.side.BLUE, 'germanAnthem.ogg')
		end
		
		if redLeader.id == 4 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'chinaAnthem.ogg')
		trigger.action.outSoundForCoalition(coalition.side.BLUE, 'chinaAnthem.ogg')
		end
		
		if redLeader.id == 2 or redLeader.id == 3 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'americaAnthem.ogg')
		trigger.action.outSoundForCoalition(coalition.side.BLUE, 'americaAnthem.ogg')
		end
		
	end
		
	local msg = {}
    msg.text = 'RED FORCE IS BEING LED BY ' .. redLeader.name 
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = ''
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = redLeader.info
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = ''
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = redLeader.finfo1
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = redLeader.finfo2
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = redLeader.finfo3
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = redLeader.finfo4
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	--msg.text = redLeader.finfo5
    --msg.displayTime = 30  
    --msg.msgFor = {coa = {'all'}} 
	--mist.message.add(msg)
	end
	
if side == "BLUE" then
	leaderANNOUNCE = leaderANNOUNCE + 1
	if leaderANNOUNCE <= 2 then	
	
		
		if blueLeader.id == 1 or blueLeader.id == 6 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'sovietAnthem.ogg')
		trigger.action.outSoundForCoalition(coalition.side.BLUE, 'sovietAnthem.ogg')
		end
		
		if blueLeader.id == 5 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'germanAnthem.ogg')
		trigger.action.outSoundForCoalition(coalition.side.BLUE, 'germanAnthem.ogg')
		end
		
		if blueLeader.id == 4 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'chinaAnthem.ogg')
		trigger.action.outSoundForCoalition(coalition.side.BLUE, 'chinaAnthem.ogg')
		end
		
		if blueLeader.id == 2 or redLeader.id == 3 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'americaAnthem.ogg')
		trigger.action.outSoundForCoalition(coalition.side.BLUE, 'americaAnthem.ogg')
		end
		
	end
	local msg = {}
    msg.text = 'BLUE FORCE IS BEING LED BY ' .. blueLeader.name 
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = blueLeader.info
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = blueLeader.finfo1
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = blueLeader.finfo2
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = blueLeader.finfo3
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	msg.text = blueLeader.finfo4
    msg.displayTime = 20  
    msg.msgFor = {coa = {'all'}} 
	mist.message.add(msg)
	local msg = {}
	--msg.text = blueLeader.finfo5
    --msg.displayTime = 30  
    --msg.msgFor = {coa = {'all'}} 
	--mist.message.add(msg)
	end
end


	function showResources(side)
    
	if side == "BLUE" then
	local msg = {} 
    msg.text = 'Blue has...'
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
		    local msg = {} 
    msg.text = heloattack.blue.supply .. ' Helicopter flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = groundattack.blue.supply .. ' CAS flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = seadattack.blue.supply .. ' SEAD flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = groundattack.blue.supply .. ' CAP flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
		    local msg = {} 
    msg.text = bmbrstrike.blue.supply .. ' BOMBER flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
end
	
	if side == "RED" then
	    local msg = {} 
    msg.text = 'Red has...'
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = heloattack.red.supply .. ' Helicopter flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = groundattack.red.supply .. ' CAS flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = seadattack.red.supply .. ' SEAD flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = groundattack.red.supply .. ' CAP flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
			    local msg = {} 
    msg.text = bmbrstrike.red.supply .. ' BOMBER flights remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	end
end


redLeader.id = mist.random(1,6)
blueLeader.id = mist.random(1,6)



while redLeader.id == blueLeader.id do-- fix so that its never same leader versus themselves
blueLeader.id = mist.random(1,6)
end


determineForceLeaders()