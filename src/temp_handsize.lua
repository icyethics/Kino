function Kino.add_temporary_hand_size()
    G.GAME.kino_temporary_handsize = G.GAME.kino_temporary_handsize or 0
    local num = G.GAME.kino_temporary_handsize_prep or 0
    G.GAME.kino_temporary_handsize_prep = 0
    G.GAME.kino_temporary_handsize = G.GAME.kino_temporary_handsize + num
    G.hand:change_size(num)
    

    if G.GAME.kino_temporary_handsize > 0 then
        G.hand.config.card_limit_UI_text = " (+" .. G.GAME.kino_temporary_handsize .. " Temporary Handsize)"
    else
        G.hand.config.card_limit_UI_text = ""
    end
end

function Kino.prepare_temporary_hand_size(num, source)
    G.GAME.kino_temporary_handsize_prep = G.GAME.kino_temporary_handsize_prep or 0
    G.GAME.kino_temporary_handsize_prep = G.GAME.kino_temporary_handsize_prep + num
end

function Kino.reset_temporary_hand_size()
    G.GAME.kino_temporary_handsize = G.GAME.kino_temporary_handsize or 0
    local _hands_to_remove = G.GAME.kino_temporary_handsize
    G.GAME.kino_temporary_handsize = 0
    G.hand:change_size(-_hands_to_remove)

    if G.GAME.kino_temporary_handsize > 0 then
        G.hand.config.card_limit_UI_text = " (+" .. G.GAME.kino_temporary_handsize .. " Temporary Handsize)"
    else
        G.hand.config.card_limit_UI_text = ""
    end
end