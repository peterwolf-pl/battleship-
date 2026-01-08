local SHIP_NAME = "batleship"
local TURRET_NAME = "batleship-artillery-turret"
local AMMO_NAME = "artillery-shell"
local AMMO_TARGET = 15

local OFFSETS = {
  {x = -3, y = 0},
  {x = 0, y = 0},
  {x = 3, y = 0}
}

local function get_ship_inventory(ship)
  if not ship or not ship.valid then
    return nil
  end

  local inventory = ship.get_inventory(defines.inventory.cargo_wagon)
  if inventory then
    return inventory
  end

  inventory = ship.get_inventory(defines.inventory.car_trunk)
  if inventory then
    return inventory
  end

  inventory = ship.get_inventory(defines.inventory.chest)
  if inventory then
    return inventory
  end

  return nil
end

local function get_turret_inventory(turret)
  if turret and turret.valid then
    return turret.get_inventory(defines.inventory.turret_ammo)
  end
  return nil
end

local function ensure_global()
  global.batleships = global.batleships or {}
end

local function create_turret(ship, offset)
  if not ship or not ship.valid then
    return nil
  end

  return ship.surface.create_entity({
    name = TURRET_NAME,
    position = {x = ship.position.x + offset.x, y = ship.position.y + offset.y},
    force = ship.force,
    raise_built = true
  })
end

local function remove_turrets(entry)
  if not entry or not entry.turrets then
    return
  end

  for _, turret in pairs(entry.turrets) do
    if turret and turret.valid then
      turret.destroy({raise_destroy = true})
    end
  end
end

local function ensure_turrets(entry)
  if not entry or not entry.ship or not entry.ship.valid then
    return
  end

  entry.turrets = entry.turrets or {}
  entry.offsets = entry.offsets or OFFSETS

  for index, offset in ipairs(entry.offsets) do
    local turret = entry.turrets[index]
    if not (turret and turret.valid) then
      entry.turrets[index] = create_turret(entry.ship, offset)
    end
  end
end

local function register_ship(ship)
  if not ship or not ship.valid or ship.name ~= SHIP_NAME then
    return
  end

  ensure_global()
  if global.batleships[ship.unit_number] then
    return
  end

  local entry = {
    ship = ship,
    turrets = {},
    offsets = OFFSETS
  }

  global.batleships[ship.unit_number] = entry
  ensure_turrets(entry)
end

local function unregister_ship(ship)
  if not ship then
    return
  end

  ensure_global()
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
  ensure_global()
  for unit_number, entry in pairs(global.batleships) do
    if not entry.ship or not entry.ship.valid then
      remove_turrets(entry)
      global.batleships[unit_number] = nil
    end
  end
end

local function load_ammo_for_entry(entry)
  if not entry or not entry.ship or not entry.ship.valid then
    return
  end

  ensure_turrets(entry)
  local ship_inventory = get_ship_inventory(entry.ship)
  if not ship_inventory then
    return
  end

  for _, turret in pairs(entry.turrets or {}) do
    local turret_inventory = get_turret_inventory(turret)
    if turret_inventory and turret_inventory.valid then
      local current = turret_inventory.get_item_count(AMMO_NAME)
      local missing = AMMO_TARGET - current
      if missing > 0 then
        local available = ship_inventory.get_item_count(AMMO_NAME)
        if available > 0 then
          local insertable = turret_inventory.get_insertable_count(AMMO_NAME)
          local to_move = math.min(available, missing, insertable)
          if to_move > 0 then
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

local function on_nth_tick()
  ensure_global()
  cleanup_invalid_entries()
  for _, entry in pairs(global.batleships) do
    load_ammo_for_entry(entry)
  end
end

script.on_init(function()
  global.batleships = {}
end)

script.on_configuration_changed(function()
  ensure_global()
  cleanup_invalid_entries()
end)

script.on_event({
  defines.events.on_built_entity,
  defines.events.on_robot_built_entity
}, on_entity_built)

script.on_event({
  defines.events.on_player_mined_entity,
  defines.events.on_robot_mined_entity,
  defines.events.on_entity_died
}, on_entity_removed)

script.on_nth_tick(30, on_nth_tick)

-- Test checklist:
-- 1) Postaw statek i potwierdź, że 3 działa pojawiają się na offsetach (-3,0), (0,0), (3,0).
-- 2) Włóż artillery-shell do ładowni statku i sprawdź, że każde działo ładuje się do 15 sztuk.
-- 3) Wykop lub zniszcz statek i potwierdź usunięcie dział.
-- 4) Usuń pojedyncze działo skryptem i sprawdź, że zostaje odtworzone.
