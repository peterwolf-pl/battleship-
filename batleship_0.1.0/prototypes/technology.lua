local tech = {
  type = "technology",
  name = "batleship",
  icon = "__base__/graphics/technology/artillery.png",
  icon_size = 256,
  prerequisites = {"artillery"},
  effects = {
    {type = "unlock-recipe", recipe = "batleship"}
  },
  unit = {
    count = 500,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"military-science-pack", 1},
      {"chemical-science-pack", 1}
    },
    time = 30
  },
  order = "e-c-c"
}

data:extend({tech})
