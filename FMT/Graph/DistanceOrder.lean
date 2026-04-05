import FMT.Graph.DistancePath

namespace FMT.Graph

def DistLE (G : Graph) (u v : G.V) (r : Nat) : Prop :=
  ∃ d, dist? (G:=G) u v = some d ∧ d ≤ r

def DistGT (G : Graph) (u v : G.V) (r : Nat) : Prop :=
  ∀ d, dist? (G:=G) u v = some d → r < d

theorem distLE_of_eq
    (G : Graph) (u v : G.V) {d r : Nat}
    (h : dist? (G:=G) u v = some d) (hdr : d ≤ r) :
    DistLE G u v r := by
  exact ⟨d, h, hdr⟩

theorem not_distLE_of_none
    (G : Graph) (u v : G.V) (r : Nat)
    (h : dist? (G:=G) u v = none) :
    ¬ DistLE G u v r := by
  intro hle
  rcases hle with ⟨d, hd, _⟩
  simp [h] at hd

theorem distGT_of_none
    (G : Graph) (u v : G.V) (r : Nat)
    (h : dist? (G:=G) u v = none) :
    DistGT G u v r := by
  intro d hd
  simp [h] at hd

theorem not_distGT_of_distLE
    (G : Graph) (u v : G.V) (r : Nat)
    (hle : DistLE G u v r) :
    ¬ DistGT G u v r := by
  rcases hle with ⟨d, hd, hdr⟩
  intro hgt
  exact Nat.not_lt_of_ge hdr (hgt d hd)

end FMT.Graph
