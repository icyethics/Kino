SMODS.Blind{
    key = "kingkong",
    dollars = 5,
    mult = 5,
    boss_colour = HEX('cdc770'),
    atlas = 'kino_blinds_2', 
    boss = {min = 3, max = 10},
    pos = { x = 0, y = 0},
    debuff = {

    },
    loc_vars = function(self)

    end,
    collection_loc_vars = function(self)

    end,
    set_blind = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local _card = SMODS.create_card({type = "BlindAbility", area = G.consumeables, key = "c_kino_damsel", no_edition = true})
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return true
        end}))
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)

        for _index, _consumable in ipairs(G.consumeables.cards) do
            if _consumable.ability.set == "BlindAbility" then
                _consumable:start_dissolve()
            end
        end
        return true
        
    end,
    press_play = function(self)
    end,
    calculate = function(self, blind, context)

        
    end
}
