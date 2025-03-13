SMODS.Joker {
    key = "shang_chi",
    order = 196,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cur_spell_non = 0,
            inc_spell_non = 1,
            reset = 10,
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 3, y = 2},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 566525,
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
    pools, k_genre = {"Superhero", "Fantasy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        local _spell_list = {
            "spell_kino_Hearts_Hearts",
            "spell_kino_Hearts_Diamonds",
            "spell_kino_Hearts_Clubs",
            "spell_kino_Hearts_Spades",
            "spell_kino_Diamonds_Diamonds",
            "spell_kino_Diamonds_Clubs",
            "spell_kino_Diamonds_Spades",
            "spell_kino_Clubs_Spades",
            "spell_kino_Clubs_Clubs",
            "spell_kino_Spades_Spades"
        }

        if context.joker_main then
            card.ability.extra.cur_spell_non = card.ability.extra.cur_spell_non + card.ability.extra.inc_spell_non
            if card.ability.extra.cur_spell_non > 10 then
                card.ability.extra.cur_spell_non = 1
            end

            return cast_spell(_spell_list[card.ability.extra.cur_spell_non], pseudorandom_element({1, 2, 3, 4}, pseudoseed("shangchi")))
        end
    end
}