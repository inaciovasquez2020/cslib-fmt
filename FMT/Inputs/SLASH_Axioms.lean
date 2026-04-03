import FMT.Graph.Basic
import FMT.Graph.PathLength
import FMT.Graph.DistanceCore

namespace FMT.Inputs
open FMT.Graph

class SLASHAxioms (G : Graph) where
dist_is_shortest :
{u v : G.V} → {n : Nat} →
dist? G u v = some n →
∀ m, m < n → ¬ Nonempty (PathLength G u v m)

dist_symm :
(u v : G.V) →
dist? G u v = dist? G v u

dist_triangle :
(u v w : G.V) → {a b : Nat} →
dist? G u v = some a →
dist? G v w = some b →
∃ c, dist? G u w = some c ∧ c ≤ a + b

dist_le_of_path :
{u v : G.V} → {n : Nat} →
Nonempty (PathLength G u v n) →
∃ d, dist? G u v = some d ∧ d ≤ n

dist_bound_of_path :
{u v : G.V} → {n : Nat} →
Nonempty (PathLength G u v n) → Nat

end FMT.Inputs
