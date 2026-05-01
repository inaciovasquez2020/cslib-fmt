import FMT.Graph.DistSymm

namespace FMT.Graph

theorem distanceSymmetry_exists_only_baseline
  {G : Graph} [FMT.Inputs.SLASHAxioms G]
  (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
  (u v : G.V) :
  dist? (G:=G) u v = dist? (G:=G) v u := by
  exact dist?_symm hsymm u v

end FMT.Graph
