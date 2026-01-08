local turret = table.deepcopy(data.raw["artillery-turret"]["artillery-turret"])

turret.name = "batleship-artillery-turret"
turret.icon = "__base__/graphics/icons/artillery-turret.png"
turret.icon_size = 64
turret.flags = {"placeable-off-grid", "not-on-map"}
turret.minable = nil
turret.selection_box = {{-0.6, -0.6}, {0.6, 0.6}}
turret.collision_box = {{-0.4, -0.4}, {0.4, 0.4}}
turret.selectable_in_game = false
turret.corpse = "small-remnants"

data:extend({turret})
