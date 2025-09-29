SMODS.Joker {
    key = "encanto",
    order = 193,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {

        }
    },
    rarity = 1,
    atlas = "kino_atlas_6",
    pos = { x = 0, y = 2},
    cost = 3,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 568124,
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
    kino_spellcaster = true,
    pools, k_genre = {"Fantasy", "Musical", "Animation"},
    

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = "gloss_spellcasting"}
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a full house, cast a spell
        -- (Based on the suits of the double cards, and the rank of the triple card)

        if context.joker_main and context.scoring_name == "Full House" then
            local _strength = 1
            local _card = nil
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() > _strength then 
                    _strength = context.scoring_hand[i]:get_id() 
                    _card = context.scoring_hand[i]
                end
            end
            card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_harry_potter'), colour = G.C.PURPLE })
            return  Blockbuster.cast_spell("spell_Wild_Wild", Blockbuster.card_to_spell_level(_card))
        end
    end
}