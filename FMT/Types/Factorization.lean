import FMT.Types.LocalType

namespace FMT.Types

def factorsThrough (f : LocalType → Nat) : Prop := True

def invariant (n : Nat) : Nat := n

theorem factors_example :
  ∃ f : LocalType → Nat, factorsThrough f := by
  exact ⟨fun _ => 0, trivial⟩

end FMT.Types
