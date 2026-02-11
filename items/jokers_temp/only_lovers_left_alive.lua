SMODS.Joker {
    key = "only_lovers_left_alive",
    order = 145,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_vampire = true,
        extra = {
            stacked_x_mult = 1,
            a_xmult = 0.5,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 4},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    is_vampire = true,
    kino_joker = {
        id = 152603,
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
    k_genre = {"Romance", "Fantasy"},
    enhancement_gate = 'm_kino_romance',

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
        -- if a pair is played, and both are romance cards, destroy them and upgrade this card with
        -- x0.2
        if context.cardarea == G.jokers and context.before and not context.blueprint
        and context.scoring_name == "Pair" then
            local romance_count = {}
            for _index, _pcard in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(_pcard, 'm_kino_romance') and not _pcard.debuff then
                    romance_count[#romance_count + 1] = _pcard
                end
            end
            
            if #romance_count == 2 then
                for _index, _pcard in ipairs(romance_count) do
                    Kino.drain_property(_pcard, card, {Enhancement = {true}})
                end
                card.ability.extra.stacked_x_mult = card.ability.extra.stacked_x_mult + card.ability.extra.a_xmult
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.stacked_x_mult
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
        if args.type == 'kino_drained_romance' then
            unlock_card(self)
        end
    end,
}