import FMT.Graph.ExistsMinPathLength
import FMT.Inputs.SLASH_Axioms
import Mathlib

namespace FMT.Inputs

open Classical
open FMT.Graph

theorem exists_shortest_path_length_constructive
    (G : Graph) (u v : G.V) :
    (∃ n, Nonempty (PathLength G u v n)) →
    ∃ n, Nonempty (PathLength G u v n) ∧
      ∀ m, m < n → ¬ Nonempty (PathLength G u v m) :=
  exists_min_pathLength G u v

@[reducible]
noncomputable def constructiveInstance
    (G : Graph) :
    SLASHAxioms G where
  exists_shortest_path_length := exists_shortest_path_length_constructive G

end FMT.Inputs
