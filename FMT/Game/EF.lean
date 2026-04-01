import FMT.Graph.Basic

namespace FMT.Game

structure Pebble (G : Type) where
  pos : G

structure Position (G H : Type) where
  left  : List (Pebble G)
  right : List (Pebble H)

def indistinguishable (k R : Nat) : Prop := True

end FMT.Game
