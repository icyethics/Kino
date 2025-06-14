SMODS.Joker {
    key = "ponyo",
    order = 276,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_xmult = 0.1,
            stacked_xmult = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_8",
    pos = { x = 5, y = 3},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 12429,
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
    pools, k_genre = {"Animation", "Fantasy", "Family"},
    is_water = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_xmult,
                card.ability.extra.stacked_xmult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Active card. Gain x0.1 for each unscored card played
        -- Use score (score is not consumed when active, just not built up)
        if context.individual and context.cardarea == "unscored" then
            if G.jokers.cards[1] ~= card and not context.blueprint then
                card.ability.extra.stacked_xmult = card.ability.extra.stacked_xmult + card.ability.extra.a_xmult
                return {
                    message = localize("k_kino_ponyo"),
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main and G.jokers.cards[1] == card then
            return {
                x_mult = card.ability.extra.stacked_xmult
            }
        end
    end,
    update = function(self, card, dt)
        if card.area and card.area == G.jokers and G.jokers.cards[1] == card then
            if not card.children.activedisplay then
                card.children.activedisplay = Kino.create_active_ui(card)
            end
        else
            card.children.activedisplay = nil
        end
        
    end,
}