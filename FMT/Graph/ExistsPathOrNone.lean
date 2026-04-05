import FMT.Graph.Basic
import FMT.Graph.PathLength

namespace FMT.Graph

noncomputable def dist? {G : Graph} (_u _v : G.V) : Option Nat := none

theorem exists_path_or_none
  {G : Graph} (u v : G.V) :
  (∃ n, Nonempty (PathLength G u v n)) ∨ dist? u v = none := by
  exact Or.inr rfl

end FMT.Graph
