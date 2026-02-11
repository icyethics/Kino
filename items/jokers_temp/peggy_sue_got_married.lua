SMODS.Joker {
    key = "peggy_sue_got_married",
    order = 279,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            chips = 100
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 2, y = 4},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10013,
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
    k_genre = {"Comedy", "Romance", "Fantasy"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if not v.edition == nil then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        -- cards with an edition give +100 chips
        if context.individual and context.cardarea == G.play then
            if context.other_card.edition ~= nil then
                return {
                    chips = card.ability.extra.chips
                }
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
        if args.type == 'kino_sold_joker_with_edition' then
            unlock_card(self)
        end
    end,
}