SMODS.Joker {
    key = "the_double",
    order = 6,
    config = {
        extra = {
            mult = 0,
            mult_mod = 2,
            a_mult = 2,
            hand_type = "Two Pair"
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 5, y = 0 },
    cost = 3,
    genre = "thriller",
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 146015,
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
    pools, k_genre = {"Thriller"},

    loc_vars = function(self, info_queue, card)
        local _keystring = "genre_" .. #self.k_genre
        info_queue[#info_queue+1] = {set = 'Other', key = _keystring, vars = self.k_genre}
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.mult,
                card.ability.extra.a_mult,
                card.ability.extra.hand_type
            }
        }
    end,
    calculate = function(self, card, context)

        if context.before and context.scoring_name == card.ability.extra.hand_type and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                focus = card,
                message = localize({type='variable', key='a_mult', vars = {card.ability.extra.mult}}),
                colour = G.C.MULT,
                card = card
            }

        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.blueprint_card and not context.retrigger_joker then
            card.ability.extra.mult_mod = card.ability.extra.mult_mod + card.ability.extra.a_mult
            card.ability.extra.mult = 0
            return {
                focus = card,
                message = localize({type='variable', key='k_upgrade_ex', vars = {card.ability.extra.mult_mod}}),
                colour = G.C.MULT,
                card = card
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}