import FMT.Graph.DistanceCore

namespace FMT.Graph

noncomputable def μ {G : Graph} (u v : G.V) : Nat :=
  match dist? (G:=G) u v with
  | some d => d
  | none => 0

end FMT.Graph
