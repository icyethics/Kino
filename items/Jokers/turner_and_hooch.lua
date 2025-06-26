SMODS.Joker {
    key = "turner_and_hooch",
    order = 33,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            is_turner = true,
            evidence_non = 0,
            a_evidence = 1,
            a_mult = 3,
            stacked_mult = 0
        }
    },
    rarity = 2,
    atlas = "kino_atlas_1",
    pos = { x = 2, y = 5},
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 6951,
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
    pools, k_genre = {"Action", "Family"},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_active"}
        return {
            vars = {
                card.ability.extra.is_turner,
                card.ability.extra.evidence_non,
                card.ability.extra.a_evidence,
                card.ability.extra.a_mult,
                card.ability.extra.stacked_mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Alternates between Turner & Hooch after each hand played.
        -- Turner: Turner, gather evidence_non. 1 evidence_non for each card played.
        -- Hooch: Each card gives mult equal to evidence_non.

        -- if context.individual and context.cardarea == G.play then
        --     -- Turner
        --     if G.jokers.cards[1] ~= card and not context.blueprint then
        --         card.ability.extra.evidence_non = card.ability.extra.evidence_non + card.ability.extra.a_evidence
        --     end
        -- end

        if context.joker_main and context.scoring_hand and G.jokers.cards[1] ~= card then
            -- Turner
            local _count = 0
            local _suits = SMODS.Suits
            for _suitname, _suitdata in pairs(_suits) do
                for _, _pcard in ipairs(context.scoring_hand) do
                    if _pcard:is_suit(_suitname) then
                        _count = _count + 1
                    end
                end
            end
            card.ability.extra.evidence_non = card.ability.extra.evidence_non + _count
        end

        if context.joker_main and G.jokers.cards[1] == card then
            -- Hooch
            return {
                mult = card.ability.extra.evidence_non * card.ability.extra.a_mult
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