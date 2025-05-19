if kino_config.confection_mechanic then
SMODS.ConsumableType {
    key = "confection",
    primary_colour = HEX("4F6367"),
    secondary_colour = HEX("4ABA8D"),
    loc_text = {
        name = "Confection",
        collection = "Confection Cards"
    },
    collection_row = {6, 6},
    shop_rate = 2,
    default = "c_kino_popcorn"
}

SMODS.UndiscoveredSprite {
    key = "confection",
    atlas = "kino_confections",
    pos = {x = 0, y = 3} 
}
end