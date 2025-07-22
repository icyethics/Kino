SMODS.Joker {
    key = "batman_and_robin",
    order = 30,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            mult = 1,
            total_non = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 415,
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
    pools = {["kino_batman"] = true}, 
    k_genre = {"Superhero", "Action"},

    loc_vars = function(self, info_queue, card)

        if G.jokers then
            card.ability.extra.total_non = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.mult
            for i = 1, #G.jokers.cards do
                if kino_quality_check(G.jokers.cards[i], "is_batman") then 
                    card.ability.extra.total_non = card.ability.extra.total_non + (1 * card.ability.extra.mult) 
                end
            end
        end

        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.total_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a pair, upgrade both cards with +3 mult for each empty joker slot or batman joker you have
        if context.after and context.cardarea == G.jokers then
            
            card.ability.extra.total_non = (G.jokers.config.card_limit - #G.jokers.cards) * card.ability.extra.mult
            for i = 1, #G.jokers.cards do
                if kino_quality_check(G.jokers.cards[i], "is_batman") then card.ability.extra.total_non = card.ability.extra.total_non + (1 * card.ability.extra.mult) end
            end


            if context.scoring_name == "Pair" then
                for _index, _pcard in ipairs(context.scoring_hand) do
                    _pcard.ability.perma_mult = _pcard.ability.perma_mult or 0
                    _pcard.ability.perma_mult = _pcard.ability.perma_mult + card.ability.extra.total_non
                    _pcard:juice_up()
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_upgrade_ex'), colour = G.C.MULT})
                end
            end
        end
    end
}