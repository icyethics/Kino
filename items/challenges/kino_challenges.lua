SMODS.Challenge {
    key = "minc",
    rules = {
        custom = {
        },
        modifiers = {}
    },
    jokers = {
        {id = 'j_kino_childs_play_1'},
    },
    deck = {
        cards = {
            {s='D',r='2',},{s='D',r='3',},{s='D',r='4',},{s='D',r='5',},{s='D',r='6',},{s='D',r='7',},{s='D',r='8',},{s='D',r='9',},{s='D',r='T',},{s='D',r='J',e='m_kino_monster',},{s='D',r='Q',e='m_kino_monster',},{s='D',r='K',e='m_kino_monster',},{s='D',r='A',},
            {s='C',r='2',},{s='C',r='3',},{s='C',r='4',},{s='C',r='5',},{s='C',r='6',},{s='C',r='7',},{s='C',r='8',},{s='C',r='9',},{s='C',r='T',},{s='C',r='J',e='m_kino_monster',},{s='C',r='Q',e='m_kino_monster',},{s='C',r='K',e='m_kino_monster',},{s='C',r='A',},
            {s='H',r='2',},{s='H',r='3',},{s='H',r='4',},{s='H',r='5',},{s='H',r='6',},{s='H',r='7',},{s='H',r='8',},{s='H',r='9',},{s='H',r='T',},{s='H',r='J',e='m_kino_monster',},{s='H',r='Q',e='m_kino_monster',},{s='H',r='K',e='m_kino_monster',},{s='H',r='A',},
            {s='S',r='2',},{s='S',r='3',},{s='S',r='4',},{s='S',r='5',},{s='S',r='6',},{s='S',r='7',},{s='S',r='8',},{s='S',r='9',},{s='S',r='T',},{s='S',r='J',e='m_kino_monster',},{s='S',r='Q',e='m_kino_monster',},{s='S',r='K',e='m_kino_monster',},{s='S',r='A',},
        },
        type = 'Challenge Deck',
        
    },
    restrictions = {
        banned_cards = {
            
        },
        banned_other = {},
    }
}

-- Only movie Jokers. Spawn with joker stickers only

SMODS.Challenge {
    key = "bacon",
    rules = {
        custom = {
            {id = 'movie_jokers_only'},
            {id = 'kino_bacon'}
        },
        modifiers = {}
    },
    jokers = {
    },
    deck = {
        type = 'Challenge Deck',
        
    },
    restrictions = {
        banned_cards = {
            
        },
        banned_other = {},
    }
}

--- Cade Yeager Cosplay. Earn no money, but instead earn money per sci-fi card that upgraded this round
SMODS.Challenge {
    key = "yeager",
    rules = {
        custom = {
            {id = 'kino_yeag', value = 1},
            {id = 'no_reward'},
            {id = 'no_extra_hand_money'}
        },
        modifiers = {}
    },
    jokers = {
    },
    deck = {
        type = 'Challenge Deck',
        rand_enhancement = {key = "m_kino_sci_fi", value = 16}
        
    },
    restrictions = {
        banned_cards = {
            
        },
        banned_other = {},
    }
}

-- xenomorph Invasion. Debuff a random card in deck whenever a hand is played
SMODS.Challenge {
    key = "xenomorph",
    rules = {
        custom = {
            {id = 'kino_alien', value = 1},
        },
        modifiers = {}
    },
    jokers = {
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            
        },
        banned_other = {},
    }
}

-- Best Song in the world: 10 random Demonic Cards. Cannot win a blind until a sacrifice has been made
SMODS.Challenge {
    key = "bestsong",
    rules = {
        custom = {
            {id = 'carryover_discards'},
            {id = 'kino_bestsong'},
        },
        modifiers = {}
    },
    jokers = {
    },
    deck = {
        type = 'Challenge Deck',
        rand_enhancement = {key = "m_kino_demonic", value = 10}
    },
    restrictions = {
        banned_cards = {
            
        },
        banned_other = {},
    }
}

-- When Perkeo met Triboulet. Cannot buy rerolls, instead, you earn a free reroll when you make a match
-- SMODS.Challenge {
--     key = "harrysally",
--     rules = {
--         custom = {
--             {id = 'kino_harrysally'},
--         },
--         modifiers = {}
--     },
--     jokers = {
--     },
--     deck = {
--         type = 'Challenge Deck',
--         rand_enhancement = {key = "m_kino_romance", value = 13}
--     },
--     restrictions = {
--         banned_cards = {
            
--         },
--         banned_other = {},
--     }
-- }

-- Debuff movies that share a genre
SMODS.Challenge {
    key = "genre_variety",
    rules = {
        custom = {
            {id = 'movie_jokers_only'},
            {id = 'kino_genre_variety'},
        },
        modifiers = {}
    },
    jokers = {
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            
        },
        banned_other = {},
    }
}

-- Jokers are only active if they share a genre with
-- the joker in the active slot
SMODS.Challenge {
    key = "genre_snob",
    rules = {
        custom = {
            {id = 'movie_jokers_only'},
            {id = 'kino_genre_snob'},
        },
        modifiers = {}
    },
    jokers = {
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            
        },
        banned_other = {},
    }
}

-- Jokers spawn in release order
-- SMODS.Challenge {
--     key = "chronology",
--     rules = {
--         custom = {
--             {id = 'movie_jokers_only'},
--             {id = 'kino_chronology'},
--         },
--         modifiers = {}
--     },
--     jokers = {
--     },
--     deck = {
--         type = 'Challenge Deck',
--     },
--     restrictions = {
--         banned_cards = {
            
--         },
--         banned_other = {},
--     }
-- }

-- Jokers charge rent based on their profit margin
-- SMODS.Challenge {
--     key = "blockbuster",
--     rules = {
--         custom = {
--             {id = 'movie_jokers_only'},
--             {id = 'kino_blockbuster'},
--         },
--         modifiers = {}
--     },
--     jokers = {
--     },
--     deck = {
--         type = 'Challenge Deck',
--     },
--     restrictions = {
--         banned_cards = {
            
--         },
--         banned_other = {},
--     }
-- }

-- Jokers spawn in release order
-- SMODS.Challenge {
--     key = "slasher",
--     rules = {
--         custom = {
--             {id = 'kino_slasher'},
--         },
--         modifiers = {}
--     },
--     jokers = {
--     },
--     deck = {
--         type = 'Challenge Deck',
--     },
--     restrictions = {
--         banned_cards = {
            
--         },
--         banned_other = {},
--     }
-- }

SMODS.Challenge {
    key = "wallstreet",
    rules = {
        custom = {
            {id = 'kino_wallstreet'},
        },
        modifiers = {}
    },
    jokers = {
    },
    deck = {
        type = 'Challenge Deck',
    },
    restrictions = {
        banned_cards = {
            
        },
        banned_other = {},
    }
}

