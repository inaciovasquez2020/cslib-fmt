import FMT.Graph.Basic

namespace FMT.Graph

def Walk (G : Graph) (u v : G.V) := List G.V

def walkLength {G : Graph} : Walk G u v → Nat := fun w => w.length

def dist (G : Graph) (u v : G.V) : Nat := 0

end FMT.Graph
