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