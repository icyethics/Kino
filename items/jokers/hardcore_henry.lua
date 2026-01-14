SMODS.Joker {
    key = "hardcore_henry",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            cost_non = 3
        }
    },
    rarity = 2,
    atlas = "kino_atlas_11",
    pos = { x = 1, y = 4},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 325348,
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
    k_genre = {"Action"},
    enhancement_gate = "m_kino_action",
    kino_bullet_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cost_non
            }
        }
    end,
    calculate = function(self, card, context)
        -- Consume 3 Bullets to copy the first scoring card
        if context.before and context.cardarea == G.play and 
        card.counter and card.counter == "counter_kino_bullet" and
        card.ability.counter and card.ability.counter.counter_num and card.ability.counter.counter_num >= card.ability.extra.cost_non then            
            card:bb_increment_counter(-card.ability.extra.cost_non)

            local _newcard = copy_card(context.scoring_hand[1])

            _newcard:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, _newcard)
            G.deck:emplace(_newcard)
            _newcard.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    _newcard:start_materialize()
                    return true
                end
            })) 
            return {
                message = localize('k_kino_hardcore_henry'), 
                colour = G.C.MULT,
                remove = true
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].career_stats.kino_action_packs_opened or 0,
                10
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'career_stat' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_action_packs_opened and G.PROFILES[G.SETTINGS.profile].career_stats.kino_action_packs_opened >= 10 then
                unlock_card(self)
            end
        end
    end,
}