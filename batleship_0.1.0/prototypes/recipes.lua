local ship_recipe = {
  type = "recipe",
  name = "batleship",
  enabled = false,
  energy_required = 30,
  ingredients = {
    {"steel-plate", 400},
    {"engine-unit", 100},
    {"advanced-circuit", 100},
    {"artillery-turret", 2},
    {"artillery-shell", 50}
  },
  result = "batleship"
}

data:extend({ship_recipe})
