import FMT.Graph.Basic
import FMT.Graph.ShortestLength

namespace FMT.Graph

noncomputable def dist? {G : Graph} (u v : G.V) : Option Nat :=
  shortestLength u v

end FMT.Graph
