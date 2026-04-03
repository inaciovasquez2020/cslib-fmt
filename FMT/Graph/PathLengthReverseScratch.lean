import FMT.Graph.PathLength
import FMT.Graph.PathLengthAccessors

namespace FMT.Graph

def revFin {n : Nat} (i : Fin (n + 1)) : Fin (n + 1) :=
  ⟨n - i.1, Nat.lt_succ_of_le (Nat.sub_le _ _)⟩

theorem revFin_zero {n : Nat} :
    (revFin ⟨0, Nat.succ_pos n⟩).1 = n := by
  simp [revFin]

theorem revFin_last {n : Nat} :
    (revFin ⟨n, Nat.lt_succ_self n⟩).1 = 0 := by
  simp [revFin]

theorem revFin_involutive_val {n : Nat} (i : Fin (n + 1)) :
    (revFin (revFin i)).1 = i.1 := by
  have hi : i.1 ≤ n := Nat.le_of_lt_succ i.2
  simp [revFin, Nat.sub_sub_self hi]

end FMT.Graph
