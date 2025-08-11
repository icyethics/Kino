SMODS.Joker {
    key = "doctor_strange_1",
    order = 211,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            stacks = 0,
            goal = 3
        }
    },
    rarity = 3,
    atlas = "kino_atlas_6",
    pos = { x = 0, y = 5},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 284052,
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
    pools, k_genre = {"Fantasy", "Superhero"},
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
        info_queue[#info_queue + 1] = SMODS.Spells["spell_kino_EyeOfAgamoto"]
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_spellcasting"}
        return {
            vars = {
                card.ability.extra.stacks,
                card.ability.extra.goal
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pre_spell_cast then
            card.ability.extra.stacks = card.ability.extra.stacks + 1

            if card.ability.extra.stacks == card.ability.extra.goal then
                card.ability.extra.stacks = 0
                G.GAME.current_round.spell_queue[#G.GAME.current_round.spell_queue + 1] = {
                    spell_key = "spell_kino_EyeOfAgamoto",
                    strength = 1
                }
            end
        end
    end
}