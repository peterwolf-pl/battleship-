-- Using "car" keeps the entity simple, placeable on any terrain, and provides an inventory
-- without requiring rails or special placement constraints.
local ship = table.deepcopy(data.raw["car"]["car"])
ship.name = "batleship"
ship.icon = "__base__/graphics/icons/car.png"
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
