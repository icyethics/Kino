SMODS.Joker {
    key = "dracula_bram_stoker",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            counters_applied = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 1, y = 0},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 6114,
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
    k_genre = {"Horror", "Romance"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1]  = {set = 'Other', key = "keyword_drain"}

        return {
            vars = {
                card.ability.extra.counters_applied
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 12 then
                local _valid_targets = Blockbuster.Counters.get_counter_targets(G.deck.cards, {"none", "match"}, "counter_kino_blood")
                for i = 1, card.ability.extra.counters_applied do
                    local _target = pseudorandom_element(_valid_targets, pseudoseed("kino_bram_stoker"))
                    _target:bb_counter_apply("counter_kino_blood", 1)
                end
            end

            return {
                message = localize("k_kino_dracula_stoker"),
                colour = G.C.KINO.DRAIN
            }
        end
    end
}