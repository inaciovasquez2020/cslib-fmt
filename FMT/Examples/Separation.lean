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
  unfold separated at h
  rw [h_eq] at h
  -- Using the standard distance property from your Graph.Distance module
  have h_zero := FMT.Graph.dist_self (G := G) v
  rw [h_zero] at h
  exact Nat.not_lt_zero R h

end FMT.Examples
