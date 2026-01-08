-- Use the cargo ship prototype from the cargo-ships mod as the base entity.
local function find_cargo_ship_prototype()
  local direct = data.raw["cargo-ship"] and data.raw["cargo-ship"]["cargo-ship"]
  if direct then
    return direct
  end

  local by_name = data.raw["car"] and data.raw["car"]["cargo-ship"]
  if by_name then
    return by_name
  end

  for _, prototypes in pairs(data.raw) do
    if prototypes["cargo-ship"] then
      return prototypes["cargo-ship"]
    end
  end

  error("cargo ship prototype not found; ensure the cargo-ships mod is enabled.")
end

local ship = table.deepcopy(find_cargo_ship_prototype())
ship.name = "batleship"
ship.icon = "__cargo-ships__/graphics/icons/cargo-ship.png"
ship.icon_size = 64
ship.flags = {"placeable-neutral", "player-creation"}
ship.minable = {mining_time = 1, result = "batleship"}
ship.max_health = 800
ship.corpse = "medium-remnants"
ship.effectivity = 0.6
ship.braking_power = "200kW"
ship.consumption = "350kW"
ship.friction = 0.01
ship.rotation_speed = 0.01
ship.weight = 2000
ship.inventory_size = 0
ship.trunk_inventory_size = 120
ship.collision_box = {{-1.8, -1.8}, {1.8, 1.8}}
ship.selection_box = {{-2.2, -2.2}, {2.2, 2.2}}

data:extend({ship})
