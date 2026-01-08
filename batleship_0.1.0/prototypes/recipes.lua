local ship_recipe = {
  type = "recipe",
  name = "batleship",
  enabled = false,
  energy_required = 30,
  ingredients = {
    {type = "item", name = "steel-plate", amount = 400},
    {type = "item", name = "engine-unit", amount = 100},
    {type = "item", name = "advanced-circuit", amount = 100},
    {type = "item", name = "artillery-turret", amount = 2},
    {type = "item", name = "artillery-shell", amount = 50}
  },
  results = {
    {type = "item", name = "batleship", amount = 1}
  }
}

data:extend({ship_recipe})
