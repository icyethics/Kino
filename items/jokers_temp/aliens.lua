SMODS.Joker {
    key = "aliens",
    order = 59,
    generate_ui = Kino.generate_info_ui,
    config = {
        kino_alien_franchise = true,
        extra = {
            cards_debuffing_non = 2,
            x_mult = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 4, y = 3},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 679,
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
    k_genre = {"Sci-fi", "Action"},
    kino_alien_franchise = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cards_debuffing_non,
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- X2 mult, but debuffs two random cards when triggered.
        if context.joker_main then
            local _cards_debuffed = 0
            local _valid_targets = {}

            for _index, _pcard in ipairs(G.deck.cards) do
                if _pcard.debuff == false then
                    _valid_targets[#_valid_targets +1] = _pcard
                end
            end

            if #_valid_targets > 0 then
                for i = 1, math.min(card.ability.extra.cards_debuffing_non, #_valid_targets) do
                    local _rand_card = pseudorandom_element(G.deck.cards,  pseudoseed('aliens'))
                    if _rand_card.debuff == false then
                        SMODS.debuff_card(_rand_card, true, card.config.center.key)
                        _cards_debuffed = _cards_debuffed + 1
                    end
                end
            end

            return {
                x_mult = card.ability.extra.x_mult,
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local _tally = 0
            for i, _pcard in ipairs(G.playing_cards) do
                if _pcard.debuff then
                    _tally = _tally + 1
                end
            end
            if _tally >= 10 then
                unlock_card(self)
            end
        end
        if args.type == 'win' and G.jokers and G.jokers.cards then
            local _true = false
            for _i, _joker in ipairs(G.jokers.cards) do
                if kino_quality_check(_joker, 'kino_alien_franchise') then
                    _true = true
                end
            end

            if _true then
                unlock_card(self)
            end
        end
    end,
}