import FMT.Graph.Distance

namespace FMT.Examples

open FMT.Graph

variable {G : Graph}

example (u : G.V) :
    dist G u u = 0 := by
  simpa using dist_refl G u

example (u : G.V) :
    dist? G u u = some 0 := by
  exact dist?_zero_of_eq (G := G) rfl

example (u : G.V) :
    dist? G u u = some 0 ↔ u = u := by
  simpa using (dist?_zero_iff_eq (G := G) (u := u) (v := u))

end FMT.Examples
