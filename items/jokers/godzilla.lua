SMODS.Joker {
    key = "godzilla",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 1
        }
    },
    rarity = 3,
    atlas = "kino_atlas_10",
    pos = { x = 4, y = 5},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1678,
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
    k_genre = {"Action", "Sci-fi", "Horror"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- Double this joker's mult when you defeat a Boss Blind
        if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
            card.ability.extra.mult = card.ability.extra.mult * 2
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
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