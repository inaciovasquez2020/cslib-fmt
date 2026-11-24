import Mathlib

namespace LogicalEntropy

theorem two_point_error (dG dH a : ℝ) :
    |dH - dG| / 2 ≤ max |a - dG| |a - dH| := by
  have ht : |dH - dG| ≤ |dH - a| + |a - dG| := by
    calc
      |dH - dG| = |(dH - a) + (a - dG)| := by
        congr 1
        ring
      _ ≤ _ := abs_add_le _ _
  rw [abs_sub_comm dH a] at ht
  have hG : |a - dG| ≤ max |a - dG| |a - dH| := le_max_left _ _
  have hH : |a - dH| ≤ max |a - dG| |a - dH| := le_max_right _ _
  linarith

theorem invariant_estimator_lower_bound {α : Type*}
    (R : α → α → Prop) (D A : α → ℝ)
    (hInv : ∀ x y, R x y → A x = A y)
    (G H : α) (hGH : R G H) :
    |D H - D G| / 2 ≤ max |A G - D G| |A H - D H| := by
  rw [← hInv G H hGH]
  exact two_point_error (D G) (D H) (A G)

theorem entropy_gap_lower_bound {α : Type*}
    (R : α → α → Prop) (D A : α → ℝ)
    (hInv : ∀ x y, R x y → A x = A y)
    (G H : α) (hGH : R G H)
    (m q : ℝ) (hm : 0 ≤ m) (hq : 1 ≤ q)
    (hgap : D H - D G = m * Real.log q) :
    m * Real.log q / 2 ≤ max |A G - D G| |A H - D H| := by
  have h := invariant_estimator_lower_bound R D A hInv G H hGH
  rw [hgap, abs_of_nonneg (mul_nonneg hm (Real.log_nonneg hq))] at h
  exact h

#print axioms LogicalEntropy.two_point_error
#print axioms LogicalEntropy.invariant_estimator_lower_bound
#print axioms LogicalEntropy.entropy_gap_lower_bound

end LogicalEntropy
