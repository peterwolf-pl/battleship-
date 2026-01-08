local ship = {
  type = "container",
  name = "batleship",
  icon = "__base__/graphics/icons/cargo-wagon.png",
  icon_size = 64,
  flags = {"placeable-neutral", "player-creation"},
  minable = {mining_time = 1, result = "batleship"},
  max_health = 1000,
  corpse = "small-remnants",
  inventory_size = 64,
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  picture = {
    layers = {
      {
        filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon.png",
        priority = "very-low",
        width = 256,
        height = 256,
        scale = 0.5
      },
      {
        filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow.png",
        priority = "very-low",
        width = 256,
        height = 256,
        scale = 0.5,
        draw_as_shadow = true
      }
    }
  }
}

data:extend({ship})
