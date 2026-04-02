import FMT.Graph.DistanceOrder
import FMT.Graph.PathLengthOne

namespace FMT.Examples

open FMT.Graph

inductive TwoV
| a
| b
deriving DecidableEq

def testGraph : Graph where
  V := TwoV
  Adj
  | TwoV.a, TwoV.b => True
  | TwoV.b, TwoV.a => True
  | _, _ => False

example : dist? testGraph TwoV.a TwoV.a = some 0 := by
  exact dist?_zero_of_eq (G := testGraph) rfl

example : Nonempty (PathLength testGraph TwoV.a TwoV.b 1) := by
  exact pathLength_one_of_adj testGraph trivial

example : ∃ d, dist? testGraph TwoV.a TwoV.b = some d ∧ d ≤ 1 := by
  exact dist?_le_of_path (G := testGraph) (u := TwoV.a) (v := TwoV.b)
    (n := 1) (pathLength_one_of_adj testGraph trivial)

example : DistLE testGraph TwoV.a TwoV.a 0 := by
  exact distLE_of_eq testGraph TwoV.a TwoV.a (dist?_zero_of_eq (G := testGraph) rfl) (by decide)

example : ¬ DistLE testGraph TwoV.a TwoV.a 0 → False := by
  intro h
  exact h (distLE_of_eq testGraph TwoV.a TwoV.a (dist?_zero_of_eq (G := testGraph) rfl) (by decide))

end FMT.Examples
