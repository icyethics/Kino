SMODS.Joker {
    key = "baby_driver",
    order = 236,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            factor = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_7",
    pos = { x = 1, y = 4},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 339403,
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
    pools, k_genre = {"Crime", "Action"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.factor
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            -- get card position
            local _mypos = 0
            local _triggers = 0
            for _index, _card in ipairs(G.play.cards) do
                if _card == context.other_card then
                    _mypos = _index
                end
            end

            if G.play.cards[_mypos - 1] then
                if (G.play.cards[_mypos - 1]:get_id() == context.other_card:get_id() - 1 or
                G.play.cards[_mypos - 1]:get_id() == context.other_card:get_id() + 1) and
                not G.play.cards[_mypos - 1].overrides_base_rank then
                    _triggers = _triggers + 1
                end
            end
            if G.play.cards[_mypos + 1] then
                if (G.play.cards[_mypos + 1]:get_id() == context.other_card:get_id() - 1 or
                G.play.cards[_mypos + 1]:get_id() == context.other_card:get_id() + 1) and
                not G.play.cards[_mypos + 1].overrides_base_rank then
                    _triggers = _triggers + 1
                end
            end

            if _triggers > 0 then
                local _mult = context.other_card.base.nominal * card.ability.extra.factor
                return {
                    mult = _mult
                }
            end
        end
    end
}