SMODS.Joker {
    key = "12_angry_men",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 1,
            stacked_mult = 0,
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 3, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 389,
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
    k_genre = {"Drama"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult, 
                card.ability.extra.stacked_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Kings give +1 mult for each face card scored this ante
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult
            card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil,
            { message = localize('k_upgrade_ex'), colour = G.C.MULT})
            if context.other_card:get_id() == 13 then
                return {
                    mult = card.ability.extra.stacked_mult,
                }
            end
        end

        if context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and not context.blueprint_card and not context.retrigger_joker then
            card.ability.extra.stacked_mult = 0
        end
    end,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local tally = 0
            for _, v in pairs(G.playing_cards) do
                if v:get_id() == 13 then
                    tally = tally+1
                end
            end
            if tally >= 12 then 
                unlock_card(self)
            end
        end
    end, 
}