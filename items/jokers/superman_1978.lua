SMODS.Joker {
    key = "superman_1978",
    order = 0,
    generate_ui = Kino.generate_info_ui,
    config = {
        is_superman = true,
        extra = {

        }
    },
    rarity = 3,
    atlas = "kino_atlas_11",
    pos = { x = 1, y = 5},
    cost = 8,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 1924,
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
    k_genre = {"Superhero"},
    enhancement_gate = "m_kino_superhero",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        -- The top card of your deck is always a Superhero card
        if (context.kino_shuffling_area and context.cardarea == G.deck and context.kino_post_shuffle)
        or context.hand_drawn or context.other_drawn then
			local _targetpos = nil
			local _selfpos = nil

			-- Iterate through every card in the deck to find both the location
			-- of the first Superhero card, and the highest placed non-stickered card
			for i, _playingcard in ipairs(G.deck.cards) do
				if not _selfpos and 
                SMODS.has_enhancement(_playingcard, "m_kino_superhero") then
					_selfpos = i
				else
					_targetpos = i
				end
			end

			if _targetpos == nil then
				_targetpos = #G.deck.cards
			end
			if _selfpos == nil then
				_selfpos = #G.deck.cards
			end

			-- Swaps the positions of the selected cards
			G.deck.cards[_selfpos], G.deck.cards[_targetpos] = G.deck.cards[_targetpos], G.deck.cards[_selfpos]
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
        if args.type == 'hand_contents' then
            local _superhero = false
            for j = 1, #args.cards do
                if args.cards[j].config.center == G.P_CENTERS.m_kino_superhero then
                    _superhero = true
                end
            end
            if _superhero and G.GAME.current_round.hands_left == 0 then 
                unlock_card(self)
            end
        end
    end, 
}