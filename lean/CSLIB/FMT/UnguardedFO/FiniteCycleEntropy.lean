import CSLIB.FMT.UnguardedFO.FiniteCycleSimpleGraph
import CSLIB.FMT.UnguardedFO.ImportedLogicalEntropyEstimator

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

/-- Actual indexed oriented edge chains of the same cyclic logical carrier,
with the span of closed-one-ball-supported circulations as observations. -/
def cyclePresentation (K : Type) [Field K] (c L : Nat) [NeZero L] :
    GraphChainPresentation K (CycleVertex c L) (CycleVertex c L) where
  boundary := cycleBoundary K c L
  localCycles := cycleLocalSpace K c L

theorem cycleObservation_finrank (K : Type) [Field K] (c L : Nat) [NeZero L]
    (hL : 4 ≤ L) :
    Module.finrank K (LinearMap.ker (graphObservation (cyclePresentation K c L))) = c := by
  rw [graphObservation_hidden_finrank]
  change Module.finrank K (LinearMap.ker (cycleBoundary K c L)) -
    Module.finrank K (cycleLocalSpace K c L) = c
  rw [cycleKernel_finrank, cycleLocalSpace_eq_bot K c L hL]
  set_option synthInstance.maxHeartbeats 200000 in
    simp

private theorem finiteDual {K V : Type*} [Field K] [Finite K]
    [AddCommMonoid V] [Module K V] [Finite V] : Finite (Module.Dual K V) :=
  Finite.of_injective (fun f : Module.Dual K V => fun x => f x)
    (by intro f g h; ext x; exact congrFun h x)

/-- Weighted conditional Shannon entropy of uniform dual samples restricted
to the presentation's actual local cycle subspace. -/
noncomputable def presentationConditionalEntropy {K V E : Type*} [Field K] [Fintype K]
    [Fintype V] [Fintype E] (G : GraphChainPresentation K V E) : ℝ := by
  classical
  letI : Finite (graphCycles G) := Finite.of_injective Subtype.val Subtype.val_injective
  letI : Fintype (Module.Dual K (graphCycles G)) := @Fintype.ofFinite _ finiteDual
  letI : Finite G.localCycles := Finite.of_injective Subtype.val Subtype.val_injective
  letI : Fintype (Module.Dual K G.localCycles) := @Fintype.ofFinite _ finiteDual
  exact ∑ y : Module.Dual K G.localCycles,
    observedMass (uniformFiniteProbability _).mass (graphObservation G) y *
    finiteEntropy (conditionalMass (uniformFiniteProbability _).mass (graphObservation G) y)

theorem presentationConditionalEntropy_eq_finrank {K V E : Type*} [Field K] [Fintype K]
    [Fintype V] [Fintype E] (G : GraphChainPresentation K V E) :
    presentationConditionalEntropy G =
      (Module.finrank K (LinearMap.ker (graphObservation G)) : ℝ) *
        Real.log (Fintype.card K) := by
  classical
  unfold presentationConditionalEntropy
  letI : Finite (graphCycles G) := Finite.of_injective Subtype.val Subtype.val_injective
  letI : Fintype (Module.Dual K (graphCycles G)) := @Fintype.ofFinite _ finiteDual
  letI : Finite G.localCycles := Finite.of_injective Subtype.val Subtype.val_injective
  letI : Fintype (Module.Dual K G.localCycles) := @Fintype.ofFinite _ finiteDual
  letI : Fintype (LinearMap.ker (graphObservation G)) := Fintype.ofFinite _
  rw [linear_uniform_conditional_entropy_exact_candidate, Module.card_eq_pow_finrank (K := K),
    Nat.cast_pow, Real.log_pow]

noncomputable def cycleEntropy (K : Type) [Field K] [Fintype K]
    (c L : Nat) [NeZero L] : ℝ :=
  presentationConditionalEntropy (cyclePresentation K c L)

theorem cycleEntropy_exact (K : Type) [Field K] [Fintype K]
    (c L : Nat) [NeZero L] (hL : 4 ≤ L) :
    cycleEntropy K c L = (c : ℝ) * Real.log (Fintype.card K) := by
  rw [cycleEntropy, presentationConditionalEntropy_eq_finrank, cycleObservation_finrank K c L hL]

section

variable (K : Type) [Field K] (c L : Nat) [NeZero L]
variable [LinearOrder (CycleVertex c L)] (hL : 4 ≤ L)

/-- Span of incidence-kernel vectors supported in an induced closed one-ball. -/
noncomputable def cycleGraphLocalSpace :
    Submodule K (LinearMap.ker (simpleGraphBoundary (K := K) (cycleSimpleGraph c L hL))) :=
  Submodule.span K {z | ∃ v, CycleGraphBallSupported K c L hL v z}

theorem cycleGraphLocalSpace_eq_map :
    (cycleLocalSpace K c L).map (cycleSimpleGraphKernelEquiv K c L hL).toLinearMap =
      cycleGraphLocalSpace K c L hL := by
  let E := cycleSimpleGraphKernelEquiv K c L hL
  have h :
      E '' {z | ∃ v, CycleBallSupported v z} =
        {z | ∃ v, CycleGraphBallSupported K c L hL v z} := by
    ext y
    constructor
    · rintro ⟨z, ⟨v, hv⟩, rfl⟩
      exact ⟨v, (cycleSimpleGraph_ballSupported_iff K c L hL v z).mpr hv⟩
    · rintro ⟨v, hv⟩
      let z := E.symm y
      have hz : E z = y := E.apply_symm_apply y
      refine ⟨z, ⟨v, (cycleSimpleGraph_ballSupported_iff K c L hL v z).mp ?_⟩, hz⟩
      change CycleGraphBallSupported K c L hL v (E z)
      rwa [hz]
  rw [cycleLocalSpace, cycleGraphLocalSpace, Submodule.map_span]
  exact congrArg (Submodule.span K) h

theorem cycleGraphLocalSpace_eq_bot : cycleGraphLocalSpace K c L hL = ⊥ := by
  rw [← cycleGraphLocalSpace_eq_map, cycleLocalSpace_eq_bot K c L hL, Submodule.map_bot]

noncomputable def cycleGraphPresentation :
    GraphChainPresentation K (CycleVertex c L) (OrderedEdge (cycleSimpleGraph c L hL)) where
  boundary := simpleGraphBoundary (cycleSimpleGraph c L hL)
  localCycles := cycleGraphLocalSpace K c L hL

theorem cycleGraphObservation_eq_zero
    (x : Module.Dual K (graphCycles (cycleGraphPresentation K c L hL))) :
    graphObservation (cycleGraphPresentation K c L hL) x = 0 := by
  ext y
  have hy : y = 0 := by
    apply Subtype.ext
    have hm := y.property
    change y.val ∈ cycleGraphLocalSpace K c L hL at hm
    rw [cycleGraphLocalSpace_eq_bot] at hm
    exact (Submodule.mem_bot K).mp hm
  simp [hy]

variable [Fintype K]

noncomputable def cycleGraphEntropy : ℝ :=
  presentationConditionalEntropy (cycleGraphPresentation K c L hL)

theorem cycleGraphEntropy_exact :
    cycleGraphEntropy K c L hL = (c : ℝ) * Real.log (Fintype.card K) := by
  rw [cycleGraphEntropy, presentationConditionalEntropy_eq_finrank, graphObservation_hidden_finrank]
  change ((Module.finrank K (LinearMap.ker (simpleGraphBoundary (K := K)
    (cycleSimpleGraph c L hL))) - Module.finrank K (cycleGraphLocalSpace K c L hL) : ℕ) : ℝ) *
      Real.log (Fintype.card K) = _
  rw [cycleSimpleGraphKernel_finrank K c L hL, cycleGraphLocalSpace_eq_bot K c L hL]
  simp only [finrank_bot, Nat.sub_zero]

theorem cycleGraphEntropy_transport : cycleGraphEntropy K c L hL = cycleEntropy K c L :=
  (cycleGraphEntropy_exact K c L hL).trans (cycleEntropy_exact K c L hL).symm

end

/-- Positive lengths, with the bound required by the EF strategy. -/
def witnessLength (r : Nat) : Nat :=
  ((r : Int) * (2 * shiftRadius r + 1) + shiftRadius r + 4).toNat

theorem witnessLength_bounds (r : Nat) :
    4 ≤ witnessLength r ∧
    shiftRadius r < (witnessLength r : Int) ∧
    (r : Int) * (2 * shiftRadius r + 1) < (witnessLength r : Int) := by
  have hp := shiftRadius_pos r
  have hn : 0 ≤ (r : Int) * (2 * shiftRadius r + 1) :=
    mul_nonneg (by omega) (by omega)
  unfold witnessLength
  have ht : 0 ≤ (r : Int) * (2 * shiftRadius r + 1) + shiftRadius r + 4 := by omega
  rw [Int.toNat_of_nonneg ht]
  omega

/-- Finite cyclic systems with positive length; no entropy parameter or
logical equivalence is postulated as part of an instance. -/
structure CycleParameters where
  components : Nat
  length : Nat
  positiveLength : 0 < length

instance (p : CycleParameters) : NeZero p.length :=
  ⟨Nat.ne_of_gt p.positiveLength⟩

def cycleStructure (p : CycleParameters) : RelStructure shiftGraphLanguage :=
  shiftGraph (cycleShift p.components p.length)

/-- A canonical order for the incidence coordinates of the logical graph. -/
noncomputable local instance cycleWitnessVertexOrder (c L : Nat) [NeZero L] :
    LinearOrder (CycleVertex c L) :=
  LinearOrder.lift' (Fintype.equivFin (CycleVertex c L)) (Fintype.equivFin _).injective

noncomputable def cycleDeficit (K : Type) [Field K] [Fintype K]
    (p : CycleParameters) : ℝ :=
  if hL : 4 ≤ p.length then cycleGraphEntropy K p.components p.length hL
  else cycleEntropy K p.components p.length

theorem cycleDeficit_eq_graph (K : Type) [Field K] [Fintype K]
    (p : CycleParameters) (hL : 4 ≤ p.length) :
    cycleDeficit K p = cycleGraphEntropy K p.components p.length hL := by
  simp [cycleDeficit, hL]

theorem cycleDeficit_eq_indexed (K : Type) [Field K] [Fintype K]
    (p : CycleParameters) : cycleDeficit K p = cycleEntropy K p.components p.length := by
  by_cases hL : 4 ≤ p.length
  · rw [cycleDeficit_eq_graph K p hL, cycleGraphEntropy_transport]
  · simp [cycleDeficit, hL]

def cycleOrder (p : CycleParameters) : Nat := p.components * p.length

theorem cycleOrder_eq_card (p : CycleParameters) :
    Fintype.card (CycleVertex p.components p.length) = cycleOrder p := by
  simp [CycleVertex, cycleOrder, Fintype.card_prod, ZMod.card]

/-- Arbitrary gap m log |K| at every finite quantifier rank, with equal order. -/
theorem logicalEntropy_witnesses (K : Type) [Field K] [Fintype K] (r m : Nat) :
    ∃ G H : CycleParameters,
      4 ≤ G.length ∧ 4 ≤ H.length ∧
      cycleOrder G = cycleOrder H ∧
      RankEquivalent (cycleStructure G) (cycleStructure H) r ∧
      cycleDeficit K H - cycleDeficit K G = (m : ℝ) * Real.log (Fintype.card K) := by
  let L := witnessLength r
  obtain ⟨hL, hr, hs⟩ := witnessLength_bounds r
  have hp : 0 < L := by omega
  have hm : 0 < (m+1 : Nat) := by omega
  let G : CycleParameters := ⟨1, (m+1)*L, Nat.mul_pos hm hp⟩
  let H : CycleParameters := ⟨m+1, L, hp⟩
  have hLG : 4 ≤ G.length := by
    change 4 ≤ (m+1)*L
    have hle : L ≤ (m+1)*L := by
      simpa using Nat.mul_le_mul_right L (show 1 ≤ m+1 by omega)
    omega
  refine ⟨G,H,hLG,hL,?_,?_,?_⟩
  · simp [cycleOrder,G,H]
  · exact oneCycle_manyCycles_rankEquivalent (m+1) L r (by omega) hL hr hs
  · rw [cycleDeficit_eq_graph K H hL, cycleDeficit_eq_graph K G hLG,
      cycleGraphEntropy_exact, cycleGraphEntropy_exact]
    simp only [G, H, Nat.cast_one, Nat.cast_add]
    ring

/-- Estimator impossibility for arbitrary rank-invariant real-valued estimators
on the cyclic family, with an explicit unbounded gap parameter. -/
theorem logicalEntropy_estimator_lower_bound (K : Type) [Field K] [Fintype K]
    (r m : Nat) (A : CycleParameters → ℝ)
    (hInv : ∀ G H, RankEquivalent (cycleStructure G) (cycleStructure H) r → A G = A H) :
    ∃ G H : CycleParameters,
      cycleOrder G = cycleOrder H ∧
      RankEquivalent (cycleStructure G) (cycleStructure H) r ∧
      (m : ℝ) * Real.log (Fintype.card K) / 2 ≤
        max |A G - cycleDeficit K G| |A H - cycleDeficit K H| := by
  obtain ⟨G,H,_,_,he,hr,hgap⟩ := logicalEntropy_witnesses K r m
  refine ⟨G,H,he,hr,?_⟩
  apply LogicalEntropy.entropy_gap_lower_bound
    (fun G H => RankEquivalent (cycleStructure G) (cycleStructure H) r)
    (cycleDeficit K) A hInv G H hr _ _ (by positivity) ?_ hgap
  exact_mod_cast Fintype.card_pos (α := K)

#print axioms presentationConditionalEntropy_eq_finrank
#print axioms cycleGraphLocalSpace_eq_map
#print axioms cycleGraphLocalSpace_eq_bot
#print axioms cycleGraphObservation_eq_zero
#print axioms cycleGraphEntropy_exact
#print axioms cycleGraphEntropy_transport
#print axioms cycleDeficit_eq_graph
#print axioms cycleDeficit_eq_indexed
#print axioms cycleObservation_finrank
#print axioms cycleEntropy_exact
#print axioms witnessLength_bounds
#print axioms cycleOrder_eq_card
#print axioms logicalEntropy_witnesses
#print axioms logicalEntropy_estimator_lower_bound

end CSLIB.FMT.UnguardedFO
