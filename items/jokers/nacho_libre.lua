SMODS.Joker {
    key = "nacho_libre",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 0, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9353,
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
    k_genre = {"Comedy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)

    end,
    calc_dollar_bonus = function(self, card)
        if G.GAME.blind.boss then
            return G.GAME.blind.dollars
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.kino_boss_mode.Small = true
        G.GAME.kino_boss_mode_odds.Small = 0.5
    end,
    remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
            G.GAME.kino_boss_mode.Small = false
            G.GAME.kino_boss_mode_odds.Small = 0
        end
	end,
}