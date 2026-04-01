import FMT.Graph.Basic

namespace FMT.Game

structure Position (G H : Type) where
  pebbles : Nat

structure DuplicatorStrategy (G H : Type) where
  respond : Position G H → Position G H

def winsLocal (k R : Nat) : Prop := True

end FMT.Game
