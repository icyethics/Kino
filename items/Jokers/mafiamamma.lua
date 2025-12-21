SMODS.Joker {
    key = "mafiamamma",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacked_chips = 0,
            factor = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_10",
    pos = { x = 0, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 809787,
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
    k_genre = {"Action", "Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_chips,
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card then
            card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + (context.card.sell_cost * card.ability.extra.factor)
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades.count or 0,
                50
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local _tally = 0
            for i, _pcard in ipairs(G.playing_cards) do
                if _pcard:get_id() == 12 and _pcard.config.center == G.P_CENTERS.m_kino_crime then
                    _tally = _tally + 1
                end
            end

            if _tally >= 5 then
                unlock_card(self)
            end
        end
    end,
}