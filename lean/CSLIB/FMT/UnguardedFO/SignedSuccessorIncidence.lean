import CSLIB.FMT.UnguardedFO.ImportedSharpCliqueEntropy

namespace CSLIB.FMT.UnguardedFO
open URF.EntropyBridge

/-- A bijective successor indexing of the unoriented edges of a simple graph. -/
structure SuccessorEdges {V : Type*} (G : SimpleGraph V) where
  next : Equiv.Perm V
  adj : ∀ u, G.Adj u (next u)
  unique : ∀ u v, (u = next v ∧ next u = v) → u = v
  cover : ∀ u v, G.Adj u v → ∃ w, (u = w ∧ v = next w) ∨ (v = w ∧ u = next w)

namespace SuccessorEdges
variable {V : Type*} [LinearOrder V] {G : SimpleGraph V}

private def sortedAdjacentEdge {V : Type*} [LinearOrder V] {G : SimpleGraph V}
    {u v : V} (ha : G.Adj u v) : OrderedEdge G :=
  if h : u < v then ⟨(u, v), h, ha⟩
  else ⟨(v, u), lt_of_le_of_ne (le_of_not_gt h) ha.ne.symm, ha.symm⟩

private theorem sortedAdjacentEdge_endpoints {V : Type*} [LinearOrder V] {G : SimpleGraph V}
    {u v : V} (ha : G.Adj u v) :
    (sortedAdjacentEdge ha).val = (u, v) ∨ (sortedAdjacentEdge ha).val = (v, u) := by
  unfold sortedAdjacentEdge
  split
  · exact Or.inl rfl
  · exact Or.inr rfl

private theorem orderedEdge_cannot_swap {V : Type*} [LinearOrder V] {G : SimpleGraph V}
    (a b : OrderedEdge G) (h : a.val = (b.val.2, b.val.1)) : False := by
  have hlt := a.property.1
  rw [h] at hlt
  exact b.property.1.not_gt hlt

variable (s : SuccessorEdges G)

def orderedEdge (u : V) : OrderedEdge G := sortedAdjacentEdge (s.adj u)

theorem endpoints (u : V) :
    (s.orderedEdge u).val = (u, s.next u) ∨
      (s.orderedEdge u).val = (s.next u, u) :=
  sortedAdjacentEdge_endpoints _

noncomputable def edgeEquiv : V ≃ OrderedEdge G := by
  apply Equiv.ofBijective s.orderedEdge
  constructor
  · intro u v he
    have he' := congrArg Subtype.val he
    rcases s.endpoints u with hu | hu <;>
      rcases s.endpoints v with hv | hv <;>
      rw [hu, hv, Prod.mk.injEq] at he'
    · exact he'.1
    · exact s.unique u v he'
    · exact s.unique u v ⟨he'.2, he'.1⟩
    · exact he'.2
  · intro e
    obtain ⟨w, hw | hw⟩ := s.cover _ _ e.property.2
    · refine ⟨w, Subtype.ext ?_⟩
      rcases s.endpoints w with he | he
      · exact he.trans (Prod.ext hw.1 hw.2).symm
      · exact False.elim (orderedEdge_cannot_swap _ e
          (he.trans (Prod.ext hw.2 hw.1).symm))
    · refine ⟨w, Subtype.ext ?_⟩
      rcases s.endpoints w with he | he
      · exact False.elim (orderedEdge_cannot_swap _ e
          (he.trans (Prod.ext hw.1 hw.2).symm))
      · exact he.trans (Prod.ext hw.2 hw.1).symm

variable (K : Type*) [Field K]

noncomputable def edgeSign (u : V) : K :=
  if (s.edgeEquiv u).val.1 = u then 1 else -1

theorem edgeSign_sq (u : V) :
    s.edgeSign K u * s.edgeSign K u = 1 := by
  unfold edgeSign
  split <;> simp

/-- Reindex source coordinates by the canonical edges, reversing the sign
when the canonical orientation differs from the cyclic direction. -/
noncomputable def signedEdges :
    (V → K) ≃ₗ[K]
      (OrderedEdge G → K) where
  toFun z e := s.edgeSign K ((s.edgeEquiv).symm e) *
    z ((s.edgeEquiv).symm e)
  invFun z u := s.edgeSign K u * z (s.edgeEquiv u)
  left_inv z := by
    funext u
    simp [← mul_assoc, edgeSign_sq]
  right_inv z := by
    funext e
    simp [← mul_assoc, edgeSign_sq]
  map_add' z w := by
    funext e
    exact mul_add _ _ _
  map_smul' a z := by
    funext e
    change _ * (a * _) = a * (_ * _)
    ring

theorem signedEdges_apply_edge (z : V → K) (u : V) :
    s.signedEdges K z (s.edgeEquiv u) = s.edgeSign K u * z u := by
  change _ * z (s.edgeEquiv.symm (s.edgeEquiv u)) = _
  rw [Equiv.symm_apply_apply]

theorem signedEdges_ne_zero_iff (z : V → K) (u : V) :
    s.signedEdges K z (s.edgeEquiv u) ≠ 0 ↔ z u ≠ 0 := by
  have hsign : s.edgeSign K u ≠ 0 := by
    intro hz
    simpa [hz] using s.edgeSign_sq K u
  rw [s.signedEdges_apply_edge K, mul_ne_zero_iff]
  simp [hsign]

theorem signed_incidence (u v : V) :
    simpleGraphIncidence (K := K) G v
        (s.edgeEquiv u) * s.edgeSign K u =
      (if v = s.next u then 1 else 0) - (if v = u then 1 else 0) := by
  have hn : u ≠ s.next u :=
    (s.adj u).ne
  have hnrev := hn.symm
  have he : (s.edgeEquiv u).val = (u, s.next u) ∨
      (s.edgeEquiv u).val = (s.next u, u) :=
    s.endpoints u
  rcases he with he | he <;>
    by_cases hv : v = u <;> by_cases hw : v = s.next u <;>
    simp_all [simpleGraphIncidence, edgeSign]

variable [Fintype V]

/-- With source-indexed cycle coordinates, the incidence row at a vertex
is the directed difference evaluated at its predecessor. -/
theorem boundary_intertwines
    (z : V → K) (v : V) :
    simpleGraphBoundary G (s.signedEdges K z) v =
      z (s.next.symm v) - z v := by
  classical
  let E := s.edgeEquiv
  let P := s.next
  change (∑ e : OrderedEdge G, simpleGraphIncidence (K := K) G v e *
    (s.signedEdges K z) e) = z (P.symm v) - z v
  calc
    _ = ∑ u : V, simpleGraphIncidence (K := K) G v (E u) *
          (s.signedEdges K z) (E u) := (E.sum_comp _).symm
    _ = ∑ u : V,
          ((if v = P u then (1 : K) else 0) - (if v = u then 1 else 0)) * z u := by
      apply Finset.sum_congr rfl
      intro u _
      rw [s.signedEdges_apply_edge K, ← mul_assoc, s.signed_incidence K]
    _ = _ := by
      simp only [sub_mul, Finset.sum_sub_distrib, ite_mul, one_mul, zero_mul]
      have he (u : V) : v = P u ↔ u = P.symm v := by
        rw [eq_comm, Equiv.apply_eq_iff_eq_symm_apply]
      simp [he, eq_comm (a := v)]

/-- The same reindexing identifies the kernel of any successor boundary
given by the predecessor-minus-current incidence rows. -/
noncomputable def kernelEquiv (B : (V → K) →ₗ[K] (V → K))
    (hB : ∀ z v, B z v = z (s.next.symm v) - z v) :
    LinearMap.ker B ≃ₗ[K] LinearMap.ker (simpleGraphBoundary (K := K) G) where
  toFun z := ⟨s.signedEdges K z, LinearMap.mem_ker.mpr (by
    funext v
    rw [s.boundary_intertwines K, ← hB, LinearMap.mem_ker.mp z.property])⟩
  invFun y := ⟨(s.signedEdges K).symm y, LinearMap.mem_ker.mpr (by
    funext v
    rw [hB, ← s.boundary_intertwines K,
      LinearEquiv.apply_symm_apply, LinearMap.mem_ker.mp y.property])⟩
  left_inv z := Subtype.ext ((s.signedEdges K).symm_apply_apply z)
  right_inv y := Subtype.ext ((s.signedEdges K).apply_symm_apply y)
  map_add' z w := Subtype.ext ((s.signedEdges K).map_add z w)
  map_smul' a z := Subtype.ext ((s.signedEdges K).map_smul a z)

end SuccessorEdges

#print axioms SuccessorEdges.edgeEquiv
#print axioms SuccessorEdges.signedEdges
#print axioms SuccessorEdges.signedEdges_ne_zero_iff
#print axioms SuccessorEdges.signed_incidence
#print axioms SuccessorEdges.boundary_intertwines
#print axioms SuccessorEdges.kernelEquiv

end CSLIB.FMT.UnguardedFO
