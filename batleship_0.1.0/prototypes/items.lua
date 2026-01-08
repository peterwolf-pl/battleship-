local ship_item = {
  type = "item",
  name = "batleship",
  icon = "__cargo-ships__/graphics/icons/cargo-ship.png",
  icon_size = 64,
  subgroup = "transport",
  order = "b[batleship]",
  place_result = "batleship",
  stack_size = 1
}

data:extend({ship_item})
