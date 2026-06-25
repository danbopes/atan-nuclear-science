local M = {
    entity = {},
    item = {},
    recipe = {},
    tech = {},
}

function M.item.set_weight(item_name, weight)
    if not data.raw["item"][item_name] then
        return
    end
    data.raw["item"][item_name].weight = weight
end

function M.entity.add_crafting_category(entity_type, entity_name, category)
    if not data.raw[entity_type] then
        return
    end
    if not data.raw[entity_type][entity_name] then
        return
    end
    local entity = data.raw[entity_type][entity_name]
    if not entity.crafting_categories then
        entity.crafting_categories = {}
    end
    entity.crafting_categories[#entity.crafting_categories + 1] = category
end

function M.entity.add_lab_input(lab_name, input)
    if not data.raw["lab"][lab_name] then
        return
    end
    local lab = data.raw["lab"][lab_name]
    if not lab.inputs then
        lab.inputs = {}
    end
    lab.inputs[#lab.inputs + 1] = input
end

function M.entity.set_crafting_speed(entity_type, entity_name, speed)
    if not data.raw[entity_type] then
        return
    end
    if not data.raw[entity_type][entity_name] then
        return
    end
    local entity = data.raw[entity_type][entity_name]
    entity.crafting_speed = speed
end

function M.recipe.double_time(recipe_name)
    if not data.raw["recipe"][recipe_name] then
        return
    end
    local recipe = data.raw["recipe"][recipe_name]
    recipe.energy_required = 2 * recipe.energy_required
end

function M.recipe.is_centrifuging(recipe_name)
    if not data.raw["recipe"][recipe_name] or not data.raw["recipe"].categories then
        return false
    end
    local category = data.raw["recipe"].categories
    -- Don't include advanced-centrifuging-or-crafting
    return category == "centrifuging" or category == "centrifuging-or-crafting"
end

function M.recipe.set_category(recipe_name, category)
    if not data.raw["recipe"][recipe_name] then
        return
    end
    data.raw["recipe"][recipe_name].categories = { category }
end

function M.tech.add_effect(tech_name, effect)
    if not data.raw["technology"][tech_name] then
        return
    end
    local tech = data.raw["technology"][tech_name]
    if not tech.effects then
        tech.effects = {}
    end
    tech.effects[#tech.effects + 1] = effect
end

function M.tech.add_ingredient(tech_name, ingredient)
    if not data.raw["technology"][tech_name] or not data.raw["technology"][tech_name].unit then
        return
    end
    local tech = data.raw["technology"][tech_name]
    if not tech.unit.ingredients then
        tech.unit.ingredients = {}
    end
    if M.tech.has_ingredient(tech, ingredient) then
        return
    end
    tech.unit.ingredients[#tech.unit.ingredients + 1] = ingredient
end

function M.tech.add_prerequisite(tech_name, prerequisite)
    if not data.raw["technology"][tech_name] or not data.raw["technology"][prerequisite] then
        return
    end
    local tech = data.raw["technology"][tech_name]
    if not tech.prerequisites then
        tech.prerequisites = {}
    end
    if M.tech.has_prerequisite(tech, prerequisite) then
        return
    end
    tech.prerequisites[#tech.prerequisites + 1] = prerequisite
end

function M.tech.has_prerequisite(tech, prerequisite)
    if not tech.prerequisites then
        return false
    end
    for _, extant in pairs(tech.prerequisites) do
        if extant == prerequisite then
            return true
        end
    end
    return false
end

function M.tech.has_ingredient(tech, ingredient)
    if not tech.unit or not tech.unit.ingredients then
        return false
    end
    for _, extant in pairs(tech.unit.ingredients) do
        if extant[1] == ingredient[1] then
            return true
        end
    end
    return false
end

function M.tech.delete_ingredient(tech_name, target)
    if
        not data.raw["technology"][tech_name]
        or not data.raw["technology"][tech_name].unit
        or not data.raw["technology"][tech_name].unit.ingredients
    then
        return false
    end
    local deleted = false
    local new_ingredients = {}
    for _, ingredient in pairs(data.raw["technology"][tech_name].unit.ingredients) do
        if ingredient[1] == target then
            deleted = true
        else
            new_ingredients[#new_ingredients + 1] = ingredient
        end
    end
    if deleted then
        data.raw["technology"][tech_name].unit.ingredients = new_ingredients
    end
    return deleted
end

function M.tech.delete_prerequisite(tech_name, target)
    if not data.raw["technology"][tech_name] or not data.raw["technology"][tech_name].prerequisites then
        return false
    end
    local deleted = false
    local new_prereqs = {}
    for _, prerequisite in pairs(data.raw["technology"][tech_name].prerequisites) do
        if prerequisite == target then
            deleted = true
        else
            new_prereqs[#new_prereqs + 1] = prerequisite
        end
    end
    if deleted then
        data.raw["technology"][tech_name].prerequisites = new_prereqs
    end
    return deleted
end

function M.tech.make_essential(tech_name)
    if not data.raw["technology"][tech_name] then
        return
    end
    data.raw["technology"][tech_name].essential = true
end

function M.tech.requires_planet_sciences(tech_name)
    if
        not data.raw["technology"][tech_name]
        or not data.raw["technology"][tech_name].unit
        or not data.raw["technology"][tech_name].unit.ingredients
    then
        return false
    end
    local count = 0
    for _, ingredient in pairs(data.raw["technology"][tech_name].unit.ingredients) do
        if
            ingredient[1] == "metallurgic-science-pack"
            or ingredient[1] == "electromagnetic-science-pack"
            or ingredient[1] == "agricultural-science-pack"
        then
            count = count + 1
        end
    end
    return count == 3
end

function M.tech.set_prerequisites(tech_name, prerequisites)
    if not data.raw["technology"][tech_name] then
        return
    end
    data.raw["technology"][tech_name].prerequisites = prerequisites
end

function M.tech.set_trigger(tech_name, trigger)
    if not data.raw["technology"][tech_name] then
        return
    end
    local tech = data.raw["technology"][tech_name]
    if tech.unit then
        tech.unit = nil
    end
    tech.research_trigger = trigger
end

return M
