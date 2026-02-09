SMODS.Joker {
    key = "pans_labyrinth",
    order = 0,
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        local _desc_nodes_dummy = {}
        local _dummy_full_UI_table = copy_table(full_UI_table)

        self.key = "j_kino_pans_labyrinth_locked"
        Kino.generate_info_ui(self, info_queue, card, _desc_nodes_dummy, specific_vars, _dummy_full_UI_table)

        self.key = "j_kino_pans_labyrinth"
        Kino.generate_info_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

        local _quest_keys = {
            slay_frog = 1, 
            pale_man = 2, 
            slay_child = 3
        }

        if not card.ability.extra.quest_completed_1 then
            full_UI_table.multi_box[1] = _dummy_full_UI_table.multi_box[_quest_keys[card.ability.extra.hearts_quest]]
        end

        if not card.ability.extra.quest_completed_2 then
            full_UI_table.multi_box[2] = _dummy_full_UI_table.multi_box[_quest_keys[card.ability.extra.diamonds_quest]]

        end

        if not card.ability.extra.quest_completed_3 then
            full_UI_table.multi_box[3] = _dummy_full_UI_table.multi_box[_quest_keys[card.ability.extra.clubs_quest]]
        end

        if not card.ability.extra.quest_completed_4 then
            full_UI_table.multi_box[4] = _dummy_full_UI_table.multi_box[_quest_keys[card.ability.extra.spades_quest]]
        end

        -- full UI table multiboxes:
        -- 1 Hearts
        -- 2 Diamonds
        -- 3 Chips
        -- 4 Spades

        -- dummy multiboxes:
        -- 1 slay frog
        -- 2 eat dinner
        -- 3 slay child
    end,
    config = {
        extra = {
            quest_completed_1 = false, -- Hearts
            quest_completed_2 = false, -- Diamonds
            quest_completed_3 = false, -- Clubs
            quest_completed_4 = false, -- Spades

            hearts_quest = nil,
            diamonds_quest = nil,
            clubs_quest = nil,
            spades_quest = nil,

            mult = 4,
            money = 1,
            chips = 25,
            x_mult = 0.2,
            payout = 0,

            confections_eaten = 0,
            slay_frog = false,
            slay_child = false,
            pale_man = false
        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 5, y = 4},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1417,
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
    k_genre = {"Fantasy", "Horror", "Drama"},

    loc_vars = function(self, info_queue, card)
        if card.ability.extra.hearts_quest == nil and card.ability.extra.diamonds_quest == nil then
            Kino.create_pan_quests(card)
        end

        local _count = 0
        for _index, _pcard in ipairs(G.discard.cards) do
            if _pcard:is_suit("Spades") then
                _count = _count + 1
            end
        end

        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.money,
                card.ability.extra.chips,
                card.ability.extra.x_mult,
                1 + (card.ability.extra.x_mult * _count),
                box_colours = {
                    G.C.FILTER,
                    not card.ability.extra.quest_completed_1 and G.C.BLACK or G.C.WHITE,
                    not card.ability.extra.quest_completed_2 and G.C.BLACK or G.C.WHITE,
                    not card.ability.extra.quest_completed_3 and G.C.BLACK or G.C.WHITE,
                    not card.ability.extra.quest_completed_4 and G.C.BLACK or G.C.WHITE,
                    G.C.KINO.STRANGE_PLANET
                }
            },
            
        }
    end,
    calculate = function(self, card, context)
        -- Complete a Quest to power up the base effect

        if context.individual and not context.end_of_round then
            local _ret = {}
            if context.cardarea == G.play and context.other_card:is_suit("Hearts") and card.ability.extra.quest_completed_1 then
                _ret.mult = card.ability.extra.mult
            end
            -- if context.other_card:is_suit("Diamonds") and card.ability.extra.quest_completed_2 then
            --     _ret.dollars = card.ability.extra.money
            -- end
            if context.cardarea == G.hand and context.other_card:is_suit("Clubs") and card.ability.extra.quest_completed_3 then
                _ret.chips = card.ability.extra.chips
            end
            
            return _ret
        end

        if context.joker_main and card.ability.extra.quest_completed_4 then
            local _count = 0
            for _index, _pcard in ipairs(G.discard.cards) do
                if _pcard:is_suit("Spades") then
                    _count = _count + 1
                end
            end
            return {
                x_mult = 1 + (card.ability.extra.x_mult * _count)
            }
        end

        if context.end_of_round and context.cardarea == G.jokers then
            local _count = 0
            for _index, _pcard in ipairs(G.deck.cards) do
                if _pcard:is_suit("Diamonds") then
                    _count = _count + 1
                end
            end
            card.ability.extra.payout = _count
        end
        
        -- -- Quest unlocking

        -- Slay Frog
        if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind:get_type() == "Boss" and not card.ability.extra.slay_frog then
            if card.ability.extra.hearts_quest == "slay_frog" then card.ability.extra.quest_completed_1 = true end
            if card.ability.extra.diamonds_quest == "slay_frog" then card.ability.extra.quest_completed_2 = true end
            if card.ability.extra.clubs_quest == "slay_frog" then card.ability.extra.quest_completed_3 = true end
            if card.ability.extra.spades_quest == "slay_frog" then card.ability.extra.quest_completed_4 = true end
            card.ability.extra.slay_frog = true
            card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_kino_pans_labyrinth'), colour = G.C.FILTER })
        end

        -- Eat 5 Confections
        if context.post_confection_used and not card.ability.extra.pale_man then
            card.ability.extra.confections_eaten = card.ability.extra.confections_eaten + 1

            if card.ability.extra.confections_eaten == 5 then
                if card.ability.extra.hearts_quest == "pale_man" then card.ability.extra.quest_completed_1 = true end
                if card.ability.extra.diamonds_quest == "pale_man" then card.ability.extra.quest_completed_2 = true end
                if card.ability.extra.clubs_quest == "pale_man" then card.ability.extra.quest_completed_3 = true end
                if card.ability.extra.spades_quest == "pale_man" then card.ability.extra.quest_completed_4 = true end
                card.ability.extra.pale_man = true
                card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_kino_pans_labyrinth'), colour = G.C.FILTER })
            end
        end

        if context.remove_playing_cards and not card.ability.extra.slay_child then
            local _cont = false
            for i = 1, #context.removed do
                if context.removed[i]:get_id() == 2 then
                    _cont = true
                    break
                end
            end

            if card.ability.extra.hearts_quest == "slay_child" then card.ability.extra.quest_completed_1 = true end
            if card.ability.extra.diamonds_quest == "slay_child" then card.ability.extra.quest_completed_2 = true end
            if card.ability.extra.clubs_quest == "slay_child" then card.ability.extra.quest_completed_3 = true end
            if card.ability.extra.spades_quest == "slay_child" then card.ability.extra.quest_completed_4 = true end
            card.ability.extra.slay_child = true
            card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_kino_pans_labyrinth'), colour = G.C.FILTER })
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        Kino.create_pan_quests(card)
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.quest_completed_2 then
            local _payout = card.ability.extra.payout

            card.ability.extra.payout = 0

            return _payout
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
        if args.type == 'kino_sci_fi_upgrades' then
            if G.PROFILES[G.SETTINGS.profile].career_stats.kino_sci_fi_upgrades and G.PROFILES[G.SETTINGS.profile].career_stats.kino_sci_fi_upgrades >= 50 then
                unlock_card(self)
            end
        end
    end,
}

function Kino.create_pan_quests(card)
    local _randomselect = pseudorandom("kino_pans_labyrinth")
    local _valid_suits = {}

    if _randomselect > 0.75 then
        card.ability.extra.quest_completed_1 = true
        _valid_suits = {"Diamonds", "Clubs", "Spades"}
    elseif _randomselect > 0.50 then
        card.ability.extra.quest_completed_2 = true
        _valid_suits = {"Hearts", "Clubs", "Spades"}
    elseif _randomselect > 0.25 then
        card.ability.extra.quest_completed_3 = true
        _valid_suits = {"Hearts", "Diamonds", "Spades"}
    else
        card.ability.extra.quest_completed_4 = true
        _valid_suits = {"Hearts", "Diamonds", "Clubs"}
    end

    local _randomselect_quest = pseudorandom("kino_pans_labyrinth_quest", 1, 3)
    local _quest_options = {"slay_frog", "pale_man", "slay_child"}
    for i = 1, 3 do
        card.ability.extra[string.lower(_valid_suits[(i % 3) + 1]) .. "_quest"] = _quest_options[i]
    end
end