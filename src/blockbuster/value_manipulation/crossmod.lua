if Cryptid and Talisman then

    Cryptid.misprintize_value_blacklist.multipliers = false

    local o_crypt_man = Cryptid.manipulate
    function Cryptid.manipulate(card, args)
        if Blockbuster.get_standard_from_card(card) then
            if card:can_calculate() then
                local _multiplier = card:get_multiplier_by_source(card, "cryptid_blockbuster") or 1


                local _pickednum = args and args.value or 
                pseudorandom(
                    "cryptid_misprint_blockbuster",
                    (G.GAME.modifiers.cry_misprint_min or 1) * (G.GAME.modifiers.cry_jkr_misprint_mod or 1),
                    (G.GAME.modifiers.cry_misprint_max or 1) * (G.GAME.modifiers.cry_jkr_misprint_mod or 1)
                )

                if args and args.dont_stack == false then
                    _multiplier = _multiplier * _pickednum
                else
                    _multiplier = _pickednum
                end

                Card:bb_set_multiplication_bonus(card, "cryptid_blockbuster", _multiplier)
            end
        else
            o_crypt_man(card, args)
        end
    end

    function Blockbuster.Cryptid_bb_set_multiplication_bonus(card, source, num)
        if card and card.config and card.config.center then
            if not Card.no(card, "immutable", true) then
                if not card.ability.blockbuster_multipliers then
                    card.ability.blockbuster_multipliers = {}
                end
                local _cur_mult = card:get_multiplier_by_source(card, source) or 0
                local _multiplier_total = Card:get_total_multiplier(card)
                
                if source and num then
                    if card.ability.blockbuster_multipliers[source] == num then
                        return false
                    elseif card.ability.blockbuster_multipliers[source] ~= nil and num == 1 then
                        for index, item in ipairs(card.ability.blockbuster_multipliers) do
                            if card.ability.blockbuster_multipliers[source] == item then
                                table.remove(card.ability.blockbuster_multipliers, index)
                            end    
                        end
                    end 

                    card.ability.blockbuster_multipliers[source] = num        
                end

                
                local _new = _multiplier_total - _cur_mult + num

                if _multiplier_total == 0 then _multiplier_total = 1 end

                local _val = _new / _multiplier_total

                o_crypt_man(card, {value = _val})
                return true
            end
        end
    end
end