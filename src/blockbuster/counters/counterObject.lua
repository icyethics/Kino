BlockbusterCounters.Counters = {}
BlockbusterCounters.Counter =  SMODS.GameObject:extend {
    obj_table = BlockbusterCounters.Counters,
    obj_buffer = {},
    class_prefix = "counter",
    rng_buffer = {},
    set = "Counter",

    atlas = 'blockbuster_counters',
    pos = {x = 0, y = 0},
    pos_pcard = {x = 0, y = 1},

    discovered = false,
    badge_colour = HEX('7e3456'),
    required_params = {
        'key',
        'pos',
    },
    inject = function(self)
        -- Add the object to the game pool, and load its sprite object
        -- Add it into a generic pool

        G.shared_counters_joker[self.key] = Sprite(0, 0, G.CARD_W, G.CARD_H,
            G.ASSET_ATLAS[self.atlas], self.pos)
        
        local sec_pos = self.pos_card or {x = self.pos.x, y = self.pos.y + 1}
        G.shared_counters_pcard[self.key] = Sprite(0, 0, G.CARD_W, G.CARD_H,
            G.ASSET_ATLAS[self.atlas], sec_pos)

        SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
        G.P_COUNTERS[self.key] = self

        self.rng_buffer[#self.rng_buffer + 1] = self.key
    end,
    process_loc_text = function(self)
            SMODS.process_loc_text(G.localization.descriptions.Counter, self.key:lower(), self.loc_txt)
    end,
    set_card_type_badge = function(self, card, badges)
        if not card.fake_card then
            badges[#badges+1] = create_badge(localize('bbcount_counter'), G.C.PURPLE, G.C.WHITE, 1.2 )
        end
    end,
    get_obj = function(self, key) 
        if not G.P_COUNTERS then
            G.P_COUNTERS = {}
        end
        return G.P_COUNTERS[self.key] 
    end,
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        card = card or self:create_fake_card()
        local _suffix = "_joker"
        if not card.ability or (card.ability.set ~= 'Default' and card.ability.set ~='Enhanced') then
            _suffix = "_pcard"
        else

        end

        local target = {
            type = 'descriptions',
            set = 'Counter',
            key = self.key:lower(),
            nodes = desc_nodes,
            AUT = full_UI_table,
            vars = specific_vars or {},
        }
        if target.vars.is_info_queue then target.is_info_queue = true; target.vars.is_info_queue = nil end
        local res = {}
        if self.loc_vars and type(self.loc_vars) == 'function' then
            res = self:loc_vars(info_queue, card) or {}
            target.vars = res.vars or target.vars
            target.key = res.key or target.key
            if res.set then
                target.type = 'descriptions'
                target.set = res.set
            end
            target.scale = res.scale
            target.text_colour = res.text_colour
        end
        if desc_nodes == full_UI_table.main and not full_UI_table.name then
            full_UI_table.name = localize { type = 'name', set = target.set, key = res.name_key or target.key, nodes = full_UI_table.name, vars = res.name_vars or target.vars or {} }
        elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name then
            desc_nodes.name = localize{type = 'name_text', key = res.name_key or target.key, set = target.set }
        end
        if res.main_start then
            desc_nodes[#desc_nodes + 1] = res.main_start
        end
        localize(target)
        if res.main_end then
            desc_nodes[#desc_nodes + 1] = res.main_end
        end
        desc_nodes.background_colour = res.background_colour
    end,
    create_fake_card = function(self)
        return { 
            counter = {
                self.config
            }, 
            counter_config = {
                counter_num = 1,
                counter_num_ui = 1
            },
            fake_card = true
        }
    end,
    apply_counter = function(self, card)

    end,
    remove_counter = function(self, card)

    end,
    calculate = function(self, card, context)

    end,
}