import FMT.Graph.DistanceCore

namespace FMT.Graph

theorem dist?_symm
  {G : Graph} (u v : G.V) (d : Nat) :
  (dist? (G:=G) u v) = some d →
  (dist? (G:=G) v u) = some d := by
  intro _
  admit

end FMT.Graph
