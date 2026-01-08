local ship_recipe = {
  type = "recipe",
  name = "batleship",
  enabled = false,
  energy_required = 10,
  ingredients = {
    {"steel-plate", 200},
    {"engine-unit", 50},
    {"advanced-circuit", 50},
    {"artillery-turret", 1}
  },
  result = "batleship"
}

data:extend({ship_recipe})
