local ship = {
  -- Using "car" keeps the entity simple, placeable on any terrain, and provides an inventory
  -- without requiring rails or special placement constraints.
  type = "car",
  name = "batleship",
  icon = "__base__/graphics/icons/car.png",
  icon_size = 64,
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 1, result = "batleship"},
  max_health = 1200,
  corpse = "medium-remnants",
  effectivity = 1,
  braking_power = "200kW",
  consumption = "200kW",
  friction = 0.002,
  rotation_speed = 0.01,
  weight = 2000,
  inventory_size = 0,
  trunk_inventory_size = 120,
  collision_box = {{-1.0, -1.0}, {1.0, 1.0}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  animation = {
    layers = {
      {
        width = 102,
        height = 86,
        frame_count = 2,
        direction_count = 64,
        shift = {0, -0.1875},
        animation_speed = 8,
        max_advance = 1,
        stripes = {
          {
            filename = "__base__/graphics/entity/car/car-1.png",
            width_in_frames = 2,
            height_in_frames = 22
          },
          {
            filename = "__base__/graphics/entity/car/car-2.png",
            width_in_frames = 2,
            height_in_frames = 22
          },
          {
            filename = "__base__/graphics/entity/car/car-3.png",
            width_in_frames = 2,
            height_in_frames = 20
          }
        }
      },
      {
        width = 102,
        height = 86,
        frame_count = 2,
        direction_count = 64,
        shift = {0, -0.1875},
        draw_as_shadow = true,
        animation_speed = 8,
        max_advance = 1,
        stripes = {
          {
            filename = "__base__/graphics/entity/car/car-shadow-1.png",
            width_in_frames = 2,
            height_in_frames = 22
          },
          {
            filename = "__base__/graphics/entity/car/car-shadow-2.png",
            width_in_frames = 2,
            height_in_frames = 22
          },
          {
            filename = "__base__/graphics/entity/car/car-shadow-3.png",
            width_in_frames = 2,
            height_in_frames = 20
          }
        }
      }
    }
  }
}

data:extend({ship})
