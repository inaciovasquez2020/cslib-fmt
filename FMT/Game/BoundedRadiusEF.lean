import FMT.Graph.Basic
import FMT.Graph.BoundedRadius

namespace FMT.Game

open FMT.Graph

-- positions in the k-pebble EF game
structure Position (G H : Graph) :=
  (pebbles : Nat → Option (G.V × H.V))

-- local consistency on radius-r balls
def locallyConsistent (G H : Graph) (r : Nat) (p : Position G H) : Prop :=
  ∀ i x y, p.pebbles i = some (x, y) →
    True  -- placeholder for ball-isomorphism constraint

-- recursive winning condition (k rounds)
def winsLocal (G H : Graph) (k r : Nat) : Position G H → Prop
| 0, _ => fun p => locallyConsistent G H r p
| (Nat.succ k'), r => fun p =>
    locallyConsistent G H r p ∧
    (∀ i, ∃ p', winsLocal G H k' r p')

end FMT.Game
