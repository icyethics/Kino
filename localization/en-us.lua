return {
    descriptions = {
        Joker = {
            j_kino_6_underground = {
                name = "6 Underground",
                text = {
                    "{C:attention}6{}'s give {C:mult}+#1#{} Mult"
                }
            },
            j_kino_9_movie = {
                name = "9",
                text = {
                    "Each scoring {C:attention}9{} gives",
                    "{C:chips}+#1#{} Chips for each",
                    "time this Ante a {C:attention}9{} was scored",
                    "{C:inactive}(Currently: {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_kino_10_things_i_hate_about_you = {
                name = "10 Things I Hate About You",
                text = {
                    {
                        "If your hand contains a scoring {C:attention}Romance Card{}",
                        "consume all {C:attention}Charges{} to give",
                        "{C:chips}+#2#{} Chips and {C:mult}+#1#{} Mult",
                        "per charge"
                    },
                    {
                        "If your hand does not contain a {C:attention}Romance Card{}",
                        "gain a {C:attention}Charge",
                        "{C:inactive}(Currently: #3# Charges)"
                    }
                }
            },
            j_kino_12_monkeys = {
                name = "Twelve Monkeys",
                text = {
                    "When you {C:attention}Select a Blind",
                    "{C:green}#1# in #2#{} Chance to create",
                    "a card of the same type",
                    "as the first one sold last blind",
                    "{C:inactive}(will create a {C:attention}#3#{C:inactive})"
                }
            },
            j_kino_30_days_of_night = {
                name = "30 Days of Night",
                text = {
                    {
                        "{C:attention}Active:{} Drain the enhancement",
                        "from scoring cards and gain {X:mult,C:white}X#3#{} Mult"
                    },
                    {
                        "{C:attention}Inactive:{} Give {X:mult,C:white}X#2#{} Mult",
                        "{C:inactive}(This joker cannot become Active",
                        "{C:inactive}again after scoring)"
                    }
                }
            },
            -- j_kino_30_days_of_night = {
            --     name = "30 Days of Night",
            --     text = {
            --         "{C:mult,E:1}#4#{}",
            --         "If Feeding: Drain the enhancement",
            --         "from scoring cards",
            --         "If Fed: Give {X:mult,C:white}X#3#{} Mult",
            --         "for each enhancement drained",
            --         "{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)"
            --     }
            -- },
            j_kino_50_first_dates = {
                name = "50 First Dates",
                text = {
                    "{C:attention}Romance Cards{} trigger",
                    "an additional time"
                }
            },
            j_kino_abyss = {
                name = "The Abyss",
                text = {
                    "Cards held in hand have",
                    "a {C:green}#1# in #2#{} chance to {C:attention}Jumpscare",
                    "increased by {C:green}#3#{} per",
                    "Unscoring card"
                }
            },
            j_kino_ai_artificial = {
                name = "A.I.: Artificial Intelligence",
                text = {
                    "{C:mult}+#1#{} Mult for every time a",
                    "{C:attention}Sci-fi Card{} has been upgraded",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_kino_alien_1 = {
                name = "Alien",
                text = {
                    "After a hand is scored, {C:green}#1# in #3#{} chance",
                    "to destroy all other jokers", 
                    "{X:mult,C:white}X#4#{} Mult per scoring card",
                    "and increase odds by {C:green}#2#{}",
                    "Resets when you sell a Joker"
                }
            },
            j_kino_alien_3 = {
                name = "Alien 3",
                text = {
                    "If you play a hand consisting",
                    "of only debuffed cards",
                    "create a {C:attention}LV426"
                }
            },
            j_kino_aliens = {
                name = "Aliens",
                text = {
                    "{X:mult,C:white}X#2#{} Mult and",
                    "{C:attention}Debuffs 2{} random cards",
                    "in your deck"
                }
            },
            j_kino_always = {
                name = "Always",
                text = {
                    "Whenever a card",
                    "is {C:attention}Destroyed",
                    "upgrade every {C:attention}Romance Card",
                    "in your deck with {C:chips}+#1#{} Chips"
                }
            },
            j_kino_angel_hearts = {
                name = "Angel Heart",
                text = {
                    "Each scored {C:hearts}Hearts{} ",
                    "gives {C:mult}+#2#{} Mult, then",
                    "doubles the Mult given",
                    "{C:inactive}(Resets at end of round)"
                }
            },
            j_kino_annihilation = {
                name = "Annihilation",
                text = {
                    "{C:green}#1# in #2#{} chance for",
                    "scoring cards to gain",
                    "first scoring card's",
                    "rank, suit, enhancement, seal or edition"

                }
            },
            j_kino_anora = {
                name = "Anora",
                text = {
                    "When you {C:attention}Make a Match{}",
                    "add a {C:green}Money Counter{}",
                    "to each card in hand"
                }
            },
            j_kino_apollo_13 = {
                name = "Apollo 13",
                text = {
                    "When you use",
                    "a {C:planet}planet",
                    "put a {C:attention}Retrigger Counter",
                    "on another random Joker"
                }
            },
            j_kino_arrival = {
                name = "Arrival",
                text = {
                    "Whenever you solve",
                    "the {C:attention}Codex{}",
                    "lower {C:attention}ante{} by #1#",
                    "and destroy this joker"
                }
            },
            j_kino_as_above = {
                name = "As Above, So Below",
                text = {
                    "{C:chips}+#2#{} Chips for",
                    "each card discarded",
                    "this round",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_asteroid_city = {
                name = "Asteroid City",
                text = {
                    {"If no joker is currently",
                    "{C:purple}Abducted{}, abduct the one",
                    "to the right"},
                    {"{C:attention}Release:{} Return {C:attention}Negative"}
                }
            },
            j_kino_avatar = {
                name = "Avatar",
                text = {
                    "Gains {C:chips}+1{} Chip for time your",
                    "most played hand type has been played",
                    "when you use a {C:attention}Planet{}",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_baby_driver = {
                name = "Baby Driver",
                text = {
                    "If a scoring card",
                    "is adjacent to a card",
                    "that is one rank",
                    "lower or higher, it",
                    "gives Mult equal to {C:attention}1X{} its rank"
                }
            },
            j_kino_baby_geniuses = {
                name = "Baby Geniuses",
                text = {
                    "Each played {C:attention}2{} gives",
                    "{C:chips}+#1#{} Chips when scored"
                }
            },
            j_kino_batman_66 = {
                name = "Batman (1966)",
                text = {
                    "Create a {C:tarot}Tarot{} when",
                    "a blind is selected",
                    "if it's a {C:attention}Boss Blind{}",
                    "create a {C:attention}Batman joker{} instead",
                    "{C:inactive}(Must have room)"
                }
            },
            j_kino_batman_1989 = {
                name = "Batman (1989)",
                text = {
                    "Gains {C:mult}+#1#{} for every empty Joker slot",
                    "at the end of round", 
                    "(Batman jokers count as empty)",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult, gaining {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_kino_batman_2022 = {
                name = "The Batman (2022)",
                text = {
                    "Retrigger a card {C:attention}#1#{} Times",
                    "for each empty joker slot",
                    "(Batman jokers count as empty)",
                    "{C:inactive}(Currently: #2# Slots)"
                }
            },
            j_kino_batman_and_robin = {
                name = "Batman & Robin",
                text = {
                    "Upgrade scoring cards with {C:mult}+#1#{} Mult",
                    "for every empty Joker slot",
                    "if your played hand is a {C:attention}Pair",
                    "(Batman jokers count as empty)",
                    "{C:inactive}(Gaining {C:mult}+#2#{C:inactive} Mult) "
                }
            },
            j_kino_batman_begins = {
                name = "Batman Begins",
                text = {
                    "{C:money}$#1#{} per empty Joker slot",
                    "(Batman jokers count as empty)",
                    "{C:inactive}(Currently: {C:money}$#2#{C:inactive})"
                }
            },
            j_kino_batman_forever = {
                name = "Batman Forever",
                text = {
                    {"Gain {C:attention}+#2#{} Charge when",
                    "you play a hand",
                    "{C:inactive}(Currently: #1# Charges)"},
                    {"If you have {C:attention}#3# Charges{}",
                    "consume them to add a {C:attention}Robin Sticker{}",
                    "to the joker to the right"}
                }
            },
            j_kino_batman_killing_joke = {
                name = "Batman: The Killing Joke",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "doubled for each empty joker slot",
                    "(Batman jokers count as empty)",
                    "{C:inactive}(Currently: {C:chips}+#2#{C:inactive} Chips)"

                }
            },
            j_kino_batman_mask_of_the_phantasm = {
                name = "Batman: Mask of the Phantasm",
                text = {
                    "{C:green}#1# in #2#{} chance to turn",
                    "the joker to the right into a {C:attention}Batman Joker",
                    "when selecting the blind",
                    "{C:green}#3# in #2#{} chance to turn",
                    "it into {C:attention}Joker{} instead",
                    "{C:inactive}(Cannot transform Batman Jokers or Joker)"
                }
            },
            j_kino_batman_returns = {
                name = "Batman Returns",
                text = {
                    "{C:attention}+#1#{} Joker Slot",
                    "for each #2# {C:attention}Batman Jokers{} you have"
                }
            },
            j_kino_batmanvsuperman = {
                name = "Batman V Superman: Dawn of Justice",
                text = {
                    "{C:attention}Batman Jokers{} have #1#% Power",
                    "during Boss Blinds"
                }
            },
            j_kino_beetlejuice_1988 = {
                name = "Beetlejuice",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if the number of times",
                    "you've played this hand is ",
                    "a multiple of three"
                }
            },
            j_kino_benjamin_button = {
                name = "The Curious Case of Benjamin Button",
                text = {
                    "Decrease the rank",
                    "of every scored card",
                }
            },
            j_kino_bfg = {
                name = "The BFG",
                text = {
                    "{C:mult}+#1#{} Mult for every",
                    "time you've improved",
                    "your Best Hand this run",
                    "{C:inactive}(Currently: {C:mult}+#3#{C:inactive} Mult)",
                    "{C:inactive}(Best Hand: {C:chips,E:1}+#2#{C:inactive})"
                }
            },
            j_kino_big_daddy = {
                name = "Big Daddy",
                text = {
                    "Turn scoring non-face cards into {C:attention}2's{}",
                    "if scoring hand contains a {C:attention}King"
                }
            },
            j_kino_big_short = {
                name = "The Big Short",
                text = {
                    {"{C:money}$#1#{} per {C:money}$#2#{} you have"},
                    {"{C:green}#3# in #4#{} chance to double your {C:money}money"},
                    {"{C:green}#5# in #6# chance to {C:attention}Bust{} instead",
                    "(Chance increases by {C:green}#7#{} at end of round)",
                    },
                }
            },
            j_kino_big_trouble_little_china = {
                name = "Big Trouble in Little China",
                text = {
                    {"When you {C:purple,E:1}Cast a Spell",
                    "gain {C:attention}1 Stack{}",},
                    {"Consume all stacks to lower",
                    "{C:attention}Boss Blind{} requirements by {C:attention}%#3#{} per stack",
                    "{C:inactive}(Currently: {C:attention}%#4#{C:inactive})"}
                }
            },
            j_kino_black_swan = {
                name = "Black Swan",
                text = {
                    "When a {C:attention}Queen{} scores",
                    "{C:green}#1# in #2#{} chance to destroy",
                    "it and create a copy of it",
                    "upgraded with {C:mult}+#3#{} Mult"
                }
            },
            j_kino_blade_1 = {
                name = "Blade",
                text = {
                    "When {C:attention}Blind{} is selected",
                    "destroy the Joker to the right if",
                    "it's {C:attention}Vampiric{}",
                    "Gain all it's upgrades",
                    "{C:inactive}(Currently: {C:chips}+#3#{C:inactive} Chips, {C:mult}+#4#{C:inactive} Mult)",
                    "{C:inactive}(Currently: {X:chips,C:white}X#2#{C:inactive} Chips, {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_blade_runner = {
                name = "Blade Runner",
                text = {
                    "{C:attention}Upgrade{} every {C:attention}Sci-Fi",
                    "card in deck if",
                    "scored hand",
                    "contains a {C:attention}Straight{}"
                }
            },
            j_kino_blair_witch = {
                name = "The Blair Witch Project",
                text = {
                    {"{C:green}Rerolls{} are free",},
                    {"When you {C:green}Reroll{} there",
                    "is a {C:green}#1# in #2#{} chance",
                    "to {C:attention}Destroy all other jokers{}",
                    "increase odds by {C:green}#3#{} each {C:green}Reroll",
                    "{C:red} Self-Destructs when chance reaches 100"}
                }
            },
            j_kino_blank_check = {
                name = "Blank Check",
                text = {
                    "Gain {C:money}$#1#{} upon",
                    "buying this joker",
                    "{C:attention}Bust{} when you",
                    "leave the shop"
                }
            },
            j_kino_bloodshot = {
                name = "Bloodshot",
                text = {
                    "{C:attention}Active:{} If you have any {C:mult}Red Seals",
                    "in your deck, remove it from the card",
                    "and put it on the first scoring card"
                }
            },
            j_kino_blue_velvet = {
                name = "Blue Velvet",
                text = {
                    {
                        "{C:chips}+#4#{} Chips per Charge",
                        "and consume a charge",
                        "{C:inactive}(Currently: {C:chips}+#5#{C:inactive} Chips &",
                        "{C:inactive} +#1# Charges"
                    },
                    {
                        "Gain #2# Charge when you",
                        "when you use a {C:attention}Consumable",
                        "Gain #3# Charges when you",
                        "destroy a card"
                    }
                }
            },
            j_kino_bones_and_all = {
                name = "Bones And All",
                text = {
                    {
                        "{X:mult,C:white}X#1#{} Mult per Charge",
                        "then half current charges",
                        "{C:inactive}(Currently: #2# Charges &",
                        "{X:mult,C:white}X#3#{C:inactive} Mult)"
                    },
                    {
                        "When a blind is selected",
                        "destroy the joker",
                        "to the right and",
                        "gain charges equal",
                        "to its sell value"
                    }
                }
            },
            j_kino_braveheart = {
                name = "Braveheart",
                text = {
                    "Each scored {C:hearts}Hearts{}",
                    "gives {C:chips}+#2#{} Chips for each",
                    "other scoring {C:hearts}Hearts{}"
                }
            },
            j_kino_breakfast_club = {
                name = "The Breakfast Club",
                text = {
                    "Scored {C:clubs}Clubs{} give {C:mult}+#2#{} Mult",
                    "for each {C:clubs}Clubs{} card ",
                    "in your deck above #1#",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
                }
            },
            j_kino_bttf = {
                name = "Back to the Future",
                text = {
                    {"Reveals top 3 cards of deck",},
                    {"{C:attention}#1#{}",
                    "{C:attention}#2#{}",
                    "{C:attention}#3#{}"}
                }
            },
            j_kino_bucket_list = {
                name = "The Bucket List",
                text = {
                    "If you have not beaten",
                    "the blind and have",
                    "{C:chips}0{} Hands left",
                    "consume a Charge and",
                    "gain {C:chips}+1{} Hand",
                    "{C:inactive}(Currently: #1# Charges Left)"
                }
            },
            j_kino_captain_blood = {
                name = "Captain Blood",
                text = {
                    "Give {C:mult}+#1#{} Mult for",
                    "each {C:money}$1{} earned since",
                    "last round",
                    "{C:inactive}(Currently: {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_kino_cars_1 = {
                name = "Cars",
                text = {
                    "{C:chips}+#1#{} Chips if you're",
                    "{C:attention}Quick{}",
                    " "
                }
            },
            j_kino_casablanca = {
                name = "Casablanca",
                text = {
                    "Each played {C:spades}Spades{} or {C:clubs}Clubs{}",
                    "gives {C:chips}+#2#{} Chips and",
                    "{C:mult}+#1#{} Mult when scored"
                }
            },
            j_kino_castaway = {
                name = "Cast Away",
                text = {
                    "If the scoring hand is a {C:attention}High Card{}",
                    "upgrade every scoring card with {C:chips}+#1#{} Chips",
                    "for every unscored card"
                }
            },
            j_kino_catch_me_if_you_can = {
                name = "Catch Me If You Can",
                text = {
                    "{C:money}$#1#{} when a",
                    "{C:attention}Wild Card{} scores"
                }
            },
            j_kino_charlie_and_the_chocolate_factory = {
                name = "Charlie & the Chocolate Factory",
                text = {
                    "{C:attention}Confections{} are always",
                    "{C:attention}Chocolate{}",
                    "{C:inactive}(Chocolate increases confection's values)"
                }
            },
            j_kino_chef = {
                name = "Chef",
                text = {
                    "When you select a Blind",
                    "create a {C:attention}Confection{}",
                    "{C:inactive}(Must have room)"
                }
            },
            j_kino_children_of_the_corn = {
                name = "Children of the Corn",
                text = {
                    "If a face card is held in hand",
                    "destroy it and give {C:chips}+#1#{} Chips"
                }
            },
            j_kino_childs_play_1 = {
                name = "Child's Play",
                text = {
                    "Becomes active whenever",
                    "your scoring hand",
                    "contains a {C:attention}2",
                    "When active, you can",
                    "discard a {C:attention}Monster Card",
                    "{C:inactive}(Currently: {C:Attention}#1#{C:inactive})"
                }
            },
            j_kino_clerks_1 = {
                name = "Clerks",
                text = {
                    "Whenever you've played",
                    "cards adding up to {C:attention}#2#",
                    "gain {C:mult}+#3#{} Mult",
                    "{C:inactive}(Current rank: {C:attention}#1#{C:inactive})"
                }
            },
            j_kino_clockwork_orange = {
                name = "A Clockwork Orange",
                text = {
                    {"{C:attention}Active:{} Consume charges to give",
                    "{X:mult,C:white}X1{} + {X:mult,C:white}#2#X{} Mult per charge",
                    "{C:inactive}(Currently: #1# Stacks)"},
                    {"Gain a {C:attention}Charge{} whenever",
                    "a card is destroyed",},   
                }
            },
            j_kino_close_encounters = {
                name = "Close Encounters of the Third Kind",
                text = {
                    {"If your played hand contains",
                    "only {C:attention}1{} card, {C:attention}Abduct{} it",},
                    {"{C:attention}Release:{} return abducted card to the deck"},
                    {"Gives {C:chips}+#3#{} Chips for {C:attention}every card",
                    "currently abducted",
                    "{C:inactive}(Currently: {C:chips}+#4#{C:inactive} Chips)"}
                }
            },
            j_kino_clown = {
                name = "Clown",
                text = {
                    "{C:mult}+#1#{} Mult per {C:attention}Clown",
                    "Create another {C:attention}Clown",
                    "at the end of a blind",
                    "{C:inactive}(Must have room)"
                }
            },
            j_kino_cocktail = {
                name = "Cocktail",
                text = {
                    "Gains {C:money}$#1#{} Sell Value",
                    "when a {C:mult}Confection{}",
                    "is used"
                }
            },
            j_kino_coco = {
                name = "Coco",
                text = {
                    "Gains {C:chips}+#1#{} Chips",
                    "when you use a {C:tarot}Death",
                    "{C:inactive}(Currently: {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_kino_commando = {
                name = "Commando",
                text = {
                    "Each {C:attention}Wild Card{}",
                    "held in hand",
                    "gives {C:mult}+#1#{} Mult"
                }
            },
            j_kino_con_air = {
                name = "Con Air",
                text = {
                    "Retrigger the first scoring",
                    "card {C:attention}#1# Times{} for each",
                    "scoring {C:attention}Crime Card"
                }
            },
            j_kino_contagion = {
                name = "Contagion",
                text = {
                    "When a card scores",
                    "set its upgrades equal",
                    "to those of the first scoring card"
                }
            },
            j_kino_creature_from_the_black_lagoon = {
                name = "The Creature from the Black Lagoon",
                text = {
                    "If your played hand contains only a {C:attention}Queen{}",
                    "destroy it and upgrade every card",
                    "in your deck with {C:mult}+#1#{} Mult",
                }
            },
            j_kino_cronos = {
                name = "Cronos",
                text = {
                    "If your hand contains",
                    "a single card",
                    "{C:attention}Drain{} half its rank",
                    "and gain #2# times that many chips",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_cruella = {
                name = "Cruella",
                text = {
                    "Whenever you've destroyed",
                    "{C:attention}#2#{} cards, give",
                    "a random card in deck",
                    "an {C:attention}Edition"
                }
            },
            j_kino_da_5_bloods = {
                name = "Da 5 Bloods",
                text = {
                    "The first time you destroy",
                    "a card of a given rank",
                    "put a {C:money}Gold Seal{} on a",
                    "card with the same rank",
                }
            },
            j_kino_dark_crystal = {
                name = "The Dark Crystal",
                text = {
                    "When your played hand",
                    "doesn't defeat the blind",
                    "gain #2# charge",
                    "if you have a charge",
                    "{C:purple, E:1}cast a random spell",
                    "{C:inactive}(Currently: #1# charge)"
                }
            },
            j_kino_dark_knight = {
                name = "The Dark Knight",
                text = {
                    "When you select a blind",
                    "destroy all {C:attention}non-Batman Jokers{}",
                    "{X:mult,C:white}X#2#{} Mult per ",
                    "Joker destroyed",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_dark_knight_returns = {
                name = "The Dark Knight Rises",
                text = {
                    "When you {C:attention}Select a Blind",
                    "for each empty joker slot",
                    "upgrade a random hand",
                    "with {C:mult}+#2#{} Mult",
                    "{C:inactive}(Currently: #1# Empty Slots)",
                    "{C:inactive}(Batman jokers count as empty slots)"
                }
            },
            j_kino_dead_zone = {
                name = "The Dead Zone",
                text = {
                    "The first time each round",
                    "you play a {C:attention}#2#",
                    "put #1# {C:attention}Power Counters",
                    "on another random Joker",
                    "{C:inactive}(Hand changes every round)"
                }
            },
            j_kino_death_race = {
                name = "Death Race",
                text = {
                    "Create a {C:tarot}Death{} tarot",
                    "when you defeat a blind {C:chips}Quick",
                    "(Time Left: #1# seconds)"
                }
            },
            j_kino_demolition_man = {
                name = "Demolition Man",
                text = {
                    "If {C:attention}first discard{} of round",
                    "has only {C:attention}1{} card, destroy",
                    "it and upgrade every",
                    "card held in hand with {C:mult}+#1#{} Mult"
                }
            },
            j_kino_demon_knight = {
                name = "Tales from the Crypt: Demon Knight",
                text = {
                    "Whenever a {C:attention}Demonic Card{}",
                    "is destroyed",
                    "upgrade every card of that",
                    "suit in your deck with",
                    "{C:mult}+#1#{} Mult"
                }
            },
            j_kino_dick_tracy = {
                name = "Dick Tracy",
                text = {
                    "When a {C:attention}Crime Card{} is destroyed",
                    "this gains {C:mult}Mult{} equal to",
                    "{C:attention}#2#X{} the current {C:money}Money Stolen",
                    "{C:inactive}(Currently: {C:mult}#1#{} Mult &",
                    "{C:inactive}{C:money}$#3#{C:inactive} stolen)"
                }
            },
            j_kino_dickie_roberts = {
                name = "Dickie Roberts: Child Star",
                text = {
                    "Scored {C:spades}Spades{} give {C:mult}+#2#{} Mult",
                    "for each {C:spades}Spades{} card", 
                    "in your deck above #1#",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_kino_die_hard_1 = {
                name = "Die Hard",
                text = {
                    "{C:money}$#1#{} for each",
                    "played {C:attention}Action Card{}",
                    "this hand"
                }
            },
            j_kino_dinner_with_andre = {
                name = "My Dinner With André",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult when",
                    "a {C:attention}Confection{} is used",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive})"
                }
            },
            j_kino_doctor_strange_1 = {
                name = "Doctor Strange",
                text = {
                    "Every {C:attention}Third{} spell",
                    "{C:purple,E:1}Cast{} turns into",
                    "{C:green,E:1}The Eye of Agamotto",
                    "{C:inactive}(Currently: #1# Spells Cast)"
                }
            },
            j_kino_doctor_strange_2 = {
                name = "Doctor Strange in the Multiverse of Madness",
                text = {
                    "{C:attention}Active:{} Redraw your hand"
                }
            },
            j_kino_doctor_who = {
                name = "Doctor Who: The Movie",
                text = {
                    {"{C:attention}Active:{}",
                    "abduct a {C:attention}Card{} from {C:attention}Hand"},
                    {"{C:attention}Release:{} Return with a random",
                    "{C:attention}Enhancement{} and {C:attention}Edition"}
                }
            },
            j_kino_donnie_darko = {
                name = "Donnie Darko",
                text = {
                    "If your first hand of the round",
                    "is exactly 2 cards",
                    "Put {C:attention}#1# Stun Counters{}",
                    "on each and",
                    "and put {C:attention}#2# Retrigger Counters",
                    "on the joker to the left"
                }
            },
            j_kino_double_dragon = {
                name = "Double Dragon",
                text = {
                    "Gives {C:chips}+#1#{} Chips",
                    "for each Pair",
                    "held in hand"
                }
            },
            j_kino_double = {
                name = "The Double",
                text = {
                    {"Gain {C:mult}+#1#{} Mult",
                    "when you play a {C:attention}#4#",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",},
                    {"Upon defeating a {C:attention}Boss Blind",
                    "reset {C:Mult}Mult{} and increase",
                    "scaling by {C:mult}+#3#",}
                }
            },
            j_kino_dr_strangelove = {
                name = "Dr. Strangelove",
                text = {
                    "{C:inactive}or How I Learned to Stop Worrying and Love the Bomb{}",
                    "When you play {C:attention}#1#{}, blow up your hand",
                    "and your score (by {X:mult,C:white}X#2#{}.)",
                    "{C:inactive}(Hand type changes every round.){}"
                }
            },
            j_kino_dracula_1931 = {
                name = "Dracula (1931)",
                text = {
                    "This Joker gains {X:mult,C:white} X#3# {} Mult",
                    "per scoring {C:attention}Enhanced card{} played,",
                    "removes card {C:attention}Enhancement",
                    "It gains {X:mult,C:white}X#2#{} Mult per",
                    "scoring {C:attention}Unenhanced card{} played,",
                    "debuffs card",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                }
            },
            j_kino_duel = {
                name = "Duel",
                text = {
                    "{C:chips}+#1#{} Chips if your",
                    "scoring hand contains",
                    "a {C:attention}Straight{}",
                    "{C:green}#2# in #3#{} chance",
                    "to not trigger"
                }
            },
            j_kino_dune_1984 = {
                name = "Dune (1984)",
                text = {
                    "When you play your least played",
                    "Poker Hand upgrade it #1# Times"
                }
            },
            j_kino_dungeons_and_dragons_1 = {
                name = "Dungeons & Dragons",
                text = {
                    { "{C:attention}Active:{} {C:mult}+#3#{} Mult",
                    "for each {C:purple}Charge{}, then",
                    "consume all charges",
                    "{C:inactive}(Currently: {C:purple}#1#{C:inactive} Stacks)"},
                    {"When you {C:purple,E:1}Cast a Spell",
                    "this gains #2# {C:purple}Charge",
                    "per spell level"},
                }
            },
            j_kino_dungeons_and_dragons_4 = {
                name = "Dungeons & Dragons: Honour Among Thieves",
                text = {
                    "When you {C:purple,E:1}Cast a Spell", 
                    "earn {C:money}$#1#{} per Spell Level"
                }
            },
            j_kino_easy_a = {
                name = "Easy A",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "{C:attention}Ace{} held in hand"
                }
            },
            j_kino_ed_wood = {
                name = "Ed Wood",
                text = {
                    "If your hand scores less",
                    "than {C:attention}#1#%{} of the total",
                    "blind, earn {C:money}$#2#{}"
                }
            },
            j_kino_edward_scissorhands = {
                name = "Edward Scissorhands",
                text = {
                    "If {C:attention}first hand{} of round",
                    "has only {C:attention}1{} card, {C:attention}Cut",
                    "it into two, and draw those to hand"
                }
            },
            j_kino_elephant_man = {
                name = "Elephant Man",
                text = {
                    "{C:chips}+#1#{} Chips per played",
                    "{C:chips}Hand{} this round",
                    "{C:mult}+#2#{} Mult per used",
                    "{C:mult}Discard{} this round"
                }
            },
            j_kino_elf = {
                name = "Elf",
                text = {
                    "Retrigger all scored",
                    "{C:attention}2{}'s & {C:attention}3{}'s",
                    "an additional {C:attention}#1# time(s){}"
                }
            },
            j_kino_encanto = {
                name = "Encanto",
                text = {
                    "When you play a {C:attention}Full House",
                    "randomly {C:purple,E:1}Cast a Spell{}"

                }
            },
            j_kino_et = {
                name = "E.T. The Extra-Terrestrial",
                text = {
                    "Create {C:attention}#1#{} Negative",
                    "{C:planet}Planets{} when you defeat",
                    "a {C:attention}Boss Blind"
                }
            },
            j_kino_evil_dead_1 = {
                name = "The Evil Dead (2013)",
                text = {
                    "{C:green}#1# in #2#{} Chance to",
                    "create {C:attention}Demon Card{}",
                    "copy of each", 
                    "sacrificed card"
                }
            },
            j_kino_ex_machina = {
                name = "Ex Machina",
                text = {
                    "If you play a ", 
                    "single {C:attention}Sci-fi Card{}",
                    "upgrade it once ",
                    "for each remaining {C:chips}Hand{}"
                }
            },
            j_kino_exorcist_1 = {
                name = "The Exorcist",
                text = {
                    "{C:attention}Demonic Cards{} are {C:attention}Cleansed",
                    "after they score",
                    "Gain {X:mult,C:white}X#2#{} Mult for",
                    "each card cleansed",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_fantasia = {
                name = "Fantasia",
                text = {
                    "Whenever you {C:purple,E:1}cast",
                    "{C:purple,E:1}a spell{}, cast it",
                    "one rank higher"
                }
            },
            j_kino_fargo = {
                name = "Fargo",
                text = {
                    "If {C:attention}first discard{} of round",
                    "has only {C:attention}1{} card, destroy",
                    "it and increase {C:money}Sell Value",
                    "of every joker by {C:money}$#1#"
                }
            },
            j_kino_fast_and_furious_5 = {
                name = "Fast Five",
                text = {
                    "Add {C:money}$#1#{} to your",
                    "{C:money}Stolen Money{} if you're",
                    "{C:chips}Quick"
                }
            },
            j_kino_fight_club = {
                name = "Fight Club",
                text = {
                    "{X:mult,C:white} X#1#{} Mult",
                    "{C:attention}Destroy{} a random",
                    "scoring card",
                }
            },   
            j_kino_fish_called_wanda = {
                name = "A Fish Called Wanda",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "{C:money}$1{} stolen",
                    "{C:inactive}(Currently: {C:mult}#3#{C:inactive} Mult)"
                }
            },
            j_kino_founder = {
                name = "The Founder",
                text = {
                    "Fills your empty",
                    "consumeable slots",
                    "with {C:attention}Fries{}",
                    "at the end of the {C:attention}shop"
                }
            },
            j_kino_frankenstein = {
                name = "Frankenstein",
                text = {
                    "When you destroy a Playing Card",
                    "Upgrade this joker #6# times", 
                    "based on its suit",
                    "{C:inactive}(Currently: {C:chips} +#1#{C:inactive} Chips, {C:mult} +#2#{C:inactive} Mult)",
                    "{C:inactive}({X:mult,C:white}x#3#{C:inactive} Mult, {C:money}$#4#{C:inactive}, {X:chips,C:white}X#5#{C:inactive} Chips)"
                }
            },
            j_kino_freaky_friday_3 = {
                name = "Freaky Friday",
                text = {
                    "{C:attention}Active:{} When this joker has",
                    "no edition, and a playing card with an edition",
                    "triggers, this gains its edition",
                    "if this joker does have an edition",
                    "remove it and put it on the playing card"
                }
            },
            j_kino_friday_the_13th = {
                name = "Friday the 13th",
                text = {
                    "If your played hand",
                    "contains no {C:attention}Face{} cards",
                    "turn a random ",
                    "{C:attention{non-enhanced card",
                    "in hand into a {C:attention}Horror Card"
                }
            },
            j_kino_gentlemen_prefer_blondes = {
                name = "Gentlemen Prefer Blondes",
                text = {
                    "Scored {C:diamonds}Diamonds{} {C:mult}+#2#{} Mult",
                    "for each {C:diamonds}Diamonds{} ",
                    "card in your deck above #1#",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_kino_get_out = {
                name = "Get Out",
                text = {
                    "When you play a single card,",
                    "turn {C:attention}#1# random cards{} in hand",
                    "into exact copies of it",
                    "Then destroy this joker"
                }
            },
            j_kino_ghost_rider_1 = {
                name = "Ghost Rider",
                text = {
                    "Destroy a random {C:attention}Demonic card{}",
                    "in your hand, and gain {X:mult,C:white}X#2#{} Mult",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_ghostbusters_1 = {
                name = "Ghostbusters",
                text = {
                    "{C:attention}Debuffed{} cards are",
                    "{C:attention}destroyed{} when scored",
                    "Give {C:chips}+#2#{} Chips for each",
                    "card destroyed this way",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_ghoulies = {
                name = "Ghoulies",
                text = {
                    "When you perform the dark ritual of",
                    "playing a {C:attention}#1#{}, summon a",
                    "random {C:attention}Demonic 2{} to your hand",
                    "{C:inactive}(Ritual changes when performed.){}"
                }
            },
            j_kino_glass = {
                name = "Glass",
                text = {
                    "{C:mult}+#1#{} Mult per Glass Card",
                    "in your deck",
                    "Increase by {C:mult}+#2#{} Mult whenever",
                    "a Glass card shatters",
                    "{C:inactive}(Currently: {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_kino_goodfellas = {
                name = "Goodfellas",
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult and",
                    "loses {C:money}$#2#{} for each",
                    "Joker on the {C:attention}Left",
                    "of this one",
                    "{C:inactive}(Currently: {X:mult,C:white}X#3#{C:inactive} Mult & {C:money}$#4#{C:inactive})"
                }
            },
            j_kino_gravity = {
                name = "Gravity",
                text = {
                    "When you select a blind",
                    "while you posses a {C:planet}Planet{}",
                    "upgrade a random hand {C:attention}#1# Times{}"
                }
            },
            j_kino_gremlins_1 = {
                name = "Gremlins",
                text = {
                    "{C:inactive,E:1}Do not get them wet!{}",
                    "Unscored cards give {C:chips}+#1#{} Chips",
                    "for each {C:attention}Monster Card{}",
                    "held in hand"
                }
            },
            j_kino_grown_ups_1 = {
                name = "Grown Ups",
                text = {
                    "Each scoring card",
                    "gives Chips equal",
                    "to the chips of",
                    "the highest scoring",
                    "card"
                }
            },
            j_kino_gone_girl = {
                name = "Gone Girl",
                text = {
                    "Scoring {C:attention}Queens{} give {X:mult,C:white}X#1#{} Mult",
                    "{C:attention}Jacks{} and {C:attention}Kings{} are {C:black}Debuffed",
                    "when scored and increase the Mult by {X:mult,C:white}X#2#{}"
                }
            },
            j_kino_guardians_of_the_galaxy_1 = {
                name = "Guardians of the Galaxy",
                text = {
                    "{C:planet}Planets{} you own",
                    "give {C:mult}+#1#{} Mult"
                }
            },
            j_kino_guardians_of_the_galaxy_2 = {
                name = "Guardians of the Galaxy Vol. 2",
                text = {
                    "Transform every {C:planet}Planet",
                    "you have into {C:attention}Ego",
                    "at the end of the {C:attention}shop",
                }
            },
            j_kino_guardians_of_the_galaxy_3 = {
                name = "Guardians of the Galaxy Vol. 3",
                text = {
                    "Turn every {C:planet}Planet",
                    "you own {C:attention}Negative",
                    "at the end of the {C:attention}shop",
                }
            },
            j_kino_gullivers_travels = {
                name = "Gulliver's Travels",
                text = {
                    {"Gain {C:attention}+#1#{} Charge(s) when",
                    "a {C:attention}5 or lower{} scores",
                    "{C:inactive}(Currently: #2# Charges)"},
                    {"Give {C:mult}Mult{} equal to charges",
                    "then halve your current charges when",
                    "a {C:attention}Face Card{} scores"}
                }
            },
            j_kino_halloween = {
                name = "Halloween (1978)",
                text = {
                    "{C:chips}+#1#{} Chips for every",
                    "time a {C:attention}Horror Card{} ",
                    "has awoken",
                    "{C:inactive}(Currently: {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_kino_hard_eight = {
                name = "Hard Eight",
                text = {
                    "{C:money}$#1#{} for each",
                    "{C:attetion}8{} held in hand",
                    "{C:attention}8s{} held",
                    "in hand have a",
                    "{C:green}#2# in #3#{} chance",
                    "to be destroyed"
                }
            },   
            j_kino_harry_potter_1 = {
                name = "Now You See Me",
                text = {
                    "Gain a charge whenever ",
                    "a card is scored",
                    "On your final hand",
                    "{C:purple, E:1}Cast a Random Spell",
                    "with the strength based on",
                    "the gathered stacks",
                    "{C:inactive}(Currently: #1# stacks)"
                }
            },
            j_kino_heart_eyes = {
                name = "Heart Eyes",
                text = {
                    "Each {C:hearts}Hearts{} held in hand",
                    "has a {C:green}#1# in #2#{} chance",
                    "to {C:attention}Jumpscare"
                }
            },
            j_kino_hellboy_1 = {
                name = "Hellboy",
                text = {
                    "{C:attention}Demonic Cards{} do not ",
                    "trigger sacrifices",
                    "Gain {C:chips}+#2#{} Chips when",
                    "a {C:attention}Demonic Card{} scores",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_her = {
                name = "Her",
                text = {
                    "When you {C:attention}Make a Match{}",
                    "every {C:attention}Sci-fi card{} held in hand",
                    "is upgraded"
                }
            },
            j_kino_hitman = {
                name = "Hit Man",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "destroy Joker to the right",
                    "and gain money equal to",
                    "{C:money}x#1#{} its sell value",
                }
            },
            j_kino_home_alone_1 = {
                name = "Home Alone",
                text = {
                    "When you play ",
                    "a {C:attention}High Card{},",
                    "gain chips equal ",
                    "to its rank",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_hook = {
                name = "Hook",
                text = {
                    "When you play a {C:attention}Face card",
                    "transform it into a random",
                    "non-face card"
                }
            },
            j_kino_hot_fuzz = {
                name = "Hot Fuzz",
                text = {
                    "When you play a {C:attention}Pair{}",
                    "gain {C:attention}#2# Bullet{}",
                    "resets when you play a {C:attention}High Card",
                    "{C:inactive}(Currently: {C:attention}#1# Bullets{C:inactive})"
                }
            },
            j_kino_house_of_gucci = {
                name = "House of Gucci",
                text = {
                    "Scored cards give {C:chips}+#1#{} Chips",
                    "if they have an enhancement, {C:mult}+#2#{} Mult if",
                    "they have a seal and {X:mult,C:white}x#3#{} Mult if",
                    "they have an edition"
                }
            },
            j_kino_hustle = {
                name = "Hustle",
                text = {
                    "Retrigger {C:attention}first scoring{} card",
                    "for each {C:money}$#1#{} you have",
                    "increasing the threshold by {C:money}$#2#{}",
                    "per retrigger",
                    "{C:inactive}(Currently: {C:attention}#3#{C:inactive} Times)"
                }
            },
            j_kino_i_robot = {
                name = "I, Robot",
                text = {
                    "Gain {X:mult,C:white}X#2#{} Mult",
                    "when a {C:attention}Sci-fi Card{} upgrades",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_inception = {
                name = "Inception",
                text = {
                    "Copies the effect of any",
                    "joker you own that this",
                    "joker has spent {C:attention}3 blinds{}",
                    "to the left of",
                    "{C:inactive}(Will copy the joker to",
                    "{C:inactive}the right in #3# turns)",
                    "{C:inactive}Currently copying #4# joker(s))"
                }
            },
            j_kino_incredible_hulk = {
                name = "The Incredible Hulk",
                text = {
                    "{C:attention}Monster Cards{} give",
                    "{C:mult}+#1#{} Mult when scored"

                }
            },
            j_kino_independence_day_1 = {
                name = "Independence Day",
                text = {
                    "Lowers {C:attention}Boss Blinds",
                    "by %#1# for every currently",
                    "{C:attention}Abducted{} card"
                }
            },
            j_kino_insidious = {
                name = "Insidious",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a {C:tarot}Demon{} card when any",
                    "{C:attention}Booster Pack{} is opened",
                    "{C:inactive}(Must have room)",
                }
            },
            j_kino_insomnia = {
                name = "Insomnia",
                text = {
                    "{C:attention}Hand size{} is doubled",
                    "but you cannot draw",
                    "additional cards"
                }
            },
            j_kino_interstellar = {
                name = "Interstellar",
                text = {
                    "When you use a {C:attention}Planet{}",
                    "store it in this joker instead",
                    "When you sell this joker",
                    "level up your most played",
                    "hand for each stored stack",
                    "{C:inactive}(Currently: {C:attention}#1#{C:inactive} Stacks)"
                }
            },
            j_kino_iron_giant = {
                name = "The Iron Giant",
                text = {
                    "Each{C:attention} Sci-Fi Card{} held in hand", 
                    "gives {X:mult,C:white}X1{} Mult,",
                    "increased by {X:mult,C:white} X#1# {}",
                    "for each time it's been upgraded"
                }
            },
            j_kino_iron_lady = {
                name = "The Iron Lady",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if your",
                    "scoring hand contains",
                    "a {C:attention}Queen"
                }
            },
            j_kino_iron_man_1 = {
                name = "Iron Man",
                text = {
                    "When your {C:attention}first hand", 
                    "contains only cards",
                    "of the {C:attention}same suit{}", 
                    "upgrade every {C:attention}Sci-fi Card",
                    "in your hand"
                }
            },
            j_kino_jaws = {
                name = "Jaws",
                text = {
                    "Unscored cards give",
                    "{C:chips}+#1#{} Chips and are",
                    "{C:attention}Debuffed{}"
                }
            },
            j_kino_joe_dirt = {
                name = "Joe Dirt",
                text = {
                    "When you discard a {C:spades}Spade{}",
                    "this gains {C:chips}+#2#{} Chips",
                    "until the end of round",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Mult)"
                }
            },
            j_kino_john_wick_1 = {
                name = "John Wick",
                text = {
                    "{C:attention}#2# Bullets{} for",
                    "each card destroyed this {C:attention}Ante",
                    "{C:inactive}(Currently: {C:attention}#1# Bullets{C:inactive})"
                }
            },
            j_kino_junior = {
                name = "Junior",
                text = {
                    "Whenever {C:attention}10 {C:attention}Kings{}",
                    "or {C:attention}Jack{} have scored",
                    "create a random {C:attention}Polychrome 2",
                    "{C:inactive}(Currently: #1# triggers)"
                }
            },
            j_kino_jurassic_park_1 = {
                name = "Jurassic Park",
                text = {
                    "Cards give {C:chips}#1#x{}",
                    "as much base chips"
                }
            },
            j_kino_karate_kid_1 = {
                name = "The Karate Kid",
                text = {
                    "If the played hand ",
                    "contains an {C:attention}Ace{}",
                    "or a {C:attention}2{}",
                    "upgrade a random hand"
                }
            },
            j_kino_kiki_delivery = {
                name = "Kiki's Delivery Service",
                text = {
                    "The first #1# times",
                    "you {C:green}Reroll",
                    "lose {C:money}-$#3#{} and",
                    "add a booster pack",
                    "to the shop",
                    "{C:inactive}(Currently: #2# Rolls Left)"
                }
            },
            j_kino_killer_klowns = {
                name = "Killer Klowns from Outer Space",
                text = {
                    "Destroy a random joker",
                    "and create negative {C:planet}Planets{}",
                    "for each {C:money}$#1#{} of Sell Value"
                }
            },
            j_kino_kindergarten_cop = {
                name = "Kindergarten Cop",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if your",
                    "scoring hand has no cards",
                    "higher than a {C:attention}5"
                }
            },
            j_kino_kramervskramer = {
                name = "Kramer Vs. Kramer",
                text = {
                    "Gains {C:mult}+#2#{} Mult",
                    "when a {C:Romance}Romance{} Joker",
                    "is sold",
                    "{C:inactive}(Currently: {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            j_kino_kraven = {
                name = "Kraven the Hunter",
                text = {
                    {"{C:attention}Prey: #3#"},
                    {"Gain {X:mult,C:white}X#2#{} Mult when",
                    "you destroy Kraven's current prey",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"}
                }
            },
            j_kino_krazy_house = {
                name = "Krazy House",
                text = {
                    "{X:mult,C:white} X#1#{} Mult",
                    "When you play a {C:attention}Full House{}, randomize",
                    "the {X:mult,C:white} xMult{} between {X:mult,C:white} x #4#{} & {X:mult,C:white} x #5#{}",
                    "and increases the range by {X:mult,C:white}#5#{}"
                }
            },
            j_kino_kung_fu_panda_1 = {
                name = "Kung-Fu Panda",
                text = {
                    "{C:chips}+#1#{} Chips if",
                    "your hand contains",
                    "scoring {C:spades}Spades{}"
                }
            },
            j_kino_la_la_land = {
                name = "La La Land",
                text = {
                    "If your first played",
                    "hand contains only ",
                    "a single card", 
                    "upgrade every card",
                    "hand with {C:chips}Chips",
                    "equal to the",
                    "played card's rank"
                }
            },
            j_kino_lady_and_the_tramp = {
                name = "Lady & the Tramp",
                text = {
                    "Gives {C:attention}#1# times{}",
                    "the difference between the",
                    "{C:attention}highest{} and {C:attention}lowest{}",
                    "scoring card in {C:chips}Chips"
                }
            },
            j_kino_lethal_weapon = {
                name = "Lethal Weapon",
                text = {
                    {"Gain {C:mult}+#1#{} Mult",
                    "when you play a {C:attention}#4#",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"},
                    {"Upon defeating a {C:attention}Boss Blind",
                    "reset {C:Mult}Mult{} and increase",
                    "scaling by {C:mult}+#3#",}
                }
            },
            j_kino_limitless = {
                name = "Limitless",
                text = {
                    "When you defeat a {C:attention}Blind",
                    "increase your {C:money}Stolen Money",
                    "by {C:attention}#1#%{}",
                    "{C:inactive}(Currently: {C:money}$#2#{C:inactive} Money Stolen",
                    "{C:inactive}will increase by {C:money}$#3#}"
                }
            },
            j_kino_longlegs = {
                name = "Longlegs",
                text = {
                    "{X:mult,C:white}X3{} Mult",
                    "Set your current Chips to {C:chips}0{} and ",
                    "debuff this joker if",
                    "{C:attention}Longleg's Secret Partner{} is scored"
                }
            },
            j_kino_lord_of_the_rings_1 = {
                name = "Lord of the Rings: The Fellowship of the Ring",
                text = {
                    {"{X:mult,C:white}x#1#{} Mult when Joker",
                    "to the right triggers",},
                    {"Affected jokers lose {C:money}$#2#{} Sell Value",
                    "at the end of the round",
                    "and {C:red}self-destruct{} when {C:money}$0{}"}
                }
            },
            j_kino_lost_in_translation = {
                name = "Lost In Translation",
                text = {
                    "{C:mult}+#1#{} Mult whenever",
                    "a {C:Romance}Romance{} Joker triggers"
                }
            },
            j_kino_lucky_number_slevin = {
                name = "Lucky Number Slevin",
                text = {
                    "All {C:attention}listed{} odds are",
                    "increased by {C:green}#1#{} for",
                    "each {C:attention}7{} held in hand",
                    "{C:inactive}(Currently: {C:green}#2#{C:inactive})"
                }
            },
            j_kino_m3gan = {
                name = "M3GAN",
                text = {
                    "On your {C:attention}Final Hand{}",
                    "lower the {C:attention}Blind{} by #1#%",
                    "for each {C:attention}Sci-Fi Card{}",
                    "in your hand"
                }
            },
            j_kino_mafiamamma = {
                name = "Mafia Mamma",
                text = {
                    "When you sell",
                    "a card, gain Chips",
                    "equal to its Sell Value",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_mamma_mia_1 = {
                name = "Mamma Mia!",
                text = {
                    "{C:mult}+#2#{} Mult if your",
                    "scoring hand contains",
                    "at least #1# {C:hearts}Hearts{}"
                }
            },
            j_kino_man_who_laughs = {
                name= "The Man Who Laughs",
                text = {
                    "{X:mult,C:white}X#1#{} Mult for each",
                    "other joker card you have",
                    "{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            },
            j_kino_mars_attacks = {
                name = "Mars Attacks",
                text = {
                    "When you use a {C:attention}Mars{}",
                    "Level Up {C:attention}Four of a Kind{}",
                    "an additional {C:attention}#1#{} levels",
                    "and decrease the level of {C:attention}Full House{}",
                    "{C:inactive,E:1}Destroying Earth has consequences.{}"
                }
            },
            j_kino_martian = {
                name = "The Martian",
                text = {
                    "When you use {C:planet}Mars",
                    "create #1# {C:attention}Confections"
                }
            },
            j_kino_matrix_1 = {
                name = "The Matrix",
                text = {
                    "{C:chips}+#1#{} Chips for",
                    "every {C:attention}Sci-fi card{}",
                    "in your deck",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_kino_megalopolis = {
                name = "Megalopolis",
                text = {
                    "Each scored {C:clubs}Clubs{}",
                    "gives {C:chips}+#2#{} Chips",
                    "for each other ",
                    "scoring {C:clubs}Clubs{}"
                }
            },
            j_kino_memento = {
                name = "Memento",
                text = {
                    {"Each scored card triggers",
                    "{C:attention}#1# additional time(s){}"},
                    {"When you take any action", 
                    "flip all cards in your hand"}
                }
            },
            j_kino_men_in_black_1 = {
                name = "Men in Black",
                text = {
                    "Gains {X:mult,C:white}X#2#{} when",
                    "a card is abducted",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_menu = {
                name = "The Menu",
                text = {
                    "Create a {C:attention}Confection",
                    "when you sell a Joker"
                }
            },
            j_kino_metropolis = {
                name = "Metropolis",
                text = {
                    "{C:attention}Sci-fi Cards{} upgrade",
                    "#1# additional time for each",
                    "Silent movie joker"
                }
            },
            j_kino_minecraft = {
                name = "A Minecraft Movie",
                text = {
                    "Scoring {C:attention}Stone Cards",
                    "turn into either {C:attention}Steel",
                    "or {C:attention}Gold Cards"
                }
            },
            j_kino_modern_times = {
                name = "Modern Times",
                text = {
                    "Scored cards have a {C:green}#2# in #3#{} chance",
                    "to retrigger {C:attention}#1#{} times",
                    "and a {C:green}#4# in #5#{} chance to",
                    "be destroyed"
                }
            },
            j_kino_moneyball = {
                name = "Moneyball",
                text = {
                    "Earn {C:money}Money{}",
                    "equal to the {C:attention}level",
                    "of your first hand played",
                    "each round"
                }
            },
            j_kino_monster_house = {
                name = "Monster House",
                text = {
                    {"Gain {C:mult}+#1#{} Mult",
                    "when you play a {C:attention}#4#",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"},
                    {"Upon defeating a {C:attention}Boss Blind",
                    "reset {C:Mult}Mult{} and increase",
                    "scaling by {C:mult}+#3#",}
                }
            },
            j_kino_moonfall = {
                name = "Moonfall",
                text = {
                    {"Give {C:chips}+#3#{} Chips for each",
                    "{C:clubs}Clubs{} in your deck",
                    "{C:inactive}(Currently: {C:chips}+#4#{C:inactive} Chips)",},
                    {"{C:purple}Abduct{} each scored non-{C:clubs}clubs{} card",
                    "on the {C:attention}First{} hand each round"},
                    {"{C:attention}Release:{} Return cards", 
                    "transformed into {C:clubs}Clubs",}
                    
                }
            },
            j_kino_morbius = {
                name = "Morbius",
                text = {
                    "When you play a hand,", 
                    "{C:attention}Debuff{} every {C:attention}Enhanced Card",
                    "in your hand and gain {X:mult,C:white}x#2#{} Mult",
                    "until the end of round.",
                    "{C:inactive}(Currently: {X:mult,C:white}x#1#{C:inactive} Mult)"
                }
            },
            j_kino_mortal_kombat = {
                name = "Mortal Kombat",
                text = {
                    "When selecting a blind",
                    "destroy a random joker",
                    "and place {C:attention}#1# Power Counters{}",
                    "on a random Joker"
                }
            },
            j_kino_moulin_rouge = {
                name = "Moulin Rouge",
                text = {
                    "Gain {C:attention}+#1#{} hand size",
                    "for each unique suit",
                    "drawn in your opening hand"
                }
            },
            j_kino_mr_and_mrs_smith = {
                name = "Mr. & Mrs. Smith",
                text = {
                    "When you play a {C:attention}Pair{},",
                    "retrigger scored cards",
                    "{C:attention}#1# additonal time(s){}"
                }
            },
            j_kino_muppets_2 = {
                name = "The Great Muppet Caper",
                text = {
                    "{C:diamonds}Diamonds{} give between {C:mult}#1#{} and",
                    "{C:mult}+#2#{} Mult when scored"
                }
            },
            j_kino_muppets_treasure_island = {
                name = "Muppet Treasure Island",
                text = {
                    "Increase Sell Value of",
                    "a random joker by {C:money}$#1#{}",
                    "each reroll in the shop"
                }
            },
            j_kino_my_neighbor_totoro = {
                name = "My Neighbor Totoro",
                text = {
                    "{C:chips}+#1#{} Chips every",
                    "#3# hands",
                    "{C:inactive}(#2# hands remaining){}"
                }
            },
            j_kino_ponyo = {
                name = "Ponyo",
                text = {
                    {"{C:attention}Active:{} {X:mult,C:white}X#2#{} Mult",},
                    {"{C:attention}Inactive:{} Gain {X:mult,C:white}X#1#{} Mult",
                    "for each unscored card"}
                }
            },
            j_kino_nightcrawler = {
                name = "Nightcrawler",
                text = {
                    "When a {C:attention}Face Card{} is destroyed",
                    "this gains {X:mult,C:white}X#1#{} mult",
                    "for {C:attention}#2# Rounds{}",
                    "{C:inactive}(Currently: {X:mult,C:white}X#3#{C:inactive} Mult)"
                }
            },
            j_kino_nightmare_on_elm_street = {
                name = "A Nightmare on Elm Street",
                text = {
                    "{C:attention}Monster cards{} held in hand",
                    "give {X:mult,C:white}X#1#{} Mult"
                }
            },
            j_kino_nope = {
                name = "Nope",
                text = {
                    {"{C:attention}Abduct{} a random card when",
                    "you play a hand with 5 or more cards",},
                    {"{C:attention}Release:{} Return debuffed",
                    "and gain {C:mult}+#3#{} Mult",
                    "{C:inactive}(Currently: {C:mult}+#2#{C:inactive} Mult)"}
                }
            },
            j_kino_nosferatu_1 = {
                name = "Nosferatu (1922)",
                text = {
                    "Gains {C:mult}+#1#{} Mult",
                    "per scoring {C:attention}Enhanced card{} played",
                    "removes card {C:attention}Enhancement",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                },
            },
            j_kino_nosferatu_2024 = {
                name = "Nosferatu (2024)",
                text = {
                    {"This Joker gains {C:mult}+#2#{} Mult",
                    "per scoring {C:attention}Enhanced card{} played,",
                    "removes card {C:attention}Enhancement"},
                    {"Whenever a {C:hearts}Hearts{} scores",
                    "it gives {C:mult}+#1#{} Mult"}
                }
            },
            j_kino_number_23 = {
                name = "The Number 23",
                text = {
                    "{C:mult}+#1#{} Mult if played",
                    "cards have a combined",
                    "rank of {C:attention}23"
                }
            },
            j_kino_oceans_11 = {
                name = "Ocean's 11 (2001)",
                text = {
                    "{C:attention}Booster Packs{} in the shop", 
                    "are free"
                }
            },
            j_kino_oceans_11_2 = {
                name = "Ocean's 11 (1960)",
                text = {
                    "When any {C:money}money{} is",
                    "lost, instead lower the",
                    "value of this joker",
                    "{C:inactive}(Max value of {C:money}$#1#{C:inactive})"
                }
            },
            j_kino_oceans_12 = {
                name = "Ocean's 12",
                text = {
                    "Add {C:money}$#1#{} to Money Stolen",
                    "when you {C:green}Reroll"
                }
            },
            j_kino_omen = {
                name = "The Omen",
                text = {
                    "{C:chips}+#1#{} Chips if you've made",
                    "at least {C:attention}#2#{} sacrifices",
                    "{C:inactive}(Currently: {C:attention}#3#{C:inactive} sacrifices made)"
                }
            },
            j_kino_only_lovers_left_alive = {
                name = "Only Lovers Left Alive",
                text = {
                    "If you play a {C:attention}Pair{}",
                    "and both are {C:attention}Romance Cards{}",
                    "destroy them and gain {X:mult,C:white}X#2#{} Mult",
                    "per card destroyed",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_oppenheimer = {
                name = "Oppenheimer",
                text = {
                    "Whenever you solve",
                    "the {C:attention}Codex{}",
                    "create a {C:spectral}Spectral Card{}"
                }
            },
            j_kino_pain_and_gain = {
                name = "Pain & Gain",
                text = {
                    "Retrigger a random card",
                    "for each {C:attention}Bullet{} you have"
                }
            },
            j_kino_panic_room = {
                name = "Panic Room",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "on your {C:attention}final hand"
                }
            },
            j_kino_party_people = {
                name = "24 Hour Party People",
                text = {
                    "Each Scoring {C:clubs}Clubs{}", 
                    "gives {C:money}$#1#{} for each", 
                    "{C:money}$#2#{} you have",

                }
            },
            j_kino_paul = {
                name = "Paul",
                text = {
                    "{C:attention}Sci-Fi Jokers{} you own",
                    "are {C:attention}#1#%{} stronger"
                }
            },
            j_kino_paulblart_1 = {
                name = "Paul Blart: Mall Cop",
                text = {
                    {"Consume a Charge to give {C:mult}+#1#{} Mult",
                    "{C:inactive}(Currently: #3# Charges)"},
                    {"Gain {C:attention}+#2# Charges{}", 
                    "when you eat a {C:mult}Confection"}
                }
            },
            j_kino_peggy_sue_got_married = {
                name = "Peggy Sue Got Married",
                text = {
                    "Cards with an edition",
                    "give {C:chips}+#1#{} Chips"
                }
            },
            j_kino_pink_panther_1 = {
                name = "The Pink Panther",
                text = {
                    "Each scored {C:diamonds}Diamonds{}", 
                    "gives {C:chips}+#2#{} Chips for",
                    "each other scoring {C:diamonds}Diamonds{}"
                }
            },
            j_kino_pinocchio_1940 = {
                name = "Pinocchio (1940)",
                text = {
                    "Each {C:attention}unmodified{} card",
                    "held in hand gives",
                    "{C:chips}+#1#{} Chips"
                }
            },
            j_kino_pinocchio_2022 = {
                name = "Pinocchio (2022)",
                text = {
                    "Scoring {C:attention}Unmodified{} cards",
                    "give {C:chips}+#1#{} chips"
                }
            },
            j_kino_piranha_2 = {
                name = "Piranha 2: The Spawning",
                text = {
                    "{C:red}+#1#{} Mult if played",
                    "hand is a",
                    "{C:attention}High Card",
                }
            },
            j_kino_pirates_movie = {
                name = "The Pirates! Band of Misfits",
                text = {
                    "When you use a consumable",
                    "with a sell value higher than {C:money}$0",
                    "create a copy with a sell value of {C:money}$0"
                }
            },
            j_kino_pirates_of_the_caribbean_1 = {
                name = "Pirates of the Caribbean: Curse of the Black Pearl",
                text = {
                    "When you destroy a card",
                    "adjacent cards gain {C:money}$#1#",
                    "{C:money}Sell Value{}"
                }
            },
            j_kino_pirates_of_the_caribbean_2 = {
                name = "Pirates of the Caribbean: Dead Man's Chest",
                text = {
                    "Cards give {X:mult,C:white}X1{} Mult",
                    "increased by {X:mult,C:white}X#1#{} mult",
                    "for each {C:money}$1{} of {C:money}Sell Value{}"
                }
            },
            j_kino_pirates_of_the_caribbean_3 = {
                name = "Pirates of the Caribbean: At World's End",
                text = {
                    "Jokers give {C:chips}Chips{} equal to",
                    "{C:attention}x3{} times their {C:money}Sell Value{}"
                }
            },
            j_kino_pitch_black = {
                name = "Pitch Black",
                text = {
                    "{C:mult}+#1#{} Mult on your final hand",
                    "and increase by {C:mult}+#2#{} Mult",
                    "whenever a card scores in a",
                    "non-final hand, then reset",
                }
            },
            j_kino_point_break = {
                name = "Point Break",
                text = {
                    "When you play a {C:attention}Pair{}",
                    "destroy a random card in",
                    "your hand, and give all",
                    "scoring cards {C:mult}+#1#{} Mult",
                }
            },
            j_kino_polar_express = {
                name = "Polar Express",
                text = {
                    "{C:chips}+#1#~+#2#{} Chips & {C:mult}+#3#~+#4#{} Mult",
                    "if you have not",
                    "{C:mult}Discarded{} since your last hand",
                }
            },
            j_kino_poltergeist = {
                name = "Poltergeist",
                text = {
                    "Each {C:attention}Demonic{} card held ",
                    "in hand gives {X:mult,C:white}X1.5{} Mult"
                }
            },
            j_kino_popeye = {
                name = "Popeye",
                text = {
                    "Increase the Power",
                    "of the Joker to",
                    "the right by",
                    "{C:attention}#1#%{}"
                }
            },
            j_kino_predator = {
                name = "Predator",
                text = {
                    "A card in your opening hand {C:attention}secretly{}",
                    "becomes a {C:attention}Predator{} for this round",
                    "The {C:attention}Predator{} gives",
                    "{X:mult,C:white}X#2#{} Mult when scored"
                }
            },
            j_kino_prestige = {
                name = "The Prestige",
                text = {
                    "When you play a hand",
                    "containing only a {C:attention}Lucky Card",
                    "destroy it, and create",
                    "a copy with all its {C:green}odds",
                    "increased by {C:green}#1#"
                }
            },
            j_kino_pride_and_prejudice = {
                name = "Pride & Prejudice",
                text = {
                    "After you draw cards",
                    "if you have only 1",
                    "{C:attention}Romance Card{} in hand,",
                    "draw another romance card"
                }
            },
            j_kino_princess_bride = {
                name = "The Princess Bride",
                text = {
                    "If your hand contains",
                    "a scoring {C:hearts}Hearts{}",
                    "draw {C:attention}#1#{} additional",
                    "cards on your next draw"
                }
            },
            j_kino_psycho = {
                name = "Psycho (1960)",
                text = {
                    "{C:attention}Face Cards{} held in hand",
                    "have a {C:green}#1# in #2#{} chance",
                    "to {C:attention}Jump Scare"
                }
            },
            j_kino_pulp_fiction = {
                name = "Pulp Fiction",
                text = {
                    {
                        "When you use a {C:attention}Consumable",
                        "gain {C:mult}+#1#{} Mult and increase",
                        "scaling with {C:mult}+#2#{} Mult",
                        "{C:inactive}(Currently: {C:mult}+#3#{C:inactive} Mult)"
                    },
                    {
                        "{C:green}#4# in #5#{} chance to",
                        "reset the values of this joker",
                        "Increased by {C:green}+1{} when",
                        "a {C:attention}consumable{} is used"
                    }
                }
            },
            j_kino_ready_player_one = {
                name = "Ready Player One",
                text = {
                    "{C:attention}Movie Jokers{} released in",
                    "the 70s and 80s give {C:chips}chips",
                    "equal to their release year"
                }
            },
            j_kino_resident_evil = {
                name = "Resident Evil",
                text = {
                    "When you discard",
                    "a single card",
                    "destroy every card in hand",
                    "that shares a rank"
                }
            },
            j_kino_ringu = {
                name = "Ring (1998)",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "Decreases by {X:mult,C:white}X#2#{} Mult",
                    "each hand",
                    "{C:attention}Cannot be sold!{}",
                    "{C:attention}there are consequences"
                }
            },
            j_kino_robocop_1 = {
                name = "Robocop",
                text = {
                    "When your scoring hand is a {C:attention}High Card{}",
                    "turn all scored cards", 
                    "into {C:attention}Sci-fi Cards{}"
                }
            },
            j_kino_rock = {
                name = "The Rock",
                text = {
                    "{C:attention}Stone cards{} give {C:mult}+#1#{} Mult",
                }
            },
            j_kino_rocky_1 = {
                name = "Rocky",
                text = {
                    "If this is your {C:attention}final hand", 
                    "this round, {C:green}Level Up",
                    "the played hand"
                }
            },
            j_kino_rogue_one = {
                name = "Rogue One",
                text = {
                    "When a {C:attention}Joker",
                    "is destroyed",
                    "create a {C:planet}Death Star"
                }
            },
            j_kino_rush_hour = {
                name = "Rush Hour",
                text = {
                    "Upgrade scoring hand",
                    "with {C:chips}+#2#{} Chips",
                    "per scoring {C:dark_edition}Black{} card",
                    "and {C:mult}+#1#{} Mult per scoring {C:mult}Red{} card",
                    "if hand contains a {C:attention}Pair"
                }
            },
            j_kino_sausage_party = {
                name = "Sausage Party",
                text = {
                    "{C:green}#1# in #2#{} Chance to upgrade",
                    "a random hand",
                    "whenever a {C:attention}Confection{} triggers",
                    
                }
            },
            j_kino_scarface_1 = {
                name = "Scarface (1932)",
                text = {
                    "When you sell a {C:attention}Consumable",
                    "{C:money}Steal Money{} equal to its value"
                }
            },
            j_kino_scarface_2 = {
                name = "Scarface (1983)",
                text = {
                    "When a {C:attention}Consumable{}",
                    "is used, turn a random card",
                    "in your deck into a {C:attention}Crime Card"
                }
            },
            j_kino_school_of_rock = {
                name = "School of Rock",
                text = {
                    "Scoring {C:attention}5s or lower{}",
                    "become {C:attention}Stone Cards"
                }
            },
            j_kino_scream_1 = {
                name = "Scream",
                text = {
                    "Gains {C:mult}+#2#{} Mult for every {C:Horror}Horror{}",
                    "joker you have at the end of round",
                    "Loses value equal to the Mult gained",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            j_kino_se7en = {
                name = "Se7en",
                text = {
                    "Each scored {C:attention}7",
                    "gives {C:mult}+#1#{} Mult"
                }
            },  
            j_kino_secretary = {
                name = "Secretary",
                text = {
                    "Each scored {C:spades}Spades{} ", 
                    "gives {C:chips}+#2#{} Chips",
                    "for each other scoring {C:spades}Spades{}",
                }
            },
            j_kino_seven_brides_for_seven_brothers = {
                name = "7 Brides for 7 Brothers",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if your deck",
                    "contains an equal number of",
                    "{C:attention}Kings{} and {C:attention}Queens"
                }
            },
            j_kino_shang_chi = {
                name = "Shang-Chi and the Legend of the 10 Rings",
                text = {
                    "{C:purple, E:1}Cast the next Spell",
                    "of the {C:attention}10"
                }
            },
            j_kino_shawshank_redemption = {
                name = "The Shawshank Redemption",
                text = {
                    "Upgrade every card in hand",
                    "with {C:chips}+#1#{} Chips",
                    "whenever you {C:red}Discard{} a Card"
                }
            },
            j_kino_shazam_1 = {
                name = "Shazam",
                text = {
                    "When you {C:purple}Cast a Spell",
                    "transform a random",
                    "{c:attention}Non-Face Card{} into a {C:attention}Jack"
                }
            },
            j_kino_shining = {
                name = "The Shining",
                text = {
                    "Gains {C:mult}+#2#{} Mult when",
                    "you draw a {C:attention}Jack{}",
                    "Resets after you play a hand",
                    "{C:inactive}(Currently: {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            j_kino_shinkamenrider = {
                name = "Shin Kamen Rider",
                text = {
                    {"Gains {X:mult,C:white}x#2#{} Mult",
                    "when a Boss Blind is defeated",
                    "{C:inactive}(Currently: {X:mult,C:white}x#1#{C:inactive} Mult)"},
                    -- {"Blinds have a {C:green}1 in 2{} Chance",
                    -- "to be a Boss Blind",}
                    
                }
            },
            j_kino_shopaholic = {
                name = "Confessions of a Shopaholic",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult whenever you",
                    "spend {C:money}$#5#{}. Goes up by {C:money}$#3#{}",
                    "every time. {C:inactive} (Spend {C:money}#4#{C:inactive})",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            },
            j_kino_signs = {
                name = "Signs",
                text = {
                    "{C:attention}Abduct{} a random unscored card",
                    "Gives {C:mult}+#3#{} for each card",
                    "abducted anywhere",
                    "{C:inactive}(Currently: {C:mult}+#4#{C:inactive} Mult)"
                }
            },
            j_kino_skyscraper = {
                name = "Skyscraper",
                text = {
                    "Gain {C:mult}+#1#{} Mult",
                    "when you play a {C:attention}#4#",
                    "Upon defeating a {C:attention}Boss Blind",
                    "reset{C:Mult} Mult{} and increase",
                    "scaling by {C:mult}+#3#",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                }
            },
            j_kino_sleepy_hollow = {
                name = "Sleepy Hollow",
                text = {
                    "{C:attention}Monster{} and {C:attention}Horror{} cards",
                    "count as any suit"
                }
            },
            j_kino_smile = {
                name = "Smile",
                text = {
                    "{C:attention}Face Cards{} are not",
                    "sacrificed by {C:attention}Demonic Cards",
                    "but do count towards sacrifices"
                }
            },
            j_kino_smurfs_1 = {
                name = "Smurfs",
                text = {
                    "Scoring {C:attention}2s{} and {C:attention}3s{}",
                    "give {C:chips}+#1#{} Chips for",
                    "each time you {C:purple}Cast a Spell",
                    "{C:inactive}(Currently: {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_kino_snow_white_1 = {
                name = "Snow White & the 7 Dwarves",
                text = {
                    {
                        "Gain a {C:attention}Charge",
                        "whenever a card with",
                        "a rank of {C:attention}5 or lower{}",
                        "scores"
                    },
                    {
                        "{C:mult}+#1#{} Mult per Charge",
                        "consumed whenever a {C:attention}Queen scores",
                        "{C:inactive}(Currently: #2# Charges)"
                    }
                }
            },
            j_kino_snowpiercer = {
                name = "Snowpiercer",
                text = {
                    "Destroy all {C:attention}Consumables",
                    "when you select a blind",
                    "and gain {C:mult}+#2#{} Mult",
                    "{C:inactive}(Currently: {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            j_kino_social_network = {
                name = "The Social Network",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "{C:attention}Face Card{} in {C:attention}deck",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                } 
            },
            j_kino_solo = {
                name = "Solo: A Star Wars Story",
                text = {
                    "When you play",
                    "a {C:attention}High Card",
                    "create a random {C:planet}Planet"
                }
            },
            j_kino_sorcerers_apprentice = {
                name = "The Sorcerer's Apprentice",
                text = {
                    "When you {C:purple,E:1}Cast a Spell",
                    "cast it again at a lower rank"
                }
            },
            j_kino_sound_of_music = {
                name = "The Sound of Music",
                text = {
                    "{C:inactive,E:1}#1#",
                    "If your hand contains a {C:attention}#2#",
                    "gain {C:mult}+#6#{} Mult and go up a rank",
                    "If your hand does not contain",
                    "a {C:attention}#2#{} reset the Mult",
                    "If you finish the song, the mult",
                    "gained becomes permanent",
                    "{C:inactive}(Currently: temporary {C:mult}+#4#{C:inactive} Mult || {C:mult}+#5#{C:inactive} Mult)"
                }
            },
            j_kino_source_code = {
                name = "Source Code",
                text = {
                    "Every {V:1}#1#{} gives",
                    "{C:mult}+#2#{} Mult for each Bullet",
                    "suit changes every round"
                }
            },
            j_kino_spartacus = {
                name = "Spartacus",
                text = {
                    "If your {C:attention}final played hand",
                    "of round is only 1 card,",
                    "turn every card in your",
                    "hand into a copy of it"
                }
            },
            j_kino_stand_by_me = {
                name = "Stand By Me",
                text = {
                    "If you play a {C:attention}Straight{},",
                    "create a Hangman"
                }
            },
            j_kino_spirited_away = {
                name = "Spirited Away",
                text = {
                    "When selecting a blind",
                    "upgrade every card",
                    "in your deck with {C:chips}+#1#{} Chips"
                }
            },
            j_kino_star_wars_clone_wars = {
                name = "Star Wars: The Clone Wars",
                text = {
                    {
                        "{C:mult}+#1#{} Mult for each",
                        "{C:Animation}Animation{} Joker",
                        "{C:inactive}(Currently: {C:mult}+#2#{C:inactive} Mult)"
                    },
                    {
                        "Retrigger this joker",
                        "#3# time(s) for each",
                        "adjacent {C:Sci-fi}Sci-fi{} Joker",
                        "{C:inactive}(Currently: {C:attention}+#4#{C:inactive} Retriggers)"
                    }
                }
            },
            j_kino_star_wars_holiday = {
                name = "The Star Wars Holiday Special",
                text = {
                    {"Gain #2# Charge when you",
                    "defeat a Blind or",
                    "use a planet",
                    "{C:inactive}(Currently: #1# Charges)"},
                    {
                        "Create a Star Wars Joker",
                        "for each {C:attention}#3# Charges{}",
                        "when this Joker is sold",
                        "{C:inactive}(Must have room)"
                    }
                }
            },
            j_kino_star_wars_i = {
                name = "Star Wars Episode I: The Phantom Menace",
                text = {
                    "When you use a {C:planet}Planet",
                    "upgrade {C:attention}#1#{} cards in your deck",
                    "with {C:chips}+#2#{} Chips"
                }
            },
            j_kino_star_wars_ii = {
                name = "Star Wars Episode II: Attack of the Clones",
                text = {
                    "When a playing card is destroyed",
                    "{C:attention}Upgrade{} each card with",
                    "the same rank in your deck with",
                    "{C:attention}#1#x{} times its upgrades",
                }
            },
            j_kino_star_wars_iii = {
                name = "Star Wars Episode III: Revenge of the Sith",
                text = {
                    "On First Hand of Round",
                    "destroy joker to the right",
                    "and upgrade {C:attention}Scoring Cards{}",
                    "with {X:mult,C:white}X#1#{} Mult equal to the",
                    "sell value"
                }
            },
            j_kino_star_wars_iv = {
                name = "Star Wars",
                text = {
                    "After you've scored",
                    "cards with a total value",
                    "{C:attention}#2#{}, upgrade",
                    "a random hand {C:attention}#3#{} Times",
                    "{C:inactive}(Currently: {C:attention}#1#{C:inactive} value scored)"
                }
            },
            j_kino_star_wars_v = {
                name = "Star Wars Episode V: The Empire Strikes Back",
                text = {
                    "Gives {C:mult}+#1#{} Mult",
                    "{C:mult}-#2#{} per hand",
                    "{C:mult}+#3#{} when you use a {C:planet}Planet"
                }
            },
            j_kino_star_wars_vi = {
                name = "Star Wars Episode VI: The Return of the Jedi",
                text = {
                    "Gives {C:chips}+#1#{} Chips",
                    "Multiply by {C:attention}x#2#{} when you use a {C:planet}Planet",
                    "{C:attention}x#3#{} when you play a hand"
                }
            },
            j_kino_star_wars_vii = {
                name = "Star Wars Episode VII: The Force Awakens",
                text = {
                    "Scoring cards give {C:mult}+#1#{} mult",
                    "for each level of the scoring poker hand"
                }
            },
            j_kino_star_wars_viii = {
                name = "Star Wars Episode VIII: The Last Jedi",
                text = {
                    "Scoring cards give {C:mult}+#2#{} mult",
                    "for each stack, then consume a stack",
                    "When selecting a blind, set stacks",
                    "equal to #2# times total {C:planet}Planets used{}",
                    "{C:inactive}(Currently {C:attention}#3#{C:planet} Planets{C:inactive} used)"
                }
            },
            j_kino_star_wars_ix = {
                name = "Star Wars Episode IX: The Rise of Skywalker",
                text = {
                    "Gain {C:attention}+#1#{} Handsize",
                    "for each {C:planet}Planet{} used",
                    "since last round",
                    "{C:inactive}(Currently: +#2# Handsize)"
                }
            },
            j_kino_stargate = {
                name = "Stargate",
                text = {
                    {"{C:attention}Abduct{} every {C:attention}Stone ",
                    "card scored",},
                    {"{C:attention}Release:{} return them unstoned",
                    "and gain {C:chips}+#4#{} Chips for each",
                    "{C:inactive}(Currently: {C:chips}+#3#{C:inactive} Chips)"}
                }
            },
            j_kino_starman = {
                name = "Starman",
                text = {
                    "When you {C:attention}Make a Match",
                    "upgrade every hand with {C:mult}+#1#{} Mult"
                }
            },
            j_kino_steel = {
                name = "Steel",
                text = {
                    "Gains {C:chips}+#2#{} Chips for",
                    "each steel card in hand",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_stranger_than_fiction = {
                name = "Stranger Than Fiction",
                text = {
                    "Narrates your very next move", 
                    "Increases by {C:chips}+#2#{} Chips if you do",
                    "Resets if you do not",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)", 
                    "\n",
                    '{C:inactive,E:1}"... and then they played', 
                    '{C:inactive,E:1}the {C:attention}#4#{}"',

                }
            },
            j_kino_stripes = {
                name = "Stripes",
                text = {
                    "Gain {C:chips}+#2#{} Chips when a card is scored",
                    "Lose {C:chips}-#2#{} Chips a card is discarded",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_kino_taken_1 = {
                name = "Taken",
                text = {
                    "Gives {C:mult}+#1#{} Mult",
                    "if a {C:attention}Queen{} is held",
                    "in hand"
                }
            },
            j_kino_terminator_1 = {
                name = "The Terminator",
                text = {
                    "Whenever a {C:attention}Sci-fi Card{}",
                    "is destroyed, create a copy",
                    "in deck and upgrade it"
                }
            },
            j_kino_terminator_2 = {
                name = "Terminator 2: Judgment Day",
                text = {
                    "{C:attention}Sci-fi Cards{} gain",
                    "{X:mult,C:white}X#1#{} Mult instead of",
                    "{C:mult}Mult{} when they upgrade"
                }
            },
            j_kino_sugarland_express = {
                name = "The Sugarland Express",
                text = {
                    {"{C:attention}Active:{} {C:chips}+#3#{} Chips for",
                    "each time this took money",},
                    {"{C:attention}Inactive:{} Takes {C:money}$#1#",
                    "when you play a hand",
                    "{C:inactive}(Currently: taken money #2# times)"}
                }
            },
            j_kino_sunshine = {
                name = "Sunshine",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "{C:hearts}Hearts{} held in hand"
                }
            },
            j_kino_terror_train = {
                name = "Terror Train",
                text = {
                    "Each card held in hand",
                    "that shares a rank",
                    "with a scoring card has a",
                    "{C:green}#1# in #2#{} chance to {C:attention}Jumpscare"
                }
            },
            j_kino_they_live = {
                name = "They Live",
                text = {
                    "{C:attention}Abduct{} every card {C:mult}discarded",
                    "on your first discard",
                    "Earn {C:money}#3#{} for each card",
                    "this joker has Abducted",
                    "{C:inactive}(Currently: {C:money}$#4#{C:inactive})"
                }
            },
            j_kino_thing = {
                name = "The Thing (1982)",
                text = {
                    "Every {V:1}#1#{} counts",
                    "as every suit,",
                    "suit changes every round"
                }
            },
            j_kino_thor_1 = {
                name = "Thor",
                text = {
                    "Retrigger a random",
                    "card {C:attention}#1#{} times",
                    "if you played more than 2",
                    "scoring cards"
                }
            },
            j_kino_three_musketeers_1 = {
                name = "The Three Musketeers (2011)",
                text = {
                    "Gain {C:mult}+#1#{} Mult",
                    "when you play a {C:attention}#4#",
                    "Upon defeating a {C:attention}Boss Blind",
                    "reset {C:Mult}Mult{} and increase",
                    "scaling by {C:mult}+#3#",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                }
            },            
            j_kino_titanic = {
                name = "Titanic",
                text = {
                    "Scored {C:hearts}Hearts{} give {C:mult}+#2#{} Mult",
                    "for each {C:hearts}Hearts{}",
                    "in your deck above #1#",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_kino_tmnt_1 = {
                name = "Teenage Mutant Ninja Turtles (1990)",
                text = {
                    "Retrigger the first",
                    "scoring card of",
                    "each suit {C:attention}#1# times{}"
                }
            },
            j_kino_to_kill_a_mockingbird = {
                name = "To Kill a Mockingbird",
                text = {
                    "Whenever a Joker",
                    "is destroyed",
                    "{C:green}#1# in #2#{} chance to",
                    "turn it {C:dark_edition}Negative{}",
                    "instead"
                }
            },
            j_kino_tower_heist = {
                name = "Tower Heist",
                text = {
                    "{C:attention}Stone Cards{} give",
                    "{C:chips}#1#{} Chips per {C:money}$1{} Stolen",
                    "{C:inactive}(Currently: {C:chips}#2#{C:inactive} Chips)"
                }
            },
            j_kino_trading_places = {
                name = "Trading Places",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult when",
                    "you sell a card for {C:money}$#3#{} or more",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_treasure_island = {
                name = "Treasure Island",
                text = {
                    "Gives {C:attention}#1#x{} the Sell",
                    "Value of all owned",
                    "Jokers when Boss blind is defeated",
                    "{C:inactive}(Currently {C:money}$#2#{C:inactive})",
                } 
            },
            j_kino_treasure_planet = {
                name = "Treasure Planet",
                text = {
                    "Earn {C:money}$#1#{} when",
                    "a {C:attention}Planet{} is used"
                }
            },
            j_kino_tree_of_life = {
                name = "The Tree of Life",
                text = {
                    "{C:chips}+#1#{} Chips for",
                    "each {C:attention}Unique Rank{}",
                    "held in hand"
                }
            },
            j_kino_true_lies = {
                name = "True Lies",
                text = {
                    "{C:attention}Wild Cards{} retrigger",
                    "{C:attention}#1#{} additional time(s)",
                    "for each {C:attention}King{} in your hand",
                    "{C:inactive}(Currently: #2# King(s))"
                }
            },
            j_kino_truman_show = {
                name = "The Truman Show",
                text = {
                    {"Gain the current ratings",
                    "as {C:chips}Chips"},
                    {"Ratings improve when",
                    "you do exciting or",
                    "flashy plays"},
                    {"Ratings worsen when",
                    "you do boring",
                    "or repeated plays"}
                }
            },
            j_kino_turner_and_hooch = {
                name = "Turner & Hooch",
                text = {
                    {"{C:attention}Inactive{}: Turner gathers",
                    "evidence equal to the number of scored suits",},
                    {"{C:attention}Active{}: Hooch gives {C:mult}+#4#{} Mult per",
                    "Evidence consumed",
                    "{C:inactive}(Currently: {C:attention}#2#{C:inactive} Evidence Collected)"}
                }
            },
            j_kino_twilight_1 = {
                name = "Twilight",
                text = {
                    {"Drain the {C:attention}Enhancement{} from",
                    "any non-romance cards played",},
                    {"{C:attention}Romance Cards{} have an",
                    "additional {X:legendary,C:white}X#2#{} when they trigger",
                    "for each card drained",
                    "{C:inactive}(Currently: {X:legendary,C:white}X#1#{C:inactive})"}
                }
            },
            j_kino_twins = {
                name = "Twins",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
                    "if played hand contains",
                    "exactly {C:attention}2 Cards"
                }
            },
            j_kino_up = {
                name = "Up",
                text = {
                    "Retrigger your highest",
                    "scoring card {C:attention}#1# times{}",
                    "{C:inactive}(Will target last one if multiple are present)"
                }
            },
            j_kino_us = {
                name = "Us",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult when",
                    "a {C:attention}Horror Card Awakens",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_v_for_vendetta = {
                name = "V for Vendetta",
                text = {
                    "Scored cards give {C:mult}+#2#{} Mult for",
                    "each {C:attention}5{} scored",
                    "Resets when a Face card is scored",
                    "{C:inactive}(Currently: {C:mult}+#1#{C:inactive} Mult)"
                }

            },
            j_kino_voyage_dans_le_lune = {
                name = "Le Voyage Dans le Lune",
                text={
                    "{C:green}#1# in #2#{} chance to create",
                    "a {C:planet}Planet{} card when any",
                    "{C:attention}Booster Pack{} is opened",
                    "{C:inactive}(Must have room)",
                },
            },
            j_kino_wall_e = {
                name = "Wall-E",
                text = {
                    "Gain {C:mult}+#1#{} Mult",
                    "when you discard",
                    "an Enhanced card",
                    "if it is metallic",
                    "gain {C:mult}+#2#{} Mult instead",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_kino_wall_street = {
                name = "Wall Street",
                text = {
                    {"When you discard a card, ",
                    "increase the sell value",
                    "of this joker by {C:money}$#1#",},
                    {"When you play a hand",
                    "{C:green}#2# in #3#{} chance to ",
                    "divide the sell value by {C:attention}#4#"}
                }
            },
            j_kino_wicker_man = {
                name = "The Wicker Man (2006)",
                text = {
                    "If {C:attention}first discard{} of round",
                    "has only {C:attention}1{} card, destroy",
                    "it and gain {C:mult}Mult{} equal to its",
                    "Chips, resets upon",
                    "defeating {C:attention}Boss Blind",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                }
            },
            j_kino_war_of_the_worlds = {
                name = "War of the Worlds",
                text = {
                    "When you select a blind",
                    "destroy every {C:attention}Planet{}",
                    "you have, and gain {C:chips}+#1#{} Hand(s)",
                    "or {C:mult}+#2#{} Discard(s) for each"
                }
            },
            j_kino_warriors = {
                name = "The Warriors",
                text = {
                    "Cards give {C:mult}+#1#{} Mult",
                    "for each card held in hand that",
                    "shares a suit"
                }
            },
            j_kino_waterworld = {
                name = "Waterworld",
                text = {
                    "Increase the sell value",
                    "of a random joker",
                    "by {C:money}$#1#{} for",
                    "each unscoring card"
                }
            },
            j_kino_west_side_story_1 = {
                name = "West Side Story (1961)",
                text = {
                    {
                    "{C:chips}Jets:",    
                    "Gives {C:chips}+#1#{} Chips",
                    "if scoring hand has more {C:spades}Spades and {C:clubs}Clubs{}",},

                    {
                    "{C:red}Sharks:",
                    "Gives {C:mult}+#2#{} Mult",
                    "if it has more {C:hearts}Hearts{} and {C:diamonds}Diamonds"}
                }
            },
            j_kino_when_harry_met_sally = {
                name = "When Harry Met Sally",
                text = {
                    "Scores cards give {X:mult,C:chips}X#1#{} Mult",
                    "if they share rank",
                    "with a card held in hand"
                }
            },
            j_kino_wizard_of_oz = {
                name = "The Wizard of Oz",
                text = { 
                    "Scored {C:attention}Wild Cards{}",
                    "give {X:mult,C:white}X#1#{} Mult"
                }
            },
            j_kino_wolf_man_1 = {
                name = "The Wolf Man (1941)",
                text = {
                    "{X:mult,C:white}X#1#{} Mult when",
                    "a Horror card {C:attention}Awakens",
                }
            },
            j_kino_wonka = {
                name = "Wonka",
                text = {
                    "{C:red}+#1#{} Mult per {C:attention}Confection{}",
                    "card used this run",
                    "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
                }
            },
            j_kino_yes_man = {
                name = "Yes Man",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult",
                    "when you play a hand",
                    "Destroys itself if", 
                    "you {C:attention}discard{}",
                    "{C:inactive}(Currently: {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            j_kino_young_frankenstein = {
                name = "Young Frankenstein",
                text = {
                    "Whenever you solve",
                    "the {C:attention}Codex{}",
                    "upgrade every scoring card",
                    "with {C:mult}+#1#{} Mult"
                }
            },
            j_kino_your_highness = {
                name = "Your Highness",
                text = {
                    "After obtaining #3# consumables",
                    "the next consumable obtained",
                    "will become negative",
                    "{C:inactive}(Will trigger after #4# cards)"
                }
            },
            j_kino_zardoz = {
                name = "Zardoz",
                text = {
                    {"{C:attention}Stone Cards{} give",
                    "{X:mult,C:white}X#1#{} Mult"},
                    {"Increases by {X:mult,C:white}X#2#{} Mult",
                    "whenever a card is destroyed"}
                }
            },
            j_kino_zodiac = {
                name = "Zodiac",
                text = {
                    "Whenever you solve",
                    "the {C:attention}Codex{}",
                    "gain a Stack",
                    "Lower the next boss blind",
                    "to {C:attention}#1#%{} per stack used",
                    "{C:inactive}(Currently: {C:attention}#2#{C:inactive} Stacks)"
                }
            },
            -- Crossmod: CRYPTID
            j_kino_human_centipede = {
                name = "The Human Centipede (First Sequence)",
                text = {
                    "Each scoring card gives {X:dark_edition,C:white}^#1#{} Mult",
                    "increased by {{X:dark_edition,C:white}#2#{} Mult for each",
                    "scoring card to the left of it",
                    "if played hand",
                    "contains a {C:attention}Straight{}",
                }
            },
            j_kino_shrek_1  = {
                name = "Shrek",
                text = {
                    "Every {C:attention}3rd time{} you",
                    "trigger {C:mult}+mult{} or {X:mult,C:white}xMult{}",
                    "turn it into {X:mult,C:white}xMult{} or {X:dark_edition,C:white}^Mult{}"
                }
            },
            j_kino_beemovie = {
                name = "Bee Movie",
                text = {
                    "Create #1# negative {C:attention}Honeycombs{}",
                    "when you {C:attention}Select a Blind"
                }
            },
            j_kino_beemovie_honeygrate = {
                name = "Honeycomb",
                text = {
                    "{X:dark_edition,C:white}^#1#{}",
                    "increased by {X:dark_edition,C:white}^#2#{} per",
                    "{C:attention}Honeycomb{} you got rid off this game",
                    "{C:inactive}(Currently: #3# Honeycombs removed)"
                }
            },
            -- Legendaries
            j_kino_2001_odyssey = {
                name = "2001: A Space Odyssey",
                text = {
                    "When you use a {C:planet}Planet",
                    "{C:attention}Upgrade{} every {C:attention}Sci-Fi",
                    "{C:attention}card{} in your deck"
                }
            },
            j_kino_indiana_jones_1 = {
                name = "Raiders of the Lost Ark",
                text = {
                    "Gain {X:mult,C:white}X#1#{} Mult",
                    "when a {C:attention}#3#{} scores,",
                    "card changes every round",
                    "{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            },
            j_kino_barbie = {
                name = "Barbie",
                text = {
                    "Each {C:attention}Face Card{}",
                    "held in hand",
                    "gives {X:mult,C:white}X1{} + {X:mult,C:white}X#1#{} Mult",
                    "for each scoring {C:attention}Queen{}"
                }
            },
            j_kino_ratatouille = {
                name = "Ratatouille",
                text = {
                    "When you select a blind",
                    "destroy a non-active {C:mult}Confection{} and {C:attention}Upgrade",
                    "every future Confection's values with {C:attention}+#1#"
                }
            },
            j_kino_citizen_kane = {
                name = "Citizen Kane",
                text = {
                    "Gain {X:mult,C:white}X#1#{} Mult mult when you",
                    "Play or Discard a hand",
                    "and double the gain until",
                    "the end of the round",
                    "{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            }

        },
        Enhanced = {
            m_kino_action = {
                name = "Action Card",
                text = {
                    "Retrigger this card",
                    "once for each",
                    "Bullet in your Magazine",
                    "{C:attention}While in Hand:{} Counts",
                    "as 1 Bullet"
                }
            },
            m_kino_crime = {
                name = "Crime Card",
                text = {
                    "Lower sell value of",
                    "a random Joker or Consumable",
                    "by {C:money}$#1#{} to earn {C:money}$#2#"
                }
            },
            m_kino_sci_fi = {
                name = "Sci-Fi Card",
                text = {
                    "Gains {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips",
                    "whenever this card gets scored",
                    "{C:inactive}(Upgraded {C:attention}#6#{C:inactive} times)",
                    "{C:mult}+#4#{} extra mult",
                    "{X:mult,C:white}X#5#{} extra mult"
                }
            },
            m_kino_demonic = {
                name = "Demonic Card",
                text = {
                    "Sacrifices the lowest scoring",
                    "{C:attention}non-Demon card",
                    "{X:mult,C:white}X#1#{} + {X:mult,C:white}X#3#{} for each",
                    "non-Demonic scored card"
                }
            },
            m_kino_romance = {
                name = "Romance Card",
                text = {
                    "If a played hand contains",
                    "exactly 2 scoring {C:attention}Romance Cards{}",
                    "The first will give {X:chips,C:white}X#1#{} Chips",
                    "and the second {X:mult,C:white}X#2#{} Mult"
                }
            },
            m_kino_horror = {
                name = "Horror Card",
                text = {
                    "{C:chips}+#1#{} extra Chips",
                    "",
                    "While held in hand",
                    "{C:green}#2# in #3#{} Chance to",
                    "{C:attention}Awaken{} per turn held in hand"
                }
            },
            m_kino_monster = {
                name = "Monster Card",
                text = {
                    "{C:attention}Cannot be Discarded{}",
                    "",
                    "Returns to slumber",
                    "after scoring"
                }
            },
            m_kino_flying_monkey = {
                name = "Flying Monkey",
                text = {
                    "Minion of the Wicked Witch",
                    "{X:chips,C:white}X#1#{} Chips",
                    "{X:mult,C:white}X#2#{} Mult",
                    "Self-destruct after #3# hands"
                }
            },
            
            m_kino_mystery = {
                name = "Mystery Card",
                text = {
                    {"{X:mult,C:white}x#1#{} Mult",
                    "Increased by {X:mult,C:white}x#2#{} when",
                    "the card is scored",
                    "adjacent to Suspect card",},
                    {
                        "SUSPECT:",
                        "Suit: {V:1}#3#{}",
                        "Rank: {C:attention}#4#{}"
                    }
                }
            },
            m_kino_fantasy = {
                name = "Fantasy Card",
                text = {
                    "Casts a {C:purple,E:1}Spell{}",
                    "when scored based on",
                    "the first three cards",
                    "held in your hand"
                }
            },
            m_kino_superhero = {
                name = "Superhero Card",
                text = {
                    "Has {X:mult,C:white}X#1#{} Mult",
                    "per played hand",
                    "this round",
                    "{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            },

            -- Crossmod enhanced
            -- Morefluff
            m_kino_error = {
                name = "name = 'ERROR'",
                text = {
                    "text = {",
                    "[c:chips]x#1#[] Chips while",
                    "held in hand",
                    "held in hand",
                    "print('testdebugerrorcard')",
                    "}"
                }
            },
            m_kino_wifi = {
                name = "Wi-fi Card",
                text = {
                    "Gives chips equal",
                    "to the rank of all",
                    "other Wi-fi cards in",
                    "your deck",
                    "{C:inactive}(Currently: {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            m_kino_angelic = {
                name = "Angelic Card",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "card held in hand",
                    "{C:green}#2# in #3#{} chance",
                    "to create an {C:attention}Angelic{} copy",
                    "of a random card from your full deck",
                    "to your hand"
                }
            },
            m_kino_finance = {
                name = "Finance Card",
                text = {
                    "When this card scores",
                    "start {C:green}INVESTING ALL YOUR {C:money}MONEY",
                    "If you already are",
                    "pay out your investment",
                    "{C:inactive}(Current investment: {C:money}$#2#{C:inactive} for #1# Rounds)"
                }
            },
            m_kino_factory = {
                name = "Factory Card",
                text = {
                    "Gathers materials from scoring cards",
                    "and creates a consumable when",
                    "#1# of any materials are gathered",
                    "{C:inactive}(Does not need room)",
                }
            },
            m_kino_time = {
                name = "Time Card",
                text = {
                    "Gives {C:chips}+#1#{} Chips",
                    "going down by {C:chips}+#2#{} Chips",
                    "every {C:attention}5 seconds since it was drawn",
                    "{C:inactive}(Currently: {C:chips}+#3#{C:inactive} Chips)"
                }
            },
            m_kino_fraction = {
                name = "Fraction Card",
                text = {
                    "Gives {C:mult}+(X/Y){} Mult",
                    "Where X is the chips total of",
                    "the card to the left and Y is",
                    "this card's chip total",
                    "{C:inactive}(Currently: {C:mult}+#2#/#1#{C:inactive} Mult)"
                }
            }


        },
        Tarot = {
            c_kino_slasher = {
                name = "Slasher",
                text = {
                    "Upgrade #1# cards into ",
                    "{C:attention}Horror cards{}"
                }
            },
            c_kino_droid = {
                name = "Droid",
                text = {
                    "Upgrade #1# cards into",
                    "{C:attention}Sci-fi Cards{}"
                }
            },
            c_kino_demon = {
                name = "Demon",
                text = {
                    "Upgrade #1# card into",
                    "a {C:attention}Demonic Card{}"
                }
            },
            c_kino_meetcute = {
                name = "Meetcute",
                text = {
                    "Upgrade #1# cards into",
                    "{C:attention}Romance Cards{}"
                }
            },
            c_kino_detective = {
                name = "Detective",
                text = {
                    "Upgrade #1# cards into",
                    "{C:attention}Mystery Cards{}"
                }
            },
            c_kino_witch = {
                name = "Witch",
                text = {
                    "Upgrade #1# card into",
                    "a {C:attention}Fantasy Card{}"
                }
            },
            c_kino_gangster = {
                name = "Gangster",
                text = {
                    "Upgrade #1# cards into",
                    "{C:attention}Crime Cards{}"
                }
            },
            c_kino_soldier = {
                name = "Soldier",
                text = {
                    "Upgrade #1# cards into",
                    "{C:attention}Action Cards{}"
                }
            },
            c_kino_superhero = {
                name = "Superhero",
                text = {
                    "Upgrade #1# card into",
                    "a {C:attention}Superhero Card{}"
                }
            },

            c_kino_producer = {
                name = "Producer",
                text = {
                    "Invest {C:money}$#2#{} into",
                    "selected {C:attention}Movie Joker",
                    "and receive potential {C:money}Profit",
                    "based on its success",
                    "{C:inactive}(Max of {C:money}$#1#{C:inactive})"
                }
            },
            
            c_kino_investor = {
                name = "Investor",
                text = {
                    "Add a {C:green}Money Counter{}",
                    "to random card", 
                    "in your deck {C:attention}#1#{} times"
                }
            },

            c_kino_chef = {
                name = "Chef",
                text = {
                    "Creates up to {C:attention}#1#",
                    "random {C:attention}Confection{} cards",
                    "{C:inactive}(Must have room)",
                }
            }


        },
        Spectral = {
            c_kino_award = {
                name = "Award",
                text = {
                    "Give an award to a {C:attention}Movie Joker",
                    "doubling it's stats",
                    "{C:inactive}(Movie Jokers can only be awarded once)"
                }
            },
            c_kino_homerun = {
                name = "Homerun",
                text = {
                    "Add a {C:red}Sports Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                }
            },
            c_kino_gathering = {
                name = "Gathering",
                text = {
                    "Add a {C:red}Family Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                }
            },
            c_kino_artifact = {
                name = "Artifact",
                text = {
                    "Add a {C:red}Adventure Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                }
            },
            c_kino_fright = {
                name = "Fright",
                text = {
                    "Add a {C:red}Thriller Seal{}",
                    "to {C:attention}3{} selected",
                    "cards in your hand",
                }
            },
            c_kino_whimsy = {
                name = "Whimsy",
                text = {
                    "Add a {C:red}Comedy Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand"
                }
            },
            c_kino_ambrosia = {
                name = "Ambrosia",
                text = {
                    "Add a {C:red}Cheese Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                }
            },

            -- Cryptid crossmod
            c_kino_award_cryptid = {
                name = "Award",
                text = {
                    "Give an award to any {C:attention}Joker",
                    "doubling it's stats",
                    "{C:inactive}(Jokers can only be awarded once)"
                }
            },
        },
        Planet = {
            c_kino_ego = {
                name = "Ego, the Living Planet",
                text = {
                    "Upgrade a random hand",
                    "with {C:chips}+#1#{} Chips",
                    "and {C:mult}+#2#{} Mult"
                }
            },
            c_kino_pandora = {
                name = "Pandora",
                text = {
                    "Upgrade your most",
                    "played hand with",
                    "{C:chips}+#1#{} Chips ",
                    "for each time",
                    "it's been played"
                }
            },
            c_kino_arrakis = {
                name = "Arrakis",
                text = {
                    "Upgrade your least played",
                    "hand with {X:chips,C:white}X2{} and {X:mult,C:white}X2{}"
                }
            },
            c_kino_krypton = {
                name = "Krypton",
                text = {
                    "Double the level of",
                    "your most played hand",
                    "{C:green}#1# in #2#{} chance to",
                    "set it to 1 instead",
                    "Chances doubles for every", 
                    "Krypton you've played",
                    "{C:inactive}(Currently: #3# Kryptons played.){}"
                }
            },
            c_kino_cybertron = {
                name = "Cybertron",
                text = {
                    "Upgrade a random hand",
                    "with {X:mult,C:white}X#1#{} for",
                    "each time a Sci-fi card was upgraded",
                    "last round",
                    "{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive})"
                }
            },
            c_kino_lv426 = {
                name = "LV-426",
                text = {
                    "Level up your most",
                    "played hand and debuff",
                    "two random cards in deck"
                }
            },
            c_kino_death_star= {
                name = "Death Star",
                text = {
                    "Destroy a random joker",
                    "to {C:attention}Level Up",
                    "every hand",
                    "{C:inactive}(Cannot target the left-most joker)"
                }
            },
        },
        confection = {
            c_kino_popcorn = {
                name = "Popcorn Snack",
                text = {
                    "Upgrade the next",
                    "hand you play with",
                    "{C:mult}+#1#{} Mult"
                }
            },
            c_kino_icecream = {
                name = "Ice Cream Snack",
                text = {
                    "Upgrade the next",
                    "hand you play with",
                    "{C:chips}+#1#{} Chips"
                }
            },
            c_kino_candy = {
                name = "Candy Snack",
                text = {
                    "Gain {C:attention}+#1#{} hand size",
                    "next round",
                }
            },
            c_kino_peanuts = {
                name = "Peanut Snack",
                text = {
                    "Gain {C:money}$#1# more{} interest",
                    "next round"
                }
            },
            c_kino_pizza = {
                name = "Pizza Slice",
                text = {
                    "{C:inactive}Quatro Formaggi{}",
                    "The first card of",
                    "each suit retriggers",
                    "{C:attention}#1#{} times next hand"
                }
            },
            c_kino_soda = {
                name = "Soda Drink",
                text = {
                    "{C:attention}Retrigger{} the first",
                    "card scored {C:attention}#1# times{}",
                    "next round"
                }
            },
            c_kino_chocolate_bar = {
                name = "Chocolate Bar",
                text = {
                    "Draw {C:attention}#1#{} cards"
                }
            },
            c_kino_fries = {
                name = "Fries",
                text = {
                    "Upgrade the next card",
                    "scored with {C:chips}+#1#{} Chips"
                }
            },
            c_kino_hotdog = {
                name = "Hotdog",
                text = {
                    "Level up the next",
                    "hand played by {C:attention}#1#"
                }
            },
            c_kino_cookie = {
                name = "Cookie",
                text = {
                    "Gain {C:chips}+1{}",
                    "hand this round"
                }
            },
            c_kino_gum = {
                name = "Chewing Gum",
                text = {
                    "Gain {C:mult}+1{}",
                    "discard this round"
                }
            },
            c_kino_chips = {
                name = "Chips",
                text = {
                    "Upgrade every {C:attention}Sci-fi Card",
                    "held in hand",
                    "next hand"
                }
            },
            c_kino_sourcandy = {
                name = "Sour Candy",
                text = {
                    "{C:green}#1# in #2#{} Chance to destroy",
                    "each scoring card next hand",
                    "lower chances by 1 for each",
                    "additional scoring card"
                }
            },
            c_kino_candycorn = {
                name = "Candy Corn",
                text = {
                    "Cards held in hand have",
                    "a {C:green}#1# in #2#{} Chance to",
                    "{C:attention}Jumpscare",
                    "{C:inactive}(Does not get eaten if",
                    "{C:inactive}no cards jumpscare)"
                }
            },
            c_kino_dno_nugget = {
                name = "D.N.O. Nugget",
                text = {
                    "Add {C:attention}#1#{} copy",
                    "of the first scoring card",
                    "to your hand"
                }
            },
            c_kino_garlic_bread = {
                name = "Garlic Bread",
                text = {
                    "Increase the sell value",
                    "of every owned joker",
                    "by {C:money}$#1#"
                }
            },
            c_kino_magic_beans = {
                name = "Magic Beans",
                text = {
                    "Cast a spell based",
                    "on the first three cards",
                    "held in hand",
                    "hext hand"
                }
            },
            c_kino_ratatouille = {
                name = "Ratatouille Snack",
                text = {
                    "Permanently {C:attention}increase",
                    "the value of all",
                    "confections by {C:attention}#1#",
                    "{C:inactive}(Except for Ratatouille)"
                }
            },
            c_kino_snackbag = {
                name = "Snack Bag",
                text = {
                    "A Bag filled",
                    "with {C:mult}Confections{}",
                    "{C:inactive}(Currently: {C:attention}#1#{C:inactive} Confections)"
                }
            },
            -- CROSSMOD Confections
            c_kino_mam = {
                name = "M&M's",
                text = {
                    "Create {C:attention}#1#{} {C:dark_edition}Negative{}",
                    "Jolly Joker(s) for each",
                    "Pair in your next hand"
                }
            },
            c_kino_nutrition = {
                name = "Nutrition Pulp",
                text = {
                    "Permanently boost the power",
                    "of your leftmost joker",
                    "by {C:attention}#1#%{}",
                    "next hand"

                }
            },
            c_kino_monster_energy = {
                name = "Monster Energy",
                text = {
                    "Retrigger a random",
                    "joker {C:attention}#1#{} times",
                    "next hand"
                }
            }
        },
        Rotarot = {
           c_kino_rot_slasher = {
                name = "The Slasher!",
                text = {
                    "Enhances {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}#2#s"
                }   
            },
            c_kino_rot_droid = {
                name = "The Droid!",
                text = {
                    "Enhances {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}#2#s"
                }   
            },            
            c_kino_rot_demon = {
                name = "The Demon!",
                text = {
                    "Enhances {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}#2#s"
                }   
            },
            c_kino_rot_meetcute = {
                name = "The Meetcute!",
                text = {
                    "Enhances {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}#2#s"
                }   
            },
            c_kino_rot_witch = {
                name = "The Witch!",
                text = {
                    "Enhances {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}#2#s"
                }   
            },
            c_kino_rot_gangster = {
                name = "The Gangster!",
                text = {
                    "Enhances {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}#2#s"
                }   
            },
            c_kino_rot_soldier = {
                name = "The Soldier!",
                text = {
                    "Enhances {C:attention}#1#",
                    "selected cards to",
                    "{C:attention}#2#s"
                }   
            },
            c_kino_rot_producer = {
                name = "The Producer!",
                text = {
                    "Set your money equal",
                    "to the Box Office of",
                    "a selected movie joker",
                    "divided by {C:money}1 Million{}"
                }   
            },
            c_kino_rot_chef = {
                name = "The chef!",
                text = {
                    "Strengthen all {C:mult}Confections{}"
                }   
            },

        },
        Back = {
            b_kino_spooky = {
                name = "Spooky Deck",
                text = {
                    "{C:attention}Horror jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with a {C:attention}The Slasher{}",
                    "and a {C:attention}The Demon"
                }
            },
            b_kino_tech = {
                name = "Tech_Deck",
                text = {
                    "{C:attention}Sci-fi jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Droid{}"
                }
            },
            b_kino_flirty = {
                name = "Flirty Deck",
                text = {
                    "{C:attention}Romance jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Meetcute{}"
                }
            },
            b_kino_questionable = {
                name = "Questionable Deck",
                text = {
                    "{C:attention}Mystery jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Detective{}"
                }
            },
            b_kino_enchanted = {
                name = "Enchanted Deck",
                text = {
                    "{C:attention}Fantasy jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Witch{}"
                }
            },
            b_kino_illicit = {
                name = "Illicit Deck",
                text = {
                    "{C:attention}Crime jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Gangster{}"
                }
            },
            b_kino_dangerous = {
                name = "Dangerous Deck",
                text = {
                    "{C:attention}Action jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Soldier{}"
                }
            },
            b_kino_heroic = {
                name = "Heroic Deck",
                text = {
                    "{C:attention}Superhero jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Superhero{}"
                }
            },

            b_kino_athletic = {
                name = "Athletic Deck",
                text = {
                    "{C:attention}Sports jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Homerun{}"
                }
            },
            b_kino_childlike = {
                name = "Childlike Deck",
                text = {
                    "{C:attention}Family jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Gathering{}"
                }
            },
            b_kino_adventurous = {
                name = "Adventurous Deck",
                text = {
                    "{C:attention}Adventure jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Artifact{}"
                }
            },
            b_kino_highpressure = {
                name = "High Pressure Deck",
                text = {
                    "{C:attention}Thriller jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Fright{}"
                }
            },
            b_kino_funny = {
                name = "Funny Deck",
                text = {
                    "{C:attention}Comedy jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Whimsy{}"
                }
            },

            
            b_kino_bacon = {
                name = "Bacon Deck",
                text = {
                    "{C:attention}Movie Jokers{} are",
                    "{C:attention}50%{} stronger if",
                    "they share {C:attention}Cast or",
                    "{C:attention}Director{} with adjacent",
                    "Jokers"
                }
            },
            b_kino_northernlion = {
                name = "Egg Deck",
                text = {
                    "{C:inactive,E:1}That's a {C:Romance,E:1}Romance!",
                    "{C:inactive,E:1}they flirt in scene 19!",
                    "{C:attention}Movie Jokers{} always count",
                    "as {C:Romance}Romance Jokers{}"
                }
            },
            b_kino_c2n = {
                name = "Cine2Nerdle Deck",
                text = {
                    "If you own a {C:attention}Movie Joker",
                    "then all jokers that spawn",
                    "will share cast with your",
                    "current jokers"
                }

            },
            b_kino_producer = {
                name = "Producer Deck",
                text = {
                    "Earn no money from",
                    "blinds or interest",
                    "After defeating a {C:attention}Boss Blind",
                    "each {C:attention}Movie Joker{} pays out",
                    "based on it's {C:attention}Profit Margin"
                }
            },
            b_kino_blankcheck = {
                name = "Blank Deck with Griffin & David",
                text = {
                    "When you buy a {C:attention}Movie Joker",
                    "the next jokers that spawn",
                    "in the shop or buffoon packs",
                    "will be the other {C:attention}Movie Jokers",
                    "from the same {C:attention}Director{}",
                    "in order of release date"

                }
            },
            b_kino_snackdeck = {
                name = "Snack Deck",
                text = {
                    "Start your run with the",
                    "{C:attention}Special Treats{} and",
                    "{C:attention}Snack Bag{} vouchers"
                }
            },
            b_kino_trophydeck = {
                name = "Winner's Deck",
                text = {
                    "Start your run with the",
                    "{C:attention}Award's Bait{} and",
                    "and {C:attention}Award Show{} vouchers"
                }
            },
            b_kino_investment = {
                name = "Investment Deck",
                text = {
                    "Earn no money from",
                    "blinds or interest",
                    "When you defeat a Blind",
                    "put a {C:green}Money Counter",
                    "on {C:attention}10{} random cards",
                    "in your deck"
                }
            },
            b_kino_darkknight = {
                name = "Dark Knight Deck",
                text = {
                    "{C:attention}Batman jokers{} are twice",
                    "as common",
                    "{C:attention}Jokers{} have a {green}1 in 4{}",
                    "chance to spawn with a {C:attention}Robin sticker"
                }
            },
            b_kino_spellslinger = {
                name = "Spellslinger's Deck",
                text = {
                    "First scoring card",
                    "casts a spell based",
                    "on the first three cards",
                    "in hand when a hand is played"
                }
            },
            b_kino_deckthatmakesyouold = {
                name = "Deck That Makes You Old",
                text = {
                    "When a card is scored",
                    "increase the rank",
                    "of every card held",
                    "in hand that shares a Suit"
                }
            },
            b_kino_alderaan = {
                name = "Alderaan Deck",
                text = {
                    "{C:attention}Star Wars Jokers{} are",
                    "2x as common",
                    "When you defeat a blind",
                    "level up a random hand",
                    "for each unused {C:mult}Discard"
                }
            },
            b_kino_cosmonaut = {
                name = "Cosmonaut's Deck",
                text = {
                    "{C:planet}Planets{} with an associated",
                    "hand type won't spawn naturally"
                }
            },
            b_kino_empowered = {
                name = "Empowered Deck",
                text = {
                    "{C:attention}Face Cards{} of each",
                    "suit start with the same",
                    "random {C:attention}Enhancement"
                }
            },



            -- Cryptid Crossmod decks
            b_kino_snackdeck_cryptid = {
                name = "Snack Deck",
                text = {
                    "Start your run with the",
                    "{C:attention}Special Treats{}, {C:attention}Snack Bag{},",
                    "and {C:attention}Heavenly Treats{} vouchers"
                }
            },
            b_kino_trophydeck_cryptid = {
                name = "Trophy Deck",
                text = {
                    "Start your run with the",
                    "{C:attention}Award's Bait{}, {C:attention}Award Show{},",
                    "and {C:attention}EGOT Winner{} vouchers"
                }
            }
        },
        Blind = {
            bl_kino_hannibal = {
                name = "Dr. Hannibal Lecter",
                text = {
                    "Destroy all cards",
                    "held in hand",
                    "when you defeat",
                    "this blind"
                }
            },
            bl_kino_vader = {
                name = "Darth Vader",
                text = {
                    "{C:attention}Force Choke{} the",
                    "joker in your Active slot",
                    "weakening it by {C:attention}33%",
                    "each round",
                    "After being {C:attention}Force Choked",
                    "three times, destroy the joker"
                }
            },
            bl_kino_mama = {
                name = "Ma-Ma",
                text = {
                    "Decrease base mult",
                    "by {C:mult}#1#{} and",
                    "chips by {C:chips}#2#{}",
                    "for each {C:attention}Consumable{}",
                    "used this run"
                }
            },
            bl_kino_cruella = {
                name = "Cruella De Vil",
                text = {
                    "Decrease base mult",
                    "by {C:mult}#1# for",
                    "each card destroyed",
                    "this run"
                }
            },
            bl_kino_voldemort = {
                name = "Voldemort",
                text = {
                    "Cast an {C:green}Evil Spell",
                    "based on the first",
                    "three cards held",
                    "in hand"
                }
            },
            bl_kino_gekko = {
                name = "Gordon Gekko",
                text = {
                    "Each card scored",
                    "has a {C:green}#1# in #2#{}",
                    "chance to either earn $5",
                    "or gain 3 {C:attention}Debt Counters{}"
                }
            },
            bl_kino_pazuzu = {
                name = "Pazuzu",
                text = {
                    "Possesses the last",
                    "hand type you played",
                    "When you play a Possessed",
                    "hand type, set its level",
                    "to 1"
                }
            },
            bl_kino_xenomorph = {
                name = "Xenomorph Queen",
                text = {
                    "Each card has a ",
                    "{C:green}#1# in #2#{} chance",
                    "to be debuffed when Scored"
                }
            },
            bl_kino_bonnieandclyde = {
                name = "Bonnie & Clyde",
                text = {
                    "Hands containing a",
                    "{C:attention}#1#{} or a",
                    "{V:1}#2#{} will",
                    "not score"
                }
            },
            bl_kino_dracula = {
                name = "Count Dracula",
                text = {
                    "Debuff each {C:attention}Enhanced",
                    "card played after scoring"
                }
            },
            bl_kino_wickedwitch = {
                name = "The Wicked Witch",
                text = {
                    "Whenever you discard",
                    "add 2 Flying Monkeys",
                    "to your deck"
                }
            },
            bl_kino_frankbooth = {
                name = "Frank Booth",
                text = {
                    "After your first hand",
                    "destroy your third Joker",
                    "after you play a hand"
                }
            },
            bl_kino_joker = {
                name = "The Joker",
                text = {
                    "A random Joker",
                    "becomes {C:attention}Joker",
                    "every second hand",
                    "played"
                }
            },
            bl_kino_hansgruber = {
                name = "Hans Gruber",
                text = {
                    "Joker lose {C:money}$2{}",
                    "Sell Value when triggered",
                    "If their value is {C:money}$0",
                    "or lower, put a Debuff Counter",
                    "on it instead"
                }
            },
            bl_kino_blofeld = {
                name = "Ernst Stavro Blofeld",
                text = {
                    "If your played hand",
                    "is as big or larger than",
                    "your previous hand",
                    "it doesn't score"
                }
            },
            bl_kino_loki = {
                name = "Loki",
                text = {
                    "A random suit is",
                    "debuffed each hand"
                }
            },
            bl_kino_ratched = {
                name = "Nurse Ratched",
                text = {
                    "Played hands only score",
                    "if you hold {C:attention}3{} different",
                    "suits in hand"
                }
            },
            bl_kino_rico_dynamite = {
                name = "Rico Dynamite",
                text = {
                    "Played poker hand loses 2 levels",
                    "and two random poker hands",
                    "gain 1 level"
                }
            },
            bl_kino_mr_chow = {
                name = "Mr. Chow",
                text = {
                    "Each scoring card",
                    "gains 2 {C:attention}Debt counters"
                }
            },
            bl_kino_deckard_shaw = {
                name = "Deckard Shaw",
                text = {
                    "Discards a random card from hand",
                    "every 5 seconds"
                }
            },
            bl_kino_entity = {
                name = "An Entity",
                text = {
                    "Cards have a {C:green}#1# in #2#{}", 
                    "chance to become a",
                    "random rank and suit"
                }
            },
            bl_kino_humungus = {
                name = "Lord Humungus",
                text = {
                    "Discard #1# cards from top",
                    "of deck when you Play or Discard"
                }
            },
            bl_kino_amadeus = {
                name = "W. Amadeus Mozart",
                text = {
                    "Lower base mult",
                    "by the combined levels",
                    "of all hands besides",
                    "the played hand"
                }
            },
            bl_kino_sallie_tomato = {
                name = "Sallie Tomato",
                text = {
                    "When you discard",
                    "put #1# {C:attention}Debt Counter",
                    "on #2# cards held",
                    "in hand"
                }
            },
            bl_kino_agent_smith = {
                name = "Agent Smith",
                text = {
                    "Cards are debuffed",
                    "unless a card of the same",
                    "rank is discarded"
                }
            },
            bl_kino_anton_chigurh = {
                name = "Anton Chigurh",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "put {C:attention}Stun Counters{} equal",
                    "to your current hands",
                    "on your left-most Joker",
                    "when a hand is played"
                }
            },
            bl_kino_beachthatmakesyouold = {
                name = "Beach That Makes You Old",
                text = {
                    "Every #1# seconds, increase the rank",
                    "of a random card in your hand",
                    "or destroy it if it's an Ace"
                }
            },
            bl_kino_pgande = {
                name = "PG&E",
                text = {
                    "Put 2 {C:green}Poison Counters",
                    "on each card held in hand",
                    "when a hand is played"
                }
            },
            bl_kino_clubber =  {
                name = "Clubber Lang",
                text = {
                    "When you discard",
                    "put a Chain card on every",
                    "card in hand"
                }
            },
            bl_kino_thanos = {
                name = "Thanos",
                text = {
                    "Half your cards are debuffed",
                    "and alternate each hand"
                }
            },
            bl_kino_immortan_joe = {
                name = "Immortan Joe",
                text = {
                    "Discard a card from top",
                    "of deck for each card Played or Discarded"
                }
            },
            bl_kino_palpatine = {
                name = "Emperor Palapatine",
                text = {
                    "{C:attention}Force Choke{} every",
                    "joker, weakening it",
                    "by {C:attention}20% each round",
                    "After being {C:attention}Force Choked",
                    "five times, destroy the joker"
                }
            },
            bl_kino_dr_evil = {
                name = "Dr. Evil",
                text = {
                    "Each subsequent hand",
                    "must be larger than",
                    "the previous hand"
                }
            }
        },
        Tag = {
            tag_kino_dinner = {
                name = "Dinner Tag",
                text = {
                    "Upgrades all future",
                    "{C:mult}Confections{} with",
                    "+1 values"
                }
            },
            tag_kino_snacktag = {
                name = "Snack Tag",
                text = {
                    "Gives a free",
                    "{C:tarot}Mega Snack Pack",
                }
            },
            tag_kino_oscar = {
                name = "Oscar Tag",
                text = {
                    "Upgrades one viable",
                    "joker with an Award"
                }
            },
            tag_kino_counter = {
                name = "Counter Tag",
                text = {
                    "Adds 3 {C:green}Money Counters",
                    "to 5 random cards",
                    "in your deck"
                }
            }
        },
        Quest = {

        },
        Other =  {
            -- Booster packs
            p_kino_horror_booster = {
                name = "Horror Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Horror Jokers{}",
                },
            },
            p_kino_action_booster = {
                name = "Action Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Action Jokers{}",
                },
            },
            p_kino_sci_fi_booster = {
                name = "Sci-fi Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Sci-fi Jokers{}",
                },
            },
            p_kino_comedy_booster = {
                name = "Comedy Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Comedy Jokers{}",
                }
            },
            p_kino_romance_booster = {
                name = "Romance Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Romance Jokers{}",  
                }
            },
            p_kino_fantasy_booster = {
                name = "Fantasy Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Fantasy Jokers{}",  
                }
            },
            p_kino_actor_booster = {
                name = "Actor Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Movie Jokers{}",
                    "that will share cast with",
                    "your current jokers"

                }
            },
            p_kino_snack_booster_normal = {
                name = "Snack Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Confections{}",
                    "{C:inactive}(Must have room)"
                }
            },
            p_kino_snack_booster_jumbo = {
                name = "Jumbo Snack Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Confections{}",
                    "{C:inactive}(Must have room)"
                }
            },
            p_kino_snack_booster_mega = {
                name = "Mega Snack Pack",
                text = {
                    "Choose {C:attention}#1#{} of",
                    "up to {C:attention}#2# Confections{}",
                    "{C:inactive}(Must have room)"
                }
            },
            
            -- Genres
            genre_1 = {
                name = "Genre",
                text = {
                    "{X:#1#,C:white}#1#{}"
                }
            },
            genre_2 = {
                name = "Genres",
                text = {
                    "{X:#1#,C:white}#1#", 
                    "{X:#2#,C:white}#2#"
                }
            },
            genre_3 = {
                name = "Genres",
                text = {
                    "{X:#1#,C:white}#1#", 
                    "{X:#2#,C:white}#2#",
                    "{X:#3#,C:white}#3#"
                }
            },

            -- Synergy System
            kino_valuechange = {
                name = "Power Boost",
                text = {
                    "Increased Power",
                    "by {C:attention}X#1#"
                }
            },
            kino_actor_synergy = {
                name = "Actor Synergy",
                text = {
                    "Has a power boost for",
                    "sharing {C:attention}#1# Actor(s)",
                    "with at least 2", 
                    "other Movie Jokers",
                }
            },

            -- Power Dampening
            output_powerchange = {
                name = "Power Dampening",
                text = {
                    "Final scoring bonuses",
                    "by this joker are",
                    "lowered by X#1#"
                }
            },

            -- Counter Tooltips
            kino_retrigger_counter = {
                name = "Retrigger Counters",
                text = {
                    "Will Retrigger",
                    "once for each",
                    "counter consumed"
                }
            },
            kino_investment_counter = {
                name = "Investment Counters",
                text = {
                    "Earn money equal",
                    "to the number of counters",
                    "then lower counters",
                    "by 1"
                }
            },
            kino_power_counter = {
                name = "Power Counters",
                text = {
                    "This card has a",
                    "{C:attention}100%{} increase",
                    "while it has counters",
                    "Remove a counter whenever",
                    "this card triggers"
                }
            },

            kino_stun_counter = {
                name = "Stun Counters",
                text = {
                    "Card is debuffed",
                    "while it has counters",
                    "Remove 1 counter",
                    "when playing a hand"
                }
            },
            kino_debt_counter = {
                name = "Debt Counters",
                text = {
                    "Lose money equal",
                    "to the number of counters",
                    "then lower counters",
                    "by 1"
                }
            },
            kino_poison_counter = {
                name = "Poison Counters",
                text = {
                    "Lower your chips and mult",
                    "by {C:attention}5%{} per counter",
                    "when triggered and lower",
                    "counters by 1"
                }
            },
            

            kino_additional_genres = {
                name = "Additional Genres",
                text = {
                    "{E:1}#1#{}"
                }
            },


            -- Keywords
            gloss_least_played = {
                name = "Least Played",
                text = {
                    "A Poker Hand must have",
                    "been played to be",
                    "considered your",
                    "least played hand"
                }
            },
            gloss_steal = {
                name = "Steal",
                text = {
                    "Lose some money and",
                    "add it to your current",
                    "{C:money}Stolen Money{}",
                    "Every played hand gains",
                    "{C:chips}+#1#{} Base Chips",
                    "{C:inactive}(Currently: {C:money}$#2# {C:inactive} stolen)"
                }
            },
            gloss_active = {
                name = "Active",
                text = {
                    "Active jokers have",
                    "specific abilities",
                    "if they're in the",
                    "{C:attention}First joker slot{}"
                }
            },
            gloss_jump_scare = {
                name = "Jumpscare",
                text = {
                    "Give {X:mult,C:white}X#1#{} and",
                    "puts 2 {C:red}Debuff Counters{}",
                    "on the card"
                }
            },
            gloss_spellcasting = {
                name = "Spellcasting",
                text = {
                    "{C:purple}Spells{} are effects",
                    "created by certain jokers",
                    "and the {C:attention}Fantasy enhancement{}",
                    "Spells can be cast at ",
                    "4 levels of power",
                    " ",
                    "{C:inactive,s:0.7}Press 's' for Spell Details"
                }
            },
            gloss_quick = {
                name = "Quick",
                text = {
                    "Power of the effect",
                    "lowers to 0 over a ",
                    "period of #1# seconds"
                }
            },
            bust_econ = {
                name = "Bust",
                text = {
                    "Set your {C:money}Money",
                    "to {C:money}$0"
                }
            },
            keyword_drain = {
                name = "Drain",
                text = {
                    "Remove the {C:attention}Enhancement",
                    "from a playing card"
                }
            },
            keyword_abduct = {
                name = "Abduct",
                text = {
                    "Store the Abducted card",
                    "in this joker",
                    "Upon defeating a {C:attention}Boss Blind",
                    "abducted cards are {C:attention}released"
                }
            },


            -- Stickers
            kino_award = {
                name = "Awarded",
                text = {
                    "Doubles the power",
                    "of Movie Joker"
                }
            },
            kino_award_cryptid = {
                name = "Awarded",
                text = {
                    "Doubles the power",
                    "of a Joker"
                }
            },
            kino_choco = {
                name = "Choco",
                text = {
                    "Increases potency",
                    "of this confection"
                }
            },
            kino_goldleaf = {
                name = "Goldleaf",
                text = {
                    "Earn {C:money}$1{} for each",
                    "goldleaf confection used",
                    "when this confection activates"
                }
            },
            kino_extra_large = {
                name = "Extra Large",
                text = {
                    "This confection has",
                    "an additional use"
                }
            },
            kino_robin = {
                name = "Robin Sticker",
                text = {
                    "This joker counts as",
                    "{C:attention}Batman"
                }
            },

            -- Consumable Types
            undiscovered_confection = {
                name = 'Not Discovered',
                text = {
                    'Purchase or use',
                    'this card in an',
                    'unseeded run to',
                    'learn what it does'
                }
            },
            kino_sports_seal={
                name="Sports Seal",
                text={
                    "If this card is the only",
                    "played card then increase",
                    "the rank of every card in hand",
                    "lower than this card by {C:attention}1 "
                },
            },
            kino_family_seal={
                name="Family Seal",
                text={
                    "When this card is played",
                    "and scored upgrade every",
                    "other scoring card with",
                    "{C:chips}+3{} Chips for",
                    "each unique scoring Suit"
                },
            },
            kino_adventure_seal = {
                name = "Adventure Seal",
                text = {
                    "Gains value for each",
                    "card scored together",
                    "with this card",
                    "Earn money equal",
                    "to the value when this card",
                    "is destroyed",
                    "{C:inactive}(Currently: {C:money}$#1#{C:inactive} Value)"
                }
            },
            kino_thriller_seal = {
                name = "Thriller Seal",
                text = {
                    "Has a {C:green}#1# in #2#{} chance",
                    "to {C:attention}Jumpscare{} while",
                    "held in hand"
                }
            },
            kino_comedy_seal = {
                name = "Comedy Seal",
                text = {
                    "Add a {C:attention}Retrigger Counter",
                    "to a random joker",
                    "when the only card",
                    "that is discarded"
                }
            },
            kino_cheese_seal = {
                name = "Cheese Seal",
                text = {
                    "Create a {C:attention}Confection",
                    "when a played hand contains",
                    "a scoring Cheese Seal"
                }
            },

            -- Quest System
            kino_questlog = {
                name = "Quests"
            },
            kino_legendary_unlock = {
                name = "Spawn Conditions"
            }
        },
        Voucher = {
            v_kino_confection_merchant = {
                name = "Confection Merchant",
                text = {
                    "{C:mult}Confection{} cards appear",
                    "{C:attention}#1#X{} more frequently",
                    "in the shop",
                }
            },
            v_kino_confection_tycoon = {
                name = "Confection Tycoon",
                text = {
                    "{C:mult}Confection{} cards appear",
                    "{C:attention}#1#X{} more frequently",
                    "in the shop",
                }
            },
            v_kino_special_treats = {
                name = "Special Treats",
                text = {
                    "{C:mult}Confections{} can appear",
                    "with additional treats"
                }
            },
            v_kino_snackbag = {
                name = "Snack Bag",
                text = {
                    "Up to 4 {C:mult}Confections{}",
                    "can stack into a {C:mult}Snack Bag",
                    "which takes up only",
                    "1 Consumable slot"
                }
            },
            v_kino_awardsbait = {
                name = "Awards Bait",
                text = {
                    "{C:attention}Movie Joker{} have a",
                    "{C:green}1 in 100{} chance",
                    "to spawn with an {C:money}Award"
                }
            },
            v_kino_awardsshow = {
                name = "Awards Show",
                text = {
                    "A random unawarded",
                    "{C:attention}Movie Joker{} gains",
                    "an {C:money}Award{} when",
                    "a {C:attention}Boss Blind{} is",
                    "defeated"
                }
            },
            v_kino_media_collection = {
                name = "Media Collection",
                text = {
                    "{C:attention}Actor and Genre{}",
                    "synergy need {C:attention}1",
                    "less joker to",
                    "synergize"
                }
            },
            v_kino_criterion_collection = {
                name = "Criterion Collection",
                text = {
                    "{C:attention}Actor and Genre{}",
                    "synergy need {C:attention}1",
                    "less joker to",
                    "synergize"
                }
            },
            -- Cryptid crossmod Vouchers
            v_kino_confection_acclimator = {
                name = "Confection Acclimator",
                text = {
					"{C:mult}Confection{} cards appear",
					"{C:attention}X#1#{} more frequently",
					"in the shop",
					"Allows control of the",
					"shop's {C:mult}Confection Rate{}",
					"{C:inactive}(Check {C:attention}Run Info{C:inactive})",
                }
            },
            v_kino_heavenly_treats = {
                name = "Heavenly Treats",
                text = {
                    "When defeating a blind",
                    "upgrade each {C:mult}Confection's{}",
                    "power by {C:attention}#2#%{}"
                }
            },
            v_kino_egot = {
                name = "EGOT Winner",
                text = {
                    "Jokers can be {C:money}awarded{}",
                    "an unlimited number of times"
                }
            },
            v_kino_datacenter = {
                name = "Data Centre",
                text = {
                    "All {C:attention}actor{} and {C:attention}genre synergies{} are",
                    "{C:attention}twice{} as effective"
                }
            }
        },
        Spell = {
            spell_kino_None_None = {
                name = "No Spell",
                text = {
                    "No spell will",
                    "be cast based",
                    "on these cards"
                }
            },

            spell_kino_Hearts_Hearts = {
                name = "Double Hearts",
                text = {
                    "Gives {C:mult}+#1#{} Mult"
                }
            },
            spell_kino_Hearts_Diamonds = {
                name = "Diamond Heart",
                text = {
                    "Gives {X:mult,C:white}X#1#{}"
                }
            },
            spell_kino_Hearts_Clubs = {
                name = "Hearty Club",
                text = {
                    "Gives {C:mult}+#1#{} Mult and",
                    "{C:chips}+#2#{} Chips"
                }
            },
            spell_kino_Hearts_Spades = {
                name = "Spade Heart",
                text = {
                    "Upgrade a random card",
                    "in hand with {C:mult}+#1#{} Mult"
                }
            },
            spell_kino_Diamonds_Diamonds = {
                name = "Double Diamonds",
                text = {
                    "Earn {C:money}$#1#"
                }
            },
            spell_kino_Diamonds_Clubs = {
                name = "Diamond Club",
                text = {
                    "Gives {X:chips,C:white}X#1#{}"
                }
            },
            spell_kino_Diamonds_Spades = {
                name = "Diamond Spade",
                text = {
                    "Create a {C:attention}#1#{}",
                    "{C:inactive}(Must have room)"
                }
            },
            spell_kino_Clubs_Spades = {
                name = "Club Spade",
                text = {
                    "Upgrade a random card",
                    "in hand with {C:chips}+#1#{} Chips"
                }
            },
            spell_kino_Clubs_Clubs = {
                name = "Double Clubs",
                text = {
                    "Gives {C:chips}+#1#{} Chips"
                }
            },
            spell_kino_Spades_Spades = {
                name = "Double Spades",
                text = {
                    "Lower the {C:attention}Blind",
                    "by {C:attention}#1#%"
                }
            },
            spell_kino_EyeOfAgamoto = {
                name = "The Eye of Agamotto",
                text = {
                    "Gain {C:chips}2 Hands{}"
                }
            },
        },
        Sleeve = {
            -- Genre Sleeves
            sleeve_kino_spooky = {
                name = "Spooky Sleeve",
                text = {
                    "{C:attention}Horror jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with a {C:attention}The Slasher{}",
                    "and a {C:attention}The Demon"
                }
            },
            sleeve_kino_tech = {
                name = "Tech_Sl33ve",
                text = {
                    "{C:attention}Sci-fi jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Droid{}"
                }
            },
            sleeve_kino_flirty = {
                name = "Flirty Sleeve",
                text = {
                    "{C:attention}Romance jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Meetcute{}"
                }
            },
            sleeve_kino_questionable = {
                name = "Questionable Sleeve",
                text = {
                    "{C:attention}Mystery jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Detective{}"
                }
            },
            sleeve_kino_enchanted = {
                name = "Enchanted Sleeve",
                text = {
                    "{C:attention}Fantasy jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Witch{}"
                }
            },
            sleeve_kino_illicit = {
                name = "Illicit Sleeve",
                text = {
                    "{C:attention}Crime jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Gangster{}"
                }
            },
            sleeve_kino_dangerous = {
                name = "Dangerous Sleeve",
                text = {
                    "{C:attention}Action jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Soldier{}"
                }
            },
            sleeve_kino_heroic = {
                name = "Heroic Sleeve",
                text = {
                    "{C:attention}Superhero jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}The Superhero{}"
                }
            },

            sleeve_kino_athletic = {
                name = "Athletic Sleeve",
                text = {
                    "{C:attention}Sports jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Homerun{}"
                }
            },
            sleeve_kino_childlike = {
                name = "Childlike Sleeve",
                text = {
                    "{C:attention}Family jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Gathering{}"
                }
            },
            sleeve_kino_adventurous = {
                name = "Adventurous Sleeve",
                text = {
                    "{C:attention}Adventure jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Artifact{}"
                }
            },
            sleeve_kino_highpressure = {
                name = "High Pressure Sleeve",
                text = {
                    "{C:attention}Thriller jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Fright{}"
                }
            },
            sleeve_kino_funny = {
                name = "Funny Sleeve",
                text = {
                    "{C:attention}Comedy jokers{} are",
                    "{C:attention}50%{} stronger and {C:attention}3{} times as common",
                    "Start with 2 copies of ",
                    "{C:attention}Whimsy{}"
                }
            },

            -- Non-genre sleeves
            sleeve_kino_bacon = {
                name = "Bacon Sleeve",
                text = {
                    "{C:attention}Movie Jokers{} are",
                    "{C:attention}#1#%{} stronger if",
                    "they share {C:attention}Cast or",
                    "{C:attention}Director{} with adjacent",
                    "Jokers"
                }
            },
            sleeve_kino_bacon_alt = {
                name = "Bacon Sleeve",
                text = {
                    "{C:attention}Movie Jokers{} are",
                    "{C:attention}#1#%{} stronger if",
                    "they share {C:attention}Cast or",
                    "{C:attention}Director{} with adjacent",
                    "Jokers"
                }
            },

            sleeve_kino_c2n = {
                name = "Cine2Nerdle Sleeve",
                text = {
                    "If you own a {C:attention}Movie Joker",
                    "then all jokers that spawn",
                    "will share cast with your",
                    "current jokers"
                }
            },

            sleeve_kino_producer = {
                name = "Producer Sleeve",
                text = {
                    "Earn no money from",
                    "blinds or interest",
                    "After defeating a {C:attention}Boss Blind",
                    "each {C:attention}Movie Joker{} pays out",
                    "based on it's {C:attention}Profit Margin"
                }
            },
            sleeve_kino_producer_alt = {
                name = "Producer Sleeve",
                text = {
                    "Earn no money from",
                    "blinds or interest",
                    "After defeating a {C:attention}Blind",
                    "each {C:attention}Movie Joker{} pays out",
                    "based on it's {C:attention}Profit Margin"
                }
            },

            sleeve_kino_investment = {
                name = "Investment Sleeve",
                text = {
                    "Earn no money from",
                    "blinds or interest",
                    "When you defeat a Blind",
                    "put a {C:green}Money Counter",
                    "on {C:attention}10{} random cards",
                    "in your deck"
                }
            },
            sleeve_kino_investment_alt = {
                name = "Investment Sleeve",
                text = {
                    "Earn no money from",
                    "blinds or interest",
                    "When you defeat a Blind",
                    "put a {C:green}Money Counter",
                    "on every card in your deck"
                }
            },

            sleeve_kino_spellslinger = {
                name = "Spellslinger's Sleeve",
                text = {
                    "First scoring card",
                    "casts a spell based",
                    "on the first three cards",
                    "in hand when a hand is played"
                }
            },
            sleeve_kino_spellslinger_alt = {
                name = "Spellslinger's Sleeve",
                text = {
                    "Final scoring card",
                    "casts a spell based",
                    "on the last three cards",
                    "in hand when a hand is played"
                }
            },

            sleeve_kino_darkknight = {
                name = "Dark Knight Sleeve",
                text = {
                    "{C:attention}Batman jokers{} are twice",
                    "as common",
                    "{C:attention}Jokers{} have a {green}1 in 4{}",
                    "chance to spawn with a {C:attention}Robin sticker"
                }
            },
            sleeve_kino_darkknight_alt = {
                name = "Dark Knight Sleeve",
                text = {
                    "{C:attention}Batman jokers{} are",
                    "four times as common",
                    "{C:attention}Jokers{} have a {green}1 in 4{}",
                    "chance to spawn with a {C:attention}Robin sticker"
                }
            },

            sleeve_kino_alderaan = {
                name = "Alderaan Sleeve",
                text = {
                    "{C:attention}Star Wars Jokers{} are",
                    "twice as common",
                    "When you defeat a blind",
                    "level up a random hand",
                    "for each unused {C:mult}Discard"
                }
            },
            sleeve_kino_alderaan_alt = {
                name = "Alderaan Sleeve",
                text = {
                    "{C:attention}Star Wars Jokers{} are",
                    "four times as common",
                    "When you defeat a blind",
                    "level up a random hand",
                    "for each unused {C:mult}Discard",
                    "and {C:chips}Hand"
                }
            },

            sleeve_kino_cosmonaut = {
                name = "Cosmonaut's Sleeve",
                text = {
                    "{C:planet}Planets{} with an associated",
                    "hand type won't spawn naturally"
                }
            },

            sleeve_kino_empowered = {
                name = "Empowered Sleeve",
                text = {
                    "{C:attention}Face Cards{} of each",
                    "suit start with the same",
                    "random {C:attention}Enhancement"
                }
            },
            sleeve_kino_empowered_alt = {
                name = "Empowered Sleeve",
                text = {
                    "All {C:attention}cards{} of each",
                    "suit start with the same",
                    "random {C:attention}Enhancement"
                }
            },
            
            sleeve_kino_deckthatmakesyouold = {
                name = "Sleeve That Makes You Old",
                text = {
                    "When a card is scored",
                    "increase the rank",
                    "of every card held",
                    "in hand that shares a Suit"
                }
            },
            sleeve_kino_deckthatmakesyouold_alt = {
                name = "Sleeve That Makes You Old",
                text = {
                    "When a card is scored",
                    "increase the rank",
                    "of every card held",
                    "in hand"
                }
            },
            
            
            


            sleeve_kino_northernlion = {
                name = "Egg Sleeve",
                text = {
                    "{C:inactive,E:1}That's a {C:Romance,E:1}Romance!",
                    "{C:inactive,E:1}they flirt in scene 19!",
                    "{C:attention}Movie Jokers{} always count",
                    "as {C:Romance}Romance Jokers{}"
                }
            },
            
            

            sleeve_kino_snackdeck = {
                name = "Snack Sleeve",
                text = {
                    "Start your run with the",
                    "{C:attention}Special Treats{} and",
                    "{C:attention}Snack Bag{} vouchers"
                }
            },
            sleeve_kino_trophydeck = {
                name = "Winner's Sleeve",
                text = {
                    "Start your run with the",
                    "{C:attention}Award's Bait{} and",
                    "and {C:attention}Award Show{} vouchers"
                }
            },


            -- Cryptid Crossmod decks
            sleeve_kino_snackdeck_cryptid = {
                name = "Snack Sleeve",
                text = {
                    "Start your run with the",
                    "{C:attention}Special Treats{}, {C:attention}Snack Bag{},",
                    "and {C:attention}Heavenly Treats{} vouchers"
                }
            },
            sleeve_kino_trophydeck_cryptid = {
                name = "Winner's Sleeve",
                text = {
                    "Start your run with the",
                    "{C:attention}Award's Bait{}, {C:attention}Award Show{},",
                    "and {C:attention}EGOT Winner{} vouchers"
                }
            }
        },
        Counter = {
            -- Score counters
            counter_mult = {
                name = "Mult Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Gives {C:mult}+#1#{} Mult",
                    "per Counter",
                }
            },
            counter_chip = {
                name = "Mult Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Gives {C:chips}+#1#{} Chips",
                    "per Counter",
                }
            },
            counter_xmult = {
                name = "xMult Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Gives {X:mult,C:white}x#1#{} Mult",
                    "per Counter",
                }
            },

            -- Beneficial Counters
            counter_retrigger = {
                name = "Retrigger Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Retrigger {C:attention}#1#{} time",
                    "per Counter"
                }
            },
            counter_money = {
                name = "Money Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Gain {C:money}$#1#{}",
                    "per Counter"
                }
            },
            counter_investment = {
                name = "Investment Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Lose $1 per Counter applied",
                    "Gain {C:money}$#1#{}",
                    "per Counter"
                }
            },

            -- Detrimental Counters
            counter_poison = {
                name = "Poison Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Reduce {C:chips}Chips{} & {C:mult}Mult",
                    "by {C:attention}#1#%{} per Counter"
                }
            },
            counter_stun = {
                name = "Stun Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    "{C:attention}after hand is played",
                    " ",
                    "Debuffed while this has",
                    "any counters"
                }
            },
            counter_debt = {
                name = "Debt Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Lose {C:money}$#1#{}",
                    "per Counter"
                }
            },

            -- Status Counters
            counter_burn = {
                name = "Burn Counter",
                text = {
                    "{C:attention}Ticks Up 1",
                    " ",
                    "Has a {C:green}1 in 10{}",
                    "chance to {C:red}self-destruct"
                }
            },
            counter_frost = {
                name = "Frost Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Halves given score",
                    "while this has any",
                    "Counters"
                }
            },
            counter_paralysis = {
                name = "Paralysis Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Has a {C:green}1 in 10{} chance",
                    "to not trigger",
                    "per Counter"
                }
            },
            counter_sleep = {
                name = "Sleep Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    "{C:attention}1 in Total Counters (#1#) chance",
                    "to clear all Counters",
                    " ",
                    "Debuffed while this",
                    "has any counters",
    
                }
            },
            counter_drowsy = {
                name = "Drowsy Counter",
                text = {
                    "{C:attention}Ticks Up 1",
                    " ",
                    "{C:green}1 in 10{} chance per Counter",
                    "to convert into",
                    "Sleep counters"
                }
            },

            -- Kino Counters
            counter_kino_power = {
                name = "Power Counter",
                text = {
                    "{C:attention}Ticks Down 1",
                    " ",
                    "Increases card's Power by {C:attention}#1#%{}",
                    "while this has any",
                    "Counters"
                }
            }
        }
    },
    misc = {
        dictionary = {
            ---- UI elements ----
            b_confection_rate = "Confection Rate",
            b_kino_pull = "TAKE",
            b_questlog = "Quests",

            -- Mod Config --
            kino_settings_header_enhancements = "Card Enhancements",
            kino_settings_header_joker_mechanics = "Joker Mechanics",
            kino_settings_header_mod_mechanics = "Mod Mechanics",

            kino_settings_sci_fi_enhancement = "Sci-fi Cards?",
            kino_settings_spellcasting = "Spellcasting Cards?",
            kino_settings_demonic_enhancement = "Demonic Cards?",
            kino_settings_horror_enhancement = "Horror/Monster Cards?",
            kino_settings_romance_enhancement = "Romance Cards?",
            kino_settings_crime_enhancement = "Crime Cards?",
            kino_settings_action_enhancement = "Action Cards?",


            kino_settings_jumpscare_mechanic = "Jumpscare Jokers?",
            kino_settings_vampire_jokers = "Vampiric Jokers?",
            kino_settings_time_based_jokers = "Timing Jokers?",
            kino_settings_speed_factor = "Quick Timer",
            kino_settings_confection_mechanic = "Confections?", 

            kino_settings_actor_synergy = "Actors?",
            kino_settings_genre_synergy = "Genre?",
            kino_settings_movie_jokers_only = "Movie Jokers Only?",
            kino_settings_custom_rarity = "Rarity System?",

            -- OTHER --
            kino_credits_header = "Credits",
            kino_credits_developer = "Developed By: ",
            kino_credits_specialthanks = "Playtesting Feedback: ",
            kino_credits_programminghelp = "Additional Programming: ",
            kino_credits_wiki = "Wiki Maintenance Help: ",
            ---------------------
            k_confection = "Confection",
            b_confection_cards = "Confection Cards",
            k_spell = "Spell",
            k_quest = "Quest",
            
            

            snack_boosters = "Confections",
            horror_booster = "Horror Joker",
            action_booster = "Action Joker",
            sci_fi_booster = "Sci-fi Joker",
            comedy_booster = "Comedy Joker",
            romance_booster = "Romance Joker",
            fantasy_booster = "Fantasy Joker",
            actor_booster = "Joker",

            k_genre_synergy_egg = "That's a Romance!",
            k_genre_synergy = "Genre Synergy!",
            k_actor_synergy = "Actor Synergy!",
            k_charged = "Gain Charge",
            k_sacrifice = "Sacrifices Will Be Made",
            k_spell_cast = "MAGIC!",
            k_romance_match_ex = "Hey there ;)",
            k_summoned_ex = "Summoned",
            kino_codex = "Solved",

            
            k_longlegs_ex = "Captured",
            k_ghost_rider_1 = "Vengeance!",
            k_blade_ex = "Vampire Killed",
            k_narrated_ex = "And then they played the #1#",
            k_10_things_ex = "Flirted With",
            k_jump_scare = "Boo!",
            k_shining = "Here's Jack!",
            k_benjamin_button = "Aged",
            k_mars_attacks = "Invaded",
            k_mars_attacks_2 = "DESTROYED!!!!",
            k_chef = "There Ya Go",
            k_jaws = "CHOMP",
            k_gone_girl_male = "Gone Girl'd",
            k_gone_girl_female = "Good For Her",
            k_hook = "Pan'd",
            k_ringu_countdown = "Ring Ring",
            k_ringu_death = "7 Days Passed",
            k_goodfellas_pay = "Payment Made",
            k_goodfellas_leave = "Broke, ay?",
            k_et = "Go Home",
            k_ocean_11_2 = "Heisted",
            k_harry_potter = "Abra Cadabra",
            k_cocktail = "Thanks for the tip!",
            k_exorcist_1 = "The Power of Christ compells you",
            k_menu = "Bon appetit",
            k_m3gan = "Beep. Boop",
            k_guardians_2 = "Visited",
            k_guardians_3 = "Saved!",
            k_princess_bride_1 = "As... You... Wish...",
            k_princess_bride_2 = "Inconceivable!",
            k_princess_bride_3 = "Is this a kissing Joker?",
            k_arrakis = "Lisan al-Gaib!",
            k_west_side_sharks = "Sharks!",
            k_west_side_jets = "Jets!",
            k_west_side_neither = "Officer Kripke! Run!",
            k_shazam = "SHAZAM!",
            k_btlc = "Have ya paid your dues, Jack?",
            k_klowns = "BWEHEHE!",
            k_independence_day = "Today, we celebrate our Independence Day!",
            k_polar_express_bad = "You've been a bad gambler",
            k_polar_express_good = "Ho ho ho!",
            k_kraven = "There's an animal in each one of us",
            k_hustle = "Dribble",
            k_terminator = "I'll be back",
            k_insomnia = "No rest",
            k_sugarland = "Stolen",
            k_drstrange = "By the Eye of Agamoto!",
            k_gremlins = "Bwehehehe",
            k_raiders = "This belongs in a Museum!",
            k_odyssey = "Everything is going extremely well",
            k_contagion = "Achoo",
            k_lalaland = "For the Fools who dream",
            k_cruella = "That card will make a great coat",
            k_hellboy = "Hell held back",
            k_minecraft_1 = "Flint & Steel!",
            k_minecraft_2 = "Chicken Jockey!",
            k_kino_fast_and_furious_5 = 'Heisted',
            k_kino_star_wars_i = "Now this is pod racing", 
            k_kino_k_kino_big_daddy = "Big. Daddy.",
            k_kino_tmnt_1 = "Cowabunga!",
            k_kino_ratatouille = "Delicious Flavours!",
            k_kino_starwars_ii = "Strengthen the Clone Army",
            k_kino_starwars_viii = "See you around, kid",
            k_kino_ponyo = "Ponyo!",
            k_kino_evil_dead_1 = "Soon all of you will be like me",
            k_kino_pirates_1 = "Pirate's Gold",
            k_kino_paulblart_1 = "Low Blood Sugar :(",
            k_kino_annihilation = "Changed...",
            k_kino_waterworld = "Value Trickled Down",
            k_kino_muppets_treasure_island = "Treasure!",
            k_kino_moulin_rouge = "Hand Size Up!",
            k_kino_pulp_fiction = "Overdose",


            -- Enhancement Barks
            k_monster_turn = "ROAR!",
            k_crime_card = "Stolen",
            k_action_card = "Bang!",
                 -- CROSS MOD BARKS
            k_kino_finance_investing = "Investing!",
            k_kino_finance_investing_2 = "Time for Payouts!",
            k_kino_angelic_create = "Be Blessed, Child",

            -- Confection Barks
            k_eaten = "Eaten",
            k_extra_large = "Took a Bite",
            k_kino_blessedconf = "Blessed be this meal",

            -- Seals
            k_kino_sportsseal_1 = "Coached",
            k_kino_sportsseal_2 = "Coaching",
            k_kino_adventureseal_1 = "Gained Notariety",
            k_kino_adventureseal_2 = "Treasure!",

            -- Spartacus Barks
            k_spartacus_1 = "I am Spartacus!",
            k_spartacus_2 = "No, I am Spartacus!",
            k_spartacus_3 = "I am!",

            -- Spell barks
            k_spellcast_1 = "",

            ph_egg = "That's a Romance!",

            -- Legendary Joker text
            k_legend_willnot = "Legendary will not appear",
            k_legend_will = "Will spawn as:",

            -- BOSS BLIND BARKS
            k_blind_vader_1 = "I have you now!",
            k_blind_vader_2 = "Don't make me destroy you",
            k_blind_gekko_1 = "Greed. Is. Good!",
            k_blind_gekko_2 = "You win a few, you lose a few",
            k_blind_pazuzu_1 = "Have you come to save God's servant?",
            k_blind_pazuzu_2 = "What an excellent day for an exorcism",
            k_blind_dracula_1 = "I don't drink... Wine",
            k_blind_joker_1 = "Ha Ha Ha Ha",
            k_blind_joker_2 = "HAHAHAHAHA",
            k_blind_joker_final = "Why So Serious?",
            k_blind_loki = "Changed the Target Suit",
            k_blind_rico_dyn = "You're doing it wrong",
            k_kino_blind_humungus_1 = "We Kill! We Kill! We Kill!",
            k_blind_smith = "No, Jimbo. Your men are already dead",
            k_kino_blind_immortan_1 = "I am your redeemer",
            k_kino_blind_thanos = "Perfectly Balanced",
            k_kino_joker_batman = "Oh no! It's Bats!",
            k_kino_batman_forever = "I'm Batman",
            k_kino_saved = "Saved!",

            -- Spellcasting Text
            k_kino_spellbook = "Spellbook",
            k_kino_spelltext = {
                "Spells are constructed of three ingredients: a primary suit, a secondary suit, and a power rank.",
                "A spell is Cast when a spellcaster card or joker is triggered"
            },
            k_kino_spell_power = "Spell Power",
            k_kino_power_level = "Power Level ",
            k_kino_spell_power_text = {
                "Spell Power is determined",
                "based on the rank of the",
                "third spell component",
            },


            k_kino_legendary_quest_tutorial = {
                "Quest jokers will lower in rarity",
                "for each quest condition you",
                "are currently meeting"
            },
            -- Legendary Joker Quests
            -- -- 2001: A Space Odyssey
            k_odyssey_quest_1 = {
                "Posses a Movie Joker",
                "directed by Kubrick"
            },
            k_odyssey_quest_2 = {
                "Possess 2 Sci-Fi Jokers"
            },
            k_odyssey_quest_3 = {
                "Posses a Movie Joker",
                "released in the 60s"
            },
            k_odyssey_quest_4 = {
                "Have 10 or more",
                "Sci-fi Cards in your deck",
            },
            k_odyssey_quest_5 = {
                "Have used 20 or more",
                "Planet Cards"
            },
            k_odyssey_quest_6 = {
                "Have a Moon, Jupiter",
                "and Earth in your inventory"
            },

            -- -- Raiders of the Lost Ark
            k_indiana_quest_1 = {
                "Posses a Movie Joker",
                "directed by Spielberg"
            },
            k_indiana_quest_2 = {
                "Posses 2 Adventure Jokers"
            },
            k_indiana_quest_3 = {
                "Posses a Movie Joker",
                "released in the 80s"
            },
            k_indiana_quest_4 = {
                "Posses a Movie Joker",
                "that shares an actor"
            },
            k_indiana_quest_5 = {
                "Have 60 or more",
                "cards in your deck"
            },
            k_indiana_quest_6 = {
                "Posses a Hieroglyph",
                "or Petroglyph Voucher"
            },

            -- Barbie Quests
            k_barbie_quest_1 = {
                "Posses a Movie Joker",
                "directed by a Woman"
            },
            k_barbie_quest_2 = {
                "Posses 2 Comedy",
                "or Adventure Jokers"
            },
            k_barbie_quest_3 = {
                "Posses a Movie Joker",
                "released in the 2020s"
            },
            k_barbie_quest_4 = {
                "Posses a Movie Joker",
                "that shares an actor"
            },
            k_barbie_quest_5 = {
                "Have more Queens than Jacks",
                "and Kings in your deck"
            },
            k_barbie_quest_6 = {
                "Have a The Lovers, The Empress,",
                "and Venus in your inventory"
            },

            -- Ratatouille Quests
            k_ratatouille_quest_1 = {
                "Posses 2 Animation",
                "or Family Jokers"
            },
            k_ratatouille_quest_2 = {
                "Have used 10 or more",
                "Confection cards"
            },
            k_ratatouille_quest_3 = {
                "Have at least ten",
                "2's in your starting Deck"
            },
            k_ratatouille_quest_4 = {
                "Posses a Movie Joker",
                "that shares an actor"
            },
            k_ratatouille_quest_5 = {
                "Posses a Movie Joker",
                "released in the 2000s"
            },
            k_ratatouille_quest_6 = {
                "Have a Pluto, Popcorn Snack,",
                "and Pizza in your inventory"
            },

            -- Citizen Kane Quests
            k_citizen_kane_quest_1 = {
                "Posses 2 Mystery",
                "or Drama Jokers"
            },
            k_citizen_kane_quest_2 = {
                "Posses a Movie Joker",
                "released in the 1940s"
            },
            k_citizen_kane_quest_3 = {
                "Posses a Movie Joker",
                "that shares an actor"
            },
            k_citizen_kane_quest_4 = {
                "Have at least ten",
                "cards with different enhancements",
                "in your starting Deck"
            },
            k_citizen_kane_quest_5 = {
                "Have $50 or more"
            },
            k_citizen_kane_quest_6 = {
                "Have a The Emperor, The Hermit,",
                "and The Earth in your inventory"
            },


            -- ========= BLOCKBUSTER API MOD LOCALIZATION ======== --
            bb_counter_tooltip = {
                "Jokers and playing cards can have",
                "only one type of counter",
                "Counters decrease by 1 when they",
                "are triggered"
            },
            bbcount_counter = "Counter",
            bb_paralysis = "Paralyzed!"
        },
        challenge_names = {
            c_kino_minc = "Monsters Inc.",
            c_kino_bacon = "Six Degrees of Kevin",
            c_kino_yeager = "Cade Yeager Cosplay",
            c_kino_xenomorph = "Xenomorph Invasion",
            c_kino_bestsong = "Best Song in the World",
            c_kino_harrysally = "When Perkeo met Triboulet",
            c_kino_genre_variety = "Genre Variety",
            c_kino_genre_snob = "Genre Snob",
            c_kino_chronology = "Chronology",
            c_kino_blockbuster = "Blockbuster Video",
            c_kino_slasher = "Slasher Movie",
            c_kino_wallstreet = "The Jimbo of Wallstreet"

        },
        v_dictionary = {
            
            -- Payout Info
            kino_sci_fi_payout = "Sci-Fi Cards Upgraded ($#1# each)",

            -- Quest Types
            v_kino_quest_hand_type = {
                "Play a {C:attention}#1#{}#2#"
            },
            v_kino_quest_card_type = {
                "Have a {C:attention}#1#{}",
                "score#2#"
            },

            -- Quest Description Units
            v_kino_questtimer = {
                " #1# times"
            },
        },
        v_text = {
            ch_c_movie_jokers_only = {
                "Only {C:attention}Movie Jokers{} can spawn"
            },
            ch_c_kino_bacon = {
                "All {C:attention}Movie Jokers{} spawn with a {C:attention}Bacon{} sticker"
            },
            ch_c_kino_yeag = {
                "At the end of the round, you earn {C:money}$#1#{} for each time a {C:attention}Sci-Fi{} card upgraded"
            },
            ch_c_kino_alien = {
                "Whenever you play a hand, one card in deck becomes permanently {C:attention}Debuffed{}"
            },
            ch_c_kino_bestsong = {
                "Gain a {C:red}Discard{} when you {C:attention}Sacrifice{}"
            },
            ch_c_kino_harrysally = {
                "You cannot buy {C:green}Rerolls{}, you instead earn them whenever you {C:attention}Make a Match"
            },
            ch_c_kino_genre_variety = {
                "{C:attention}Movie Jokers{} are debuffed while you own another joker that shares a {C:attention}Genre{}"
            },
            ch_c_kino_genre_snob = {
                "{C:attention}Movie Jokers{} are debuffed if they do not share the genre of the Joker in your {C:attention}Active slot{}"
            },
            ch_c_kino_chronology = {
                "{C:attention}Movie Jokers{} spawn in order of release"
            },
            ch_c_kino_blockbuster = {
                "All {C:attention}Movie Jokers{} are rental, charging more rent depending on how profitable they were"
            },
            ch_c_kino_slasher = {
                "Every Fourth card scored {C:attention}Jumpscares{}"
            },
            ch_c_kino_wallstreet = {
                "Whenever you use any {C:attention}Consumable{}, you {C:money}Bust"
            },

            -- More general rules
            ch_c_carryover_discards = {
                "{C:red}Discards{} carry over between rounds"
            },
            ch_c_carryover_hands = {
                "{C:blue}Hands{} carry over between rounds"
            }
        },
        labels = {
            kino_award = "Awarded",
            kino_choco = "Chocolate-Dipped",
            kino_goldleaf = "Goldleaf",
            kino_extra_large = "Extra Large",
            kino_robin = "Robin",
            kino_family_seal = "Family Seal",
            kino_cheese_seal = "Cheese Seal",
            kino_adventure_seal = "Adventure Seal",
            kino_thriller_seal = "Thriller Seal",
            kino_sports_seal = "Sports Seal",
            kino_comedy_seal = "Comedy Seal"

        }
    }
}