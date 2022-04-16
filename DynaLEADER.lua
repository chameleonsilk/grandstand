-- version 1.03
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
bAAAamount = 4
bTRUCKamount = 2
bSHORADamount = 2
bTANKamount = 4
bAPCamount = 4
bINFamount = 4
bSRSAMamount = 4
bLRSAMamount = 3
bCPamount = 1
heloattack.blue.supply = 12
groundattack.blue.supply = 18
seadattack.blue.supply = 6
gcicap.blue.supply = 18
--
heloattack.cas.template_prefix.blue = '__HELOUSSR__'
groundattack.cas.template_prefix.blue = '__CASUSSR__'
seadattack.sead.template_prefix.blue = '__SEADUSSR__'
gcicap.cap.template_prefix.blue  = '__CAPUSSR__'
gcicap.gci.template_prefix.blue = '__GCIUSSR__'

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
bAAAamount = 4
bTRUCKamount = 4
bSHORADamount = 4
bTANKamount = 5
bAPCamount = 4
bINFamount = 4
bSRSAMamount = 3
bLRSAMamount = 2
bCPamount = 1
heloattack.blue.supply = 12
groundattack.blue.supply = 12
seadattack.blue.supply = 12
gcicap.blue.supply = 12
heloattack.cas.template_prefix.blue = '__HELOAMERICA__'
groundattack.cas.template_prefix.blue = '__CASAMERICA__'
seadattack.sead.template_prefix.blue = '__SEADAMERICA__'
gcicap.cap.template_prefix.blue = '__CAPAMERICA__'
gcicap.gci.template_prefix.blue = '__GCIAMERICA__'
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
bAAAamount = 3
bTRUCKamount = 5
bSHORADamount = 3
bTANKamount = 4
bAPCamount = 4
bINFamount = 3
bSRSAMamount = 2
bLRSAMamount = 2
bCPamount = 1
heloattack.blue.supply = 12
groundattack.blue.supply = 14
seadattack.blue.supply = 14
gcicap.blue.supply = 14
heloattack.cas.template_prefix.blue = '__HELOAMERICA__'
groundattack.cas.template_prefix.blue = '__CASAMERICA__'
seadattack.sead.template_prefix.blue = '__SEADAMERICA__'
gcicap.cap.template_prefix.blue = '__CAPAMERICA__'
gcicap.gci.template_prefix.blue = '__GCIAMERICA__'
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
bAAAamount = 5
bTRUCKamount = 5
bSHORADamount = 1
bTANKamount = 5
bAPCamount = 5
bINFamount = 6
bSRSAMamount = 2
bLRSAMamount = 2
bCPamount = 1
heloattack.blue.supply = 8
groundattack.blue.supply = 13
seadattack.blue.supply = 10
gcicap.blue.supply = 13
heloattack.cas.template_prefix.blue = '__HELOCHINA__'
groundattack.cas.template_prefix.blue = '__CASCHINA__'
seadattack.sead.template_prefix.blue = '__SEADCHINA__'
gcicap.cap.template_prefix.blue = '__CAPCHINA__'
gcicap.gci.template_prefix.blue = '__GCICHINA__'
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
bAAAamount = 3
bTRUCKamount = 4
bSHORADamount = 2
bTANKamount = 7
bAPCamount = 4
bINFamount = 3
bSRSAMamount = 1
bLRSAMamount = 1
bCPamount = 1
heloattack.blue.supply = 4
groundattack.blue.supply = 16
seadattack.blue.supply = 8
gcicap.blue.supply = 20
heloattack.cas.template_prefix.blue = '__HELOCHINA__'
groundattack.cas.template_prefix.blue = '__CASUSSR__'
seadattack.sead.template_prefix.blue = '__SEADCHINA__'
gcicap.cap.template_prefix.blue = '__CAPAMERICA__'
gcicap.gci.template_prefix.blue = '__GCIUSSR__'
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
bAAAamount = 3
bTRUCKamount = 3
bSHORADamount = 2
bTANKamount = 6
bAPCamount = 2
bINFamount = 6
bSRSAMamount = 3
bLRSAMamount = 1
bCPamount = 1
heloattack.blue.supply = 6
groundattack.blue.supply = 12
seadattack.blue.supply = 12
gcicap.blue.supply = 14
heloattack.cas.template_prefix.blue = '__HELOUSSR__'
groundattack.cas.template_prefix.blue = '__CASUSSR__'
seadattack.sead.template_prefix.blue = '__SEADUSSR__'
gcicap.cap.template_prefix.blue = '__CAPUSSR__'
gcicap.gci.template_prefix.blue = '__GCIUSSR__'
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
rAAAamount = 4
rTRUCKamount = 2
rSHORADamount = 2
rTANKamount = 4
rAPCamount = 4
rINFamount = 4
rSRSAMamount = 4
rLRSAMamount = 3
rCPamount = 1
heloattack.red.supply = 10
groundattack.red.supply = 22
seadattack.red.supply = 6
gcicap.red.supply = 20
heloattack.cas.template_prefix.red = '__HELOUSSR__'
groundattack.cas.template_prefix.red = '__CASUSSR__'
seadattack.sead.template_prefix.red = '__SEADUSSR__'
gcicap.cap.template_prefix.red = '__CAPUSSR__'
gcicap.gci.template_prefix.red = '__GCIUSSR__'
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
rAAAamount = 4
rTRUCKamount = 4
rSHORADamount = 4
rTANKamount = 5
rAPCamount = 4
rINFamount = 4
rSRSAMamount = 3
rLRSAMamount = 2
rCPamount = 1
heloattack.red.supply = 12
groundattack.red.supply = 12
seadattack.red.supply = 12
gcicap.red.supply = 12
heloattack.cas.template_prefix.red = '__HELOAMERICA__'
groundattack.cas.template_prefix.red = '__CASAMERICA__'
seadattack.sead.template_prefix.red = '__SEADAMERICA__'
gcicap.cap.template_prefix.red = '__CAPAMERICA__'
gcicap.gci.template_prefix.red = '__GCIAMERICA__'
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
rAAAamount = 3
rTRUCKamount = 5
rSHORADamount = 3
rTANKamount = 4
rAPCamount = 4
rINFamount = 3
rSRSAMamount = 2
rLRSAMamount = 2
rCPamount = 1
heloattack.red.supply = 12
groundattack.red.supply = 14
seadattack.red.supply = 14
gcicap.red.supply = 14
heloattack.cas.template_prefix.red = '__HELOAMERICA__'
groundattack.cas.template_prefix.red = '__CASAMERICA__'
seadattack.sead.template_prefix.red = '__SEADAMERICA__'
gcicap.cap.template_prefix.red = '__CAPAMERICA__'
gcicap.gci.template_prefix.red = '__GCIAMERICA__'
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
rAAAamount = 5
rTRUCKamount = 5
rSHORADamount = 1
rTANKamount = 5
rAPCamount = 5
rINFamount = 6
rSRSAMamount = 2
rLRSAMamount = 2
rCPamount = 1
heloattack.red.supply = 8
groundattack.red.supply = 13
seadattack.red.supply = 10
gcicap.red.supply = 13
heloattack.cas.template_prefix.red = '__HELOCHINA__'
groundattack.cas.template_prefix.red = '__CASCHINA__'
seadattack.sead.template_prefix.red = '__SEADCHINA__'
gcicap.cap.template_prefix.red  = '__CAPCHINA__'
gcicap.gci.template_prefix.red = '__GCICHINA__'
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
rAAAamount = 3
rTRUCKamount = 4
rSHORADamount = 2
rTANKamount = 7
rAPCamount = 4
rINFamount = 3
rSRSAMamount = 1
rLRSAMamount = 1
rCPamount = 1
heloattack.red.supply = 4
groundattack.red.supply = 16
seadattack.red.supply = 8
gcicap.red.supply = 20
heloattack.cas.template_prefix.red = '__HELOCHINA__'
groundattack.cas.template_prefix.red = '__CASUSSR__'
seadattack.sead.template_prefix.red = '__SEADCHINA__'
gcicap.cap.template_prefix.red = '__CAPAMERICA__'
gcicap.gci.template_prefix.red = '__GCIUSSR__'
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
rAAAamount = 3
rTRUCKamount = 3
rSHORADamount = 2
rTANKamount = 6
rAPCamount = 2
rINFamount = 6
rSRSAMamount = 3
rLRSAMamount = 1
rCPamount = 1
heloattack.red.supply = 6
groundattack.red.supply = 16
seadattack.red.supply = 6
gcicap.red.supply = 12
heloattack.cas.template_prefix.red = '__HELOUSSR__'
groundattack.cas.template_prefix.red = '__CASUSSR__'
seadattack.sead.template_prefix.red = '__SEADUSSR__'
gcicap.cap.template_prefix.red  = '__CAPUSSR__'
gcicap.gci.template_prefix.red  = '__GCIUSSR__'
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
    msg.text = heloattack.blue.supply .. ' Helicopters remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = groundattack.blue.supply .. ' CAS planes remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = seadattack.blue.supply .. ' SEAD planes remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = groundattack.blue.supply .. ' CAP planes remaining' 
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
    msg.text = heloattack.red.supply .. ' Helicopters remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = groundattack.red.supply .. ' CAS planes remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = seadattack.red.supply .. ' SEAD planes remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	    local msg = {} 
    msg.text = groundattack.red.supply .. ' CAP planes remaining' 
    msg.displayTime = 10  
    msg.msgFor = {coa = {'all'}} 
    mist.message.add(msg)
	end
end


redLeader.id = mist.random(1,6)
blueLeader.id = mist.random(1,6)
determineForceLeaders()