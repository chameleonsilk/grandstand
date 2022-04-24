--revision 4
--[[
Copyright (c) 2016 Snafu, Stonehouse, Rivvern, Chameleon Silk, lukrop.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software and the Software shall not be
included in whole or part in any sort of paid for software or paid for downloadable
content (DLC) without the express permission of the copyright holders.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

--[[--
## Overview
Autonomous GCI and CAS script for DCS: World.
The script provides an autonomous model of combat air patrols and ground controlled
interceptors for use with DCS World by mission builders.

After minimal setup the script will automatically spawn CAS and GCI flights for two
sides and give them patrol and intercept tasks as well as returning them to base when
threats cease to be detected.

Originally created by Snafu, enhanced and further modified by Stonehouse,
Rivvern, Chameleon Silk.

Rewritten by lukrop.

## Links

Github repository: <https://github.com/lukrop/GCICAS>

@script GCICAS
@author Snafu
@author Stonehouse
@author Rivvern
@author Chameleon Silk
@author lukrop
@copyright 2016 Snafu, Stonehouse, Rivvern, Chameleon Silk, lukrop.
@license Modified MIT. See LICENSE file.
]]

do
  --- Flight class.
  -- @type bmbrstrike.Flight
  bmbrstrike.Flight = {}

  local function getFlightIndex(group)
    if type(group) ~= "string" then
      if group:getName() then
        group = group:getName()
      else
        return false
      end
    end
    for i, side in pairs(bmbrstrike.sides) do
      for j, task in pairs(bmbrstrike.tasks) do
        for n = 1, #bmbrstrike[side][task].flights do
          if bmbrstrike[side][task].flights[n].group_name == group then
            return {side = side, task = task, index = n}
          end
        end
      end
    end
    return false
  end

  --- Returns the flight for the given group.
  -- @tparam string|Group group this can be a Group object
  -- or the group name.
  -- @treturn bmbrstrike.Flight the flight for the given group.
  function bmbrstrike.Flight.getFlight(group)
    f = getFlightIndex(group)
    if f then
      return bmbrstrike[f.side][f.task].flights[f.index]
    else
      return false
    end
  end

  --- Creates a new flight.
  -- @tparam Group group group of the flight.
  -- @tparam Airbase airbase homplate of the new flight.
  -- @tparam string task task of the new flight. Can be "CAS" or "SEAD".
  -- @param param task parameter. This can be a zone table if it's a
  -- CAS flight or SEAD flight
  function bmbrstrike.Flight:new(group, airbase, task, param)
    if group:isExist() then
      local side = bmbrstrike.coalitionToSide(group:getCoalition())
      local f = {}
      f.side = side
      f.group = group
      f.group_name = group:getName()
      f.airbase = airbase
      f.task = task
      -- is the flight RTB?
      f.rtb = false
      f.in_zone = false

      --if task == "cas" then
        f.zone = param
        f.zone_name = param.name
        f.intercepting = true
        f.vul_time = math.random(bmbrstrike[side].bomb.vul_time_min,
                                 bmbrstrike[side].bomb.vul_time_max)
      --end

      -- get current timestamp
      local timestamp = timer.getAbsTime()
      f.units_moved = {}
      -- set timestamp for each unit
      -- this is later used for garbage collection checks
      for u, unit in pairs(group:getUnits()) do
        f.units_moved[u] = {}
        f.units_moved[u].unit = unit
        f.units_moved[u].last_moved = timestamp
        f.units_moved[u].spawned_at = timestamp
      end

      setmetatable(f, self)
      self.__index = self

      table.insert(bmbrstrike[side][task].flights, f)
      bmbrstrike.log:info("Registered flight: $1", f.group_name)

      return f
    else
      return nil
    end
  end

  --- Removes the flight
  -- @tparam bmbrstrike.Flight self flight object
  function bmbrstrike.Flight:remove()
    if self.zone then
      -- if we didn't already leave the zone do it now.
      self:leaveZone()
    end
    local f = getFlightIndex(self.group_name)
    local r = table.remove(bmbrstrike[f.side][f.task].flights, f.index)
    if r then
      bmbrstrike.log:info("Removing flight $1 with index $2", r.group_name, f.index)
    end
  end
  

  --- Decreases active flights counter in this flights zone.
  -- Actually just decreases the active flights
  -- counter of a zone. Does NOT task the flight itself.
  function bmbrstrike.Flight:leaveZone()
    if self.in_zone then
      local zone = self.zone
      if zone.patrol_count <= 1 then
        zone.patrol_count = 0
      else
        zone.patrol_count = zone.patrol_count - 1
      end
      self.in_zone = false

      -- get current time
      local time_now = timer.getAbsTime()
      -- get time on station by substracting vul start time from current time
      -- and convert it to minutes
      local time_on_station = 0
      if self.vul_start then
        time_on_station = (time_now - self.vul_start) / 60
      end
      local vul_diff = self.vul_time - time_on_station
      -- set new vul time only if more than 5 minutes
      if vul_diff > 5 then
        self.vul_time = vul_diff
      else
        self.vul_time = 0
      end
    end
  end
  
  --- Increases active flights counter in this flights zone.
  -- Actually just increases the active flights
  -- counter of a zone. Does NOT task the flight itself.
  function bmbrstrike.Flight:enterZone()
    if not self.in_zone then
      self.intercepting = false
      self.in_zone = true
      local zone = self.zone
      zone.patrol_count = zone.patrol_count + 1
    end
  end
  
  --- Tasks flight with combat air patrol.
  -- Creates waypoints inside it's assigned zone and tasks
  -- the flight with patroling along the route.
  -- @tparam[opt] boolean cold If set to true the flight won't
  -- engage any enemy unit's it detects by itself. Default false.
  function bmbrstrike.Flight:taskWith(cold)
    -- only task with CAS if ther is still vul time left
    if self.vul_time == 0 then
      -- send flight RTB if no vul time left.
      bmbrstrike.log:info("No vul time left for $1", self.group_name)
      self:taskWithRTB()
    else
      local group = self.group
      local ctl = group:getController()
      local side = bmbrstrike.coalitionToSide(group:getCoalition())
      local start_pos = bmbrstrike.getFirstActiveUnit(group):getPoint()
      local leg_dist = math.random(bmbrstrike[side].bomb.leg_min, bmbrstrike[side].bomb.leg_max)
      local sead_route = bmbrstrike.buildRoute(start_pos, self.zone.name, self.vul_time, leg_dist)
      local sead_task = {
        id = 'Mission',
        params = {
          route = sead_route
        }
      }

      self.intercepting = false

      ctl:setTask(sead_task)
      self:enterZone()
      	ctl:setOption(0, 0) --weapon free, open fire weapon free, open fire, return fire, weapon hold
	ctl:setOption(1, 0) --no reaction, passive, evade, bypass, allow abort
	ctl:setOption(4, 1) --cms never, against missile, in sam wez, near enemies
	ctl:setOption(3, 3) --radar using never, attack only, for search, continuous
	ctl:setOption(6, 1) --rtb on bingo
	--ctl:setOption(10, 1) --rtb on bingo
	ctl:setOption(6, 0) --alarm state, auto, green, red
	ctl:setOption(15, 1) --prohibit jettison
	ctl:setOption(25, 1) --jettison tanks if empty
	ctl:setOption(28, 2) --engage any, engage air, engage ground only

      if not cold then
        bmbrstrike.taskEngage(group)
      end
      bmbrstrike.log:info("Tasking $1 with CAS in zone $2", group:getName(), self.zone.name)
    end
  end
  


  --- Tasks the flight to return to it's homeplate.
  -- @tparam[opt] Airbase airbase optionally use this as homeplate/airbase
  -- to return to.
  -- @tparam[opt] boolean cold If set to true the flight won't
  -- engage any targets it detects on the way back to base.
  -- Default false.
  function bmbrstrike.Flight:taskWithRTB(airbase, cold)
    if not airbase then
      airbase = self.airbase
    end

    if self.zone then
      self:leaveCASZone()
      local side = self.side
      -- let's try to spawn a new CAS flight as soon as the current one is tasked with RTB.
      -- never spawn more than 2 x the groups_count, to prevent spam in case something ever goes wrong.
      if (not bmbrstrike[side].limit_resources or
        (bmbrstrike[side].limit_resources and bmbrstrike[side].supply > 0))
        and #bmbrstrike[side].bomb.flights < bmbrstrike[side].bomb.groups_count * 2 then
        bmbrstrike.spawn(side, self.zone, bmbrstrike[side].bomb.spawn_mode)
      end
    end
    self.rtb = true
    local group = self.group
    local ctl = group:getController()
    local af_pos = mist.utils.makeVec2(airbase:getPoint())
    local af_id = airbase:getID()
    local rtb_task = {
      id = 'Mission',
      params = {
        route = {
          points = {
            [1] = {
              alt = bmbrstrike.bomb.min_alt,
              alt_type = "BARO",
              speed = bmbrstrike.bomb.speed,
              x = af_pos.x,
              y = af_pos.y,
              aerodromeId = af_id,
              type = "Land",
              action = "Landing",
            }
          }
        }
      }
    }

    ctl:setTask(rtb_task)

    if not cold then
      -- only engage if enemy is inside of 10km of the leg
      --bmbrstrike.taskEngage(group, 10000)
	  bmbrstrike.taskEngageBomb(side)
    end

    bmbrstrike.log:info("Tasking $1 with RTB to $2", group:getName(), airbase:getName())
  end

  --- Functions
  -- @section bmbrstrike

  --- Clean up inactive/stuck flights.
  local function garbageCollector(side)
    local timestamp = timer.getAbsTime()
    for t, task in pairs(bmbrstrike.tasks) do
      for f, flight in pairs(bmbrstrike[side][task].flights) do
        if flight.group then
          if flight.group:isExist() then
            for u = 1, #flight.units_moved do
              local unit = flight.units_moved[u].unit
              -- check if unit exists
              if unit then
                if unit:isExist() then
                  -- if unit is in air we won't do anything
                  if not unit:inAir() then
                    -- check if unit is moving
                    local mag = mist.vec.mag(unit:getVelocity())
                    if mag == 0 then
                      -- get the last time the unit moved
                      local last_moved = flight.units_moved[u].last_moved
                      if timestamp - last_moved > bmbrstrike.move_timeout then
                        bmbrstrike.log:info("Cleaning up $1", flight.group:getName())
                        flight.group:destroy()
                        flight:remove()
                      end
                    else
                      flight.units_moved[u].last_moved = timestamp
                    end
                  end
                end
              end
            end
          else
            flight:remove()
          end
        else
          flight:remove()
        end
      end
    end
  end

  local function checkForTemplateUnits(side)
    if bmbrstrike[side].bomb.enabled then
      for i = 1, bmbrstrike.template_count do
        local unit = bmbrstrike.bomb.template_prefix[side]..side..i
        if not Unit.getByName(unit) then
          bmbrstrike.log:alert("BMBR template unit missing: $1", unit)
          return false
        end
      end
    end
    if bmbrstrike[side].borders_enabled then
      if not Group.getByName(bmbrstrike[side].border_group) then
        bmbrstrike.log:alert("Border group is missing: $1", bmbrstrike[side].border_group)
        return false
      end
    end
    return true
  end

  local function checkForTriggerZones(side)
    for i = 1, bmbrstrike[side].bomb.zones_count do
      local zone_name = bmbrstrike[side].bomb.zone_name
      if not trigger.misc.getZone(zone_name) then
        bmbrstrike.log:alert("sead trigger zone is missing: $1", zone_name)
        return false
      end
    end
    return true
  end

  local function manage(side)
    local patroled_zones = 0

    for i = 1, #bmbrstrike[side].bomb.zones do
      local zone = bmbrstrike[side].bomb.zones[i]
      bmbrstrike.log:info("Zone $1 has $2 patrols", zone.name, zone.patrol_count)

      -- see if we can send a new sead into the zone
      if zone.patrol_count <= 0 then
        -- first check if we already hit the maximum amounts of routine sead groups
        if #bmbrstrike[side].bomb.flights < bmbrstrike[side].bomb.groups_count then
          -- check if we limit resources and if we have enough supplies
          -- if we don't limit resource or have enough supplies we spawn
          if not bmbrstrike[side].limit_resources or
            (bmbrstrike[side].limit_resources and bmbrstrike[side].supply > 0) and bmbrstrike.allowspawn == true then
            -- finally spawn it
            bmbrstrike.spawn(side, bmbrstrike[side].bomb.zones[i], bmbrstrike[side].bomb.spawn_mode)
			bmbrstrike.allowspawn = false;
          end
        end
      else
        patroled_zones = patroled_zones + 1
      end
    end
    -- if all zones are patroled and we still have sead groups left
    -- send them to a random zone
    if #bmbrstrike[side].bomb.flights < bmbrstrike[side].bomb.groups_count then
      if not bmbrstrike[side].limit_resources or
        (bmbrstrike[side].limit_resources and bmbrstrike[side].supply > 0) then
        local random_zone = math.random(1, #bmbrstrike[side].bomb.zones)
        bmbrstrike.spawn(side, bmbrstrike[side].bomb.zones[random_zone], bmbrstrike[side].bomb.spawn_mode)
      end
    end
    bmbrstrike.log:info("$1 patrols in $2/$3 zones with $4 flights",
                    side, patroled_zones, bmbrstrike[side].bomb.zones_count, #bmbrstrike[side].bomb.flights)
  end
  
  -- returns airfields of given side which are marked with
  -- triggerzones (triggerzone name is exactly the same as airfield name).
  local function getAirfields(side)
    local coal_airfields = coalition.getAirbases(bmbrstrike.sideToCoalition(side))
    local bmbrstrike_airfields = {}

    -- loop over all coalition airfields
    for i = 1, #coal_airfields do
      -- get name of airfield
      local af_name = coal_airfields[i]:getName()
      if not string.match(af_name, "FARP") then
        -- check if a triggerzone exists with that exact name
        if mist.DBs.zonesByName[af_name] then
          -- add it to our airfield list for bmbrstrike
          bmbrstrike_airfields[#bmbrstrike_airfields + 1] = coal_airfields[i]
        end
      end
    end

    if #bmbrstrike_airfields == 0 then
      bmbrstrike.log:warn("No airbase for $1 found", side)
    end
    return bmbrstrike_airfields
  end

  -- returns all currently active aircraft of the given side
  -- parameter side has to be "red" or "blue"
  local function getAllActiveAircrafts(side)
    local filter = { "[" .. side .. "][plane]", "[" .. side .. "][helicopter]", "[" .. side .. "][vehicle]"}
    local all_aircraft = mist.makeUnitTable(filter)
    local active_aircraft = {}

    for i = 1, #all_aircraft do
      local ac = Unit.getByName(all_aircraft[i])
      if ac ~= nil then
        if Unit.isActive(ac) then
          table.insert(active_aircraft, ac)
        end
      end
    end
    if #active_aircraft == 0 then
      bmbrstrike.log:warn("No active aircraft for $1 found", side)
    end
    return active_aircraft
  end

  -- returns a random airfield for the given side
  local function getRandomAirfield(side)
    local rand = math.random(1, #bmbrstrike[side].airfields)
    return bmbrstrike[side].airfields[rand]
  end

  local function buildFirstWp(airbase, spawn_mode)
    local airbase_pos = airbase:getPoint()
    local airbase_id = airbase:getID()
    local wp = mist.fixedWing.buildWP(airbase_pos)

    if spawn_mode == "parking" then -- start from parking area
      wp.airdromeId = airbase_id
      wp.type = "TakeOffParking"
      wp.action = "From Parking Area"
    elseif spawn_mode == "takeoff" then -- or start from runway
      wp.airdromeId = airbase_id
      wp.type = "TakeOff"
      wp.action = "From Runway"
    elseif spawn_mode == "air" then
      -- randomize spawn position a little bit in seade of air start
      wp.x = wp.x + (50 * math.sin(math.random(10)))
      wp.y = wp.y + (50 * math.sin(math.random(10)))
    end

    return wp
  end

  --- Converts coaltion number to side string.
  -- 0 = "neutral", 1 = "red", 2 = "blue"
  -- @tparam number coal coaltion number.
  -- @treturn string side
  function bmbrstrike.coalitionToSide(coal)
    if coal == coalition.side.NEUTRAL then return "neutral"
    elseif coal == coalition.side.RED then return "red"
    elseif coal == coalition.side.BLUE then return "blue"
    end
  end

  --- Converts side string to coaltion number.
  -- 0 = "neutral", 1 = "red", 2 = "blue"
  -- @tparam string side side string.
  -- @treturn number coalition number.
  -- @see coalitionToSide
  function bmbrstrike.sideToCoalition(side)
    if side == "neutral" then return coalition.side.NEUTRAL
    elseif side == "red" then return coalition.side.RED
    elseif side == "blue" then return coalition.side.BLUE
    end
  end

  --- Returns first active unit of a group.
  -- @tparam Group group group whose first active
  -- unit to return.
  -- @treturn Unit first active unit of group.
    function bmbrstrike.getFirstActiveUnit(group)
    if group ~= nil then
      -- engrish mast0r isExistsingsed
      if not group:isExist() then return nil end
      local units = group:getUnits()
      for i = 1, group:getSize() do
        if units[i] then
          return units[i]
        end
      end
      return nil
    else
      return nil
    end
  end

  --- Returns the closest airfield to unit.
  -- Returned airfield is controlled by given side. This function
  -- also returns the distance to the unit.
  -- @tparam string side side string, either "red" or "blue".
  -- The airfield returned has to be controlled by this side.
  -- @tparam Unit unit unit to use as reference.
  -- @treturn table @{closestAirfieldReturn}
  function bmbrstrike.getClosestAirfieldToUnit(side, unit)
    if not unit then
      bmbrstrike.log:error("Couldn't find unit.")
      return
    end
    local airfields = bmbrstrike[side].airfields

    if #airfields == 0 then
      bmbrstrike.log:warn("There are no airfields of side $1", side)
      return nil
    end

    local unit_pos = mist.utils.makeVec2(unit:getPoint())
    local min_distance = -1
    local closest_af = nil

    for i = 1, #airfields do
      local af = airfields[i]
      local af_pos = mist.utils.makeVec2(af:getPoint())
      local distance = mist.utils.get2DDist(unit_pos, af_pos)

      if distance < min_distance or min_distance == -1 then
        min_distance = distance
        closest_af = af
      end
    end

    --- Table returned by getClosestAirfieldToUnit.
    -- @table closestAirfieldReturn
    -- @tfield Airbase airfield the Airbase object
    -- @tfield number distance the distance in meters
    -- to the unit.
    --return {airfield = closest_af, distance = min_distance}
    return closest_af, min_distance
  end



  --- Returns a table containting a sead route.
  -- Route originating from given airbase, waypoints
  -- are placed randomly inside given zone. Optionally
  -- you can specify the amount of waypoints inside the zone.
  -- @tparam string zone trigger zone name
  -- @tparam number vul_time time on station
  -- @tparam number leg_distance leg distance for race-track pattern orbit.
  function bmbrstrike.buildRoute(start_pos, zone, vul_time, leg_distance)
    local points = {}
    -- make altitude consistent for the whole route.
    local alt = math.random(bmbrstrike.bomb.min_alt, bmbrstrike.bomb.max_alt)

    local start_vul_script = "local group = ...\
                local flight = bmbrstrike.Flight.getFlight(group)\
                if flight then\
                  bmbrstrike.log:info('$1 starting vul time $2 at $3',\
                                  flight.group_name, flight.vul_time, flight.zone.name)\
                  flight.vul_start = timer.getAbsTime()\
                else\
                  bmbrstrike.log:error('Could not find flight')\
                end"

    local end_vul_script = "local group = ...\
                local flight = bmbrstrike.Flight.getFlight(group)\
                if flight then\
                  bmbrstrike.log:info('$1 vul time over at $2',\
                                  flight.group_name, flight.zone.name)\
                  flight:taskWithRTB()\
                else\
                  bmbrstrike.log:error('Could not find flight')\
                end"

    -- build orbit start waypoint
    local orbit_start_point = mist.getRandomPointInZone(zone)
    -- add a bogus waypoint so the start vul time script block
    -- isn't executed instantly after tasking
    points[1] = mist.fixedWing.buildWP(start_pos)
    points[2] = mist.fixedWing.buildWP(orbit_start_point)
    points[2].task = {}
    points[2].task.id = 'ComboTask'
    points[2].task.params = {}
    points[2].task.params.tasks = {}
    points[2].task.params.tasks[1] = {
      number = 1,
      auto = false,
      id = 'WrappedAction',
      enabled = true,
      params = {
        action = {
          id = 'Script',
          params = {
            command = start_vul_script
          }
        }
      }
    }
    points[2].task.params.tasks[2] = {
      number = 2,
      auto = false,
      id = 'ControlledTask',
      enabled = true,
      params = {
        task = {
          id = 'Orbit',
          params = {
            altitude = alt,
            pattern = 'Race-Track',
            speed = bmbrstrike.bomb.speed
          }
        },
        stopCondition = {
          duration = vul_time * 60
        }
      }
    }

    -- if we don't use the race-track pattern we'll add the vul end time
    -- waypoint right where the start waypoint is and use the 'Circle' pattern.
    local orbit_end_point
    if not bmbrstrike.bomb.race_track_orbit then
      points[2].task.params.tasks[2].params.task.params.pattern = 'Circle'
      orbit_end_point = start_pos
    else
      -- build second waypoint (leg end waypoint)
      --local orbit_end_point = mist.getRandPointInCircle(orbit_start_point, leg_distance, leg_distance)
	  local orb_dist = mist.random(bmbrstrike.bomb.orbit_end_min_dist, bmbrstrike.bomb.orbit_end_max_dist)
      orbit_end_point = mist.getRandomPointInZone(zone, orb_dist)
    end

    points[3] = mist.fixedWing.buildWP(orbit_end_point)
    points[3].task = {
      id = 'WrappedAction',
      params = {
        action = {
          id = 'Script',
          params = {
            command = end_vul_script
          }
        }
      }
    }

    for i = 1, 3 do
      points[i].speed = bmbrstrike.bomb.speed
      points[i].alt = alt
    end

    -- local ground_level = land.getHeight(point)
    -- -- avoid crashing into hills
    -- if (alt - 100) < ground_level then
    --   alt = alt + ground_level
    -- end

    bmbrstrike.log:info("Built CAS route with $1 min vul time at $2 meters in $3", vul_time, alt, zone)

    local route = {}
    route.points = points
    return route
  end
  

  --- Tasks group to automatically engage any spotted targets.
  -- @tparam Group group group to task.
  -- @tparam[opt] number max_dist maximum engagment distance.
  -- Targets further out (from the route) won't be engaged.
  function bmbrstrike.taskEngage(group, max_dist)
    if not max_dist then
      max_dist = bmbrstrike.bomb.max_engage_distance
    end
    local ctl = group:getController()
    local engage = {
      id = 'EngageTargets',
      params = {
        maxDist = max_dist,
        maxDistEnabled = true,
        targetTypes = { [1] = "All"},
        priority = 0
      }
    }
    ctl:pushTask(engage)
  end

  --- Tasks group to engage a group.
  -- @tparam Group group group to task.
  -- @tparam Group target group that should be engaged by
  -- given group.
  function bmbrstrike.taskEngageGroup(group, target)
    local ctl = group:getController()
    local engage_group = {
      id = 'EngageGroup',
      params = {
        groupId = target:getID(),
        directionEnabled = false,
        priority = 0,
        altittudeEnabled = false,
      }
    }
    ctl:pushTask(engage_group)
  end

  --- Spawns a fighter group.
  -- @tparam string side side of the newly created group.
  -- Can be "red" or "blue".
  -- @tparam string name new group name.
  -- @tparam number size count of aircraft in the new group.
  -- @tparam Airbase airbase home plate of the new group.
  -- @tparam string spawn_mode How the new group will be spawned.
  -- Can be 'parking' or 'air'. 'parking' will spawn them at the ramp
  -- wit engines turned off. 'air' will spawn them in the air already
  -- flying.
  -- @tparam string task Task of the new group.
  -- for 'cas', or 'sead'.
  -- @tparam[opt] string zone zone name in which to spawn the unit. This only is
  -- taken into account if spawn_mode is "in-zone".
  -- @tparam[opt] boolean cold if set to true the newly group won't engage
  -- any enemys until tasked otherwise. Default false.
  -- @treturn Group|nil newly spawned group or nil on failure.
  function bmbrstrike.spawnFighterGroup(side, name, size, airbase, spawn_mode, task, zone, cold)
    local template_unit_name = bmbrstrike[task].template_prefix[side]..side..math.random(1, bmbrstrike.template_count)
    local template_unit = Unit.getByName(template_unit_name)
    if not template_unit then
      bmbrstrike.log:error("Can't find template unit $1. This should never happen.\
                       Somehow the template unit got deleted.", template_unit_name)
      return nil
    end
    local template_group = mist.getGroupData(template_unit:getGroup():getName())
    local template_unit_data = template_group.units[1]
    local airbase_pos = airbase:getPoint()
    local group_data = {}
    local unit_data = {}
    local onboard_num = template_unit_data.onboard_num - 1
    local route = {}

    local rand_point = {}
    if spawn_mode == "in-zone" then
      rand_point = mist.getRandomPointInZone(zone)
    end

    for i = 1, size do
      unit_data[i] = {}
      unit_data[i].type = template_unit_data.type
      unit_data[i].name = name.." Pilot "..i
      if spawn_mode == "in-zone" then
        unit_data[i].x = rand_point.x + (50 * math.sin(math.random(10)))
        unit_data[i].y = rand_point.y + (50 * math.sin(math.random(10)))
      else
        unit_data[i].x = airbase_pos.x + (50 * math.sin(math.random(10)))
        unit_data[i].y = airbase_pos.z + (50 * math.sin(math.random(10)))
      end
      unit_data[i].alt = bmbrstrike[side].bomb.min_alt
      unit_data[i].onboard_num =  onboard_num + i
      unit_data[i].groupName = name
      unit_data[i].payload = template_unit_data.payload
      unit_data[i].skill = template_unit_data.skill
      unit_data[i].livery_id = template_unit_data.livery_id
      if side == 'blue' then
        unit_data[i].callsign = {}
        unit_data[i].callsign[1] = 4 -- Colt
        unit_data[i].callsign[2] = bmbrstrike[side].bomb.flight_num
        unit_data[i].callsign[3] = i
      else
        unit_data[i].callsign = 600 + bmbrstrike[side].bomb.flight_num + i
      end
    end

    group_data.units = unit_data
    group_data.groupName = name
    group_data.hidden = bmbrstrike[side].hide_groups
    --group_data.country = template_group.country
    group_data.country = template_unit:getCountry()
    group_data.category = template_group.category
    group_data.task = "CAS"

    route.points = {}
    if spawn_mode == "in-zone" then
      route.points[1] = mist.fixedWing.buildWP(rand_point)
      route.points[1].alt = bmbrstrike[side].bomb.min_alt
      route.points[1].speed = bmbrstrike[side].bomb.speed
    else
      route.points[1] = buildFirstWp(airbase, spawn_mode)
    end
    group_data.route = route

    if mist.groupTableCheck(group_data) then
      local spawn_pos = airbase:getName()
      if spawn_mode == "in-zone" then
        spawn_pos = zone
      end
      bmbrstrike.log:info("Spawning fighter group $1 at $2", name, spawn_pos)
      mist.dynAdd(group_data)
    else
      bmbrstrike.log:error("Couldn't spawn group with following groupTable: $1", group_data)
    end

    return Group.getByName(name)
  end
  
  --- Spawns a CAS flight.
  -- @tparam string side side for the new CAS.
  -- @tparam string zone CAS zone (trigger zone) name.
  -- @tparam string spawn_mode how the new CAS will be spawned.
  -- Can be 'parking' or 'air'.
  function bmbrstrike.spawn(side, zone, spawn_mode)
    -- increase flight number
    bmbrstrike[side].bomb.flight_num = bmbrstrike[side].bomb.flight_num + 1
    -- select random airbase (for now) TODO: choose closest airfield
    local airbase = getRandomAirfield(side)
    local group_name = "BMBR "..side.." "..bmbrstrike[side].bomb.flight_num
    -- define size of the flight
    local size = bmbrstrike[side].bomb.group_size
    if size == "randomized" then
      size = math.random(1,2)*2
    else
      size = tonumber(size)
    end
    -- actually spawn something
    local group = bmbrstrike.spawnFighterGroup(side, group_name, size, airbase, spawn_mode, "bomb", zone.name)
    --local ctl = group:getController()
    --ctl:setOption(AI.Option.Air.id.RADAR_USING, AI.Option.Air.val.RADAR_USING.FOR_ATTACK_ONLY)
    bmbrstrike[side].supply = bmbrstrike[side].supply - 1
    -- keep track of the flight
    local flight = bmbrstrike.Flight:new(group, airbase, "bomb", zone)
    -- task the group, for some odd reason we have to wait until we use setTask
    -- on a freshly spawned group.
    mist.scheduleFunction(bmbrstrike.Flight.taskWith, {flight}, timer.getTime() + 5)
    return group
  end


  --- Initialization function
  -- Checks if all template units are present. Creates
  -- border polygons if borders enabled.
  -- @todo complete documentation.
  function bmbrstrike.init()
    for i, side in pairs(bmbrstrike.sides) do
    -- if not (checkForTemplateUnits(side) and checkForTriggerZones(side)) then
     --   return false
    --  end

      bmbrstrike[side].bomb.zones = {}
      bmbrstrike[side].bomb.flights = {}
      bmbrstrike[side].bomb.flight_num = 0
      bmbrstrike[side].airfields = getAirfields(side)

      if bmbrstrike[side].bomb.enabled then
        -- loop through all zones
        for i = 1, bmbrstrike[side].bomb.zones_count do
          local zone_name = bmbrstrike[side].bomb.zone_name
          local point = trigger.misc.getZone(zone_name).point
          local size = trigger.misc.getZone(zone_name).radius

          -- create zone table
          bmbrstrike[side].bomb.zones[i] = {
            name = zone_name,
            pos = point,
            radius = size,
            patrol_count = 0,
          }
        end

        for i = 1, bmbrstrike[side].bomb.groups_count do
          local spawn_mode = "parking"
          if bmbrstrike[side].bomb.start_airborne then
            spawn_mode = "in-zone"
          end
          -- try to fill all zones
          local zone = bmbrstrike[side].bomb.zones[i]
          -- if we have more flights than zones we select one random zone
          if zone == nil then
            zone = bmbrstrike[side].bomb.zones[math.random(1, bmbrstrike[side].bomb.zones_count)]
          end
          -- actually spawn the group
          --local grp = bmbrstrike.spawnCAS(side, zone, spawn_mode)
          -- delay the spawn by bmbrstrike interval seconds after one another
          local spawn_delay = (i - 1) * bmbrstrike.initial_spawn_delay
          mist.scheduleFunction(bmbrstrike.spawn, {side, zone, spawn_mode}, timer.getTime() + spawn_delay)
        end
      end
    end
    -- add event handler managing despawns
    return true
  end

  --- Main function.
  -- Run approx. every @{bmbrstrike.interval} sconds. A random amount
  -- of 0 to 2 seconds is added for declustering.
  -- @todo do the "declustering" at a different level. Probably
  -- more efficient.
  function bmbrstrike.main()
    for i, side in pairs(bmbrstrike.sides) do
      -- update list of occupied airfields
      bmbrstrike[side].airfields = getAirfields(side)
      -- update list of all aircraft
      bmbrstrike[side].active_aircraft = getAllActiveAircrafts(side)
      -- update list of all EWR
      --bmbrstrike[side].active_ewr = getAllActiveEWR(side)
    end

    -- check for airspace intrusions after updating all the lists
    for i, side in pairs(bmbrstrike.sides) do
      manage(side)
      --checkForAirspaceIntrusion(side)
      --handleIntrusion(side)
      garbageCollector(side)
    end
  end

end

    --- Tasks group to automatically engage any spotted targets.
  -- @tparam Group group group to task.
  -- @tparam[opt] number max_dist maximum engagment distance.
  -- Targets further out (from the route) won't be engaged.
  function bmbrstrike.taskEngageBomb(side)
    local ctl = group:getController()
	local target = {}
	target.expend = "Two"
	target.weaponType = 16
	target.attackQty = 3
	
	
	if side == "red" then
	target.point = redStrikePos
	end
	
	if side == "blue" then
	target.point = blueStrikePos
	end	
	
	local engage = {id = 'Bombing', params = target}
    ctl:pushTask(engage)
  end

if bmbrstrike.init() then
  local start_delay = bmbrstrike.initial_spawn_delay * math.max(bmbrstrike.red.bomb.groups_count, bmbrstrike.blue.bomb.groups_count)
  mist.scheduleFunction(bmbrstrike.main, {}, timer.getTime() + start_delay, bmbrstrike.interval)
end

local function resetTimer(arg)
bmbrstrike.allowspawn = true
mist.scheduleFunction(resetTimer, {""}, timer.getTime() + bmbrstrike.next_spawn_delay)
--return
end
