
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

SMODS.Sound({
  key = "bite",
  path = "bite.ogg"
})

SMODS.Sound({
  key = "gulp",
  path = "gulp.ogg"
})