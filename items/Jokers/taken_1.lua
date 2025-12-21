SMODS.Joker {
    key = "taken_1",
    order = 289,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 3,
            r_mult_non = 4,
            stacked_mult = 0,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_9",
    pos = { x = 0, y = 0},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8681,
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
    k_genre = {"Action", "Crime"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.r_mult_non,
                card.ability.extra.stacked_mult
            }
        }
    end,
    calculate = function(self, card, context)

        if context.hand_drawn and not context.blueprint then
            local _trigger = false
            for i = 1, #context.hand_drawn do
                if context.hand_drawn[i]:get_id(12) and not context.hand_drawn.debuff then
                    _trigger = true
                    card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
                end
            end

            if _trigger then
                return {
                    message = localize("k_upgrade_ex"),
                    color = G.C.MULT
                }
            end
        end

        if context.pre_discard then
            local _queen_count = 0
            for i, _pcard in ipairs(context.full_hand) do
                if _pcard:get_id(12) then
                    _queen_count = _queen_count + 1
                    card.ability.extra.stacked_mult = math.max((card.ability.extra.stacked_mult - card.ability.extra.r_mult_non), 0)
                end
            end

            if _queen_count > 0 then
                return {
                    message = "-" .. _queen_count * card.ability.extra.r_mult_non,
                    color = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
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
        if args.type == 'win' then
            local _tally = 0
            for i, _pcard in ipairs(G.playing_cards) do
                if _pcard:get_id() == 12 then
                    _tally = _tally + 1 
                    break
                end
            end

            if _tally == 0 then
                unlock_card(self)
            end
        end
    end,
}