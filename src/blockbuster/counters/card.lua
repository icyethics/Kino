function Card:bb_counter_apply(counter_type, number, no_override)

    if type(counter_type) == 'string' then
        assert(G.P_COUNTERS[counter_type], ("Could not find center \"%s\""):format(counter_type))
        counter_type = G.P_COUNTERS[counter_type]
    end

    if no_override and self.counter and self.counter ~= nil then
        return {

        }
    end

    if not self.counter or (self.counter ~= counter_type) then
        -- Cleanse

        local _removal_type = "overwrite"
        self:bb_remove_counter(_removal_type)

        self.counter_config = {
            counter_num = 0,
            counter_num_ui = 0
        }
        self.counter = nil

        -- Set new counter type
        self.counter = counter_type

        BlockbusterCounters.counter_ui_text(self)

        -- Copy config table from template to _object
        self.ability.counter = {}
        if counter_type then
            for _key, _value in pairs(counter_type.config) do
                self.ability.counter[_key] = _value
            end
        end

        -- Add_counter action
        local obj = self.counter
        if obj and obj.add_counter and type(obj.add_counter) == 'function' then
            local o = obj:add_counter(self, number)
            if o then
                if not o.card then o.card = self end
                return o
            end
        end
    end

    SMODS.calculate_context({counter_applied = true, card = self, counter_type = self.counter, number = number})

    self:bb_increment_counter(number, true)
end

function Card:bb_increment_counter(number, first_application)
    if self.counter then

        if not first_application then
            SMODS.calculate_context({counter_incremented = true, card = self, counter_type = self.counter, number = number})
        end
        
        self.counter_config.counter_num = math.min(self.counter_config.counter_num + number, self.counter.config.cap or 99)

        --Counter Increment action
        local obj = self.counter
        if obj.increment and type(obj.increment) == 'function' then
            local o = obj:increment(self, number)
            if o then
                if not o.card then o.card = self end
                return o
            end
        end

        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
            if self.counter then
                self:juice_up()
                self.counter_config.counter_num_ui = math.min(self.counter_config.counter_num_ui + number, self.counter.config.cap or 99)
                if self.counter_config.counter_num_ui <= 0 then
                    self:bb_remove_counter("tick_down")
                end
            end
        return true end }))

        
    end
end

function Card:bb_remove_counter(removal_method)
    -- Remove Counter Action
    if self.counter then
        local obj = self.counter

        SMODS.calculate_context({counter_removed = true, card = self, counter_type = self.counter, removal_method = removal_method or "unknown"})

        if obj.remove_counter and type(obj.remove_counter) == 'function' then
            local o = obj:remove_counter(self)
            if o then
                if not o.card then o.card = self end
                return o
            end
        end

        self.counter = nil
        self.counter_config = {
            counter_num = 0,
            counter_num_ui = 0
        }
        self.ability.counter = 0
        if self.children.counter_ui_box then
            self.children.counter_ui_box = nil
        end
    end
end

function Card:bb_calculate_counter(context)
    -- local obj = G.P_COUNTERS[self.counter] or {}
    local obj = self.counter
    if obj.calculate and type(obj.calculate) == 'function' then
    	local o = obj:calculate(self, context)
    	if o then
            if not o.card then o.card = self end
            return o
        end
    end
end

local o_copy_card = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
    new_card = o_copy_card(other, new_card, card_scale, playing_card, strip_edition)

    if other.counter then
        new_card:bb_counter_apply(other.counter, other.counter_config.counter_num)
    end

    return new_card
end