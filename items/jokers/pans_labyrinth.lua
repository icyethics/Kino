SMODS.Joker {
    key = "pans_labyrinth",
    order = 0,
    generate_ui = Kino.generate_info_ui,
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

        local _var1, _var2, _var3, _var4

        _var1 = card.ability.extra.quest_completed_1 and 
        localize({type='variable', key="k_kino_pans_quest_hearts", vars = {card.ability.extra.mult}})
        or localize({type='variable', key='k_kino_pans_quest_' .. card.ability.extra.hearts_quest})
        
        _var2 = card.ability.extra.quest_completed_2 and 
        localize({type='variable', key="k_kino_pans_quest_diamonds", vars = {card.ability.extra.money}})
        or localize({type='variable', key='k_kino_pans_quest_' .. card.ability.extra.diamonds_quest})

        return {
            vars = {
                _var1
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
                _ret.chips = card.ability.extra.money
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
                x_mult = 1 + (card.ability.extra.xmult * _count)
            }
    end
        
    end,
    add_to_deck = function(self, card, from_debuff)
        Kino.create_pan_quests(card)
        -- local _randomselect = pseudorandom("kino_pans_labyrinth")
        -- local _valid_suits = {}

        -- if _randomselect > 0.75 then
        --     card.ability.extra.quest_completed_1 = true
        --     _valid_suits = {"Diamonds", "Clubs", "Spades"}
        -- elseif _randomselect > 0.50 then
        --     card.ability.extra.quest_completed_2 = true
        --     _valid_suits = {"Hearts", "Clubs", "Spades"}
        -- elseif _randomselect > 0.25 then
        --     card.ability.extra.quest_completed_3 = true
        --     _valid_suits = {"Hearts", "Diamonds", "Spades"}
        -- else
        --     card.ability.extra.quest_completed_4 = true
        --     _valid_suits = {"Hearts", "Diamonds", "Clubs"}
        -- end

        -- local _randomselect_quest = pseudorandom("kino_pans_labyrinth_quest", 1, 3)
        -- local _quest_options = {"slay_frog", "pale_man", "slay_child"}
        -- for i = 1, 3 do
        --     card.ability.extra[string.lower(_valid_suits[(i % 3) + 1]) .. "_quest"] = _quest_options[i]
        -- end


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

function Kino.create_pan_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    if not card then
        card = self:create_fake_card()
    end
    local target = {
        type = 'descriptions',
        key = self.key,
        set = self.set,
        nodes = desc_nodes,
        AUT = full_UI_table,
        vars =
            specific_vars or {}
    }
    local res = {}
    if self.loc_vars and type(self.loc_vars) == 'function' then
        res = self:loc_vars(info_queue, card) or {}
        target.vars = res.vars or target.vars
        target.key = res.key or target.key
        target.set = res.set or target.set
        target.scale = res.scale
        target.text_colour = res.text_colour
    end

    if desc_nodes == full_UI_table.main and not full_UI_table.name then
        full_UI_table.name = localize { type = 'name', set = target.set, key = res.name_key or target.key, nodes = full_UI_table.name, vars = res.name_vars or target.vars or {} }
    elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name and self.set ~= 'Enhanced' then
        desc_nodes.name = localize{type = 'name_text', key = res.name_key or target.key, set = target.set }
    end
    if specific_vars and specific_vars.debuffed and not res.replace_debuff then
        target = { type = 'other', key = 'debuffed_' ..
        (specific_vars.playing_card and 'playing_card' or 'default'), nodes = desc_nodes, AUT = full_UI_table, }
    end
    if res.main_start then
        desc_nodes[#desc_nodes + 1] = res.main_start
    end

    localize(target)
    if res.main_end then
        desc_nodes[#desc_nodes + 1] = res.main_end
    end
    desc_nodes.background_colour = res.background_colour
    
    -- Identical to Kino.generate_info_ui code, except no 
    if not card or not card.ability then return end

    if card.ability.multipliers then
        local _multiplier = 1
        for _source, _mult in pairs(card.ability.multipliers) do
            _multiplier = _multiplier * _mult
        end

        if _multiplier > 1 then
            info_queue[#info_queue+1] = {set = 'Other', key = "kino_valuechange", vars = {_multiplier}}
        end

        if card.ability.last_actor_count and card.ability.last_actor_count > 1 then
            info_queue[#info_queue+1] = {set = 'Other', key = "kino_actor_synergy", vars = {card.ability.last_actor_count}}
        end
    end

    if card.ability.kino_additional_genres then
        
        if #card.ability.kino_additional_genres > 1 then
            local _genrestring = ""

            for i = 1, #card.ability.kino_additional_genres do
                if i == 1 then
                    _genrestring = _genrestring .. card.ability.kino_additional_genres[i]
                else

                    _genrestring = _genrestring .. ", " .. card.ability.kino_additional_genres[i]
                end
            end

            info_queue[#info_queue+1] = {set = 'Other', key = "kino_additional_genres", vars = {3}}
        end
    end
    

    full_UI_table.name = {
        {
            n = G.UIT.C,
            config = { align = "cm", padding = 0.05 },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = full_UI_table.name
                },
                {
                    n = G.UIT.R,
                    config = { align = 'cm'},
                    nodes = Kino.get_genre_text(card)
                }

            }
        }
    }
end

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