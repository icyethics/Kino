-- Containing functins and hooks that relate to Cryptid crossmod mechanics

if Cryptid then
    
local o_misprinterize = Cryptid.misprintize
function Cryptid.misprintize(card, override, force_reset, stack)
    if card and card.config and card.config.center and card.config.center.kino_joker then
        if card:can_calculate() then
            local _multiplier = card:get_multiplier_by_source(card, "cryptid_kino") or 1

            local _pickednum = pseudorandom("cryptid_misprint_kino", override and override.min or 1, override and override.max or 1)
            
            if stack then
                _multiplier = _multiplier * _pickednum
            else
                _multiplier = _pickednum
            end
            
            if force_reset then
                _multiplier = 1
            end

            Card:set_multiplication_bonus(card, "cryptid_kino", _multiplier)
        end
    else
        o_misprinterize(card, override, force_reset, stack)
    end
end


local enh_table = {
    m_kino_action = {"action"},
    m_kino_crime = {"crime"},
    m_kino_sci_fi = {"sci-fi", "scifi", "sci fi", "sci_fi"},
    m_kino_demonic = {"demonic"},
    m_kino_romance = {"romance"},
	m_kino_horror = { "horror", "horor" },
    m_kino_monster = {"monster"},
    m_kino_flying_monkey = {"flying monkey", "monkey", "flying ape"},
    m_kino_mystery = {"mystery"},
    m_kino_fantasy = {"fantasy", "spellcasting"},
}
Cryptid.load_enhancement_aliases(enh_table)

-- IF MOREFLUFF ADD this
-- Morefluff crossmod enhancements
local more_fluff_add = {
    m_kino_error = {"error"},
    m_kino_wifi = {"wi-fi", "wifi", "wi fi", "wi_fi"},
    m_kino_angelic = {"angelic", "angel"},
    m_kino_finance = {"finance"},
    m_kino_factory = {"factory"},
    m_kino_time = {"time", "clock"},
    m_kino_fraction = {"fraction"}
}


end