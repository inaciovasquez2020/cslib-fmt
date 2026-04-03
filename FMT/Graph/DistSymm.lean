import FMT.Graph.DistancePath
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem dist?_symm
(G : Graph) [Inputs.SLASHAxioms G] (u v : G.V) :
dist? G u v = dist? G v u :=
Inputs.SLASHAxioms.dist_symm u v

end FMT.Graph
