local _o_gsr = Game.start_run
function Game:start_run(args)
    local ret = _o_gsr(self, args)
  
    -- Setting up the base suit count for the deck
    if not self.GAME.suit_startingcounts then
        self.GAME.suit_startingcounts = {}

        local _suits = SMODS.Suits
        for _suitname, _suitdata in pairs(_suits) do
            -- Iterate through playing cards, storing the count
            local _count = 0
            for _, _playing_card in ipairs(G.playing_cards) do
                if _playing_card.base.suit == _suitname then
                    _count = _count + 1
                end
            end
            self.GAME.suit_startingcounts[_suitname] = _count
        end
    end

    -- DECK behaviours
    -- Empowered Deck
    if G.GAME.starting_params.kino_empowereddeck then
        local _suits = SMODS.Suits

        for _suitname, _suitdata in pairs(_suits) do
            local _enhancement = SMODS.poll_enhancement({guaranteed = true})

            -- iterate through every card
            for _, _pcard in ipairs(G.playing_cards) do
                if not G.GAME.starting_params.kino_empoweredsleeve and 
                _pcard:is_suit(_suitname) and not SMODS.has_any_suit(_pcard) and
                _pcard:is_face() then
                    _pcard:set_ability(_enhancement)
                elseif G.GAME.starting_params.kino_empoweredsleeve and 
                _pcard:is_suit(_suitname) and not SMODS.has_any_suit(_pcard) then
                    _pcard:set_ability(_enhancement)
                end
            end
        end
    end

    -- Invisible Joker Behaviour Handler
    self.kino_offscreen_area = CardArea(
        G.TILE_W - 600*G.CARD_W - 200.95, -100.1*G.jokers.T.h,
        G.jokers.T.w, G.jokers.T.h,
        { type = "joker", card_limit = 100000, highlighted_limit = 0 }
    )

    local _calcjoker = SMODS.add_card{key = "j_kino_handlerobject", area = self.kino_offscreen_area, skip_materialize = true, no_edition = true}

    if G.GAME.starting_params.kino_spellcasting_deck then
        Kino.initialize_spellslingerdeck_UI()
    end

    return ret
end


local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    

    ret.modifiers.genre_bonus = {}
    ret.last_played_hand = nil

    ret.current_round.scrap_total = 0
    ret.current_round.matches_made = 0
    ret.current_round.sci_fi_upgrades = 0
    ret.current_round.sci_fi_upgrades_last_round = 0
    ret.current_round.sacrifices_made = 0
    ret.current_round.kryptons_used = 0
    ret.current_round.beaten_run_high = 0
    ret.current_round.horror_transform = 0
    ret.current_round.cards_abducted = 0
    ret.money_stolen = 0
    ret.cards_destroyed = 0
    ret.jumpscare_triggers = 0

    ret.current_round.actors_check = 3
    ret.current_round.actors_table_offset = 0
    ret.current_round.genre_synergy_treshold = 5
    
    -- Fantasy cards
    ret.current_round.spells_cast = 0
    ret.current_round.last_spell_cast = {
        key = "",
        rank = 1
    }
    ret.current_round.spell_queue = {
        -- should be {spell_key = KEY, strength = STRENGTH}
    }

    -- 

    ret.confections_used = 0
    ret.confections_powerboost = 0
    ret.confections_goldleaf_bonus = 1
    ret.current_round.confections_temp_boost = 0
    ret.current_round.confection_used = false

    ret.current_round.abduction_waitinglist = {}

    -- Joker Pool information
    ret.current_round.joker_queue = {}

    -- Boss Blind info
    ret.current_round.boss_blind_joker_counter = 0
    ret.current_round.boss_blind_blofeld_counter = 10000
    ret.current_round.boss_blind_agent_smith_rank_discards = {}
    ret.current_round.boss_blind_thanos_cards = {}

    -- -- Set up visual information 
    self.shared_indicator_sprites = {
        powerchange_sprite = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["kino_ui"], {
                x = 6,
                y = 0
            }),
    }

    -- Setting up the Sci-fi display sprites
    self.shared_enhancement_sprites = {
        angelic_sprite = Sprite(0, 0, self.CARD_W, self.CARD_H,
            G.ASSET_ATLAS["kino_morefluff_enhancements"], {
                x = 0,
                y = 5
            }),
        time_sprite = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["kino_morefluff_enhancements"], {
                x = 1,
                y = 5
            }),
        active_sprite = Sprite(0,0, self.CARD_W, self.CARD_W, 
            G.ASSET_ATLAS["kino_ui_large"], {
                x=0, 
                y=0
            }),
    }

    self.shared_segdisp = {
        {},
        {},
        {},
        {}
    }
    for i = 1, 14 do
        for j = 1, 4 do
            self.shared_segdisp[j][i] = Sprite(0, 0, self.CARD_W, self.CARD_H,
                G.ASSET_ATLAS["kino_seg_display"], {
                    x = i - 1,
                    y = 4 - j
                })
        end
    end

    --- Set up for the Counter System
    -- Jokers
    self.counter_numbers_jokers = {

    }
    for i = 1, 10 do
        self.counter_numbers_jokers[i] = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["kino_counters_jokers"], {
                x = i - 1,
                y = 0
            })
    end

    local _listofsprites = {
        {name = "kino_retrigger", x = 0, y = 1},
        {name = "kino_investment", x = 1, y = 1},
        {name = "kino_power", x = 2, y = 1},
        {name = "kino_heal", x = 3, y = 1},

        {name = "kino_stun", x = 0, y = 2},
        {name = "kino_debt", x = 1, y = 2},
        {name = "kino_chained", x = 2, y = 2},
        {name = "kino_poison", x = 3, y = 2},
    }

    self.counter_sprites_jokers = {}
    for _index, _info in ipairs(_listofsprites) do
        self.counter_sprites_jokers[_info.name] = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["kino_counters_jokers"], {
                x = _info.x,
                y = _info.y
            })
    end

    -- Playing Cards
    self.counter_numbers_pcards = {

    }
    for i = 1, 10 do
        self.counter_numbers_pcards[i] = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["kino_counters_pcards"], {
                x = i - 1,
                y = 0
            })
    end

    local _listofsprites = {
        {name = "kino_retrigger", x = 0, y = 1},
        {name = "kino_investment", x = 1, y = 1},
        {name = "kino_power", x = 2, y = 1},
        {name = "kino_heal", x = 3, y = 1},

        {name = "kino_stun", x = 0, y = 2},
        {name = "kino_debt", x = 1, y = 2},
        {name = "kino_chained", x = 2, y = 2},
        {name = "kino_poison", x = 3, y = 2},
    }

    self.counter_sprites_pcards = {}
    for _index, _info in ipairs(_listofsprites) do
        self.counter_sprites_pcards[_info.name] = Sprite(0, 0, self.CARD_W, self.CARD_W,
            G.ASSET_ATLAS["kino_counters_pcards"], {
                x = _info.x,
                y = _info.y
            })
    end
    
    

    ret.kino_genre_weight = {}
    for _, _genre in ipairs(kino_genres) do
        ret.kino_genre_weight[_genre] = 0
    end

    return ret
end