module Main (main) where

import Constants
import Graphics.Element exposing (Element)
import Keyboard
import Signal.Extra
import Signal.Time
import Game
import Time
import View
import Window


-- Signals

updateSignal : Signal Game.Update
updateSignal =
  Signal.mergeMany
  [ Signal.map Game.StartTime Signal.Time.startTime
  , Signal.map Game.Tick (Time.fps Constants.tickFps)
  , Signal.map Game.Arrows Keyboard.arrows
  , Signal.map Game.Wasd Keyboard.wasd
  , Signal.map Game.Space Keyboard.space
  , Signal.map Game.Escape (Keyboard.isDown 27)
  ]


gameSignal : Signal Game.Model
gameSignal =
  Signal.Extra.foldp' Game.updateGame Game.intro updateSignal


main : Signal Element
main =
  Signal.map2 View.view Window.dimensions gameSignal

