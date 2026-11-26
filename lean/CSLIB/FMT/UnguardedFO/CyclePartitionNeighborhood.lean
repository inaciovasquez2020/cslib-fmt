import CSLIB.FMT.UnguardedFO.CyclePartitionCore

/-! Ported from URF-Core at d5916b12a6eb2df34fb150ce2e804236f077e7c7 (PR #603). -/

namespace CSLIB.FMT.UnguardedFO

open URF.EntropyBridge

variable {sizes : List ℕ}

private def cycleOffset (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (u : CyclePartitionVertex sizes) (d : ℤ) : CyclePartitionVertex sizes :=
  ⟨u.1, ⟨((↑u.2.val + d) % (sizes.get u.1 : ℤ)).toNat, by
    have hm : (0 : ℤ) < (sizes.get u.1 : ℤ) := by exact_mod_cast hp u.1
    have hz := Int.emod_lt_of_pos ((u.2.val : ℤ) + d) hm
    omega⟩⟩

private theorem cycleOffset_val (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (u : CyclePartitionVertex sizes) (d : ℤ) :
    ((cycleOffset hp u d).2.val : ℤ) = (↑u.2.val + d) % (sizes.get u.1 : ℤ) :=
  Int.toNat_of_nonneg (Int.emod_nonneg _ (by exact_mod_cast (hp u.1).ne'))

private theorem cycleOffset_eq (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (u : CyclePartitionVertex sizes) (d e : ℤ) :
    cycleOffset hp u d = cycleOffset hp u e ↔ d ≡ e [ZMOD (sizes.get u.1 : ℤ)] := by
  constructor
  · intro h
    apply (Int.ModEq.add_left_cancel' (u.2.val : ℤ))
    change _ % _ = _ % _
    rw [← cycleOffset_val hp u d, ← cycleOffset_val hp u e, h]
  · intro h
    cases u with
    | mk i x =>
      apply congrArg (Sigma.mk i)
      apply Fin.ext
      exact_mod_cast (cycleOffset_val hp ⟨i, x⟩ d).trans
        ((h.add_left (x.val : ℤ)).eq.trans (cycleOffset_val hp ⟨i, x⟩ e).symm)

private theorem cycleOffset_zero (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (u : CyclePartitionVertex sizes) : cycleOffset hp u 0 = u := by
  cases u with
  | mk i x =>
    apply congrArg (Sigma.mk i)
    apply Fin.ext
    have ht : (x.val : ℤ) < (sizes.get i : ℤ) := by exact_mod_cast x.isLt
    have h := cycleOffset_val hp ⟨i, x⟩ 0
    rw [add_zero, Int.emod_eq_of_lt (by positivity) ht] at h
    exact_mod_cast h

private theorem cycleOffset_add (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (u : CyclePartitionVertex sizes) (d e : ℤ) :
    cycleOffset hp (cycleOffset hp u d) e = cycleOffset hp u (d + e) := by
  obtain ⟨i, x⟩ := u
  apply congrArg (Sigma.mk i)
  apply Fin.ext
  have h := (cycleOffset_val hp (cycleOffset hp ⟨i, x⟩ d) e).trans
    (show _ = ((cycleOffset hp ⟨i, x⟩ (d + e)).2.val : ℤ) by
      rw [cycleOffset_val hp ⟨i, x⟩ d, cycleOffset_val hp ⟨i, x⟩ (d + e)]
      change (((x.val : ℤ) + d) % (sizes.get i : ℤ) + e) % (sizes.get i : ℤ) =
        ((x.val : ℤ) + (d + e)) % (sizes.get i : ℤ)
      rw [Int.emod_add_emod, add_assoc])
  exact_mod_cast h

private theorem cycleOffset_one (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (u : CyclePartitionVertex sizes) :
    cycleOffset hp u 1 = cyclePartitionNext sizes hp u := by
  obtain ⟨i, x⟩ := u
  apply congrArg (Sigma.mk i)
  apply Fin.ext
  exact_mod_cast cycleOffset_val hp ⟨i, x⟩ 1

private theorem cycleOffset_adj
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (u v : CyclePartitionVertex sizes) :
    (cyclePartitionSimpleGraph sizes).Adj u v ↔
      cycleOffset hp u 1 = v ∨ cycleOffset hp u (-1) = v := by
  rw [cyclePartition_adj_iff_next h3 hp, ← cycleOffset_one, ← cycleOffset_one]
  constructor
  · rintro (h | h)
    · exact Or.inl h
    · apply Or.inr
      rw [← h, cycleOffset_add]
      simpa using cycleOffset_zero hp v
  · rintro (h | h)
    · exact Or.inl h
    · apply Or.inr
      rw [← h, cycleOffset_add]
      simpa using cycleOffset_zero hp u

private theorem cycleOffset_walk
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    {u v : CyclePartitionVertex sizes} (w : (cyclePartitionSimpleGraph sizes).Walk u v) :
    ∃ d : ℤ, -(w.length : ℤ) ≤ d ∧ d ≤ w.length ∧ cycleOffset hp u d = v := by
  induction w with
  | nil => exact ⟨0, by simp, by simp, cycleOffset_zero hp _⟩
  | @cons a b c hab w ih =>
    obtain ⟨d, hlo, hhi, hd⟩ := ih
    rcases (cycleOffset_adj hp h3 a b).mp hab with h | h
    · refine ⟨1 + d, ?_, ?_, ?_⟩
      · simp only [SimpleGraph.Walk.length_cons, Nat.cast_add, Nat.cast_one]; omega
      · simp only [SimpleGraph.Walk.length_cons, Nat.cast_add, Nat.cast_one]; omega
      · rw [← cycleOffset_add, h, hd]
    · refine ⟨-1 + d, ?_, ?_, ?_⟩
      · simp only [SimpleGraph.Walk.length_cons, Nat.cast_add, Nat.cast_one]; omega
      · simp only [SimpleGraph.Walk.length_cons, Nat.cast_add, Nat.cast_one]; omega
      · rw [← cycleOffset_add, h, hd]

private theorem cycleOffset_walk_steps
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (u : CyclePartitionVertex sizes) (s : ℤ) (hs : s = 1 ∨ s = -1) (n : ℕ) :
    ∃ w : (cyclePartitionSimpleGraph sizes).Walk u (cycleOffset hp u (n * s)),
      w.length = n := by
  induction n with
  | zero =>
    have h : cycleOffset hp u (0 * s) = u := by simpa using cycleOffset_zero hp u
    exact ⟨SimpleGraph.Walk.nil.copy rfl h.symm, by simp⟩
  | succ n ih =>
    obtain ⟨w, hw⟩ := ih
    have he : (cyclePartitionSimpleGraph sizes).Adj
        (cycleOffset hp u (n * s)) (cycleOffset hp u (↑(n + 1) * s)) := by
      apply (cycleOffset_adj hp h3 _ _).mpr
      have ht : cycleOffset hp (cycleOffset hp u (n * s)) s =
          cycleOffset hp u (↑(n + 1) * s) := by
        rw [cycleOffset_add, Nat.cast_add, Nat.cast_one, add_mul, one_mul]
      rcases hs with rfl | rfl
      · exact Or.inl ht
      · exact Or.inr ht
    exact ⟨w.concat he, by simp [hw]⟩

/-- A closed graph-distance ball restricted to reachable vertices. -/
def rootedBallVertices {V : Type} (G : SimpleGraph V) (r : ℕ) (u : V) : Set V :=
  {v | G.Reachable u v ∧ G.dist u v ≤ r}

private theorem cycleOffset_mem_ball
    (hp : ∀ i : Fin sizes.length, 0 < sizes.get i)
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (u : CyclePartitionVertex sizes) (r : ℕ) (d : ℤ)
    (hlo : -(r : ℤ) ≤ d) (hhi : d ≤ r) :
    cycleOffset hp u d ∈ rootedBallVertices (cyclePartitionSimpleGraph sizes) r u := by
  have hn : d.natAbs ≤ r := by omega
  obtain ⟨s, hs, hds⟩ : ∃ s : ℤ, (s = 1 ∨ s = -1) ∧ (d.natAbs : ℤ) * s = d := by
    obtain hd | hd := Int.natAbs_eq d
    · exact ⟨1, Or.inl rfl, by rw [mul_one, ← hd]⟩
    · exact ⟨-1, Or.inr rfl, by rw [mul_neg_one, ← hd]⟩
  obtain ⟨w, hw⟩ := cycleOffset_walk_steps hp h3 u s hs d.natAbs
  let w' := w.copy rfl (congrArg (cycleOffset hp u) hds)
  exact ⟨⟨w'⟩, (SimpleGraph.dist_le w').trans (by simpa [w', hw] using hn)⟩

private theorem cycleOffset_modEq_eq {m : ℕ} {d e : ℤ}
    (h : d ≡ e [ZMOD (m : ℤ)]) (hb : (e - d).natAbs < m) : d = e := by
  have hz := Int.eq_zero_of_dvd_of_natAbs_lt_natAbs h.dvd
    (show (e - d).natAbs < (m : ℤ).natAbs by simpa using hb)
  omega

/-- The integer offsets of a centered radius-`r` path. -/
def CenteredPathVertex (r : ℕ) := {d : ℤ // -(r : ℤ) ≤ d ∧ d ≤ r}

def centeredPath (r : ℕ) : SimpleGraph (CenteredPathVertex r) where
  Adj d e := d.val + 1 = e.val ∨ e.val + 1 = d.val
  symm := by
    intro d e h
    exact h.elim Or.inr Or.inl
  loopless := by
    constructor
    intro d
    change ¬ (d.val + 1 = d.val ∨ d.val + 1 = d.val)
    omega

def centeredPathRoot (r : ℕ) : CenteredPathVertex r := ⟨0, by constructor <;> omega⟩

def rootedBallRoot {V : Type} (G : SimpleGraph V) (r : ℕ) (u : V) :
    rootedBallVertices G r u := ⟨u, ⟨SimpleGraph.Reachable.refl u, by simp⟩⟩

/-- Explicit coordinate map from the centered path to the induced radius ball. -/
noncomputable def cyclePartition_rootedBallIso
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (r : ℕ) (u : CyclePartitionVertex sizes) (hsize : 2 * r + 2 ≤ sizes.get u.1) :
    centeredPath r ≃g (cyclePartitionSimpleGraph sizes).induce
      (rootedBallVertices (cyclePartitionSimpleGraph sizes) r u) := by
  let hp : ∀ i : Fin sizes.length, 0 < sizes.get i := fun i => by have := h3 i; omega
  let f : CenteredPathVertex r → rootedBallVertices (cyclePartitionSimpleGraph sizes) r u :=
    fun d => ⟨cycleOffset hp u d.val, cycleOffset_mem_ball hp h3 u r d.val d.property.1 d.property.2⟩
  have hf : Function.Bijective f := by
    constructor
    · intro d e he
      apply Subtype.ext
      have hm := (cycleOffset_eq hp u d.val e.val).1 (congrArg Subtype.val he)
      have hd := d.property
      have he := e.property
      exact cycleOffset_modEq_eq hm (by omega)
    · intro v
      obtain ⟨w, hw⟩ := v.property.1.exists_walk_length_eq_dist
      obtain ⟨d, hlo, hhi, hd⟩ := cycleOffset_walk hp h3 w
      have hb := v.property.2
      rw [← hw] at hb
      refine ⟨⟨d, by constructor <;> omega⟩, Subtype.ext hd⟩
  refine ⟨Equiv.ofBijective f hf, ?_⟩
  intro d e
  change (cyclePartitionSimpleGraph sizes).Adj (cycleOffset hp u d.val)
    (cycleOffset hp u e.val) ↔ d.val + 1 = e.val ∨ e.val + 1 = d.val
  rw [cycleOffset_adj hp h3, cycleOffset_add, cycleOffset_add]
  have hd := d.property
  have he := e.property
  constructor
  · rintro (h | h)
    · exact Or.inl (cycleOffset_modEq_eq ((cycleOffset_eq hp u _ _).1 h) (by omega))
    · have ht := cycleOffset_modEq_eq ((cycleOffset_eq hp u _ _).1 h) (by omega)
      exact Or.inr (by omega)
  · rintro (h | h)
    · exact Or.inl (by rw [h])
    · have ht : d.val + (-1) = e.val := by omega
      exact Or.inr (by rw [ht])

theorem cyclePartition_rootedBallIso_root
    (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (r : ℕ) (u : CyclePartitionVertex sizes) (hsize : 2 * r + 2 ≤ sizes.get u.1) :
    cyclePartition_rootedBallIso h3 r u hsize (centeredPathRoot r) =
      rootedBallRoot (cyclePartitionSimpleGraph sizes) r u := by
  apply Subtype.ext
  exact cycleOffset_zero (fun i => lt_of_lt_of_le (by decide : 0 < 3) (h3 i)) u

structure RootedNeighborhood where
  carrier : Type
  graph : SimpleGraph carrier
  root : carrier

def RootedNeighborhood.isoSetoid : Setoid RootedNeighborhood where
  r a b := ∃ e : a.graph ≃g b.graph, e a.root = b.root
  iseqv :=
    ⟨fun a => ⟨SimpleGraph.Iso.refl, rfl⟩,
    fun ⟨e, he⟩ => ⟨e.symm, by rw [← he]; exact e.toEquiv.symm_apply_apply _⟩,
    fun ⟨e, he⟩ ⟨f, hf⟩ => ⟨e.trans f, by change f (e _) = _; rw [he, hf]⟩⟩

abbrev RootedNeighborhoodClass := Quotient RootedNeighborhood.isoSetoid

def graphRootedBall {V : Type} (G : SimpleGraph V) (r : ℕ) (u : V) : RootedNeighborhood :=
  ⟨rootedBallVertices G r u, G.induce _, rootedBallRoot G r u⟩

/-- One rooted induced-ball isomorphism class per actual graph vertex. -/
noncomputable def rootedNeighborhoodObservation {V : Type} [Fintype V]
    (G : SimpleGraph V) (r : ℕ) : Multiset RootedNeighborhoodClass :=
  Finset.univ.val.map (fun u => Quotient.mk _ (graphRootedBall G r u))

def centeredPathClass (r : ℕ) : RootedNeighborhoodClass :=
  Quotient.mk _ ⟨CenteredPathVertex r, centeredPath r, centeredPathRoot r⟩

theorem cyclePartition_neighborhoodObservation_eq_replicate
    (r : ℕ) (h3 : ∀ i : Fin sizes.length, 3 ≤ sizes.get i)
    (hsize : ∀ i : Fin sizes.length, 2 * r + 2 ≤ sizes.get i) :
    rootedNeighborhoodObservation (cyclePartitionSimpleGraph sizes) r =
      Multiset.replicate (Fintype.card (CyclePartitionVertex sizes)) (centeredPathClass r) := by
  have hclass (u : CyclePartitionVertex sizes) :
      centeredPathClass r = (Quotient.mk _ (graphRootedBall (cyclePartitionSimpleGraph sizes) r u) :
        RootedNeighborhoodClass) :=
    Quotient.sound ⟨cyclePartition_rootedBallIso h3 r u (hsize u.1),
      cyclePartition_rootedBallIso_root h3 r u (hsize u.1)⟩
  unfold rootedNeighborhoodObservation
  simp only [← hclass, Multiset.map_const']
  change Multiset.replicate (Finset.univ : Finset (CyclePartitionVertex sizes)).card _ = _
  rw [Finset.card_univ]

#print axioms cyclePartition_rootedBallIso
#print axioms cyclePartition_rootedBallIso_root
#print axioms rootedNeighborhoodObservation
#print axioms cyclePartition_neighborhoodObservation_eq_replicate


end CSLIB.FMT.UnguardedFO
