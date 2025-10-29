SMODS.Atlas {
    key = "kinoween_jack",
    atlas_table = "ANIMATION_ATLAS",
    path = "kinoween_jack.png",
    px = 34,
    py = 34,
    frames = 21
}



SMODS.Blind{
    key = "jack_skellington",
    dollars = 5,
    mult = 2,
    boss_colour = HEX('c38639'),
    atlas = 'kinoween_jack', 
    boss = {min = 1, max = 10},
    pos = { x = 0, y = 0},
    debuff = {

    },
    in_pool = function(self)
        if G.GAME.modifiers.kinoween then return true end
        return false
    end,
    loc_vars = function(self)
        local key

        key = self.key

        return { key = key}
    end,
    collection_loc_vars = function(self)
        local key

        key = self.key

        return { key = key}
    end,
    set_blind = function(self)
        local list_of_spooky_objects = {
            "m_kino_horror",
            "m_kino_monster",
            "m_kino_crime",
            "m_kino_demonic",
            "m_kino_flying_monkey",
            "m_kino_pennywise_balloon",
            "m_kino_fabricated_monster",
            "m_kino_error",
            "m_kino_finance",
            "m_kino_factory",
            "m_kino_supervillain",
        }

        -- Wha-ah-ah-at's this, what's this
        -- Puts 3 Frost counters on every card and joker that isn't
        -- succificiently spooky
        for _index, _joker in ipairs(G.jokers.cards) do
            local _is_target = true
            if is_genre(_joker, "Horror") or is_genre(_joker, "Thriller") or is_genre(_joker, "Crime") then
                _is_target = false
            end

            if _is_target then
                _joker:bb_counter_apply("counter_frost", 3)
            end
        end

        for _index, _pcard in ipairs(G.playing_cards) do
            local _is_target = true
            for _index2, _enhancement in ipairs(list_of_spooky_objects) do
                if SMODS.has_enhancement(_pcard, _enhancement) then
                    _is_target = false
                    break
                end
            end

            if _is_target then
                _pcard:bb_counter_apply("counter_frost", 3)
            end
        end
    end,
    drawn_to_hand = function(self)
        
    end,
    disable = function(self)

    end,
    defeat = function(self)
        
    end,
    press_play = function(self)

    end,
    calculate = function(self, blind, context)

    end
}

