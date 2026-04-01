import FMT.Graph.Basic

namespace FMT.Game

structure Pebble (G : Type) where
  pos : G

structure Position (G H : Type) where
  left  : List (Pebble G)
  right : List (Pebble H)

structure Move (G H : Type) where
  pickLeft  : Bool
  index     : Nat

structure DuplicatorStrategy (G H : Type) where
  respond : Position G H → Move G H → Position G H

def initial (G H : Type) : Position G H :=
  ⟨[], []⟩

end FMT.Game
