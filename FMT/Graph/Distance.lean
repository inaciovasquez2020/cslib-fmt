import FMT.Graph.Basic

namespace FMT.Graph

-- length of a walk from u to v (to be refined with adjacency constraints)
structure Walk (G : Graph) (u v : G.V) :=
  (len : Nat)

-- graph distance as minimal walk length
noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  Nat.find (fun n => ∃ w : Walk G u v, w.len = n)

end FMT.Graph
