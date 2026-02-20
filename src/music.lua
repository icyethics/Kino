
-- Thank you, Ren!
SMODS.Sound {
  key = 'music_kinoween_default',
  path = 'music_kinoween_default.ogg',
  vol = 0.6,
  pitch = 0.7,
  select_music_track = function(self)
      if kino_config.halloween_music and G.GAME.modifiers.kinoween then return 6 end
  end
}

-- Sounds

-- Confection related sounds
SMODS.Sound({
  key = "bite",
  path = "bite.ogg"
})

SMODS.Sound({
  key = "gulp",
  path = "gulp.ogg"
})

-- Jumpscare & Horror Cards
SMODS.Sound({
  key = "boo_1",
  path = "boo_1.ogg",
  vol = 2,
})
SMODS.Sound({
  key = "boo_2",
  path = "boo_2.ogg",
  vol = 5,
})
SMODS.Sound({
  key = "boo_3",
  path = "boo_2_2.ogg",
  vol = 1,
})
SMODS.Sound({
  key = "monster_awaken",
  path = "monster_awaken.ogg",
  vol = 2,
})