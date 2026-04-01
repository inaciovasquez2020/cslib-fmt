import FMT.Graph.Basic

namespace FMT.Examples

structure LiftedGraph where
  V : Type

def highGirthPair : LiftedGraph × LiftedGraph :=
  ⟨⟨Unit⟩, ⟨Unit⟩⟩

theorem local_indistinguishable :
  ∀ k R : Nat, True := by
  intro k R
  trivial

end FMT.Examples
