import FMT.Types.Factorization

namespace FMT.Invariants

open FMT.Types

def badF : LocalType → Nat
| .zero => 0
| .one  => 1

theorem badF_factorsThrough : factorsThrough badF := by
  refine ⟨fun n => n, ?_⟩
  intro x
  cases x <;> rfl

end FMT.Invariants
