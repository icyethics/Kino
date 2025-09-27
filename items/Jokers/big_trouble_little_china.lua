SMODS.Joker {
    key = "big_trouble_little_china",
    order = 213,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            a_stacks = 1,
            lower_by = 2.5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 2, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 6978,
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
    pools, k_genre = {"Fantasy", "Action", "Comedy"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_fantasy") then
                    enhancement_gate = true
                    break
                end
            end

            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.kino_spellcaster then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_spellcasting"}
        return {
            vars = {
                card.ability.extra.a_stacks,
                card.ability.extra.stacks,
                card.ability.extra.lower_by,
                card.ability.extra.lower_by * card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        if context.bb_cast_spell and not context.blueprint then
            card.ability.extra.stacks = card.ability.extra.stacks + card.ability.extra.a_stacks
        end

        if context.first_hand_drawn then
            if G.GAME.blind.boss then
                card:juice_up(0.8, 0.8)
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_btlc'), colour = G.C.BLACK })
                
                G.GAME.blind.chips = G.GAME.blind.chips * ((100 - (card.ability.extra.lower_by * card.ability.extra.stacks)) / 100)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                card.ability.extra.stacks = 0
            end
        end
    end
}