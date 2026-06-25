data:extend({
    {
        type = "recipe",
        name = "nuclear-science-pack",
        categories = { "centrifuging" },
        enabled = false,
        energy_required = 10, -- NOTE: will be doubled to 20 in data-updates
        ingredients = {
            { type = "item", name = "uranium-235", amount = 1 },
            { type = "item", name = "water-barrel", amount = 20 },
            { type = "item", name = "concrete", amount = 10 },
        },
        results = {
            { type = "item", name = "nuclear-science-pack", amount = 2 },
            { type = "item", name = "barrel", amount = 20, ignored_by_productivity = 20 },
        },
        main_product = "nuclear-science-pack",
        allow_productivity = true,
        surface_conditions = {
            { property = "pressure", min = 1000, max = 1000 },
        },
    },
    {
        type = "recipe",
        name = "atan-atom-forge",
        categories = { "advanced-centrifuging-or-crafting" },
        enabled = false,
        energy_required = 12,
        ingredients = {
            { type = "item", name = "centrifuge", amount = 1 },
            { type = "item", name = "steel-plate", amount = 50 },
            { type = "item", name = "processing-unit", amount = 30 },
            { type = "item", name = "refined-concrete", amount = 20 },
        },
        results = {
            { type = "item", name = "atan-atom-forge", amount = 1 },
        },
        main_product = "atan-atom-forge",
        allow_productivity = false,
        surface_conditions = {
            { property = "pressure", min = 1000, max = 1000 },
        },
    },
})
