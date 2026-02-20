SMODS.Enhancement {
    key = "mystery",
    atlas = "kino_enhancements",
    pos = { x = 5, y = 5},
    config = {
        extra = {
            suspect_rank = nil,
            suspect_suit = nil,
            suspect_rank_revealed = false,
            suspect_suit_revealed = false,
            suspect_rank_visual = "",
            x_mult = 1,
            a_xmult = 0.5
        }

    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.a_xmult,
                (card.ability.extra.suspect_suit and card.ability.extra.suspect_suit_revealed) and localize(card.ability.extra.suspect_suit, "suits_plural") or "???",
                (card.ability.extra.suspect_rank and card.ability.extra.suspect_rank_revealed) and localize(card.ability.extra.suspect_rank_visual, 'ranks') or "???",
                colours = {
                    (card.ability.extra.suspect_suit and card.ability.extra.suspect_suit_revealed) and G.C.SUITS[card.ability.extra.suspect_suit] or G.C.FILTER
                }
            }
        }
    end,
    calculate = function(self, card, context, effect)
        -- Gain 0.75 mult if you find your suspect
        if context.main_scoring and context.cardarea == G.play then
            -- Pre-check
            if card.ability.extra.suspect_rank == nil then
                local _table = Kino.mystery_card_select(card)
                card.ability.extra.suspect_rank = _table.rank
                card.ability.extra.suspect_suit = _table.suit
                card.ability.extra.suspect_rank_visual = _table.rank_visual
            end

            -- Find me
            local _mypos = nil

            for _index, _suspect in ipairs(G.hand.cards) do
                local _suitmatch = false
                local _rankmatch = false

                if _suspect:is_suit(card.ability.extra.suspect_suit) then
                    _suitmatch = true
                    card.ability.extra.suspect_suit_revealed = true
                    card:juice_up()
                end

                if _suspect:get_id() == card.ability.extra.suspect_rank then
                    _rankmatch = true
                    card.ability.extra.suspect_rank_revealed = true
                    card:juice_up()
                end

                if _suitmatch and _rankmatch then
                    _suspect:juice_up()
                    card_eval_status_text(_suspect, 'extra', nil, nil, nil,
                    { message = localize('k_kino_mystery'), colour = G.C.MULT})
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.a_xmult

                    -- reset card
                    card.ability.extra.suspect_suit_revealed = false
                    card.ability.extra.suspect_rank_revealed = false
                    local _table = Kino.mystery_card_select(card)
                    card.ability.extra.suspect_rank = _table.rank
                    card.ability.extra.suspect_suit = _table.suit
                    card.ability.extra.suspect_rank_visual = _table.rank_visual

                    check_for_unlock({type="kino_mystery_card_solved"})
                    break
                end
            end

            if card.ability.extra.x_mult ~= 1 then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end



            -- OLD FUNCTIONALITY
            -- if context.scoring_hand[_mypos + 1] then
            --     local _suspect = context.scoring_hand[_mypos + 1]
            --     local _suitmatch = false
            --     local _rankmatch = false

            --     if _suspect:is_suit(card.ability.extra.suspect_suit) then
            --         _suitmatch = true
            --         card.ability.extra.suspect_suit_revealed = true
            --         card:juice_up()
            --     end

            --     if _suspect:get_id() == card.ability.extra.suspect_rank then
            --         _rankmatch = true
            --         card.ability.extra.suspect_rank_revealed = true
            --         card:juice_up()
            --     end

            --     if _suitmatch and _rankmatch then
            --         card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.a_xmult

            --         -- reset card
            --         card.ability.extra.suspect_suit_revealed = false
            --         card.ability.extra.suspect_rank_revealed = false
            --         local _table = Kino.mystery_card_select(card)
            --         card.ability.extra.suspect_rank = _table.rank
            --         card.ability.extra.suspect_suit = _table.suit
            --         card.ability.extra.suspect_rank_visual = _table.rank_visual

            --         check_for_unlock({type="kino_mystery_card_solved"})
            --     end
            -- end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        -- Pick target card
        local _table = Kino.mystery_card_select(card)
        card.ability.extra.suspect_rank = _table.rank
        card.ability.extra.suspect_suit = _table.suit
        card.ability.extra.suspect_rank_visual = _table.rank_visual
    end
}

Kino.mystery_card_select = function(card)

    local _pickedcard = card
    while _pickedcard == card do
        _pickedcard = pseudorandom_element(G.playing_cards, pseudoseed("kino_mysterygen"))
    end

    local _suit = _pickedcard.base.suit
    local _rank = _pickedcard:get_id()
    local _rank_visual = _pickedcard.base.value
    
    return {
        suit = _suit,
        rank = _rank,
        rank_visual = _rank_visual
    }
end

local MysterySprite
SMODS.DrawStep {
    key = "kino_enhancement_mystery_step",
    order = 50,
    func = function(card, layer)
        -- if card and SMODS.has_enhancement(card, 'm_kino_mystery') then
        if card and card.config.center == G.P_CENTERS.m_kino_mystery then
            MysterySprite = MysterySprite or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["kino_enhancements"], {x = 5, y = 1})
            MysterySprite.role.draw_major = card
            MysterySprite:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil, nil, 1)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}