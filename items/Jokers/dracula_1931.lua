SMODS.Joker {
    key = "dracula_1931",
    order = 123,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_vampire = true,
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.05,
        }
    },
    rarity = 3,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 2},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    is_vampire = true,
    kino_joker = {
        id = 138,
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
    k_genre = {"Horror"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards and G.jokers.cards then
            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.is_vampire then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1]  = {set = 'Other', key = "keyword_drain"}
        return {
            vars = {
                card.ability.extra.stacked_x_mult,
                card.ability.extra.a_xmult,
            }
        }
    end,
    calculate = function(self, card, context)
        -- Debuffs scored cards. Gains x0.1 per card debuff. Gains x0.2 instead if they were enhanced.
        
        -- if context.cardarea == G.jokers and context.before and not context.blueprint then
        --     -- suck up the enhancement
        --     local enhanced = {}
        --     for k, v in ipairs(context.scoring_hand) do
        --         if Kino.drain_property(v, card, {Enhancement = {true}}) then
        --             enhanced[#enhanced + 1] = v
        --         end
        --     end
        -- end

        if context.kino_drain then

            card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult

            return {
                extra = { focus = card,
                message = localize({type='variable', key='a_xmult', vars = {card.ability.extra.stacked_x_mult}}),
                colour = G.C.MULT,
                card = card
                }
            }
        end

        if context.joker_main and card.ability.extra.stacked_x_mult ~= 1 then
            return {
                x_mult = card.ability.extra.stacked_x_mult,
                message = localize({type = 'variable', key ='a_xmult', vars = {card.ability.extra.stacked_x_mult}})
            }
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
        if args.type == 'round_win' and G.GAME.blind:get_type() == "Boss" and  G.GAME.round_resets.blind_choices.Boss == "bl_kino_dracula" then
            unlock_card(self)
        end
    end,
}