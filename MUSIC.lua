-- revision 1.03
Music = 1 -- enabled
Tension_Set = 0
Music_Battle_Sample = 1
Music_Relaxed_Sample = 1
NoMusic = false


function PlayIntroMusic()
if Music == 0 then
  local randomizer_tune = mist.random(1,4)
  
  if randomizer_tune == 1 then
  trigger.action.outSoundForCoalition(coalition.side.RED, 'groundtask.ogg')
  end
  
  if randomizer_tune == 2 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'bombing3.ogg')
    end
    
    if randomizer_tune == 3 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'bombing4.ogg')
    end
    
        if randomizer_tune == 4 then
		trigger.action.outSoundForCoalition(coalition.side.RED, 'bombing2.ogg')
    end
   end
  end
  
function Play_Music_BLUE(arg, time)
if NoMusic ~= true then
    local Return_Time = 10
    local Old_Tension_Set = Tension_Set
    if Music == 1 then -- condition block only used if Music is enabled
          --
          if trigger.misc.getUserFlag('1') == 0 then
            Tension_Set = 0
          end
          
          if trigger.misc.getUserFlag('1') == 1 then
            Tension_Set = 1
          end
       
          -- set tension level based off of enemy present in GCI zone
          --
          if Tension_Set == 0 and Old_Tension_Set == 1 then
          Music_Relaxed_Sample = 1
          end
          if Tension_Set == 1 and Old_Tension_Set == 0 then
          Music_Battle_Sample = 1
          end
          -- set back to intro sample if the tension has changed    
    
          if Tension_Set == 0 and Music_Relaxed_Sample == 2 then -- play relaxed track
    trigger.action.outSoundForCoalition(coalition.side.BLUE, 'relaxed_mid_33sec.ogg') 
    Return_Time = 33 -- sample is 10 seconds long
    end
          
          if Tension_Set == 0 and Music_Relaxed_Sample == 1 then -- play relaxed start
    trigger.action.outSoundForCoalition(coalition.side.BLUE, 'relaxed_start_12sec.ogg') 
    Return_Time = 12
    Music_Relaxed_Sample = 2 -- set to main sample
    end
          
          if Tension_Set == 1 and Music_Battle_Sample == 2  then -- play battle track
    trigger.action.outSoundForCoalition(coalition.side.BLUE, 'battle_mid_41sec.ogg') 
    Return_Time = 41 -- sample is 41 seconds long
    end
          
          if Tension_Set == 1 and Music_Battle_Sample == 1  then -- play battle start
    trigger.action.outSoundForCoalition(coalition.side.BLUE, 'battle_start_15sec.ogg') 
    Return_Time = 15 -- sample is 15 seconds long
    Music_Battle_Sample = 2 -- set to main sample
    end
    else
    -- do not play anything
    end
    return time + Return_Time --  return exactly same time sample ends
    end
end

function Play_Music_RED(arg, time)
if NoMusic ~= true then
    local Return_Time = 10
    local Old_Tension_Set = Tension_Set
    if Music == 1 then -- condition block only used if Music is enabled
          --
          if trigger.misc.getUserFlag('2') == 0 then
            Tension_Set = 0
          end
          
          if trigger.misc.getUserFlag('2') == 1 then
            Tension_Set = 1
          end
       
          -- set tension level based off of enemy present in GCI zone
          --
          if Tension_Set == 0 and Old_Tension_Set == 1 then
          Music_Relaxed_Sample = 1
          end
          if Tension_Set == 1 and Old_Tension_Set == 0 then
          Music_Battle_Sample = 1
          end
          -- set back to intro sample if the tension has changed    
    
          if Tension_Set == 0 and Music_Relaxed_Sample == 2 then -- play relaxed track
    trigger.action.outSoundForCoalition(coalition.side.RED, 'relaxed_mid_31sec.ogg') 
    Return_Time = 31 -- sample is 10 seconds long
    end
          
          if Tension_Set == 0 and Music_Relaxed_Sample == 1 then -- play relaxed start
    trigger.action.outSoundForCoalition(coalition.side.RED, 'relaxed_start_12sec.ogg') 
    Return_Time = 12
    Music_Relaxed_Sample = 2 -- set to main sample
    end
          
          if Tension_Set == 1 and Music_Battle_Sample == 2  then -- play battle track
    trigger.action.outSoundForCoalition(coalition.side.RED, 'battle_mid_41sec.ogg') 
    Return_Time = 41 -- sample is 41 seconds long
    end
          
          if Tension_Set == 1 and Music_Battle_Sample == 1  then -- play battle start
    trigger.action.outSoundForCoalition(coalition.side.RED, 'battle_start_15sec.ogg') 
    Return_Time = 15 -- sample is 15 seconds long
    Music_Battle_Sample = 2 -- set to main sample
    end
    else
    -- do not play anything
    end
    return time + Return_Time --  return exactly same time sample ends
    end
end

function Music_Poll(arg, time) -- this will be used to setup the triggers to make
 
 
mist.flagFunc.units_in_moving_zones{
	units = {'[blue][plane]'},
	zone_units = {'[red][all]'},
	flag = 2,
	radius = 150000,
	zone_type = 'sphere',
	toggle = true,
}
 
   
mist.flagFunc.units_in_moving_zones{
	units = {'[red][plane]'},
	zone_units = {'[blue][all]'},
	flag = 1,
	radius = 150000,
	zone_type = 'sphere',
	toggle = true
}

end
 
 timer.scheduleFunction(Play_Music_BLUE, nil, timer.getTime() + 1) 
 timer.scheduleFunction(Play_Music_RED, nil, timer.getTime() + 1) 
   -- func end   
   
   Music_Poll("","")