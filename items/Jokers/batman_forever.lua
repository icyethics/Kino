SMODS.Joker {
    key = "batman_forever",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_batman = true,
        extra = {
            stacks = 0,
            a_charge = 1,
            threshold = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_10",
    pos = { x = 4, y = 2},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 414,
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
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.a_charge,
                card.ability.extra.threshold
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.stacks < card.ability.extra.threshold then
                card.ability.extra.stacks = card.ability.extra.stacks + card.ability.extra.a_charge

                local eval = function(card)
                return card.ability.extra.stacks >= 5 end
                juice_card_until(card, eval, true)
            else
                -- find me
                local _mypos = nil
                for _index, _joker in ipairs(G.jokers.cards) do
                    if _joker == card then
                        _mypos = _index
                    end
                end

                -- if joker to the right, make robin
                if G.jokers.cards[_mypos + 1] and not G.jokers.cards[_mypos + 1].ability.is_robin then
                    SMODS.Stickers['kino_robin']:apply(G.jokers.cards[_mypos + 1], true)
                    card.ability.extra.stacks = card.ability.extra.stacks - card.ability.extra.threshold
                    return {
                        message = localize("k_kino_batman_forever")
                    }
                end
            end
        end
    end
}