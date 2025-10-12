-- Containing functins and hooks that relate to Cryptid crossmod mechanics

if Cryptid and Talisman then

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

if Cryptid.load_enhancement_aliases then
    Cryptid.load_enhancement_aliases(enh_table)
end


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
if Cryptid.load_enhancement_aliases and next(SMODS.find_mod("MoreFluff")) then
    Cryptid.load_enhancement_aliases(more_fluff_add)
end

if Cryptid.setup_voucher_rate_adjuster then
    Cryptid.setup_voucher_rate_adjuster("v_kino_confection_acclimator", "b_confection_rate", "confection", G.C.SECONDARY_SET.Mult)
end
end

if Talisman then
    function check_and_set_high_score(score, amt)
        if G.GAME.round_scores[score] and to_big(math.floor(amt)) > to_big(G.GAME.round_scores[score].amt) then
            G.GAME.round_scores[score].amt = to_big(math.floor(amt))
            if score == "hand" then
                G.GAME.current_round.beaten_run_high = G.GAME.current_round.beaten_run_high + 1
            end
        end
        if  G.GAME.seeded  then return end
    end
end