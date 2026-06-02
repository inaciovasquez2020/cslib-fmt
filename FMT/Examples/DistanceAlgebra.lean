import FMT.Graph.Basic
import FMT.Graph.PathLength
import FMT.Graph.PathLengthLemmas
import FMT.Graph.DistanceOrder
import FMT.Inputs.SLASH_Axioms

namespace FMT.Examples

inductive Line3 where
  | a
  | b
  | c
deriving DecidableEq, Repr

def lineGraph : FMT.Graph.Graph where
  V := Line3
  Adj u v :=
    (u = Line3.a ∧ v = Line3.b) ∨
    (u = Line3.b ∧ v = Line3.a) ∨
    (u = Line3.b ∧ v = Line3.c) ∨
    (u = Line3.c ∧ v = Line3.b)

theorem lineGraph_symm :
    ∀ {u v : lineGraph.V}, lineGraph.Adj u v → lineGraph.Adj v u := by
  intro u v h
  rcases h with h | h | h | h
  · exact Or.inr (Or.inl ⟨h.2, h.1⟩)
  · exact Or.inl ⟨h.2, h.1⟩
  · exact Or.inr (Or.inr (Or.inr ⟨h.2, h.1⟩))
  · exact Or.inr (Or.inr (Or.inl ⟨h.2, h.1⟩))

theorem lineGraph_path_ab :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.b 1) := by
  refine ⟨?_⟩
  exact
    { verts := fun i => if i.1 = 0 then Line3.a else Line3.b
      start := by simp
      finish := by simp
      step := by
        intro i
        fin_cases i
        simp
        exact Or.inl ⟨rfl, rfl⟩ }

theorem lineGraph_path_bc :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.b Line3.c 1) := by
  refine ⟨?_⟩
  exact
    { verts := fun i => if i.1 = 0 then Line3.b else Line3.c
      start := by simp
      finish := by simp
      step := by
        intro i
        fin_cases i
        simp
        exact Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩)) }

theorem lineGraph_path_ba :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.b Line3.a 1) := by
  refine ⟨?_⟩
  exact
    { verts := fun i => if i.1 = 0 then Line3.b else Line3.a
      start := by simp
      finish := by simp
      step := by
        intro i
        fin_cases i
        simp
        exact Or.inr (Or.inl ⟨rfl, rfl⟩) }

theorem lineGraph_path_cb :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.c Line3.b 1) := by
  refine ⟨?_⟩
  exact
    { verts := fun i => if i.1 = 0 then Line3.c else Line3.b
      start := by simp
      finish := by simp
      step := by
        intro i
        fin_cases i
        simp
        exact Or.inr (Or.inr (Or.inr ⟨rfl, rfl⟩)) }

theorem lineGraph_path_ac_two :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.c 2) := by
  refine ⟨?_⟩
  exact
    { verts := fun i =>
        if i.1 = 0 then Line3.a else if i.1 = 1 then Line3.b else Line3.c
      start := by simp
      finish := by simp
      step := by
        intro i
        fin_cases i
        · simp
          exact Or.inl ⟨rfl, rfl⟩
        · simp
          exact Or.inr (Or.inr (Or.inl ⟨rfl, rfl⟩)) }

theorem lineGraph_direct_path_symmetry_ab_ba :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.b 1) ∧
      Nonempty (FMT.Graph.PathLength lineGraph Line3.b Line3.a 1) := by
  exact ⟨lineGraph_path_ab, lineGraph_path_ba⟩

theorem lineGraph_direct_path_ac_le_two :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.c 2) := by
  exact lineGraph_path_ac_two


private theorem lineGraph_no_path_ab_zero :
    ¬ Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.b 0) := by
  intro h
  rcases h with ⟨p⟩
  have hs : p.verts ⟨0, by decide⟩ = Line3.a := p.start
  have hf : p.verts ⟨0, by decide⟩ = Line3.b := p.finish
  exact Line3.noConfusion (hs.symm.trans hf)

private theorem lineGraph_no_path_ba_zero :
    ¬ Nonempty (FMT.Graph.PathLength lineGraph Line3.b Line3.a 0) := by
  intro h
  rcases h with ⟨p⟩
  have hs : p.verts ⟨0, by decide⟩ = Line3.b := p.start
  have hf : p.verts ⟨0, by decide⟩ = Line3.a := p.finish
  exact Line3.noConfusion (hs.symm.trans hf)

private theorem lineGraph_no_path_bc_zero :
    ¬ Nonempty (FMT.Graph.PathLength lineGraph Line3.b Line3.c 0) := by
  intro h
  rcases h with ⟨p⟩
  have hs : p.verts ⟨0, by decide⟩ = Line3.b := p.start
  have hf : p.verts ⟨0, by decide⟩ = Line3.c := p.finish
  exact Line3.noConfusion (hs.symm.trans hf)

private theorem lineGraph_no_path_cb_zero :
    ¬ Nonempty (FMT.Graph.PathLength lineGraph Line3.c Line3.b 0) := by
  intro h
  rcases h with ⟨p⟩
  have hs : p.verts ⟨0, by decide⟩ = Line3.c := p.start
  have hf : p.verts ⟨0, by decide⟩ = Line3.b := p.finish
  exact Line3.noConfusion (hs.symm.trans hf)

private theorem lineGraph_no_path_ac_zero :
    ¬ Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.c 0) := by
  intro h
  rcases h with ⟨p⟩
  have hs : p.verts ⟨0, by decide⟩ = Line3.a := p.start
  have hf : p.verts ⟨0, by decide⟩ = Line3.c := p.finish
  exact Line3.noConfusion (hs.symm.trans hf)

private theorem lineGraph_no_path_ca_zero :
    ¬ Nonempty (FMT.Graph.PathLength lineGraph Line3.c Line3.a 0) := by
  intro h
  rcases h with ⟨p⟩
  have hs : p.verts ⟨0, by decide⟩ = Line3.c := p.start
  have hf : p.verts ⟨0, by decide⟩ = Line3.a := p.finish
  exact Line3.noConfusion (hs.symm.trans hf)

private theorem lineGraph_no_path_ac_one :
    ¬ Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.c 1) := by
  intro h
  rcases h with ⟨p⟩
  have hs : p.verts ⟨0, by decide⟩ = Line3.a := p.start
  have hf : p.verts ⟨1, by decide⟩ = Line3.c := p.finish
  have hstep := p.step ⟨0, by decide⟩
  rcases hstep with hstep | hstep | hstep | hstep
  · exact Line3.noConfusion (hstep.2.symm.trans hf)
  · exact Line3.noConfusion (hs.symm.trans hstep.1)
  · exact Line3.noConfusion (hs.symm.trans hstep.1)
  · exact Line3.noConfusion (hs.symm.trans hstep.1)

private theorem lineGraph_no_path_ca_one :
    ¬ Nonempty (FMT.Graph.PathLength lineGraph Line3.c Line3.a 1) := by
  intro h
  rcases h with ⟨p⟩
  have hs : p.verts ⟨0, by decide⟩ = Line3.c := p.start
  have hf : p.verts ⟨1, by decide⟩ = Line3.a := p.finish
  have hstep := p.step ⟨0, by decide⟩
  rcases hstep with hstep | hstep | hstep | hstep
  · exact Line3.noConfusion (hs.symm.trans hstep.1)
  · exact Line3.noConfusion (hs.symm.trans hstep.1)
  · exact Line3.noConfusion (hs.symm.trans hstep.1)
  · exact Line3.noConfusion (hstep.2.symm.trans hf)

theorem lineGraph_path_aa_zero :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.a Line3.a 0) := by
  refine ⟨?_⟩
  exact
    { verts := fun _ => Line3.a
      start := rfl
      finish := rfl
      step := by intro i; fin_cases i }

theorem lineGraph_path_bb_zero :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.b Line3.b 0) := by
  refine ⟨?_⟩
  exact
    { verts := fun _ => Line3.b
      start := rfl
      finish := rfl
      step := by intro i; fin_cases i }

theorem lineGraph_path_cc_zero :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.c Line3.c 0) := by
  refine ⟨?_⟩
  exact
    { verts := fun _ => Line3.c
      start := rfl
      finish := rfl
      step := by intro i; fin_cases i }

theorem lineGraph_path_ca_two :
    Nonempty (FMT.Graph.PathLength lineGraph Line3.c Line3.a 2) := by
  refine ⟨?_⟩
  exact
    { verts := fun i =>
        if i.1 = 0 then Line3.c else if i.1 = 1 then Line3.b else Line3.a
      start := by simp
      finish := by simp
      step := by
        intro i
        fin_cases i
        · simp
          exact Or.inr (Or.inr (Or.inr ⟨rfl, rfl⟩))
        · simp
          exact Or.inr (Or.inl ⟨rfl, rfl⟩) }

instance lineGraph_slashAxioms : FMT.Inputs.SLASHAxioms lineGraph where
  exists_shortest_path_length := by
    intro u v h
    cases u <;> cases v
    · refine ⟨0, lineGraph_path_aa_zero, ?_⟩
      intro m hm
      omega
    · refine ⟨1, lineGraph_path_ab, ?_⟩
      intro m hm
      have hm0 : m = 0 := by omega
      subst hm0
      exact lineGraph_no_path_ab_zero
    · refine ⟨2, lineGraph_path_ac_two, ?_⟩
      intro m hm
      interval_cases m
      · exact lineGraph_no_path_ac_zero
      · exact lineGraph_no_path_ac_one
    · refine ⟨1, lineGraph_path_ba, ?_⟩
      intro m hm
      have hm0 : m = 0 := by omega
      subst hm0
      exact lineGraph_no_path_ba_zero
    · refine ⟨0, lineGraph_path_bb_zero, ?_⟩
      intro m hm
      omega
    · refine ⟨1, lineGraph_path_bc, ?_⟩
      intro m hm
      have hm0 : m = 0 := by omega
      subst hm0
      exact lineGraph_no_path_bc_zero
    · refine ⟨2, lineGraph_path_ca_two, ?_⟩
      intro m hm
      interval_cases m
      · exact lineGraph_no_path_ca_zero
      · exact lineGraph_no_path_ca_one
    · refine ⟨1, lineGraph_path_cb, ?_⟩
      intro m hm
      have hm0 : m = 0 := by omega
      subst hm0
      exact lineGraph_no_path_cb_zero
    · refine ⟨0, lineGraph_path_cc_zero, ?_⟩
      intro m hm
      omega

theorem lineGraph_dist_ab_le_one :
    FMT.Graph.DistLE lineGraph Line3.a Line3.b 1 := by
  rcases FMT.Graph.dist?_le_of_path
      (G := lineGraph) (u := Line3.a) (v := Line3.b) (n := 1)
      lineGraph_path_ab with
    ⟨d, hd, hle⟩
  exact FMT.Graph.distLE_of_eq lineGraph Line3.a Line3.b hd hle

theorem lineGraph_dist_ba_le_one :
    FMT.Graph.DistLE lineGraph Line3.b Line3.a 1 := by
  rcases FMT.Graph.dist?_le_of_path
      (G := lineGraph) (u := Line3.b) (v := Line3.a) (n := 1)
      lineGraph_path_ba with
    ⟨d, hd, hle⟩
  exact FMT.Graph.distLE_of_eq lineGraph Line3.b Line3.a hd hle

theorem lineGraph_dist_ab_ba_symmetry :
    FMT.Graph.DistLE lineGraph Line3.a Line3.b 1 ∧
      FMT.Graph.DistLE lineGraph Line3.b Line3.a 1 := by
  exact ⟨lineGraph_dist_ab_le_one, lineGraph_dist_ba_le_one⟩

theorem lineGraph_dist_ac_le_two :
    FMT.Graph.DistLE lineGraph Line3.a Line3.c 2 := by
  rcases FMT.Graph.dist?_le_of_path
      (G := lineGraph) (u := Line3.a) (v := Line3.c) (n := 2)
      lineGraph_path_ac_two with
    ⟨d, hd, hle⟩
  exact FMT.Graph.distLE_of_eq lineGraph Line3.a Line3.c hd hle

/-
The `DistLE` reintroduction route is now closed by `lineGraph_slashAxioms`.

Closed unconditionally here:
- reverse one-step path witness `lineGraph_path_ba`;
- two-step path witness `lineGraph_path_ac_two`;
- direct path-level symmetry witness `lineGraph_direct_path_symmetry_ab_ba`;
- direct path-level two-step reachability witness `lineGraph_direct_path_ac_le_two`.

Closed theorem-level objects:
- `lineGraph_dist_ab_ba_symmetry`;
- `lineGraph_dist_ac_le_two`;
- `lineGraph_slashAxioms`.
-/

end FMT.Examples
