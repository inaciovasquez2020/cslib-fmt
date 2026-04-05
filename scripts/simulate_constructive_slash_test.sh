#!/usr/bin/env zsh
set -euo pipefail

echo "== write patch targets =="
test -f FMT/Graph/PathLength.lean
test -f FMT/Inputs/ConstructiveSLASHAxioms.lean

echo "== syntax/build smoke test =="
lake build FMT.Graph.PathLength FMT.Inputs.ConstructiveSLASHAxioms

echo "== wrapper compatibility test =="
lake build \
  FMT.Graph.ExistsShortestPathLength \
  FMT.Graph.DistancePath \
  FMT.Graph.DistSymm \
  FMT.Graph.DistTriangle \
  FMT.Graph.DistSomeOfShortestPath

echo "== no placeholder census in touched files =="
grep -nE '(^|[^A-Za-z0-9_])(sorry|admit|axiom)($|[^A-Za-z0-9_])' \
  FMT/Graph/PathLength.lean \
  FMT/Inputs/ConstructiveSLASHAxioms.lean \
  FMT/Graph/ExistsShortestPathLength.lean \
  FMT/Graph/DistancePath.lean \
  FMT/Graph/DistSymm.lean \
  FMT/Graph/DistTriangle.lean \
  FMT/Graph/DistSomeOfShortestPath.lean && exit 1 || true

echo "== typeclass instantiation simulation =="
cat > /tmp/ConstructiveSlashSmoke.lean <<'EOT'
import FMT.Inputs.ConstructiveSLASHAxioms
import Mathlib

namespace FMT.Test

open FMT.Graph
open FMT.Inputs

inductive V where
| a | b | c
deriving DecidableEq

def Adj : V → V → Prop
| .a, .b => True
| .b, .a => True
| .b, .c => True
| .c, .b => True
| .a, .c => True
| .c, .a => True
| _, _ => False

def G : Graph where
  V := V
  Adj := Adj

theorem Adj_symm : ∀ x y : G.V, G.Adj x y → G.Adj y x := by
  intro x y h
  cases x <;> cases y <;> simpa [G, Adj] using h

noncomputable instance : SLASHAxioms G :=
  undirectedGraphInstance G Adj_symm

example : ∃ d, dist? G V.a V.c = some d := by
  have hpath : Nonempty (PathLength G V.a V.c 1) := by
    refine ⟨{
      verts := fun
        | ⟨0, _⟩ => V.a
        | ⟨1, _⟩ => V.c
      start := rfl
      finish := rfl
      step := by
        intro i
        fin_cases i
        simp [G, Adj]
    }⟩
  rcases Inputs.dist_le_of_path_constructive (G := G) (u := V.a) (v := V.c) (n := 1) hpath with ⟨d, hd, _⟩
  exact ⟨d, hd⟩

example : dist? G V.a V.b = dist? G V.b V.a := by
  simpa using Inputs.dist_symm_of_adj_symm G Adj_symm V.a V.b

end FMT.Test
EOT
lake env lean /tmp/ConstructiveSlashSmoke.lean

echo "== triangle simulation =="
cat > /tmp/ConstructiveSlashTriangle.lean <<'EOT'
import FMT.Inputs.ConstructiveSLASHAxioms
import Mathlib

namespace FMT.Test2

open FMT.Graph
open FMT.Inputs

inductive V where
| a | b | c
deriving DecidableEq

def Adj : V → V → Prop
| .a, .b => True
| .b, .a => True
| .b, .c => True
| .c, .b => True
| _, _ => False

def G : Graph where
  V := V
  Adj := Adj

theorem Adj_symm : ∀ x y : G.V, G.Adj x y → G.Adj y x := by
  intro x y h
  cases x <;> cases y <;> simpa [G, Adj] using h

noncomputable instance : SLASHAxioms G :=
  undirectedGraphInstance G Adj_symm

def pab : PathLength G V.a V.b 1 where
  verts
  | ⟨0, _⟩ => V.a
  | ⟨1, _⟩ => V.b
  start := rfl
  finish := rfl
  step := by
    intro i
    fin_cases i
    simp [G, Adj]

def pbc : PathLength G V.b V.c 1 where
  verts
  | ⟨0, _⟩ => V.b
  | ⟨1, _⟩ => V.c
  start := rfl
  finish := rfl
  step := by
    intro i
    fin_cases i
    simp [G, Adj]

example : ∃ c, dist? G V.a V.c = some c ∧ c ≤ 2 := by
  have hab : dist? G V.a V.b = some 1 := by
    apply Inputs.dist_some_of_shortest_path_constructive
    · exact ⟨pab⟩
    · intro m hm
      have hm0 : m = 0 := by omega
      subst hm0
      intro h0
      rcases h0 with ⟨p⟩
      have : V.a = V.b := by simpa using p.start.symm.trans p.finish
      cases this
  have hbc : dist? G V.b V.c = some 1 := by
    apply Inputs.dist_some_of_shortest_path_constructive
    · exact ⟨pbc⟩
    · intro m hm
      have hm0 : m = 0 := by omega
      subst hm0
      intro h0
      rcases h0 with ⟨p⟩
      have : V.b = V.c := by simpa using p.start.symm.trans p.finish
      cases this
  simpa using Inputs.dist_triangle_constructive G V.a V.b V.c hab hbc

end FMT.Test2
EOT
lake env lean /tmp/ConstructiveSlashTriangle.lean

echo "PASS"
