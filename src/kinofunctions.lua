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
    if not G or not G.jokers or not G.jokers.cards then
        return nil
    end

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

function create_cast_list_for_specific_jokers(_list_of_jokers)
    if _list_of_jokers.config then
        local _list_temp = {}
        _list_temp[#_list_temp + 1] = _list_of_jokers
        _list_of_jokers = _list_temp
    end

    local _castlist = {}
    local _hash = {}

    for _, _joker in ipairs(_list_of_jokers) do
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
    if not joker or not actor_table then
        return nil
    end

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
    if card and card.config and card.config[quality] and card.config[quality] ~= false then
        return true
    end
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
        return
    end
    -- upgrades should be put into an array with whether they were a level up.
    -- the level_up_hand function should be modified to upgrade the hand
    -- after the normal level calc is done.
    local _chips = chips + (G.GAME.hands[hand].chips * x_chips)
    local _mult = mult + (G.GAME.hands[hand].mult * x_mult)


    -- Store amounts coming from bonusses
    G.GAME.hands[hand].mult_bonus = (G.GAME.hands[hand].mult_bonus or 0) + _mult
    G.GAME.hands[hand].chips_bonus = (G.GAME.hands[hand].chips_bonus or 0) + _chips 

    -- Set bonuses as permanent upgrades
    G.GAME.hands[hand].s_mult = math.max(G.GAME.hands[hand].s_mult + _mult, 1)
    G.GAME.hands[hand].s_chips = math.max(G.GAME.hands[hand].s_chips + chips, 1)

    -- Set both
    G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].s_mult + G.GAME.hands[hand].l_mult*(G.GAME.hands[hand].level - 1), 1)
    G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].s_chips + G.GAME.hands[hand].l_chips*(G.GAME.hands[hand].level - 1), 1)
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

        if SMODS.has_enhancement(v, "m_kino_fabricated_monster") and v.ability.extra.level_non >= 2 then
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
    PINK = HEX("f7b7f2"),
    MAGIC = HEX("7F00FF"),
    ALIEN = HEX("71d027"),
    CONFECTION = HEX("8e1212"),
    DRAIN = HEX("b52727"),
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
    G.ARGS.LOC_COLOURS["Magic"] = G.C.KINO.MAGIC
    G.ARGS.LOC_COLOURS["Alien"] = G.C.KINO.ALIEN
    G.ARGS.LOC_COLOURS["Confection"] = G.C.KINO.CONFECTION
    G.ARGS.LOC_COLOURS["Drain"] = G.C.KINO.DRAIN

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
