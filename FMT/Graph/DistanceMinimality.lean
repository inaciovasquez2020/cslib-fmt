import FMT.Graph.Distance
import FMT.Graph.DistancePath

namespace FMT.Graph

theorem dist_eq_of_no_shorter_path
  (G : Graph) [FMT.Inputs.SLASHAxioms G] {u v : G.V} {n : Nat}
  (hpath : Nonempty (PathLength G u v n))
  (hmin : ∀ m, m < n → ¬ Nonempty (PathLength G u v m)) :
  ∃ d, dist? (G:=G) u v = some d ∧ d = n := by
  refine ⟨n, ?_, rfl⟩
  exact dist?_some_of_shortest_path (G:=G) (u:=u) (v:=v) hpath hmin

theorem dist?_some_iff_shortest
  (G : Graph) [Inputs.SLASHAxioms G] {u v : G.V} {n : Nat} :
  dist? (G:=G) u v = some n ↔
    Nonempty (PathLength G u v n) ∧
    ∀ m, m < n → ¬ Nonempty (PathLength G u v m) := by
  constructor
  · intro h
    exact shortest_length_spec h
  · intro h
    rcases h with ⟨hpath, hmin⟩
    rcases dist_eq_of_no_shorter_path G hpath hmin with ⟨d, hd, hEq⟩
    simpa [hEq] using hd

end FMT.Graph
