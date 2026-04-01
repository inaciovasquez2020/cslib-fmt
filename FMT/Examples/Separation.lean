import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Examples

/-- Two vertices are separated if their distance in G is strictly greater than R -/
def separated (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) : Prop :=
  FMT.Graph.dist G u v > R

/-- Minimal reflexive FO equivalence stub -/
def FO_equiv (k R : Nat) : Prop := k = k ∧ R = R

/--
A refinement theorem: if u and v are separated by R,
then they cannot be the same vertex.
-/
theorem separation_is_nontrivial (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) :
  separated G u v R → u ≠ v := by
  intro h h_eq
  subst h_eq
  -- Use the property that dist v v = 0
  have h_dist : FMT.Graph.dist G v v = 0 := FMT.Graph.dist_self v
  rw [h_dist] at h
  exact Nat.not_lt_zero R h

end FMT.Examples
