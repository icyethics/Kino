SMODS.Joker {
    key = "gullivers_travels",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            a_stacks = 1
        }
    },
    rarity = 1,
    atlas = "kino_atlas_8",
    pos = { x = 3, y = 4},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 38745,
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
    k_genre = {"Comedy", "Family"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_stacks,
                card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain a Charge when a 5 or lower scores
        -- Face cards give mult equal to charges, then halve your current charges
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() <= 5 then
                card.ability.extra.stacks = card.ability.extra.stacks + card.ability.extra.a_stacks
            end

            if context.other_card:is_face() then
                local _mult = card.ability.extra.stacks
                card.ability.extra.stacks = card.ability.extra.stacks / 2

                return {
                    mult = _mult
                }
            end
        end
    end,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local _tally_face = 0
            local _tally_low = 0
            for j = 1, #args.cards do
                if args.cards[j]:is_face() and args.cards[j]:get_id() ~= 2  then
                    _tally_face = _tally_face + 1
                elseif args.cards[j]:get_id() == 2 then
                    _tally_low = _tally_low + 1
                end
            end
            if _tally_face <= 3 and
            _tally_low <= 3 and 
            _tally_face + _tally_low == 5 then 
                unlock_card(self)
            end
        end
    end, 
}