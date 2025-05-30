if next(SMODS.find_mod("MoreFluff")) then
    -- Slasher
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_slasher",
        key = "rot_slasher",
        pos = { x = 0, y = 0 },
        config = {
            max_highlighted = 1,
            mod_conv = "m_kino_error"
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_error

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })

    -- Droid
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_droid",
        key = "rot_droid",
        pos = { x = 1, y = 0 },
        config = {
            max_highlighted = 2,
            mod_conv = "m_kino_wifi"
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_wifi

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })

    -- Demon
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_demon",
        key = "rot_demon",
        pos = { x = 2, y = 0 },
        config = {
            max_highlighted = 2,
            mod_conv = "m_kino_angelic"
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_angelic

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })

    -- Meetcute
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_meetcute",
        key = "rot_meetcute",
        pos = { x = 3, y = 0 },
        config = {
            max_highlighted = 1,
            mod_conv = "m_kino_finance"
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_finance

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })
    
    -- Detective
    -- SMODS.Consumable({
    --     object_type = "Consumable",
    --     set = "Rotarot",
    --     name = "rot_kino_meetcute",
    --     key = "rot_meetcute",
    --     pos = { x = 3, y = 0 },
    --     config = {
    --         max_highlighted = 1,
    --         mod_conv = "m_kino_finance"
    --     },
    --     cost = 4,
    --     atlas = "kino_mf_rotarots",
    --     unlocked = true,
    --     discovered = true,
    --     display_size = { w = 107, h = 107 },
    --     can_use = function(self, card)
    --         return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
    --     end,
    --     loc_vars = function(self, info_queue, card)
    --         info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_finance

    --         return { vars = { 
    --         card and card.ability.max_highlighted or self.config.max_highlighted,
    --         localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
    --         } }
    --     end
    -- })

    
    -- Witch
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_witch",
        key = "rot_witch",
        pos = { x = 5, y = 0 },
        config = {
            max_highlighted = 1,
            mod_conv = "m_kino_factory"
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_factory

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })

    
    -- Gangster
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_gangster",
        key = "rot_gangster",
        pos = { x = 0, y = 1 },
        config = {
            max_highlighted = 1,
            mod_conv = "m_kino_time"
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_time

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })
    
    -- Soldier
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_soldier",
        key = "rot_soldier",
        pos = { x = 1, y = 1},
        config = {
            max_highlighted = 1,
            mod_conv = "m_kino_fraction"
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_fraction

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })

    
    -- RESERVED
    -- SMODS.Consumable({
    --     object_type = "Consumable",
    --     set = "Rotarot",
    --     name = "rot_kino_meetcute",
    --     key = "rot_meetcute",
    --     pos = { x = 3, y = 0 },
    --     config = {
    --         max_highlighted = 1,
    --         mod_conv = "m_kino_finance"
    --     },
    --     cost = 4,
    --     atlas = "kino_mf_rotarots",
    --     unlocked = true,
    --     discovered = true,
    --     display_size = { w = 107, h = 107 },
    --     can_use = function(self, card)
    --         return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
    --     end,
    --     loc_vars = function(self, info_queue, card)
    --         info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_finance

    --         return { vars = { 
    --         card and card.ability.max_highlighted or self.config.max_highlighted,
    --         localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
    --         } }
    --     end
    -- })

    
    -- Producer
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_producer",
        key = "rot_producer",
        pos = { x = 3, y = 1 },
        config = {
            max_highlighted = 1,
            mod_conv = "m_kino_finance"
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_kino_finance

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })

    
    -- Chef
    SMODS.Consumable({
        object_type = "Consumable",
        set = "Rotarot",
        name = "rot_kino_chef",
        key = "rot_chef",
        pos = { x = 5, y = 1 },
        config = {
        },
        cost = 4,
        atlas = "kino_mf_rotarots",
        unlocked = true,
        discovered = true,
        display_size = { w = 107, h = 107 },
        can_use = function(self, card)
            return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
        end,
        loc_vars = function(self, info_queue, card)

            return { vars = { 
            card and card.ability.max_highlighted or self.config.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}
            } }
        end
    })
end