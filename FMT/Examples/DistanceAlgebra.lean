import FMT.Graph.DistanceSymmetry
import FMT.Graph.DistanceTriangle
import FMT.Graph.PathLengthOne

namespace FMT.Examples

open FMT.Graph

inductive Line3
| a
| b
| c
deriving DecidableEq

def lineGraph : Graph where
  V := Line3
  Adj
  | Line3.a, Line3.b => True
  | Line3.b, Line3.a => True
  | Line3.b, Line3.c => True
  | Line3.c, Line3.b => True
  | _, _ => False

theorem lineGraph_symm :
    ∀ x y : lineGraph.V, lineGraph.Adj x y → lineGraph.Adj y x := by
  intro x y h
  cases x <;> cases y <;> simpa [lineGraph] at h ⊢

example : dist? lineGraph Line3.a Line3.b = dist? lineGraph Line3.b Line3.a := by
  exact dist?_symm lineGraph lineGraph_symm

example : DistLE lineGraph Line3.a Line3.c 2 := by
  have hab : Nonempty (PathLength lineGraph Line3.a Line3.b 1) :=
    pathLength_one_of_adj lineGraph trivial
  have hbc : Nonempty (PathLength lineGraph Line3.b Line3.c 1) :=
    pathLength_one_of_adj lineGraph trivial
  have h1 : DistLE lineGraph Line3.a Line3.b 1 :=
    distLE_of_eq lineGraph Line3.a Line3.b
      (by
        rcases dist?_le_of_path (G := lineGraph) (u := Line3.a) (v := Line3.b) (n := 1) hab with ⟨d, hd, hle⟩
        have : d = 1 := by omega
        simpa [this] using hd)
      (by decide)
  have h2 : DistLE lineGraph Line3.b Line3.c 1 :=
    distLE_of_eq lineGraph Line3.b Line3.c
      (by
        rcases dist?_le_of_path (G := lineGraph) (u := Line3.b) (v := Line3.c) (n := 1) hbc with ⟨d, hd, hle⟩
        have : d = 1 := by omega
        simpa [this] using hd)
      (by decide)
  simpa using distLE_triangle lineGraph h1 h2

end FMT.Examples
