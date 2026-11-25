import CSLIB.FMT.UnguardedFO.SignedSuccessorIncidence

/-! Ported from URF-Core at d5916b12a6eb2df34fb150ce2e804236f077e7c7 (PR #603). -/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

/-- Vertices of the disjoint union of the cycles specified by a length list. -/
abbrev CyclePartitionVertex (sizes : List ℕ) :=
  Σ i : Fin sizes.length, Fin (sizes.get i)

/-- Clockwise successor relation, including the last-to-first edge. -/
def cyclePartitionSuccessorRel (sizes : List ℕ)
    (u v : CyclePartitionVertex sizes) : Prop :=
  u.1 = v.1 ∧
    (u.2.val + 1 = v.2.val ∨
      (u.2.val + 1 = sizes.get u.1 ∧ v.2.val = 0))

/-- An actual finite simple graph: the symmetric, irreflexive closure of
the successor edges within each listed cycle. -/
def cyclePartitionSimpleGraph (sizes : List ℕ) :
    SimpleGraph (CyclePartitionVertex sizes) :=
  SimpleGraph.fromRel (cyclePartitionSuccessorRel sizes)

/-- Each edge preserves the explicit component label. -/
theorem cyclePartition_adj_same_component (sizes : List ℕ)
    (u v : CyclePartitionVertex sizes)
    (h : (cyclePartitionSimpleGraph sizes).Adj u v) :
    u.1 = v.1 := by
  change u ≠ v ∧
    (cyclePartitionSuccessorRel sizes u v ∨
      cyclePartitionSuccessorRel sizes v u) at h
  rcases h.2 with huv | hvu
  · exact huv.1
  · exact hvu.1.symm

/-- The resulting graph has a finite vertex set, even when the list
contains zero-sized entries (the intended cycle class additionally
requires all lengths at least three). -/
theorem cyclePartition_vertices_finite (sizes : List ℕ) :
    Finite (CyclePartitionVertex sizes) := inferInstance

/-- Exact cardinality of the dependent vertex carrier, indexed by
the lengths of its constituent cycle components. -/
theorem cyclePartition_vertices_card (sizes : List ℕ) :
    Fintype.card (CyclePartitionVertex sizes) =
      ∑ i : Fin sizes.length, sizes.get i := by
  simp only [CyclePartitionVertex, Fintype.card_sigma, Fintype.card_fin]


/-- Cyclic successor of a vertex in its indexed block. -/
def cyclePartitionNext (sizes : List ℕ)
    (hpos : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (v : CyclePartitionVertex sizes) : CyclePartitionVertex sizes :=
  ⟨v.1, ⟨(v.2.val + 1) % sizes.get v.1,
    Nat.mod_lt _ (hpos v.1)⟩⟩

/-- A directed incidence boundary with one edge coordinate per vertex:
zero boundary means invariance under the cyclic successor. -/
def cyclePartitionDirectedBoundary (K : Type*) [Field K]
    (sizes : List ℕ)
    (hpos : ∀ i : Fin sizes.length, 0 < sizes.get i) :
    (CyclePartitionVertex sizes → K) →ₗ[K]
      (CyclePartitionVertex sizes → K) where
  toFun z v := z v - z (cyclePartitionNext sizes hpos v)
  map_add' z w := by
    funext v
    change (z v + w v) -
      (z (cyclePartitionNext sizes hpos v) +
        w (cyclePartitionNext sizes hpos v)) =
      (z v - z (cyclePartitionNext sizes hpos v)) +
        (w v - w (cyclePartitionNext sizes hpos v))
    ring
  map_smul' a z := by
    funext v
    change a * z v - a * z (cyclePartitionNext sizes hpos v) =
      a * (z v - z (cyclePartitionNext sizes hpos v))
    ring

/-- A kernel vector has equal coefficients at consecutive positions. -/
theorem cyclePartitionDirectedKernel_succ
    {K : Type*} [Field K]
    (sizes : List ℕ)
    (hpos : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (z : LinearMap.ker (cyclePartitionDirectedBoundary K sizes hpos))
    (i : Fin sizes.length) (n : ℕ)
    (hn : n < sizes.get i) (hn1 : n + 1 < sizes.get i) :
    z.val (⟨i, ⟨n, hn⟩⟩ : CyclePartitionVertex sizes) =
      z.val (⟨i, ⟨n + 1, hn1⟩⟩ : CyclePartitionVertex sizes) := by
  have hz := congrFun (LinearMap.mem_ker.mp z.property)
    (⟨i, ⟨n, hn⟩⟩ : CyclePartitionVertex sizes)
  change z.val (⟨i, ⟨n, hn⟩⟩ : CyclePartitionVertex sizes) -
    z.val (cyclePartitionNext sizes hpos
      (⟨i, ⟨n, hn⟩⟩ : CyclePartitionVertex sizes)) = 0 at hz
  have hs : cyclePartitionNext sizes hpos
      (⟨i, ⟨n, hn⟩⟩ : CyclePartitionVertex sizes) =
        (⟨i, ⟨n + 1, hn1⟩⟩ : CyclePartitionVertex sizes) := by
    have hfin :
        (⟨(n + 1) % sizes.get i, Nat.mod_lt _ (hpos i)⟩ :
          Fin (sizes.get i)) = ⟨n + 1, hn1⟩ :=
      Fin.ext (Nat.mod_eq_of_lt hn1)
    exact congrArg (fun a : Fin (sizes.get i) =>
      (⟨i, a⟩ : CyclePartitionVertex sizes)) hfin
  rw [hs] at hz
  exact sub_eq_zero.mp hz

/-- Kernel coefficients are constant throughout each positive-length block. -/
theorem cyclePartitionDirectedKernel_constant
    {K : Type*} [Field K] (sizes : List ℕ)
    (hpos : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (z : LinearMap.ker (cyclePartitionDirectedBoundary K sizes hpos))
    (i : Fin sizes.length) (x : Fin (sizes.get i)) :
    z.val (⟨i, x⟩ : CyclePartitionVertex sizes) =
      z.val (⟨i, ⟨0, hpos i⟩⟩ : CyclePartitionVertex sizes) := by
  have haux : ∀ n (hn : n < sizes.get i),
      z.val (⟨i, ⟨n, hn⟩⟩ : CyclePartitionVertex sizes) =
      z.val (⟨i, ⟨0, hpos i⟩⟩ : CyclePartitionVertex sizes) := by
    intro n
    induction n with
    | zero =>
        intro hn
        rfl
    | succ n ih =>
        intro hn
        have hp : n < sizes.get i := by omega
        exact (cyclePartitionDirectedKernel_succ sizes hpos z i n hp hn).symm.trans
          (ih hp)
  exact haux x.val x.isLt

/-- No dimension claim is assumed: a circulation is exactly one field
element per indexed cycle block, via a linear equivalence. -/
noncomputable def cyclePartitionDirectedKernelEquiv
    (K : Type*) [Field K] (sizes : List ℕ)
    (hpos : ∀ i : Fin sizes.length, 0 < sizes.get i) :
    LinearMap.ker (cyclePartitionDirectedBoundary K sizes hpos) ≃ₗ[K]
      (Fin sizes.length → K) where
  toFun z i := z.val (⟨i, ⟨0, hpos i⟩⟩ : CyclePartitionVertex sizes)
  invFun a := ⟨fun v => a v.1, by
    apply LinearMap.mem_ker.mpr
    funext v
    change a v.1 - a (cyclePartitionNext sizes hpos v).1 = 0
    simp [cyclePartitionNext]⟩
  left_inv z := by
    apply Subtype.ext
    funext v
    exact (cyclePartitionDirectedKernel_constant sizes hpos z v.1 v.2).symm
  right_inv a := by rfl
  map_add' z w := by rfl
  map_smul' a z := by rfl

/-- Exact circulation dimension, valid over any field and for unequal
positive component lengths. -/
theorem cyclePartitionDirectedKernel_finrank
    (K : Type*) [Field K] (sizes : List ℕ)
    (hpos : ∀ i : Fin sizes.length, 0 < sizes.get i) :
    Module.finrank K
      (LinearMap.ker (cyclePartitionDirectedBoundary K sizes hpos)) =
      sizes.length := by
  calc
    _ = Module.finrank K (Fin sizes.length → K) :=
      (cyclePartitionDirectedKernelEquiv K sizes hpos).finrank_eq
    _ = sizes.length := by
      rw [Module.finrank_fintype_fun_eq_card, Fintype.card_fin]


variable {sizes : List ℕ}

theorem cyclePartition_successor_iff_next
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (u v : CyclePartitionVertex sizes) :
    cyclePartitionSuccessorRel sizes u v ↔ cyclePartitionNext sizes hp u = v := by
  obtain ⟨i, x⟩ := u
  obtain ⟨j, y⟩ := v
  constructor
  · rintro ⟨hij, h⟩
    change i = j at hij
    subst j
    change x.val + 1 = y.val ∨ (x.val + 1 = sizes.get i ∧ y.val = 0) at h
    apply congrArg (Sigma.mk i)
    apply Fin.ext
    change (x.val + 1) % sizes.get i = y.val
    rcases h with h | ⟨h, hy⟩
    · rw [h, Nat.mod_eq_of_lt y.isLt]
    · rw [h, hy, Nat.mod_self]
  · intro h
    have hij : i = j := congrArg Sigma.fst h
    subst j
    have hy : (x.val + 1) % sizes.get i = y.val :=
      congrArg (fun a : CyclePartitionVertex sizes => a.2.val) h
    change i = i ∧ (x.val + 1 = y.val ∨ (x.val + 1 = sizes.get i ∧ y.val = 0))
    refine ⟨rfl, ?_⟩
    by_cases ht : x.val + 1 < sizes.get i
    · exact Or.inl (by rwa [Nat.mod_eq_of_lt ht] at hy)
    · have he : x.val + 1 = sizes.get i := by have := x.isLt; omega
      exact Or.inr ⟨he, by simpa [he] using hy.symm⟩

theorem cyclePartition_next_injective
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i) :
    Function.Injective (cyclePartitionNext sizes hp) := by
  rintro ⟨i, x⟩ ⟨j, y⟩ h
  have hij : i = j := congrArg Sigma.fst h
  subst j
  have he : (x.val + 1) % sizes.get i = (y.val + 1) % sizes.get i :=
    congrArg (fun a : CyclePartitionVertex sizes => a.2.val) h
  apply congrArg (Sigma.mk i)
  apply Fin.ext
  have hm := Nat.ModEq.add_right_cancel' 1
    (show x.val + 1 ≡ y.val + 1 [MOD sizes.get i] from he)
  change x.val % sizes.get i = y.val % sizes.get i at hm
  simpa only [Nat.mod_eq_of_lt x.isLt, Nat.mod_eq_of_lt y.isLt] using hm

noncomputable def cyclePartitionNextPerm
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i) :
    Equiv.Perm (CyclePartitionVertex sizes) :=
  Equiv.ofBijective _ ⟨cyclePartition_next_injective hp,
    Finite.surjective_of_injective (cyclePartition_next_injective hp)⟩

theorem cyclePartition_next_next_ne
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i) (v : CyclePartitionVertex sizes) :
    cyclePartitionNext sizes hp (cyclePartitionNext sizes hp v) ≠ v := by
  obtain ⟨i, x⟩ := v
  intro h
  have he : (((x.val + 1) % sizes.get i) + 1) % sizes.get i = x.val :=
    congrArg (fun a : CyclePartitionVertex sizes => a.2.val) h
  have hstep := (Nat.mod_modEq (x.val + 1) (sizes.get i)).add_right 1
  have hwrap : (x.val + 1) % sizes.get i + 1 ≡ x.val [MOD sizes.get i] := by
    change ((x.val + 1) % sizes.get i + 1) % sizes.get i = x.val % sizes.get i
    rw [he, Nat.mod_eq_of_lt x.isLt]
  have hreturn : x.val ≡ x.val + 2 [MOD sizes.get i] := hwrap.symm.trans hstep
  have hdvd := (Nat.modEq_iff_dvd' (show x.val ≤ x.val + 2 by omega)).mp hreturn
  have hdiv : sizes.get i ∣ 2 := by simpa only [Nat.add_sub_cancel_left] using hdvd
  have hle := Nat.le_of_dvd (by decide : 0 < 2) hdiv
  have hm := h3 i
  omega

theorem cyclePartition_adj_iff_next
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (u v : CyclePartitionVertex sizes) :
    (cyclePartitionSimpleGraph sizes).Adj u v ↔
      cyclePartitionNext sizes hp u = v ∨ cyclePartitionNext sizes hp v = u := by
  change u ≠ v ∧ (_ ∨ _) ↔ _
  rw [cyclePartition_successor_iff_next hp, cyclePartition_successor_iff_next hp]
  refine ⟨And.right, fun h => ⟨?_, h⟩⟩
  intro he
  subst v
  have hn : cyclePartitionNext sizes hp u = u := h.elim id id
  exact cyclePartition_next_next_ne h3 hp u (by rw [hn, hn])


noncomputable def cyclePartitionSuccessorEdges {sizes : List ℕ}
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i) :
    SuccessorEdges (cyclePartitionSimpleGraph sizes) where
  next := cyclePartitionNextPerm hp
  adj u := (cyclePartition_adj_iff_next h3 hp u _).2 (Or.inl rfl)
  unique u v h := False.elim (cyclePartition_next_next_ne h3 hp u (by
    obtain ⟨h₁, h₂⟩ := h
    change u = cyclePartitionNext sizes hp v at h₁
    change cyclePartitionNext sizes hp u = v at h₂
    rw [h₂, ← h₁]))
  cover u v he := by
    rcases (cyclePartition_adj_iff_next h3 hp u v).1 he with h | h
    · exact ⟨u, Or.inl ⟨rfl, h.symm⟩⟩
    · exact ⟨v, Or.inr ⟨rfl, h.symm⟩⟩

section
variable {sizes : List ℕ}
variable (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
variable (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
variable (K : Type*) [Field K]

noncomputable def cyclePartitionPredecessorBoundary :
    (CyclePartitionVertex sizes → K) →ₗ[K] (CyclePartitionVertex sizes → K) :=
  (LinearEquiv.piCongrLeft' K (fun _ : CyclePartitionVertex sizes => K)
      (cyclePartitionNextPerm hp)).toLinearMap.comp (cyclePartitionDirectedBoundary K sizes hp)

theorem cyclePartition_predecessorBoundary_apply
    (z : CyclePartitionVertex sizes → K) (v : CyclePartitionVertex sizes) :
    cyclePartitionPredecessorBoundary hp K z v = z ((cyclePartitionNextPerm hp).symm v) - z v := by
  change z ((cyclePartitionNextPerm hp).symm v) -
    z (cyclePartitionNextPerm hp ((cyclePartitionNextPerm hp).symm v)) = _
  rw [Equiv.apply_symm_apply]

theorem cyclePartition_predecessorBoundary_ker :
    LinearMap.ker (cyclePartitionPredecessorBoundary hp K) =
      LinearMap.ker (cyclePartitionDirectedBoundary K sizes hp) := by
  unfold cyclePartitionPredecessorBoundary
  rw [LinearEquiv.ker_comp]

variable [LinearOrder (CyclePartitionVertex sizes)]

noncomputable def cyclePartitionIncidenceKernelEquiv :
    LinearMap.ker (cyclePartitionDirectedBoundary K sizes hp) ≃ₗ[K]
      LinearMap.ker (simpleGraphBoundary (K := K) (cyclePartitionSimpleGraph sizes)) :=
  (LinearEquiv.ofEq _ _ (cyclePartition_predecessorBoundary_ker hp K).symm).trans
    ((cyclePartitionSuccessorEdges h3 hp).kernelEquiv K _
      (cyclePartition_predecessorBoundary_apply hp K))

include h3 hp in
theorem cyclePartition_incidenceKernel_finrank :
    Module.finrank K
      (LinearMap.ker (simpleGraphBoundary (K := K) (cyclePartitionSimpleGraph sizes))) =
        sizes.length :=
  (cyclePartitionIncidenceKernelEquiv h3 hp K).finrank_eq.symm.trans
    (cyclePartitionDirectedKernel_finrank K sizes hp)

end


/-- A maximal-count partition of N into admissible cycle lengths:
M-1 copies of L, and one cycle absorbing the remainder, M=N/L. -/
def maximalCycleLengths (N L : ℕ) : List ℕ :=
  List.replicate (N / L - 1) L ++ [L + N % L]

theorem maximalCycleLengths_length (N L : ℕ) (hNL : L ≤ N) (hL : 0 < L) :
    (maximalCycleLengths N L).length = N / L := by
  have hm : 0 < N / L := Nat.div_pos hNL hL
  simp [maximalCycleLengths]
  omega

theorem maximalCycleLengths_sum (N L : ℕ) (hNL : L ≤ N) (hL : 0 < L) :
    (maximalCycleLengths N L).sum = N := by
  have hm : 0 < N / L := Nat.div_pos hNL hL
  have hs : N / L - 1 + 1 = N / L := by omega
  have hdiv : N % L + L * (N / L) = N := Nat.mod_add_div N L
  simp only [maximalCycleLengths, List.sum_append, List.sum_replicate,
    List.sum_cons, List.sum_nil, add_zero]
  calc
    (N / L - 1) * L + (L + N % L) =
        (N / L - 1 + 1) * L + N % L := by ring
    _ = (N / L) * L + N % L := by rw [hs]
    _ = N := by simpa [mul_comm, add_comm] using hdiv

theorem maximalCycleLengths_min (N L : ℕ) :
    ∀ t ∈ maximalCycleLengths N L, L ≤ t := by
  intro t ht
  simp only [maximalCycleLengths, List.mem_append, List.mem_replicate,
    List.mem_singleton] at ht
  rcases ht with ht | ht
  · rcases ht with ⟨_, rfl⟩
    exact le_rfl
  · subst t
    omega

/-- All cycle partitions of N with parts at least L have at most N/L parts. -/
theorem cyclePartition_count_le (N L : ℕ) (hL : 0 < L)
    (sizes : List ℕ) (hsum : sizes.sum = N)
    (hmin : ∀ t ∈ sizes, L ≤ t) :
    sizes.length ≤ N / L := by
  have hmul : sizes.length * L ≤ sizes.sum := by
    calc
      sizes.length * L = (List.replicate sizes.length L).sum := by simp
      _ ≤ sizes.sum := by
        have hsum_le :
            (sizes.map (fun _ => L)).sum ≤ (sizes.map id).sum := by
          apply List.sum_le_sum
          intro i hi
          exact hmin i hi
        have hmap : ∀ ys : List ℕ,
            ys.map (fun _ => L) = List.replicate ys.length L := by
          intro ys
          induction ys with
          | nil => rfl
          | cons x xs ih => simpa [List.replicate_succ, ih, Nat.add_comm]
        rw [← hmap sizes]
        simpa only [List.map_id] using hsum_le
  apply (Nat.le_div_iff_mul_le hL).2
  simpa [hsum] using hmul

/-- Both extreme component counts are realized as finite cycle-length
partitions, without imposing divisibility L ∣ N. -/
theorem cyclePartition_extremizers (N L : ℕ)
    (hNL : L ≤ N) (hL : 0 < L) :
    (∃ sizes : List ℕ, sizes.sum = N ∧ sizes.length = 1 ∧
      ∀ t ∈ sizes, L ≤ t) ∧
    (∃ sizes : List ℕ, sizes.sum = N ∧ sizes.length = N / L ∧
      ∀ t ∈ sizes, L ≤ t) := by
  constructor
  · refine ⟨[N], by simp, by simp, ?_⟩
    intro t ht
    simp only [List.mem_singleton] at ht
    subst t
    exact hNL
  · exact ⟨maximalCycleLengths N L,
      maximalCycleLengths_sum N L hNL hL,
      maximalCycleLengths_length N L hNL hL,
      maximalCycleLengths_min N L⟩


#print axioms cyclePartition_vertices_card
#print axioms cyclePartition_adj_iff_next
#print axioms cyclePartitionDirectedKernelEquiv
#print axioms cyclePartitionDirectedKernel_finrank
#print axioms cyclePartitionSuccessorEdges
#print axioms cyclePartition_predecessorBoundary_apply
#print axioms cyclePartition_predecessorBoundary_ker
#print axioms cyclePartitionIncidenceKernelEquiv
#print axioms cyclePartition_incidenceKernel_finrank
#print axioms cyclePartition_extremizers
#print axioms cyclePartition_count_le

end CSLIB.FMT.UnguardedFO
