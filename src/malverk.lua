if AltTexture and TexturePack then

print("testing")

AltTexture{
    key = 'kino_atlas_1',
    set = 'Joker',
    path = '001_kino_jokerresprite.png',
    original_sheet = true,
    keys = {
        'j_kino_creature_from_the_black_lagoon',
        'j_kino_robocop',
        'j_kino_angel_hearts',
        'j_kino_party_people',
        'j_kino_et',
        'j_kino_turner_and_hooch'
    },
}

AltTexture{
    key = 'kino_atlas_2',
    set = 'Joker',
    path = '002_kino_jokerresprite.png',
    original_sheet = true,
    keys = {
        'j_kino_shopaholic',
        'j_kino_thing',
        'j_kino_get_out',
        'j_kino_nope',
        'j_kino_clockwork_orange',
        'j_kino_spartacus',
        'j_kino_edward_scissorhands',
        'j_kino_beetlejuice_1988',
        'j_kino_ed_wood',
        'j_kino_twins'
    },
}

AltTexture{
    key = 'kino_atlas_3',
    set = 'Joker',
    path = '003_kino_jokerresprite.png',
    original_sheet = true,
    keys = {
        'j_kino_alien_3',
        'j_kino_jurassic_park_1',

    },
}

TexturePack{
    key = 'kino_retextured',
    textures = {
        'kino_atlas_1',
        'kino_atlas_2',
        'kino_atlas_3',
    },
    loc_txt = {
        name = 'Kino Retextured',
        text = {
            'Adds Pixel Art textures to certain Kino jokers',
            'that are more in line with the Balatro style'
        }
    }
}

end