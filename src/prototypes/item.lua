local item_sounds = require("__base__.prototypes.item_sounds")
local tint = require("__base__.prototypes.item-tints")

data:extend({
    {
        type = "item",
        name = "nuclear-science-pack",
        localised_description = { "item-description.science-pack" },
        icon = "__atan-nuclear-science__/graphics/icons/nuclear-science-pack.png",
        subgroup = "science-pack",
        color_hint = { text = "N" },
        order = "g[z-nuclear-science-pack]",
        inventory_move_sound = item_sounds.science_inventory_move,
        pick_sound = item_sounds.science_inventory_pickup,
        drop_sound = item_sounds.science_inventory_move,
        stack_size = 200,
        default_import_location = "nauvis",
        weight = 1 * kg,
        random_tint_color = tint.bluish_science,
        pictures = {
            layers = {
                {
                    filename = "__atan-nuclear-science__/graphics/icons/nuclear-science-pack.png",
                    mipmap_count = 4,
                    scale = 0.5,
                    size = 64,
                },
                {
                    filename = "__atan-nuclear-science__/graphics/icons/space-age-science-pack-glow.png",
                    mipmap_count = 4,
                    scale = 0.5,
                    size = 64,
                    draw_as_light = true,
                },
            },
        },
    },
    {
        type = "item",
        name = "atan-atom-forge",
        icon = "__atan-nuclear-science__/graphics/icons/atom-forge.png",
        subgroup = "production-machine",
        order = "fa[atom-forge]",
        inventory_move_sound = item_sounds.mechanical_inventory_move,
        pick_sound = item_sounds.mechanical_inventory_pickup,
        drop_sound = item_sounds.mechanical_inventory_move,
        place_result = "atan-atom-forge",
        stack_size = 10,
        default_import_location = "nauvis",
        random_tint_color = tint.iron_rust,
        weight = 1000 * kg,
    },
})
