SMODS.Joker {
    key = "inception",
    order = 105,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            adapted_non = 0,
            a_adapted = 1,
            copied_cards = {},
            current_target = nil
        }
    },
    rarity = 3,
    atlas = "kino_atlas_3",
    pos = { x = 2, y = 5},
    cost = 9,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 27205,
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
    k_genre = {"Sci-fi", "Crime"},

    loc_vars = function(self, info_queue, card)
        card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil

        for index, _joker in ipairs(card.ability.extra.copied_cards) do
            info_queue[#info_queue+1] = G.P_CENTERS[_joker.ability.key]
        end

        return {
            vars = {
                card.ability.extra.adapted_non,
                card.ability.extra.a_adapted,
                3 - card.ability.extra.adapted_non,
                #card.ability.extra.copied_cards
            },
            main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
        }
    end,
    calculate = function(self, card, context)
        -- Sit next to a card for 3 turns, to copy its effect while it exists
        if context.setting_blind and not context.repetition and not context.blueprint then
            local _my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    _my_pos = i
                end
            end
            
            if card.ability.extra.adapted_non == 0 
            or (card.ability.extra.adapted_non > 0 and G.jokers.cards[_my_pos + 1] ~= card.ability.extra.current_target) then
                card.ability.extra.current_target = G.jokers.cards[_my_pos + 1]
                card.ability.extra.adapted_non = 0
            end

            card.ability.extra.adapted_non = card.ability.extra.adapted_non + card.ability.extra.a_adapted

            if card.ability.extra.adapted_non >= 3 then
                card.ability.extra.copied_cards[#card.ability.extra.copied_cards + 1] = card.ability.extra.current_target
            end
        end

        for _, present_joker in ipairs(card.ability.extra.copied_cards) do

            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == present_joker then
                    other_joker = G.jokers.cards[i + 1]
                end
            end
            if other_joker == nil then
                table.remove(card.ability.extra.copied_cards, _)
            end

            if other_joker and other_joker ~= card then
                context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                context.blueprint_card = context.blueprint_card or card

                if context.blueprint > #G.jokers.cards + 1 then
                    return
                end

                local other_joker_ret, trig = other_joker:calculate_joker(context)
                local eff_card = context.blueprint_card or card

                context.blueprint = nil
                context.blueprint_card = nil

                if other_joker_ret == true then
                    return other_joker_ret
                end
                if other_joker_ret or trig then
                    if not other_joker_ret then
                        other_joker_ret = {}
                    end
                    other_joker_ret.card = eff_card
                    other_joker_ret.colour = darken(G.C.BLUE, 0.3)
                    other_joker_ret.no_callback = true
                    return other_joker_ret
                end
            end
        end
    end,
    update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i + 1]
				end
			end
			if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
				card.ability.blueprint_compat = "compatible"
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,
}