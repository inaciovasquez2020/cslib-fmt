import FMT.Graph.DistanceOrder

namespace FMT.Examples

open FMT.Graph

inductive SplitV
| a
| b
| c
deriving DecidableEq

def splitGraph : Graph where
  V := SplitV
  Adj
  | SplitV.a, SplitV.b => True
  | SplitV.b, SplitV.a => True
  | _, _ => False

example : dist? splitGraph SplitV.a SplitV.a = some 0 := by
  exact dist?_zero_of_eq (G := splitGraph) rfl

example : ∃ d, dist? splitGraph SplitV.a SplitV.b = some d ∧ d ≤ 1 := by
  exact dist?_le_of_path (G := splitGraph) (u := SplitV.a) (v := SplitV.b)
    (n := 1) (pathLength_one_of_adj splitGraph trivial)

example : dist? splitGraph SplitV.a SplitV.c = none := by
  unfold dist?
  simp [splitGraph, PathLength]

example : ¬ DistLE splitGraph SplitV.a SplitV.c 0 := by
  exact not_distLE_of_none splitGraph SplitV.a SplitV.c 0 (by
    unfold dist?
    simp [splitGraph, PathLength])

example : DistGT splitGraph SplitV.a SplitV.c 0 := by
  exact distGT_of_none splitGraph SplitV.a SplitV.c 0 (by
    unfold dist?
    simp [splitGraph, PathLength])

end FMT.Examples
