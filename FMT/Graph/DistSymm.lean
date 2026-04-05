import FMT.Graph.Distance
import FMT.Inputs.ConstructiveSLASHAxioms

namespace FMT.Graph

open FMT.Inputs

theorem dist_symm
  (G : Graph)
  [DecidableEq G.V]
  (hAdjSymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
  (u v : G.V) :
  dist G u v = dist G v u := by
  unfold dist
  have h : dist? G u v = dist? G v u := dist_symm_of_adj_symm G hAdjSymm u v
  rw [h]

end FMT.Graph
