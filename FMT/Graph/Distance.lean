import FMT.Graph.Basic

namespace FMT.Graph

def Walk (G : Graph) (u v : G.V) := List G.V

def walkLength {G : Graph} (w : Walk G u v) : Nat := w.length

def dist (G : Graph) (u v : G.V) : Nat := 0

end FMT.Graph
