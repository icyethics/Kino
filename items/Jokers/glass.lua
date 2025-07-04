SMODS.Joker {
    key = "glass",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 1,
            a_mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 5, y = 5},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1,
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
    pools, k_genre = {"Superhero"},
    enhancement_gate = "m_glass",

    loc_vars = function(self, info_queue, card)
        local _count = 0
        if G.playing_cards then
            for _index, _pcard in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(_pcard, "m_glass") then
                    _count = _count + 1
                end
            end
        end

        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.a_mult,
                _count * card.ability.extra.stacks
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gives +1 mult for each Glass card in deck. Increase by 1 whenever a glass joker shatters

        -- Code taken from Glass joker in VanillaRemade
        if context.remove_playing_cards and not context.blueprint then
            local glass_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card.shattered then glass_cards = glass_cards + 1 end
            end
            if glass_cards > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card.ability.extra.stacks = card.ability.extra.stacks +
                                    card.ability.extra.a_mult * glass_cards
                                return true
                            end
                        }))
                        SMODS.calculate_effect(
                            {
                                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.stacks +
                                card.ability.extra.a_mult * glass_cards } }
                            }, card)
                        return true
                    end
                }))
                return nil, true -- This is for Joker retrigger purposes
            end
        end
        if context.using_consumeable and not context.blueprint and context.consumeable.config.center.key == 'c_hanged_man' then
            -- Glass Joker updates on Hanged Man and no other destroy consumable
            local glass_cards = 0
            for _, removed_card in ipairs(G.hand.highlighted) do
                if SMODS.has_enhancement(removed_card, 'm_glass') then glass_cards = glass_cards + 1 end
            end
            if glass_cards > 0 then
                card.ability.extra.stacks = card.ability.extra.stacks +
                    card.ability.extra.a_mult * glass_cards
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.stacks } }
                }
            end
        end
        -- end of cited code

        if context.joker_main then
            local _count = 0
            for _index, _pcard in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(_pcard, "m_glass") then
                    _count = _count + 1
                end
            end
            
            return {
                mult = _count * card.ability.extra.stacks
            }
        end
    end
}