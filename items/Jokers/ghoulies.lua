SMODS.Joker {
    key = "ghoulies",
    order = 110,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            hand_name = "High Card"
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 1, y = 0},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 18498,
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
    k_genre = {"Horror"},
    enhancement_gate = 'm_kino_demonic',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_name
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play the given hand type, add a Demonic 2 to your hand.
        if context.joker_main and context.scoring_name == card.ability.extra.hand_name then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _pool = {G.P_CARDS.H_2, G.P_CARDS.C_2, G.P_CARDS.D_2, G.P_CARDS.S_2}
                    local _card = create_playing_card({
                        front = pseudorandom_element(_pool, pseudoseed('ghoulies')), 
                        center = G.P_CENTERS.m_kino_demonic}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                    G.GAME.blind:debuff_card(_card)
                    G.hand:sort()
                    return true
                end}))

            -- After performing the ritual, change the ritual
            local _poker_hands = {}
            local cur_hand = card.ability.extra.hand_name
    
            for k, v in pairs(G.GAME.hands) do
                if v.visible then _poker_hands[#_poker_hands+1] = k end
            end
            
            card.ability.extra.hand_name = nil
    
            while not card.ability.extra.hand_name do
                card.ability.extra.hand_name = pseudorandom_element(_poker_hands)
                if card.ability.extra.hand_name == cur_hand then
                    card.ability.extra.hand_name = nil
                end
            end
            
            -- Tell everyone the summoning worked.
            return {
                message = localize('k_summoned_ex'),
                colour = G.C.BLACK,
                card = card,
                playing_cards_created = {true}
            }
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades.count or 0,
                50
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'modify_deck' then
            local _tally = 0
            for i, _pcard in ipairs(G.playing_cards) do
                if _pcard.config.center == G.P_CENTERS.m_kino_demonic and _pcard:get_id() == 2 then
                    _tally = _tally + 1
                    break
                end
            end

            if _tally >= 1 then
                unlock_card(self)
            end
        end
    end,
}