SMODS.Joker {
    key = "king_kong",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 50
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 5, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 244,
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
    k_genre = {"Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives +50 mult if blind is a boss blind
        if context.joker_main and G.GAME.blind.boss then
            return {
                mult = card.ability.extra.mult
            }
        end

        -- Hidden effect
        if context.fix_probability and context.identifier == "gros_michel" then
            local _ret = {
                numerator = context.denominator,
                denominator = context.denominator
            }

            if pseudorandom("kong_message ") < 0.2 then
                _ret.message = "Ba na na"
                _ret.colour = G.C.MONEY
            end

            return _ret
        end

        if context.mod_probability  and context.identifier == "cavendish" then
            local _ret = {
                denominator = context.denominator / 10,
            }

            if pseudorandom("kong_message ") < 0.2 then
                _ret.message = "Ba na na"
                _ret.colour = G.C.MONEY
            end

            return _ret
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.kino_boss_mode.Small = true
        G.GAME.kino_boss_mode_odds.Small = 0.25
        G.GAME.kino_boss_mode.Big = true
        G.GAME.kino_boss_mode_odds.Big = 0.25
    end,
    remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
            G.GAME.kino_boss_mode.Small = false
            G.GAME.kino_boss_mode_odds.Small = 0
            G.GAME.kino_boss_mode.Big = false
            G.GAME.kino_boss_mode_odds.Big = 0
        end
	end,
}