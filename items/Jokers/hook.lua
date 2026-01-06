SMODS.Joker {
    key = "hook",
    order = 94,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_pirate = true,
        extra = {
            stacked_chips = 0,
            a_chips = 10,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_3",
    pos = { x = 3, y = 3},
    cost = 2,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 879,
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
    k_genre = {"Fantasy", "Adventure", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.stacked_chips, 
                card.ability.extra.a_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.stacked_chips
            }
        end

        if context.pre_discard then
            local _face_count = 0
            for i, _pcard in ipairs(context.full_hand) do
                if _pcard:is_face() then
                    _face_count = _face_count + 1
                end
            end

            if _face_count >= 2 then
                card.ability.extra.stacked_chips = card.ability.extra.stacked_chips + card.ability.extra.a_chips
                return {
                    message = localize("k_upgrade_ex"),
                    color = G.C.CHIPS
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
        if args.type == 'round_win' and G.GAME.blind:get_type() == "Boss" and  G.GAME.round_resets.blind_choices.Boss == "bl_hook" then
            unlock_card(self)
        end
    end,
}