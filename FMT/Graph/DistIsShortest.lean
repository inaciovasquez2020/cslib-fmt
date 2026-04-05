import FMT.Graph.DistanceCore
import FMT.Graph.PathLength
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem dist?_is_shortest
(G : Graph) [Inputs.SLASHAxioms G] {u v : G.V} {n : Nat} :
dist? (G:=G) u v = some n →
∀ m, m < n → ¬ Nonempty (PathLength G u v m) :=
Inputs.SLASHAxioms.dist_is_shortest

end FMT.Graph
