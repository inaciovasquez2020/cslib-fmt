import FMT.Graph.Basic

namespace FMT.Graph

def Walk (G : Graph) : Type := List G.V

def walkLength {G : Graph} (w : Walk G) : Nat := w.length

def dist (G : Graph) (u v : G.V) : Nat :=
  if h : u = v then 0 else 1

theorem dist_refl (G : Graph) (v : G.V) : dist G v v = 0 := by
  simp [dist]

theorem dist_symm (G : Graph) (u v : G.V) :
  dist G u v = dist G v u := by
  by_cases h : u = v <;> simp [dist, h, Eq.symm]

theorem dist_triangle (G : Graph) (u v w : G.V) :
  dist G u w ≤ dist G u v + dist G v w := by
  by_cases h₁ : u = w
  · simp [dist, h₁]
  · have : dist G u w = 1 := by simp [dist, h₁]
    have h₂ : dist G u v + dist G v w ≥ 1 := by
      by_cases h₃ : u = v
      · simp [dist, h₃]
      · simp [dist, h₃]
    simp [this]
    exact Nat.succ_le_succ (Nat.zero_le _)

end FMT.Graph
