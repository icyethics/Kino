local o_cuc = Card.use_consumeable
function Card:use_consumeable(area, copier)
    local _ret = o_cuc(self, area, copier)

    if self.key == "m_kino_droid" then
        for index, _pcard in ipairs(G.hand.highlighted) do
            if _pcard.config.center == "m_gold" then
                check_for_unlock({type="kino_droid_on_gold"})
            end
        end
    end

    return _ret
end

local o_c_shatter = Card.shatter
function Card:shatter()
    local _ret = o_c_shatter(self)
    G.GAME.kino_tracking_shattered = G.GAME.kino_tracking_shattered or 0
    G.GAME.kino_tracking_shattered = G.GAME.kino_tracking_shattered + 1
    if G.GAME.kino_tracking_shattered >= 20 then
        check_for_unlock({type="kino_shattered_20"})
    end
    return _ret
end