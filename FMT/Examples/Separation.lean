import FMT.Graph.Basic
import FMT.Graph.Distance

namespace FMT.Examples

/-- Two vertices are separated if their distance in G is strictly greater than R -/
def separated (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) : Prop :=
  FMT.Graph.dist G u v > R

/-- Minimal FO equivalence now tied to actual graph distance data. -/
def FO_equiv (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) : Prop :=
  FMT.Graph.dist G u v ≤ R

theorem separation_is_nontrivial (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) :
  separated G u v R → u ≠ v := by
  intro h h_eq
  subst h_eq
  unfold separated at h
  simp [FMT.Graph.dist] at h

theorem separated_not_fo_equiv (G : FMT.Graph.Graph) [DecidableEq G.V] (u v : G.V) (R : Nat) :
  separated G u v R → ¬ FO_equiv G u v R := by
  intro h hfo
  unfold separated FO_equiv at *
  exact Nat.not_lt_of_ge hfo h

end FMT.Examples
