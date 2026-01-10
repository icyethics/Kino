SMODS.Joker {
    key = "coco",
    order = 194,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 1, y = 2},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 354912,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    k_genre = {"Animation", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you use a Death, transform an additional random card in hand as well
        if context.using_consumeable and context.consumeable.ability.set == "Tarot" and context.consumeable.ability.name == "Death" then
            local _valid_targets = {}
            local _transform_goal = G.hand.highlighted[2]
            
            for i, _pcard in ipairs(G.hand.cards) do
                if _pcard ~= G.hand.highlighted[1] and _pcard ~= G.hand.highlighted[2] then
                    _valid_targets[#_valid_targets + 1] = _pcard
                end
            end

            if #_valid_targets > 0 then
                local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_coco"))
                 G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    local new_card = copy_card(_transform_goal, _target)
                    new_card:juice_up()
                    return true end }))
                card:juice_up()
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'kino_death_on_same_card' then
            unlock_card(self)
        end
    end,
}