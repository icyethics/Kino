SMODS.Joker {
    key = "source_code",
    order = 321,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            mult = 1
        }
    },
    rarity = 2,
    atlas = "kino_atlas_9",
    pos = { x = 2, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 45612,
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
    k_genre = {"Sci-fi", "Action", "Thriller"},
    enhancement_gate = "m_kino_action",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(G.GAME.current_round.kino_source_code and G.GAME.current_round.kino_source_code or "Hearts", "suits_singular"),
                card.ability.extra.mult,
                colours = {
                    G.C.SUITS[G.GAME.current_round.kino_source_code and G.GAME.current_round.kino_source_code or "Hearts"]
                }
            }
        }
    end,
    calculate = function(self, card, context)
        -- Random Suit gives +1 mult for each Bullet

        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit(G.GAME.current_round.kino_source_code) then
                local _bullets = G.GAME.bullet_count

                return {
                    mult = _bullets * card.ability.extra.mult
                }
            end
        end
    end,
    -- Unlock Functions
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win' then
            if next(find_joker("j_kino_matrix_1")) then
                unlock_card(self)
            end
        end
    end,
}