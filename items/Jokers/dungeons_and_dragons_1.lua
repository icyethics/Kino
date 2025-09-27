SMODS.Joker {
    key = "dungeons_and_dragons_1",
    order = 191,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            a_stacks = 1,
            a_mult = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_6",
    pos = { x = 4, y = 1},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 11849,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    pools, k_genre = {"Fantasy"},
    in_pool = function(self, args)
        -- Check for the right frequency
        local enhancement_gate = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_kino_fantasy") then
                    enhancement_gate = true
                    break
                end
            end

            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.kino_spellcaster then
                    enhancement_gate = true
                    break
                end
            end
        end

        return enhancement_gate
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_spellcasting"}
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.a_stacks,
                card.ability.extra.a_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Gain stacks when not in the active slot, turn stacks into mult in the active slot
        if context.bb_cast_spell then
            card.ability.extra.stacks = card.ability.extra.stacks + context.strength * card.ability.extra.a_stacks
        end

        if context.joker_main and G.jokers.cards[1] == card then
            local _mult = card.ability.extra.stacks * card.ability.extra.a_mult
            card.ability.extra.stacks = 0
            return {
                mult = _mult
            }
        end
    end,
    update = function(self, card, dt)
        if card.area and card.area == G.jokers and G.jokers.cards[1] == card then
            if not card.children.activedisplay then
                card.children.activedisplay = Kino.create_active_ui(card)
            end
        else
            card.children.activedisplay = nil
        end
        
    end,
}