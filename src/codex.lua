Kino.get_dummy_codex = function()
    return {
    {suit = nil, rank = nil},
    {suit = nil, rank = nil},
    {suit = nil, rank = nil},
    {suit = nil, rank = nil},
    {suit = nil, rank = nil}
}
end

function Kino.create_codex(loc_limits, codexseed)
    if not G.playing_cards then return false end

    local _selected_cards = {}
    local _solved_codex = {}
    local _ret_codex = {}

    for i = 1, 5 do
        local _pcard = pseudorandom_element(G.playing_cards, pseudoseed("codex_" .. codexseed))

        _selected_cards[#_selected_cards + 1] = _pcard
        _solved_codex[i] = {suit = nil, rank = nil}
        _ret_codex[i] = {suit = _pcard.base.suit, rank = _pcard.base.id}
    end

    return _ret_codex, _solved_codex
end

function Kino.compare_hand_to_codex(card, codex, checked_hand, solved_codex, codex_type)

    local _solved_codex = solved_codex
    local _last_played_hand_match = {}
    local _result = true

    -- set checked hand to last hand
    for i = 1, 5 do
        if checked_hand[i] then
            _last_played_hand_match[#_last_played_hand_match + 1] = {
                suit = checked_hand[i].base.suit,
                rank = checked_hand[i]:get_id(),
                is_match = nil
            }
        else
            _last_played_hand_match[#_last_played_hand_match + 1] = {
                suit = nil,
                rank = nil,
                is_match = nil
            }
        end
    end


    -- Check if exact positions match
    for i = 1, 5 do
        local _pcard = checked_hand[i]
        local _match = false
        -- checking for suit type code
        if codex_type == "suit" then
            if _solved_codex[i].suit ~= nil then
                _match = true
            elseif codex[i].suit and _pcard and _pcard:is_suit(codex[i].suit) then
                _match = true
                _solved_codex[i].suit = codex[i].suit
            end

            -- Iterate through all options and mark if there's a match, and whether it's exact
            for j = 1, #_last_played_hand_match do
                if _last_played_hand_match[j].suit == _solved_codex[i].suit and
                _last_played_hand_match[j].is_match ~= "Match" then
                    if i == j then
                        _last_played_hand_match[j].is_match = "Match"
                    else
                        _last_played_hand_match[j].is_match = "Near-Match"
                    end
                end
            end

        elseif codex_type == "rank" then
            if _solved_codex[i].rank ~= nil then
                _match = true
            elseif codex[i].rank and _pcard and _pcard:get_id() == codex[i].rank then
                _match = true
                _solved_codex[i].rank = codex[i].rank
            end

            -- Iterate through all options and mark if there's a match, and whether it's exact
            for j = 1, #_last_played_hand_match do
                if _last_played_hand_match[j].rank == _solved_codex[i].rank and
                _last_played_hand_match[j].is_match ~= "Match" then
                    if i == j then
                        _last_played_hand_match[j].is_match = "Match"
                    else
                        _last_played_hand_match[j].is_match = "Near-Match"
                    end
                end
            end
        end

        if not _match then
            _result = false
        end
    end

    return _result, _solved_codex, _last_played_hand_match
end

function Kino.codex_ui(codex_type, codex_solve, reveal_all)
    local _key_nodes = {}


    if not codex_solve then
        print("no codex given")
        codex_solve = Kino.get_dummy_codex()
    end

    for _, _unit in ipairs(codex_solve) do

        local _base_colour = G.C.GREY
        local _base_text = "??"

        if codex_type == "suit" and _unit.suit then
            _base_text = _unit.suit
            _base_colour = G.C.GREEN
        elseif codex_type == "rank" and _unit.rank then
            _base_text = Kino.rank_to_string(_unit.rank)
            _base_colour = G.C.GREEN
        end

        _key_nodes[#_key_nodes + 1] = {
            n = G.UIT.C,
            config = {   
                minh = 0.5,
                minw = 0.5,                     
                maxh = 0.5,
                maxw = 0.5,
                r = 0.01,
                colour = _base_colour,
                align = 'cm'
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = _base_text,
                        colour = G.C.WHITE, 
                        scale = 0.3, 
                        shadow = false
                    }
                }
            }
        }
    end

    return {
        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = G.C.CLEAR,
            padding = 0.01
        },
        nodes = _key_nodes
    }
end

function Kino.last_hand_played_codex(codex_type, hand_played, reveal_all)
    local _key_nodes = {}


    if not hand_played then
        print("no codex given")
        hand_played = Kino.get_dummy_codex()
    end

    for _, _unit in ipairs(hand_played) do

        local _base_colour = G.C.GREY
        local _base_text = "??"

        if codex_type == "suit" and _unit.suit then
            _base_text = _unit.suit
            if _unit.is_match == "Match" then
                _base_colour = G.C.GREEN
            elseif _unit.is_match == "Near-Match" then
                _base_colour = G.C.MONEY
            end
        elseif codex_type == "rank" and _unit.rank then
            _base_text = Kino.rank_to_string(_unit.rank)
            if _unit.is_match == "Match" then
                _base_colour = G.C.GREEN
            elseif _unit.is_match == "Near-Match" then
                _base_colour = G.C.MONEY
            end
        end

        _key_nodes[#_key_nodes + 1] = {
            n = G.UIT.C,
            config = {   
                minh = 0.5,
                minw = 0.5,                     
                maxh = 0.5,
                maxw = 0.5,
                r = 0.01,
                colour = _base_colour,
                align = 'cm'
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = _base_text,
                        colour = G.C.WHITE, 
                        scale = 0.3, 
                        shadow = false
                    }
                }
            }
        }
    end

    return {
        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = G.C.CLEAR,
            padding = 0.01
        },
        nodes = _key_nodes
    }
end