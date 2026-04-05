import FMT.Graph.PathLength

namespace FMT.Graph

axiom dist? {G : Graph} : G.V → G.V → Option Nat

axiom exists_path_or_none
  {G : Graph} {u v : G.V} :
  dist? (G:=G) u v = none ∨ ∃ n, Nonempty (PathLength G u v n)

end FMT.Graph
