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
    self.GAME.full_deck_starting_size = #G.playing_cards

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

    if kino_config.halloween_deck then
        G.GAME.modifiers.kinoween = true
        Kino.kinoween_ban_list()
    end

    -- Invisible Joker Behaviour Handler
    self.kino_offscreen_area = CardArea(
        G.TILE_W - 600*G.CARD_W - 200.95, -100.1*G.jokers.T.h,
        G.jokers.T.w, G.jokers.T.h,
        { type = "joker", card_limit = 100000, highlighted_limit = 0 }
    )

    -- Set Boss Blind generation hooks
    
    self.GAME.round_resets.blind_choices.Small = Kino.get_blind("Small")
    self.GAME.round_resets.blind_choices.Big = Kino.get_blind("Big")
    self.GAME.round_resets.blind_choices.Boss = Kino.get_blind("Boss")

    self.jokers.config.card_limit_UI_text = ""
    self.hand.config.card_limit_UI_text = ""
    
    SMODS.calculation_keys[#SMODS.calculation_keys +1] = "bb_counter_number"

    return ret
end


local igo = Game.init_game_object
Game.init_game_object = function(self)
    if Cryptid or Talisman then
        Kino.cryptid_crossmod_loading()
    end
    

    local ret = igo(self)
    
    ret.seen_jokers = {}
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
    ret.current_round.bb_spells_cast = 0
    ret.current_round.bb_last_spell_cast = {
        key = "",
        rank = 1
    }
    ret.current_round.spell_queue = {
        -- should be {spell_key = KEY, strength = STRENGTH}
    }

    -- 

    ret.confections_used = {}
    ret.confections_used.all = 0
    ret.confections_powerboost = 0
    ret.confections_goldleaf_bonus = 1
    ret.current_round.confections_temp_boost = 0
    ret.current_round.confection_used = false
    ret.bullet_count = 0
    ret.current_round.abduction_waitinglist = {}

    -- Joker Pool information
    ret.current_round.joker_queue = {}
    ret.kino_boss_mode = {}
    ret.kino_boss_mode_odds = {}

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

    -- Action Card Bullet Sprites
    self.kino_bullets_ui = {
        BulletSprite_1 = Sprite(0, 0, self.CARD_W, self.CARD_H, self.ASSET_ATLAS["kino_bullets"], {x = 1, y = 0}),
        BulletSprite_2 = Sprite(0, 0, self.CARD_W, self.CARD_H, self.ASSET_ATLAS["kino_bullets"], {x = 0, y = 1}),
        BulletSprite_3 = Sprite(0, 0, self.CARD_W, self.CARD_H, self.ASSET_ATLAS["kino_bullets"], {x = 1, y = 1}),
        BulletUISprite = UISprite(0, 0, self.CARD_W, self.CARD_H, self.ASSET_ATLAS["kino_bullets"], { x = 0, y = 0 })
    }

    -- Rotisserie Sprites loading
    self.rotisserie_sprites = {
    }

    for segment_index = 1, 8 do
        self.rotisserie_sprites[segment_index] = {}
        for heat_index = 1, 8 do
            self.rotisserie_sprites[segment_index][heat_index] = Sprite(0, 0, self.CARD_W, self.CARD_H,
                G.ASSET_ATLAS["kino_mf_rotisserie"], {
                    x = heat_index - 1,
                    y = segment_index - 1,
                })
        end
    end

    ret.kino_genre_weight = {}
    for _, _genre in ipairs(kino_genres) do
        ret.kino_genre_weight[_genre] = 0
    end
    return ret
end