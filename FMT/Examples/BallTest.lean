import FMT.Graph.Basic
import FMT.Graph.Distance
import FMT.Graph.BoundedRadius

namespace FMT.Examples

def G : FMT.Graph.Graph := { V := Unit }

open FMT.Graph

example : ∃ u : Ball G 0 (), u.val = () := by
  exact ⟨⟨(), trivial⟩, rfl⟩

end FMT.Examples
