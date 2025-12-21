SMODS.Joker {
    key = "demon_knight",
    order = 235,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 6
        }
    },
    rarity = 2,
    atlas = "kino_atlas_7",
    pos = { x = 0, y = 4},
    cost = 4,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 9059,
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
    k_genre = {"Horror", "Action"},
    enhancement_gate = "m_kino_demonic",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        -- Whenever you destroy a demonic card, upgrade every card of that suit with +6 mult
        if context.remove_playing_cards then
            for _, _pcard in ipairs(context.removed) do

                if _pcard.config.center == G.P_CENTERS.m_kino_demonic then
                -- if SMODS:has_enhancement(_pcard, 'm_kino_demonic') then
                    for i, v in ipairs(G.playing_cards) do
                        if v:is_suit(_pcard.base.suit) then
                            v.ability.perma_mult = v.ability.perma_mult or 0
                            v.ability.perma_mult = v.ability.perma_mult + card.ability.extra.mult
                        end
                    end
                end
            end
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
            if G.GAME.current_round.sacrifices_made <= 0 then
                for i, _pcard in ipairs(G.playing_cards) do
                    if _pcard.config.center == G.P_CENTERS.m_kino_demonic then
                        unlock_card(self)
                        break
                    end
                end
            end
        end
    end,
}