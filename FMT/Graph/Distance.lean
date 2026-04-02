import FMT.Graph.DistancePath

namespace FMT.Graph

/--
Legacy compatibility layer.

Canonical graph distance is `dist? : G.V -> G.V -> Option Nat`.
This file exists only to keep old numeric consumers building during migration.
It must not be used for new semantics.
-/
noncomputable def dist (G : Graph) (u v : G.V) : Nat :=
  (dist? G u v).getD 0

@[deprecated dist (since := "2026-04-02")]
theorem dist_eq_getD_dist? (G : Graph) (u v : G.V) :
    dist G u v = (dist? G u v).getD 0 := rfl

@[deprecated dist (since := "2026-04-02")]
theorem dist_refl (G : Graph) (v : G.V) : dist G v v = 0 := by
  simp [dist, dist?_zero_of_eq]

end FMT.Graph
