SMODS.Joker {
    key = "mortal_kombat",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            power_counters = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_8",
    pos = { x = 0, y = 5},
    cost = 8,
    blueprint_compat = false,
    perishable_compat = true,
    kino_joker = {
        id = 9312,
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
    pools, k_genre = {"Action", "Fantasy"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.power_counters
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you select a blind, destroy a random joker
        -- to give another joker a 50% power boost

        if context.setting_blind then

            -- pick a target pool
            local _validtargets = {}
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker:can_calculate() and _joker ~= card and
                not SMODS.is_eternal(_joker, {kino_mortal_kombat = true, joker = true}) then
                    _validtargets[#_validtargets + 1] = _joker
                end
            end

            -- kill it
            local _target = pseudorandom_element(_validtargets, pseudoseed("kino_mortkom_kill"))

            if _target then
                _target.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        _target:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
            end
            
            -- pick a target pool: boosting
            local _validtargets = {}
            for _index, _joker in ipairs(G.jokers.cards) do
                if _joker:can_calculate() and Kino.can_multiply(_joker) and _joker ~= card and _joker ~= _target then
                    _validtargets[#_validtargets + 1] = _joker
                end
            end

            -- boost it
            local _newtarget = pseudorandom_element(_validtargets, pseudoseed("kino_mortkom_boost"))
            _newtarget:juice_up()
            -- Kino.change_counters(_newtarget, "kino_power", 3)
            _newtarget:bb_counter_apply("counter_kino_power", card.ability.extra.power_counters)

        end
    end
}