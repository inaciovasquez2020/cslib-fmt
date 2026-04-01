import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Examples

-- Minimal concrete graph instance
structure DummyGraph where
  V : Type

instance : DecidableEq Unit := inferInstance

def G : FMT.Graph.Graph := {
  V := Unit
}

open FMT.Graph

-- Example evaluations
example : dist (G := G) () () = 0 := by
  simp [dist]

example : dist (G := G) () () ≤ dist (G := G) () () + dist (G := G) () () := by
  simp [dist]

end FMT.Examples
