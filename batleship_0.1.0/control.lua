local SHIP_NAME = "batleship"
local TURRET_NAME = "batleship-artillery-turret"
local AMMO_NAME = "artillery-shell"

local function get_ship_inventory(ship)
  if ship and ship.valid then
    return ship.get_inventory(defines.inventory.chest)
  end
  return nil
end

local function get_turret_inventory(turret)
  if turret and turret.valid then
    return turret.get_inventory(defines.inventory.turret_ammo)
  end
  return nil
end

local function remove_turrets(entry)
  if not entry or not entry.turrets then
    return
  end
  for _, turret in pairs(entry.turrets) do
    if turret and turret.valid then
      turret.destroy()
    end
  end
end

local function create_turrets_for_ship(ship)
  local offsets = {
    {0.0, -1.5},
    {-1.0, 1.0},
    {1.0, 1.0}
  }

  local turrets = {}
  for index, offset in ipairs(offsets) do
    local position = {x = ship.position.x + offset[1], y = ship.position.y + offset[2]}
    local turret = ship.surface.create_entity({
      name = TURRET_NAME,
      position = position,
      force = ship.force
    })
    turrets[index] = turret
  end
  return turrets
end

local function register_ship(ship)
  if not ship or not ship.valid or ship.name ~= SHIP_NAME then
    return
  end
  global.batleships = global.batleships or {}
  if global.batleships[ship.unit_number] then
    return
  end
  local turrets = create_turrets_for_ship(ship)
  global.batleships[ship.unit_number] = {
    ship = ship,
    turrets = turrets
  }
end

local function unregister_ship(ship)
  if not ship or not ship.valid then
    return
  end
  if not global.batleships then
    return
  end
  local entry = global.batleships[ship.unit_number]
  if entry then
    remove_turrets(entry)
    global.batleships[ship.unit_number] = nil
  end
end

local function on_entity_built(event)
  local entity = event.created_entity or event.entity
  if entity and entity.valid and entity.name == SHIP_NAME then
    register_ship(entity)
  end
end

local function on_entity_removed(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == SHIP_NAME then
    unregister_ship(entity)
  end
end

local function cleanup_invalid_entries()
  if not global.batleships then
    return
  end
  for unit_number, entry in pairs(global.batleships) do
    if not entry.ship or not entry.ship.valid then
      remove_turrets(entry)
      global.batleships[unit_number] = nil
    end
  end
end

local function load_ammo()
  if not global.batleships then
    return
  end
  for _, entry in pairs(global.batleships) do
    local ship = entry.ship
    if ship and ship.valid then
      local ship_inventory = get_ship_inventory(ship)
      if ship_inventory then
        for _, turret in pairs(entry.turrets or {}) do
          local turret_inventory = get_turret_inventory(turret)
          if turret_inventory and turret_inventory.valid then
            local available = ship_inventory.get_item_count(AMMO_NAME)
            if available > 0 then
              local insertable = turret_inventory.get_insertable_count(AMMO_NAME)
              if insertable > 0 then
                local to_move = math.min(available, insertable)
                local removed = ship_inventory.remove({name = AMMO_NAME, count = to_move})
                if removed > 0 then
                  turret_inventory.insert({name = AMMO_NAME, count = removed})
                end
              end
            end
          end
        end
      end
    end
  end
end

script.on_init(function()
  global.batleships = {}
end)

script.on_configuration_changed(function()
  global.batleships = global.batleships or {}
  cleanup_invalid_entries()
end)

script.on_event({
  defines.events.on_built_entity,
  defines.events.on_robot_built_entity,
  defines.events.script_raised_built,
  defines.events.script_raised_revive
}, on_entity_built)

script.on_event({
  defines.events.on_pre_player_mined_item,
  defines.events.on_robot_pre_mined,
  defines.events.on_entity_died,
  defines.events.script_raised_destroy
}, on_entity_removed)

script.on_nth_tick(30, function()
  cleanup_invalid_entries()
  load_ammo()
end)
