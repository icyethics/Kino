SMODS.ConsumableType {
    key = "BlindAbility",
    primary_colour = HEX("c7cfdb"),
    secondary_colour = HEX("899dbb"),
    loc_text = {
        name = "Blind Ability",
        collection = "Blind Ability Cards"
    },
    shop_rate = 0,
    default = "c_kino_damsel",
}

SMODS.DrawStep {
    key = "kino_blind_ability",
    order = 51,
    func = function(card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' and 
        card.ability.set == "BlindAbility" then
            card.children.center:draw_shader('kino_steel', nil, card.ARGS.send_to_shader)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}