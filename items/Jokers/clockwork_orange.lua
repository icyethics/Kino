SMODS.Joker {
    key = "clockwork_orange",
    order = 48,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            x_mult = 0.25
        }
    },
    rarity = 1,
    atlas = "kino_atlas_2",
    pos = { x = 5, y = 1},
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 185,
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
    k_genre = {"Sci-fi", "Crime"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.x_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you destroy a card, gain a charge
        -- Loses all charges and gives X.5 per charge
        if context.remove_playing_cards and not context.blueprint then
            for i = 1, #context.removed do
                card.ability.extra.stacks = card.ability.extra.stacks + 1
            end
        end

        if context.joker_main and G.jokers.cards[1] == card then
            local _power = card.ability.extra.stacks * card.ability.extra.x_mult
            card.ability.extra.stacks = 0

            return {
                x_mult = 1 + _power
            }
        end
    end,
    update = function(self, card, dt)
        if card.area and card.area == G.jokers and G.jokers.cards[1] == card then
            if not card.children.activedisplay then
                card.children.activedisplay = Kino.create_active_ui(card)
            end
        else
            card.children.activedisplay = nil
        end
        
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            local _kubrick_match = false
            for i, _joker in ipairs(G.jokers.cards) do
                for j, _director in ipairs(self.kino_joker.directors) do
                    print(_director)
                    if Kino.has_director(_joker, _director, true) then
                        _kubrick_match = true
                        break
                    end
                end
            end

            if _kubrick_match then
                unlock_card(self)
            end
        end
    end,
}