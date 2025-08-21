-- Support Functions Needed:
-- 1. Create a tooltip for the genre
-- 2. Create a tooltip for the director
-- 3a. make jokers be able to check their cast, and compare.
-- 3b. start displaying cast members over the corresponding jokers if they're present in at least 3 owned jokers.

-- Genre tooltip

-- Is director

-- Is cast

-- Director tooltip

function genre_match(_listA, _listB)
    if type(_listA) ~= "table" then
        _listA = {_listA}
    end
    if type(_listB) ~= "table" then
        _listB = {_listB}
    end

    for _index, _genre in ipairs(_listA) do
        for _, _genreComp in ipairs(_listB) do
            if _genre == _genreComp then
                return _index
            end
        end
    end

    return false
end

function is_genre(joker, genre, debug)
    if G.GAME.modifiers.egg_genre == genre then
        return true
    end

    if joker.config.center.k_genre then
        for i = 1, #joker.config.center.k_genre do
            if debug then
            
                print("Checking: " .. genre)
                print(joker.config.center.k_genre[i])
            end
            if genre == joker.config.center.k_genre[i] then
                if debug then print("------ TRUE") end
                return true
            end
        end
    end

    if joker.ability and joker.ability.kino_additional_genres then
        for i = 1, #joker.ability.kino_additional_genres do
            if genre == joker.ability.kino_additional_genres[i] then
                return true
            end
        end
    end
    return false
end

function has_cast(joker, actor)
    local _center = nil
    if joker.kino_joker then
        _center = joker.kino_joker
    else
        if joker.config.center and joker.config.center.kino_joker then
            _center = joker.config.center.kino_joker
        else
            _center = joker.kino_joker
            return false
        end 
    end


    for _, _castmember in ipairs(_center.cast) do
        if actor == _castmember then
            return true
        end
    end

    return false
end

function create_cast_list()
    local _castlist = {}
    local _hash = {}

    for _, _joker in ipairs(G.jokers.cards) do
        if _joker.config.center.kino_joker then
            for _, _castmember in ipairs(_joker.config.center.kino_joker.cast) do
                if not _hash[_castmember] then
                    _castlist[#_castlist + 1] = _castmember
                    _hash[_castmember] = true
                end
            end
        end
    end

    return _castlist
end

function has_cast_from_table(joker, actor_table)
    for _, _castmember in ipairs(actor_table) do
        if has_cast(joker, _castmember) then
            return true
        end
    end
    return false
end

function display_egg_message()
    if not G.GAME.egg_message then
        G.GAME.egg_message = UIBox{
            definition = 
            {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes={
                {n=G.UIT.R, config = {align = 'cm', maxw = 1}, nodes={
                    {n=G.UIT.O, config={object = DynaText({scale = 0.7, string = localize('ph_egg'), maxw = 9, colours = {G.C.WHITE},float = true, shadow = true, silent = true, pop_in = 0, pop_in_rate = 6})}},
                }}
            }}, 
            config = {
                align = 'cm',
                offset ={x=0,y=-3.1}, 
                major = G.play,
            }
        }
        G.GAME.egg_message.attention_text = true
        G.GAME.egg_message.states.collide.can = false
    end

    if G.GAME.egg_message then
        G.GAME.egg_message:remove()
        G.GAME.egg_message = nil
    end
end

function kino_quality_check(card, quality)

    if card and card.ability and card.ability[quality] and card.ability[quality] ~= false then
        return true
    end
    return false
end

-- Get Random hand type (Based on the neutronstarrandomhand function from Cryptid. (Planets.lua - line 830 - 853))
function get_random_hand()
    local rand_hand
    while true do
        rand_hand = pseudorandom_element(G.handlist, pseudoseed("random"))
        if G.GAME.hands[rand_hand].visible then
            break
        end
    end

    return rand_hand
end

-- Only accounts for played hands
function get_least_played_hand()
    local _tally = nil
    local _hands = {}
    for k, v in ipairs(G.handlist) do
        if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played < _tally) and G.GAME.hands[v].played ~= 0 then
            _hands = {}
            _hands[#_hands + 1] = v
            
            _tally = G.GAME.hands[v].played
        end
        if G.GAME.hands[v].visible and (_tally == nil or G.GAME.hands[v].played == _tally) and not G.GAME.hands[v].played == 0 then
            _hands[#_hands + 1] = v
        end
    end

    if #_hands == 0 then 
        pseudorandom_element(G.handlist, pseudoseed("random_least_played_hand")) 
    end
    return _hands
end

-- Add a function to trigger jokers when money is spend in the shop (Based on cryptid, exotic.lua, l. 1407-1413)
local base_ease_dollars = ease_dollars
function ease_dollars(mod, x)
    base_ease_dollars(mod, x)

    SMODS.calculate_context({kino_ease_dollars = mod})

    -- for i = 1, #G.jokers.cards do 
    --     local effects = G.jokers.cards[i]:calculate_joker({kino_ease_dollars = mod})
    -- end
end

-- Add a function to randomize suits for jokers that need that (added to the ancient card functionality)
-- also resets sci-fi cards upgraded
local rac = reset_ancient_card
function reset_ancient_card()
    rac()
    if not G.GAME.current_round.kino_thing_card then
        G.GAME.current_round.kino_thing_card = { suit = "Spades" }
    end

    local thing_suits = {}
    for k, v in ipairs({'Spades','Hearts','Clubs','Diamonds'}) do
        if v ~= G.GAME.current_round.kino_thing_card.suit then thing_suits[#thing_suits + 1] = v end
    end
    local thing_card = pseudorandom_element(thing_suits, pseudoseed('thing'..G.GAME.round_resets.ante))
    G.GAME.current_round.kino_thing_card.suit = thing_card

    reset_raiders_card()
    reset_bonnieandclyde()
    Kino.reset_source_code()
    Kino.reset_dead_zone()
end

 -- Indiana Jones checks
function reset_raiders_card()
    if not G.GAME.current_round.kino_indiana_key then
        G.GAME.current_round.kino_indiana_rank = 2
        G.GAME.current_round.kino_indiana_suit = "Spades"
        G.GAME.current_round.kino_indiana_key = "S_2"
    end

    local valid_raiders_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            valid_raiders_cards[#valid_raiders_cards+1] = v
        end
    end

    if valid_raiders_cards[1] then 
        local idol_card = pseudorandom_element(valid_raiders_cards, pseudoseed('raiders'..G.GAME.round_resets.ante))
        G.GAME.current_round.kino_indiana_rank = idol_card:get_id()
        G.GAME.current_round.kino_indiana_suit = idol_card.base.suit
        G.GAME.current_round.kino_indiana_key = idol_card.config.card_key
    end
end

function reset_bonnieandclyde()
    if G.GAME.round % 3 ~= 0 then
        return false
    end

    if not G.GAME.current_round.bonnierank then
        G.GAME.current_round.bonnierank = 2
        G.GAME.current_round.clydesuit = "Spades"
    end

    local _ranks = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
    local _suits = {"Hearts", "Diamonds", "Spades", "Clubs"}

    G.GAME.current_round.bonnierank = pseudorandom_element(_ranks, pseudoseed("bonnie_boss"))
    G.GAME.current_round.clydesuit = pseudorandom_element(_suits, pseudoseed("clyde_boss"))
end

function Kino.reset_source_code()
    if not G.GAME.current_round.kino_source_code then
        G.GAME.current_round.kino_source_code = "Hearts"
    end
    
    local _suit = pseudorandom_element(SMODS.Suits, pseudoseed("kino_source_code"))

    G.GAME.current_round.kino_source_code = _suit.key

end

function Kino.reset_dead_zone()
    G.GAME.current_round.kino_dead_zone_hand = get_random_hand()
end

-- For everything that needs to be done when the shop is closed.
function end_shopping()
    G.GAME.current_round.sci_fi_upgrades_last_round = 0
end

---- Add Scrap functionality
function update_scrap(num, is_set)
    -- num is the number to increment or set the scrap by
    -- is_set == true will set instead of increment
    if not G.GAME.current_round.scrap_total then
        G.GAME.current_round.scrap_total = 0
    end

    if is_set then
        G.GAME.current_round.scrap_total = num
    else
        G.GAME.current_round.scrap_total = G.GAME.current_round.scrap_total + num
    end
end

---- Add Matchmaking functionality
function update_matches(num, is_set)
    -- num is the number to increment or set the scrap by
    -- is_set == true will set instead of increment
    if not G.GAME.current_round.matchmade_total then
        G.GAME.current_round.matchmade_total = 0

    end

    if is_set then
        G.GAME.current_round.matchmade_total = num
    else
        G.GAME.current_round.matchmade_total = G.GAME.current_round.matchmade_total + num
    end
end


-- Booster:Set_cost hook for oceans_11	
local b_sc = Card.set_cost
function Card:set_cost()
    -- print("entered: " .. (oceans or ""))
    b_sc(self)
    if (self.ability and self.ability.set == "Booster" and G.GAME.kino_oceans_11) then
        self.cost = 0
    end
    
end


---- Kino Syngery system ----
function check_genre_match(joker)
    -- Checks to see how many jokers share a genre with the joker that the function uses
    if not joker or not joker.config.center.kino_joker then
        return 
    end

    local _jokers_that_share_genre = 0
    -- iterate through each genre
    for _, _genre in ipairs(joker.config.center.k_genre) do
        for __, _joker_comp in ipairs(G.jokers.cards) do
            if _joker_comp ~= joker then
                if is_genre(_joker_comp, _genre) then
                    _jokers_that_share_genre = _jokers_that_share_genre + 1
                    break
                end
            end
        end
        if _jokers_that_share_genre > 0 and not joker.debuff then
            SMODS.debuff_card(joker, true, "kino_genre_variety_" .. _genre)
        elseif _jokers_that_share_genre == 0 and joker.debuff then
            SMODS.debuff_card(joker, false, "kino_genre_variety_" .. _genre)
        end
    end
end

function check_genre_snob()
    -- active joker ==
    if not G.jokers or not G.jokers.cards or (#G.jokers.cards < 1) then return end
    if not G.jokers.cards[1].config.center.kino_joker then return end

    local _active_genres = G.jokers.cards[1].config.center.k_genre

    for i = 1, #G.jokers.cards do
        local _genre_match = false
        local _joker = G.jokers.cards[i]
        for _, _genre in ipairs(_active_genres) do
            if is_genre(_joker, _genre) then
                _genre_match = true
                break
            end
        end

        if i > 1 and _genre_match == false and not _joker.debuff then
            SMODS.debuff_card(_joker, true, "kino_genre_snob")
        elseif i == 1 and (_genre_match == true and _joker.debuff) then
            SMODS.debuff_card(_joker, false, "kino_genre_snob")
        end
    end
end

function check_genre_synergy()
    -- check jokers, then if 5 of them share a genre, add a joker slot
    if not G.jokers or not G.jokers.cards or not kino_config.genre_synergy
    or not G.GAME.current_round.genre_synergy_treshold then
        return false
    end

    local five_of_genres = {}

    if not G.jokers.config.synergyslots then
        G.jokers.config.synergyslots = 0
    end

    G.jokers.config.card_limit = G.jokers.config.card_limit - G.jokers.config.synergyslots

    for i, genre in ipairs(kino_genres) do
        local count = 0
        for j, joker in ipairs(G.jokers.cards) do
            if G.GAME.modifiers.kino_genre_variety then
                check_genre_match(joker)            
            end
            if G.GAME.modifiers.kino_genre_snob then
                check_genre_snob()
            end

            if is_genre(joker, genre) then
                count = count + 1
            end
        end
        
        if count >= G.GAME.current_round.genre_synergy_treshold then
            five_of_genres[#five_of_genres + 1] = genre
        end
    end

    if #five_of_genres > G.jokers.config.synergyslots then
        -- Genre synergy!
        for i, genre in ipairs(five_of_genres) do
            local _text = localize('k_genre_synergy')
            if G.GAME.modifiers.egg_genre and genre == "Romance" then
                _text = localize('k_genre_synergy_egg')
            end

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = _text,
                    scale = 1.3, 
                    hold = 1.4,
                    major = G.play,
                    align = 'tm',
                    offset = {x = 0, y = -1},
                    silent = true
                })
                play_sound('tarot2', 1, 0.4)
            return true end }))
        end
    end

    G.jokers.config.synergyslots = (#five_of_genres * Kino.genre_synergy_slots)
    G.jokers.config.card_limit = G.jokers.config.card_limit + G.jokers.config.synergyslots
    if G.jokers.config.synergyslots > 0 then
        G.jokers.config.card_limit_UI_text = " (+" .. G.jokers.config.synergyslots .. " Genre Bonus)"
    else
        G.jokers.config.card_limit_UI_text = ""
    end
    -- G.jokers:draw()
end

function check_actor_synergy()

    if not kino_config.actor_synergy or not G.jokers or not G.jokers.cards then
        return false
    end

    for i = 1, #G.jokers.cards do
        local _retcount = G.jokers.cards[i]:kino_synergy(G.jokers.cards[i])
        if _retcount > 0 then
            card_eval_status_text(G.jokers.cards[i], 'extra', nil, nil, nil,
            { message = localize('k_actor_synergy'), colour = G.C.LEGENDARY})
            G.jokers.cards[i]:juice_up()
        end
    end
end

function Card:kino_synergy(card)
    -- Iterate through all other jokers and check the following:
    -- If they share a genre
    -- If they share a director
    -- If they share an actor

    -- If they have the Bacon sticker

    -- If 5 share an actor, x2 all values
    -- if 3 share an actor, start shaking (and display the actor)

    if not kino_config.actor_synergy  or not self.config.center.kino_joker then
        return 0
    end

    local _my_pos = nil

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
            _my_pos = i
        end
    end

    local _left = _my_pos - 1
    local _right = _my_pos + 1

    local _actors = self.config.center.kino_joker.cast
    card.ability.current_synergy_actors = {
        -- actor_ID = num of matches
    }

    -- Iterate through actor list
    for _, actor in pairs(_actors) do
        -- Iterate through other jokers
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card then
                if G.jokers.cards[i].config.center.kino_joker then
                    local _compared_actors = G.jokers.cards[i].config.center.kino_joker.cast

                    -- now iterate through the checked jokers and see if there's a match
                    for _j, comp_actor in pairs(_compared_actors) do
                        if actor == comp_actor then

                            if not card.ability.current_synergy_actors[actor] then
                                card.ability.current_synergy_actors[actor] = 1
                            end
                            card.ability.current_synergy_actors[actor] = card.ability.current_synergy_actors[actor] + 1
                        end
                    end
                end
            end
        end
    end

    local _count = 0
    for actor_id, frequency in pairs(card.ability.current_synergy_actors) do
        local _num = ((frequency + G.GAME.current_round.actors_table_offset) <= #Kino.actor_synergy) and frequency + G.GAME.current_round.actors_table_offset or #Kino.actor_synergy
        local _order = Kino.actor_synergy[_num]
        if frequency < G.GAME.current_round.actors_check then
            card:set_multiplication_bonus(card, actor_id, _order, true)
        end
        if frequency >= G.GAME.current_round.actors_check and _count <= 2 then
            _count = _count + 1
            local _multiplier = card:set_multiplication_bonus(card, actor_id, _order, true)
        end
    end

    local _return_count = 0
    if _count > 0 then
        if _count > (card.ability.last_actor_count or 0) then
            _return_count = _count
        end

        card.ability.last_actor_count = _count
    end

    if self.ability.kino_bacon or G.GAME.modifiers.bacon_bonus then

        local _found_match = false
        local _found_match_right = false
        local _found_match_left = false
        
        for _i, actor in pairs(_actors) do
            -- test left
            if G.jokers.cards[_left] and G.jokers.cards[_left].config.center.kino_joker then
                local _compared_actors = G.jokers.cards[_left].config.center.kino_joker.cast
                for _j, _compactor in pairs(_compared_actors) do
                    if actor == _compactor then
                        _found_match = true
                        _found_match_left = true
                    
                        break
                    end
                end
            end

            -- test right
            if G.jokers.cards[_right] and G.jokers.cards[_right].config.center.kino_joker then
                local _compared_actors = G.jokers.cards[_right].config.center.kino_joker.cast
                for _j, _compactor in pairs(_compared_actors) do
                    if actor == _compactor then
                        _found_match = true
                        _found_match_right = true
                        break
                    end
                end
            end
        end

        if self.ability.kino_bacon then
            if not _found_match then
                SMODS.debuff_card(card, true, "bacon")
            else
                SMODS.debuff_card(card, false, "bacon")
            end
        end
        
        if G.GAME.modifiers.bacon_bonus then
            if not _found_match_right then
                card:set_multiplication_bonus(card, "bacon_deck_right", 1)
            else
                card:set_multiplication_bonus(card, "bacon_deck_right", G.GAME.modifiers.bacon_bonus)
            end

            if not _found_match_left then
                card:set_multiplication_bonus(card, "bacon_deck_left", 1)
            else
                card:set_multiplication_bonus(card, "bacon_deck_left", G.GAME.modifiers.bacon_bonus)
            end
        end

    end

    return _return_count
end

function Card:set_multiplication_bonus(card, source, num, is_actor, reset_from_value_for_cryptid)

    -- Keys that should be exempt:
    -- goal
    -- keys that start with "base_"
    -- chance
    -- chance_cur
    -- "stacked_"
    -- keys ending in "_non"
    -- non-integers
    -- "time_"
    if not card or not card.config or not card.config.center or not kino_config.actor_synergy or not card.config.center.kino_joker then
        if Cryptid and card and card.config and card.config.center then
            if not Card.no(card, "immutable", true) then
                local _val = num
                if reset_from_value_for_cryptid then
                    _val = 1 / reset_from_value_for_cryptid
                end
                Cryptid.with_deck_effects(card, function(cards)
                    Cryptid.misprintize(
                        cards,
                        { min = _val, max = _val},
                        nil,
                        true
                    )
                end)
                return true
            end
        end
        return false
    end
    if not card.ability.multipliers then
        card.ability.base = {}
        for key, val in pairs(card.ability.extra) do
            card.ability.base[key] = val
        end
        card.ability.multipliers = {}
    end

    local _multipliers = card.ability.multipliers
    local _source = source
    local _num = num

    -- Add the source, or replace it if already existing
    if _source and _num then
        if card.ability.multipliers[_source] == _num then
            return false
        elseif card.ability.multipliers[_source] ~= nil and _num == 1 then
            for index, item in ipairs(card.ability.multipliers) do
                if card.ability.multipliers[_source] == item then
                    table.remove(card.ability.multipliers, index)
                end    
            end
        end 

        _multipliers[_source] = _num        
    end

    -- Check for the award sticker
    if card.ability.kino_award then
        _multipliers["kino_award"] = Kino.award_mult ^ card.ability.kino_award_times
    end
    local _cardextra = card and card.ability.extra
    local _baseextra = card.ability.base

    for name, value in pairs(_cardextra) do

        -- check the values

        if check_variable_validity_for_mult(name) and type(_cardextra[name]) == "number" then
            _cardextra[name] = _baseextra[name]
            for source, mult in pairs(_multipliers) do
                _cardextra[name] = _cardextra[name] * mult
                
            end
        end
    end
    return true
end

function Card:get_multiplier_by_source(card, source)
    if not card or not card.ability or 
    not card.ability.multipliers or 
    not card.ability.multipliers[source] then
        return false
    end

    return card.ability.multipliers[source]
end

function check_variable_validity_for_mult(name)

    if not kino_config.actor_synergy then
        return false
    end

    local _non_valid = {
        "stacks",
        "goal",
        "chance",
        "chance_cur",
        "reset",
        "threshold",
        "time_spent",
        "codex_length"
    }

    local _non_valid_element = {
        {"base_", 5},
        {"stacked_", 8},
        {"time_", 5},
        {"_non", 4},
        {"rank_", 5}
    }

    for i = 1, #_non_valid do
        if name == _non_valid[i] then
            return false
        end
    end

    for i = 1, #_non_valid_element do

        
        if string.sub(_non_valid_element[i][1], 1, 1) == "_" then
            if string.sub(name, -_non_valid_element[i][2]) == _non_valid_element[i][1] then
                return false
            end
        else
            if string.sub(name, 1, _non_valid_element[i][2]) == _non_valid_element[i][1] then
                return false
            end
        end
    end
    return true
end

function Kino.synergycheck()
    -- if G.GAME.modifiers.kino_genre_variety then
    --     check_genre_match()            
    -- end
    check_genre_synergy()
    check_actor_synergy()
end

function Kino.can_multiply(target)
    if target.config.center.kino_joker then
        return true
    end

    if Cryptid and Talisman then
        return true
    end

    return false
end
------------------------------

local base_atd = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    base_atd(self, from_debuff)

    -- if G.GAME.modifiers.kino_genre_variety then
    --     check_genre_match()            
    -- end
    if not from_debuff then
        check_genre_synergy()
        check_actor_synergy()
    end
end

local base_rmd = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    base_rmd(self, from_debuff)
    
    -- if G.GAME.modifiers.kino_genre_variety then
    --     check_genre_match()            
    -- end
    if not from_debuff then
        check_genre_synergy()
        check_actor_synergy()
    end
end

local base_set_rank = CardArea.set_ranks
function CardArea:set_ranks()
    -- Do synergy checks
    base_set_rank(self)

    -- print("set ranks")

    if self == G.jokers then
        -- if G.GAME.modifiers.kino_genre_variety then
        --     check_genre_match()            
        -- end
        check_genre_synergy()
        check_actor_synergy()
    end
end

local base_align_cards = CardArea.align_cards
function CardArea:align_cards()
    base_align_cards(self)

    if self == G.jokers then
        -- if G.GAME.modifiers.kino_genre_variety then
        --     check_genre_match()            
        -- end
        check_genre_synergy()
        check_actor_synergy()
    end

    if self == G.deck and G.GAME.starting_params.kino_spellcasting_deck then
        Kino.update_spellslingerdeck_UI()
    end
end


function Card:get_release(card)
    if card.config.center.kino_joker then
        local _joker = card.config.center.kino_joker

        local _year = tonumber(string.sub(_joker.release_date, 1, 4))
        local _month = tonumber(string.sub(_joker.release_date, 6, 7))
        local _day = tonumber(string.sub(_joker.release_date, 9, 10))

        return {_year, _month, _day}
    end

    return false
end

local base_gcb = Card.get_chip_bonus
function Card:get_chip_bonus()
    
    local ret = base_gcb(self)

    if not G.jokers or not G.jokers.cards then
        return ret
    end

    local _factor = 1

    for i, joker in ipairs(G.jokers.cards) do
        if joker.ability and joker.ability.extra and type(joker.ability.extra) == "table" 
        and joker.ability.extra.nominal_mult_factor then
            _factor = _factor * joker.ability.extra.nominal_mult_factor
        end
    end

    if _factor == 1 then
        _factor = 0
    end

    return ret + (self.base.nominal * _factor)
end
-------------------------------

-- level_up_hand hook to allow for interstellar functionality
local luh = level_up_hand
function level_up_hand(card, hand, instant, amount, interstellar)
    if card and card.ability and card.ability.set == "Planet" and next(find_joker('j_kino_interstellar'))
    and not interstellar then
        SMODS.calculate_context({interstellar = true, planet = card})
    else
        luh(card, hand, instant, amount)
    end
end



-- Upgrade Hand functionality for alternative upgrades.
function upgrade_hand(card, hand, chips, mult, x_chips, x_mult, instant)
    -- card = the source of the upgrade
    -- hand = the hand type being upgraded
    -- chips = the increase in chips
    -- xchips = multiply the chips
    -- xmult = multiply the mult
    -- boolean islevelup = whether the level increases
    chips = chips or 0
    mult = mult or 0
    x_chips = x_chips or 0
    x_mult = x_mult or 0

    if not hand then
        print("No hand was assigned! crash prevented")
    end
    -- upgrades should be put into an array with whether they were a level up.
    -- the level_up_hand function should be modified to upgrade the hand
    -- after the normal level calc is done.
    local _chips = chips + (G.GAME.hands[hand].chips * x_chips)
    local _mult = mult + (G.GAME.hands[hand].mult * x_mult)


    -- Set mult
    G.GAME.hands[hand].mult_bonus = (G.GAME.hands[hand].mult_bonus or 0) + _mult
    
    -- Set chips
    G.GAME.hands[hand].chips_bonus = (G.GAME.hands[hand].chips_bonus or 0) + _chips 

    -- Set both
    G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].s_mult + G.GAME.hands[hand].l_mult*(G.GAME.hands[hand].level - 1) +  G.GAME.hands[hand].mult_bonus, 1)
    G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].s_chips + G.GAME.hands[hand].l_chips*(G.GAME.hands[hand].level - 1) +  G.GAME.hands[hand].chips_bonus, 1)
    -- play animation

    if not instant then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            update_hand_text({immediate = true, nopulse = nil, delay = 0}, {handname=localize(hand, 'poker_hands'), level=G.GAME.hands[hand].level})
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
        delay(1.3)
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
    }))
end

-- Hook to add card upgrade tag functionality
local smods_score_card = SMODS.score_card
SMODS.score_card = function(card, context)

    for i = 1, #G.GAME.tags do
        G.GAME.tags[i]:apply_to_run({type = 'card_scoring', card = card, before = true})
    end

    smods_score_card(card, context)

    for i = 1, #G.GAME.tags do
        G.GAME.tags[i]:apply_to_run({type = 'card_scoring', card = card, after = true})
    end
end

-- Changes the can_discard function to account for monster cards
local can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    -- checks if _monster_cards exist
    local _monster = 0
    for k, v in pairs(G.hand.highlighted) do
        if SMODS.has_enhancement(v, "m_kino_monster") then
            _monster = _monster + 1
            break
        end
    end

    local _monster_exemptions = 0
    for i, _joker in ipairs(G.jokers.cards) do
        if _joker and _joker.ability and type(_joker.ability.extra) == "table" and
        _joker.ability.extra.stacked_monster_exemptions then
            _monster_exemptions = _monster_exemptions + _joker.ability.extra.stacked_monster_exemptions
        end
    end

    if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 0 or 
    (_monster > 0 and _monster > _monster_exemptions)then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.RED
        e.config.button = 'discard_cards_from_highlighted'
    end
end

------------ TAG functionality ------------
function Tag:set_chocolate_bonus(chocolate_bonus)
    local obj = SMODS.Tags[self.key]
    if obj and obj.set_chocolate_bonus and type(obj.set_chocolate_bonus) == 'function' then
        obj:set_chocolate_bonus(chocolate_bonus)
    end
    return true
end

-------------
SMODS.Enhancement:take_ownership('lucky', {
    loc_vars = function (self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        local numerator_mult, denominator_mult = SMODS.get_probability_vars(card, 1 * (cfg.lucky_bonus or 1), 5, 'lucky_mult')
        local numerator_dollars, denominator_dollars = SMODS.get_probability_vars(card, 1 * (cfg.lucky_bonus or 1), 15, 'lucky_money')
        return {vars = {numerator_mult, cfg.mult, denominator_mult, cfg.p_dollars, denominator_dollars, numerator_dollars}}
    end,
})
------------ Helpers ------------
function Kino.debugfunc(inc)
    print(G.GAME.last_played_hand[inc])
end

function Kino.debugfunc_ID_check()
    for _index, _card in ipairs(G.hand.cards) do
        print("Card #".. _index)
        print(_card.ID)
        print(_card.ability.unique_val)
        print(_card.ability.unique_val__saved_ID)
    end
end

function Kino.print_contexts(context)
    for _key, _value in pairs(context) do
        print(_key)
    end
end

function Kino.rank_to_string(rank)

    if rank == nil then
        return "nil-err"
    end
    local _string = "nil"

    if  2 <= rank and rank <= 10 then
        _string = tostring(rank)
    elseif rank == 11 then
        _string = "J"
    elseif rank == 12 then
        _string = "Q"
    elseif rank == 13 then
        _string = "K"
    elseif rank == 14 then
        _string = "A"
    end

    return _string
end

function Kino.rank_to_value(rank)
    local _string = "nil"

    if  2 <= rank and rank <= 10 then
        _string = tostring(rank)
    elseif rank == 11 then
        _string = "Jack"
    elseif rank == 12 then
        _string = "Queen"
    elseif rank == 13 then
        _string = "King"
    elseif rank == 14 then
        _string = "Ace"
    end

    return _string
end

-- Discard input card
Kino.discard_given_card = function(list_of_cards, hook)
    stop_use()

    local highlighted_count = #list_of_cards
    if highlighted_count > 0 then 
        update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
        table.sort(list_of_cards, function(a,b) return a.T.x < b.T.x end)
        inc_career_stat('c_cards_discarded', highlighted_count)
        for j = 1, #G.jokers.cards do
            G.jokers.cards[j]:calculate_joker({pre_discard = true, full_hand = list_of_cards, hook = hook})
        end
        local cards = {}
        local destroyed_cards = {}
        for i=1, highlighted_count do
            list_of_cards[i]:calculate_seal({discard = true})
            local removed = false
            for j = 1, #G.jokers.cards do
                local eval = nil
                eval = G.jokers.cards[j]:calculate_joker({discard = true, other_card = list_of_cards[i], full_hand = list_of_cards})
                if eval then
                    if eval.remove then removed = true end
                    card_eval_status_text(G.jokers.cards[j], 'jokers', nil, 1, nil, eval)
                end
            end
            table.insert(cards, list_of_cards[i])
            if removed then
                destroyed_cards[#destroyed_cards + 1] = list_of_cards[i]
                if list_of_cards[i].ability.name == 'Glass Card' then 
                    list_of_cards[i]:shatter()
                else
                    list_of_cards[i]:start_dissolve()
                end
            else 
                list_of_cards[i].ability.discarded = true
                draw_card(G.hand, G.discard, i*100/highlighted_count, 'down', false, list_of_cards[i])
            end
        end

        if destroyed_cards[1] then 
            for j=1, #G.jokers.cards do
                eval_card(G.jokers.cards[j], {cardarea = G.jokers, remove_playing_cards = true, removed = destroyed_cards})
            end
        end

        G.GAME.round_scores.cards_discarded.amt = G.GAME.round_scores.cards_discarded.amt + #cards
        check_for_unlock({type = 'discard_custom', cards = cards})
        if not hook then
            if G.GAME.modifiers.discard_cost then
                ease_dollars(-G.GAME.modifiers.discard_cost)
            end
            ease_discard(-1)
            G.GAME.current_round.discards_used = G.GAME.current_round.discards_used + 1
            G.STATE = G.STATES.DRAW_TO_HAND
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
        end
    end
end

local _o_cc = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    if Kino.abduction and not Kino.abduction.cards then return {} end
    if G.kino_offscreen_area and not G.kino_offscreen_area.cards then return {} end
    return _o_cc(context, return_table)
end

----------------------
to_big = to_big or function(x, y)
    return x
end

to_number = to_number or function(x, y)
    return x
end


----------------------
-- COLOURS --

G.C.KINO = {
    ACTION = HEX("0a4a59"),
    ADVENTURE = HEX("aa5d23"),
    ANIMATION = HEX("c1d07a"),
    BIOPIC = HEX("6461f7"), 
    COMEDY = HEX("420690"),
    CHRISTMAS = HEX("cc1d49"),
    CRIME = HEX("6a4c47"),
    DRAMA = HEX("694c77"),
    FAMILY = HEX("fbf0f3"),
    FANTASY = HEX("087ad9"),
    GANGSTER = HEX("592d2d"),
    HEIST = HEX("46b35f"), 
    HISTORICAL = HEX("733c13"), 
    HORROR = HEX("372a2d"),
    MUSICAL = HEX("ae327f"), 
    MYSTERY = HEX("7d17dd"),
    ROMANCE = HEX("c8117d"),
    SCIFI = HEX("1eddd4"),
    SILENT = HEX("888888"),
    SPORTS = HEX("cc9c37"), 
    SUPERHERO = HEX("4c71ee"),
    THRILLER = HEX("078084"),
    WAR = HEX("305e2c"),
    WESTERN = HEX("735b48"),
    PINK = HEX("f7b7f2")
}

local genrecolors = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        genrecolors()
    end
    G.ARGS.LOC_COLOURS["Action"] = G.C.KINO.ACTION
    G.ARGS.LOC_COLOURS["Adventure"] = G.C.KINO.ADVENTURE
    G.ARGS.LOC_COLOURS["Animation"] = G.C.KINO.ANIMATION
    G.ARGS.LOC_COLOURS["Biopic"] = G.C.KINO.BIOPIC
    G.ARGS.LOC_COLOURS["Comedy"] = G.C.KINO.COMEDY
    G.ARGS.LOC_COLOURS["Christmas"] = G.C.KINO.CHRISTMAS
    G.ARGS.LOC_COLOURS["Crime"] = G.C.KINO.CRIME
    G.ARGS.LOC_COLOURS["Drama"] = G.C.KINO.DRAMA
    G.ARGS.LOC_COLOURS["Family"] = G.C.KINO.FAMILY
    G.ARGS.LOC_COLOURS["Fantasy"] = G.C.KINO.FANTASY
    G.ARGS.LOC_COLOURS["Gangster"] = G.C.KINO.GANGSTER
    G.ARGS.LOC_COLOURS["Heist"] = G.C.KINO.HEIST
    G.ARGS.LOC_COLOURS["Historical"] = G.C.KINO.HISTORICAL
    G.ARGS.LOC_COLOURS["Horror"] = G.C.KINO.HORROR
    G.ARGS.LOC_COLOURS["Musical"] = G.C.KINO.MUSICAL
    G.ARGS.LOC_COLOURS["Mystery"] = G.C.KINO.MYSTERY
    G.ARGS.LOC_COLOURS["Romance"] = G.C.KINO.ROMANCE
    G.ARGS.LOC_COLOURS["Sci-fi"] = G.C.KINO.SCIFI
    G.ARGS.LOC_COLOURS["Silent"] = G.C.KINO.SILENT
    G.ARGS.LOC_COLOURS["Sports"] = G.C.KINO.SPORTS
    G.ARGS.LOC_COLOURS["Superhero"] = G.C.KINO.SUPERHERO
    G.ARGS.LOC_COLOURS["Thriller"] = G.C.KINO.THRILLER
    G.ARGS.LOC_COLOURS["War"] = G.C.KINO.WAR
    G.ARGS.LOC_COLOURS["Western"] = G.C.KINO.WESTERN

    return genrecolors(_c, _default)
end

--- Global Variables ---
Kino.jump_scare_mult = 2
Kino.jumpscare_stunned_duration = 3
Kino.goldleaf_chance = 3
Kino.choco_chance = 2
Kino.xl_chance = 1

Kino.awardschance = 1

Kino.genre_synergy_slots = 1
Kino.actor_synergy = {1, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.25, 2.5, 3}
Kino.award_mult = 2
Kino.awards_max = 1

Kino.crime_chips = 5
Kino.bullet_magazine_max = 6
