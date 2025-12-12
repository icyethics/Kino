function Blockbuster.printBanList()
    for _key, _bool in pairs(G.GAME.banned_keys) do
        print(_key)
    end
end

function Blockbuster.printLegalList()
    for _key, _object in pairs(G.P_CENTERS) do
        if G.GAME.banned_keys[_key] then
        
        else
            print(_key)
        end
    end
end