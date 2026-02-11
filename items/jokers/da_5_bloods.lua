SMODS.Joker {
    key = "da_5_bloods",
    order = 223,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            used_ranks = {},
            used_ranks_hash = {}
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 0, y = 1},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 581859,
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
    k_genre = {"Drama", "Adventure"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                
            }
        }
    end,
    calculate = function(self, card, context)
        -- if you destroy a card, give a random card of the same rank a gold seal (if possible)
        if context.remove_playing_cards then
            for i = 1, #context.removed do
                local _rank = context.removed[i]:get_id()
                if not card.ability.extra.used_ranks_hash[tostring(_rank)] then
                    local _viable_targets = {}
                
                    for _, _pcard in ipairs(G.playing_cards) do
                        if _pcard:get_id() == _rank and
                        p_card ~= context.removed[i] and
                        _pcard.seal == nil and
                        _pcard:can_calculate() then
                            _viable_targets[#_viable_targets + 1] = _pcard
                        end
                    end
    
                    if #_viable_targets >= 1 then
                        local _target = pseudorandom_element(_viable_targets, pseudoseed("kino_d5b"))
                        card.ability.extra.used_ranks_hash[tostring(_rank)] = true
                        _target:set_seal("Gold", true)
                        card:juice_up()
                    end 
                end

                
            end
        end

    end
}