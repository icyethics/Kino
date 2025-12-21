SMODS.Joker {
    key = "metropolis",
    order = 226,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            kino_sci_fi_upgrade_inc = 1,
            factor = 1,
            main_eval = false
        }
    },
    rarity = 3,
    atlas = "kino_atlas_7",
    pos = { x = 3, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 19,
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
    k_genre = {"Sci-fi", "Silent"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.factor,
                card.ability.extra.kino_sci_fi_upgrade_inc
            }
        }
    end,
    calculate = function(self, card, context)
        -- Sci-fi cards upgrade an additional time for each Silent joker you have

        if (context.cardarea and not context.cardarea == G.jokers) or not G.GAME or not G.GAME.probabilities or not G.hand then return end

        if context.main_eval and not card.ability.extra.main_eval then
            card.ability.extra.main_eval = true
        elseif context.main_eval and card.ability.extra.main_eval then
            return
        elseif not context.main_eval then
            card.ability.extra.main_eval = false
        end

        local _num = 0
        for _, _joker in ipairs(G.jokers.cards) do
            if is_genre(_joker, "Silent") then
                _num = _num + card.ability.extra.factor
            end
        end

        card.ability.extra.kino_sci_fi_upgrade_inc = _num
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
        if args.type == 'kino_droid_on_gold' then
            unlock_card(self)
        end
    end,
}
