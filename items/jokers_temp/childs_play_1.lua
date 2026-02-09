SMODS.Joker {
    key = "childs_play_1",
    order = 171,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_monster_exemptions = true,
            stacks = 0,
            chips = 8,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_5",
    pos = { x = 2, y = 4},
    cost = 2,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 10585,
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

    loc_vars = function(self, info_queue, card)


        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.stacks,
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a hand containing a 2, activate
        -- When active, you may discard monster cards

        if context.discard and
        not context.other_card.debuff 
        and not context.blueprint then
            if context.other_card:get_id() <= 5 or 
            SMODS.has_enhancement(context.other_card, "m_kino_monster") or
            SMODS.has_enhancement(context.other_card, "m_kino_horror") then
                card.ability.extra.stacks = card.ability.extra.stacks + 1
            end
        end

        if context.joker_main and card.ability.extra.stacks > 0 then
            local _chips = card.ability.extra.stacks * card.ability.extra.chips
            card.ability.extra.stacks = math.floor(card.ability.extra.stacks / 2)
            return {
                chips = _chips
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
        if args.type == 'modify_deck' then
            local _tally = 0
            for i, _pcard in ipairs(G.playing_cards) do
                if _pcard:get_id() == 2 and 
                (_pcard.config.center == G.P_CENTERS.m_kino_horror or _pcard.config.center == G.P_CENTERS.m_kino_monster) then
                    _tally = _tally + 1
                end
            end

            if _tally >= 5 then
                unlock_card(self)
            end
        end
    end,
}