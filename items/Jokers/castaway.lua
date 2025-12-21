SMODS.Joker {
    key = "castaway",
    order = 129,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_wet = true,
        extra = {
            bonus = 5
        }
    },
    rarity = 2,
    atlas = "kino_atlas_4",
    pos = { x = 2, y = 3},
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 8358,
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
    k_genre = {"Drama"},
    is_wet = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bonus
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you play a high card, upgrade it with +5 chips for each unscoring card
        if context.individual and context.cardarea == G.play and context.scoring_name == "High Card" then
            local _card = context.other_card 
            local _count = #context.full_hand - #context.scoring_hand 

            _card.ability.perma_bonus = _card.ability.perma_bonus or 0
            _card.ability.perma_bonus = _card.ability.perma_bonus + (card.ability.extra.bonus * _count)
        end

        if context.individual and context.cardarea == "unscored" and context.scoring_name == "High Card" then
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = context.scoring_hand[1]
            }          
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].kino_sci_fi_upgrades.count or 0,
                50
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            if #G.playing_cards <= 26 then
                unlock_card(self) 
            end
        end
    end,
}