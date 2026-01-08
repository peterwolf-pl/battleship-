local ship_recipe = {
  type = "recipe",
  name = "batleship",
  enabled = false,
  energy_required = 15,
  ingredients = {
    {"steel-plate", 150},
    {"engine-unit", 40},
    {"advanced-circuit", 20},
    {"electric-engine-unit", 10}
  },
  result = "batleship"
}

data:extend({ship_recipe})
