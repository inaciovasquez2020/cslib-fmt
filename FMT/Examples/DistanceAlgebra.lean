import FMT.Graph.Basic
import FMT.Graph.PathLength
import FMT.Graph.PathLengthLemmas
import FMT.Graph.DistanceOrder

namespace FMT.Examples

inductive Line3 where
  | a
  | b
  | c
deriving DecidableEq, Repr

def lineGraph : FMT.Graph.Graph where
  V := Line3
  Adj u v :=
    (u = Line3.a ∧ v = Line3.b) ∨
    (u = Line3.b ∧ v = Line3.a) ∨
    (u = Line3.b ∧ v = Line3.c) ∨
    (u = Line3.c ∧ v = Line3.b)

theorem lineGraph_symm :
    ∀ {u v : lineGraph.V}, lineGraph.Adj u v → lineGraph.Adj v u := by
  intro u v h
  rcases h with h | h | h | h
  · exact Or.inr (Or.inl ⟨h.2, h.1⟩)
  · exact Or.inl ⟨h.2, h.1⟩
  · exact Or.inr (Or.inr (Or.inr ⟨h.2, h.1⟩))
  · exact Or.inr (Or.inr (Or.inl ⟨h.2, h.1⟩))

theorem lineGraph_path_ab :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.b 1) := by
  refine ⟨?_⟩
  exact
    { verts := fun i => if i.1 = 0 then Line3.a else Line3.b
      start := by simp
      finish := by simp
      step := by
        intro i
        fin_cases i
        simp
        exact Or.inl ⟨rfl, rfl⟩ }

theorem lineGraph_path_bc :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.b Line3.c 1) := by
  refine ⟨?_⟩
  exact
    { verts := fun i => if i.1 = 0 then Line3.b else Line3.c
      start := by simp
      finish := by simp
      step := by
        intro i
        fin_cases i
        simp
        exact Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩)) }

end FMT.Examples
