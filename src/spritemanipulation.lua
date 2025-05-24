print("testing this")
local o_gamerun = Game.start_up
function Game:start_up()
    print("entering this func")
    o_gamerun()


    -- Setting up the Sci-fi display sprites
    self.shared_segdisp = {
        {},
        {},
        {},
        {}
    }
    for i = 1, 14 do
        for j = 1, 4 do
            self.shared_segdisp[j][i] = Sprite(0, 0, self.CARD_W, self.CARD_H,
                G.ASSET_ATLAS["kino_seg_display"], {
                    x = i - 1,
                    y = j - 1
                })
        end
    end

    print(#self.shared_segdisp[1])
end