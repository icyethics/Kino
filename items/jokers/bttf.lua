SMODS.Joker {
    key = "bttf",
    order = 10,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            display_amount = 3
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 3, y = 1 },
    cost = 5,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 105,
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
    k_genre = {"Sci-fi"},

    loc_vars = function(self, info_queue, card)

        local _display = card.area == G.jokers and Kino.bttf_preview(G.deck.cards, card.ability.extra.display_amount) or nil

        return {
            vars = {
                card.ability.extra.display_amount,
            },
            main_end = _display
        }
    end,
    calculate = function(self, card, context)
        -- Shows you the top three cards
    end
}

function Kino.bttf_preview(card_table, num)
    if not card_table or type(card_table) ~= "table" or #card_table < 1 or num < 1 then
        return nil
    end

    local _width = math.min(num*G.CARD_W, 6*G.CARD_W)
    local _scale = 0.5
    Kino.bttf_preview_area = CardArea(
        2,2,
        _width * _scale,
        (0.95*G.CARD_H) * _scale, 
        {card_limit = num, type = 'title', highlight_limit = 0, temporary = true}
    )

    for i = 1, num do
        local _startScale = 0.3
        local _card = copy_card(card_table[#card_table + 1 - (i)], nil, _startScale)
        ease_value(_card.T, 'scale',0.5,nil,'REAL',true,0.2)
        -- local _card = Card(0,0, 0.5*G.CARD_W, 0.5*G.CARD_H, G.P_CARDS['S_A'], G.P_CENTERS['c_base'])
        Kino.bttf_preview_area:emplace(_card)
    end

    local _return = {
        {
            n = G.UIT.C,
            config = {
                align = 'cm',
                colour = G.C.CLEAR,
                padding = 0.1
            },
            nodes = {
                {
                    n=G.UIT.O, 
                    config = {
                        object = Kino.bttf_preview_area
                    }
                }
            }
        }
    }

    return _return
end