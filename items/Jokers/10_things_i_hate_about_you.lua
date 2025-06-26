SMODS.Joker {
    key = "10_things_i_hate_about_you",
    order = 146,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            charges_non = 0,
            mult = 8,
            chips = 20,
        }
    },
    rarity = 1,
    atlas = "kino_atlas_4",
    pos = { x = 3, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 509967,
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
    pools, k_genre = {"Comedy", "Romance"},
    enhancement_gate = 'm_kino_romance',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips,
                card.ability.extra.charges_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gains a stack whenever a hand scores without a romance card
        -- Romance cards consume stacks to give +chips and +mult

        if context.joker_main then
            -- check for romance cards
            local _hasrom = false

            for _, _pcard in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(_pcard, "m_kino_romance") then
                    _hasrom = true
                    break
                end
            end

            -- if not Romance card
            if _hasrom == false then
                card.ability.extra.charges_non = card.ability.extra.charges_non + 1
            end

            if _hasrom == true then
                local _charges = card.ability.extra.charges_non
                card.ability.extra.charges_non = 0
                return {
                    chips = card.ability.extra.chips * _charges,
                    mult = card.ability.extra.mult * _charges
                }
            end
        end

    end
}