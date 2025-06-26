local _o_gsr = Game.start_run
function Game:start_run(args)
  local ret = _o_gsr(self, args)
  
    -- Setting up the base suit count for the deck
    self.GAME.suit_startingcounts = {}

    local _suits = SMODS.Suits
    for _suitname, _suitdata in pairs(_suits) do
        -- Iterate through playing cards, storing the count
        local _count = 0
        for _, _playing_card in ipairs(G.playing_cards) do
            if _playing_card.base.suit == _suitname then
                _count = _count + 1
            end
        end
        self.GAME.suit_startingcounts[_suitname] = _count
    end

  return ret
end