import CSLIB.FMT.UnguardedFO.CyclePartitionNeighborhood
import CSLIB.FMT.UnguardedFO.ImportedLogicalEntropyEstimator

/-! Ported from URF-Core at d5916b12a6eb2df34fb150ce2e804236f077e7c7 (PR #603). -/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

/-- Admissible disjoint cycle families with fixed order and minimum length. -/
structure AdmissibleCycleFamily (N L : ℕ) where
  sizes : List ℕ
  total : sizes.sum = N
  minLength : ∀ t ∈ sizes, L ≤ t

/-- Orient the edges using the lexicographic order on component and position. -/
local instance cyclePartitionVertexOrder (sizes : List ℕ) : LinearOrder (CyclePartitionVertex sizes) :=
  Sigma.Lex.linearOrder

noncomputable abbrev AdmissibleCycleSpace (K : Type*) [Field K] {N L : ℕ}
    (g : AdmissibleCycleFamily N L) :=
  LinearMap.ker (simpleGraphBoundary (K := K) (cyclePartitionSimpleGraph g.sizes))

noncomputable instance admissibleCycleSpaceFintype (K : Type*) [Field K] [Fintype K]
    {N L : ℕ} (g : AdmissibleCycleFamily N L) : Fintype (AdmissibleCycleSpace K g) :=
  Fintype.ofFinite _

noncomputable def admissibleCycleEntropy (K : Type*) [Field K] [Fintype K]
    {N L : ℕ} (g : AdmissibleCycleFamily N L) : ℝ :=
  finiteEntropy (fun _ : AdmissibleCycleSpace K g =>
    (1 : ℝ) / Fintype.card (AdmissibleCycleSpace K g))

theorem admissibleCycleEntropy_eq (K : Type*) [Field K] [Fintype K]
    {N L : ℕ} (hL : 3 ≤ L) (g : AdmissibleCycleFamily N L) :
    admissibleCycleEntropy K g = (g.sizes.length : ℝ) *
      Real.log (Fintype.card K) := by
  have h3 (i : Fin g.sizes.length) : 3 ≤ g.sizes.get i :=
    hL.trans (g.minLength _ (List.get_mem _ _))
  have hp (i : Fin g.sizes.length) : 0 < g.sizes.get i := by have := h3 i; omega
  unfold admissibleCycleEntropy
  rw [uniform_entropy_exact_candidate, Module.card_eq_pow_finrank (K := K),
    Nat.cast_pow, Real.log_pow]
  change (Module.finrank K (LinearMap.ker
    (simpleGraphBoundary (K := K) (cyclePartitionSimpleGraph g.sizes))) : ℝ) * _ = _
  rw [cyclePartition_incidenceKernel_finrank h3 hp K]

noncomputable def admissibleCycleObservation {N L : ℕ} (r : ℕ)
    (g : AdmissibleCycleFamily N L) : Multiset RootedNeighborhoodClass :=
  rootedNeighborhoodObservation (cyclePartitionSimpleGraph g.sizes) r

theorem admissibleCycleObservation_eq {N L r : ℕ}
    (hL : max 3 (2 * r + 2) ≤ L) (g : AdmissibleCycleFamily N L) :
    admissibleCycleObservation r g = Multiset.replicate N (centeredPathClass r) := by
  have hm (i : Fin g.sizes.length) : max 3 (2 * r + 2) ≤ g.sizes.get i :=
    hL.trans (g.minLength _ (List.get_mem _ _))
  unfold admissibleCycleObservation
  rw [cyclePartition_neighborhoodObservation_eq_replicate r
    (fun i => (le_max_left _ _).trans (hm i)) (fun i => (le_max_right _ _).trans (hm i)),
    cyclePartition_vertices_card, ← List.sum_ofFn, List.ofFn_get, g.total]

/-- Sharp worst-case absolute error for deterministic estimation from the
multiset of actual rooted induced radius balls. -/
theorem cyclePartition_radius_minimax
    (K : Type*) [Field K] [Fintype K] (N L r : ℕ)
    (hNL : L ≤ N) (hL : max 3 (2 * r + 2) ≤ L) :
    (∀ estimate : Multiset RootedNeighborhoodClass → ℝ,
      ∃ g : AdmissibleCycleFamily N L,
        ((((N / L : ℕ) : ℝ) - 1) * Real.log (Fintype.card K)) / 2 ≤
          |estimate (admissibleCycleObservation r g) - admissibleCycleEntropy K g|) ∧
    (∃ estimate : Multiset RootedNeighborhoodClass → ℝ,
      ∀ g : AdmissibleCycleFamily N L,
        |estimate (admissibleCycleObservation r g) - admissibleCycleEntropy K g| ≤
          ((((N / L : ℕ) : ℝ) - 1) * Real.log (Fintype.card K)) / 2) := by
  have h3 := (le_max_left 3 (2 * r + 2)).trans hL
  have hp : 0 < L := by omega
  let M := N / L
  let w := Real.log (Fintype.card K)
  have hq : 1 ≤ (Fintype.card K : ℝ) := by exact_mod_cast Fintype.card_pos (α := K)
  have hw : 0 ≤ w := Real.log_nonneg hq
  obtain ⟨⟨lo, hloN, hloCount, hloMin⟩, ⟨hi, hhiN, hhiCount, hhiMin⟩⟩ :=
    cyclePartition_extremizers N L hNL hp
  let glo : AdmissibleCycleFamily N L := ⟨lo, hloN, hloMin⟩
  let ghi : AdmissibleCycleFamily N L := ⟨hi, hhiN, hhiMin⟩
  have hrange (g : AdmissibleCycleFamily N L) :
      1 ≤ g.sizes.length ∧ g.sizes.length ≤ M := by
    refine ⟨?_, cyclePartition_count_le N L hp g.sizes g.total g.minLength⟩
    by_contra hn
    have hempty := List.length_eq_zero_iff.mp (show g.sizes.length = 0 by omega)
    have hzero : N = 0 := by simpa [hempty] using g.total.symm
    omega
  constructor
  · intro estimate
    let obs := admissibleCycleObservation (N := N) (L := L) r
    have he : obs glo = obs ghi :=
      (admissibleCycleObservation_eq hL glo).trans (admissibleCycleObservation_eq hL ghi).symm
    have hM : (1 : ℝ) ≤ (M : ℝ) := by exact_mod_cast Nat.div_pos hNL hp
    have hgap : admissibleCycleEntropy K ghi - admissibleCycleEntropy K glo =
        ((M : ℝ) - 1) * Real.log (Fintype.card K) := by
      rw [admissibleCycleEntropy_eq K h3, admissibleCycleEntropy_eq K h3]
      change (hi.length : ℝ) * w - (lo.length : ℝ) * w = _
      rw [hhiCount, hloCount]
      push_cast
      ring
    have hlower := LogicalEntropy.entropy_gap_lower_bound
      (fun g h => obs g = obs h) (admissibleCycleEntropy K) (fun g => estimate (obs g))
      (fun _ _ h => congrArg estimate h) glo ghi he ((M : ℝ) - 1) (Fintype.card K)
      (sub_nonneg.mpr hM) hq hgap
    rcases le_max_iff.mp hlower with h | h
    · exact ⟨glo, h⟩
    · exact ⟨ghi, h⟩
  · refine ⟨fun _ => (w + (M : ℝ) * w) / 2, fun g => ?_⟩
    rw [admissibleCycleEntropy_eq K h3]
    have hlo : (1 : ℝ) ≤ g.sizes.length := by exact_mod_cast (hrange g).1
    have hhi : (g.sizes.length : ℝ) ≤ M := by exact_mod_cast (hrange g).2
    have ha := mul_le_mul_of_nonneg_right hlo hw
    have hb := mul_le_mul_of_nonneg_right hhi hw
    change |(w + (M : ℝ) * w) / 2 - (g.sizes.length : ℝ) * w| ≤
      (((M : ℝ) - 1) * w) / 2
    exact abs_le.mpr ⟨by linarith, by linarith⟩

/-- The least achievable worst-case error, with an attaining estimator. -/
theorem cyclePartition_radius_minimax_value
    (K : Type*) [Field K] [Fintype K] (N L r : ℕ)
    (hNL : L ≤ N) (hL : max 3 (2 * r + 2) ≤ L) :
    IsLeast {E : ℝ | ∃ estimate : Multiset RootedNeighborhoodClass → ℝ,
      ∀ g : AdmissibleCycleFamily N L,
        |estimate (admissibleCycleObservation r g) - admissibleCycleEntropy K g| ≤ E}
      (((((N / L : ℕ) : ℝ) - 1) * Real.log (Fintype.card K)) / 2) := by
  obtain ⟨lower, upper⟩ := cyclePartition_radius_minimax K N L r hNL hL
  refine ⟨upper, ?_⟩
  rintro E ⟨estimate, hestimate⟩
  obtain ⟨g, hg⟩ := lower estimate
  exact hg.trans (hestimate g)

#print axioms admissibleCycleEntropy
#print axioms admissibleCycleEntropy_eq
#print axioms admissibleCycleObservation_eq
#print axioms cyclePartition_radius_minimax
#print axioms cyclePartition_radius_minimax_value


end CSLIB.FMT.UnguardedFO
