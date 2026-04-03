import FMT.Graph.Basic

namespace FMT.Game

structure Pebble (G : Type) where
  pos : G

structure Position (G H : Type) where
  left : List (Pebble G)
  right : List (Pebble H)

def indistinguishable (_k _R : Nat) : Prop := True

end FMT.Game
