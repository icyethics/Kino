Kino.Debug = {}

Kino.Debug.DiscoverUnlocked = function()
    print("Discovering Objects")
    local _count = 0
    for _key, _center in pairs(G.P_CENTERS) do
      if not _center.demo and not _center.wip and not _center.unlocked == false then 
        _center.alerted = true
        _center.discovered = true
        _center.unlocked = true
        _count = _count + 1
      end
    end
    print("Discovered " .. _count .. " Objects")
end

Kino.Debug.CountGenres = function()
    print("Counting Every Genre")
    local _genrecount = {}
    for _index, _genre in ipairs(kino_genres) do
      _genrecount[_genre] = 0
    end

    local _count = 0
    for _key, _center in pairs(G.P_CENTERS) do
      if _center.k_genre then 
        for _index, _genre in ipairs(_center.k_genre) do
          _genrecount[_genre] = _genrecount[_genre] + 1
        end
      end
    end
    print(_genrecount)
end

function Kino.Debug.last_played_hand(inc)
    print(G.GAME.last_played_hand[inc])
end

function Kino.Debug.ID_check()
    for _index, _card in ipairs(G.hand.cards) do
        print("Card #".. _index)
        print(_card.ID)
        print(_card.ability.unique_val)
        print(_card.ability.unique_val__saved_ID)
    end
end

function Kino.Debug.print_contexts(context)
    for _key, _value in pairs(context) do
        print(_key)
    end
end

function Kino.Debug.cardareaprint(area)
    if area == Kino.snackbag then print('snack') end
    if area == G.kino_snackbag then print('snackbag in G') end
    if area == G.jokers then print('jokers') end
    if area == G.consumeables then print('consum') end
    if not area then print('nil') end
end