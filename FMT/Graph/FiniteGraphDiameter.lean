import FMT.Graph.GlobalDistanceAxiomDischarge

namespace FMT.Graph

open Classical

/--
A finite graph is connected when every ordered pair of repo-native vertices has
a realized optional distance value.
-/
def ConnectedGraph
  (G : Graph)
  [Fintype G.V] : Prop :=
  ∀ u w : G.V, ∃ n : Nat, dist? u w = some n

/--
The finite set of all ordered repo-native vertex pairs.
-/
def allVertexPairs
  (G : Graph)
  [Fintype G.V] : Finset (G.V × G.V) :=
  Finset.univ.product Finset.univ

/--
The optional distance attached to one ordered repo-native vertex pair.
-/
noncomputable def pairDistance?
  {G : Graph}
  (p : G.V × G.V) : Option Nat :=
  dist? p.1 p.2

/--
All ordered repo-native vertex pairs are reachable.
-/
def allPairDistancesReachable
  (G : Graph)
  [Fintype G.V] : Prop :=
  ∀ p ∈ allVertexPairs G, ∃ n : Nat, pairDistance? p = some n

/--
Finite set of realized pairwise distances.

Unreachable pairs contribute `0`; the surrounding `finiteGraphDiameter?`
definition returns `none` unless every pair is reachable, so these fallback
zeros do not affect connected cases.
-/
noncomputable def pairDistanceValues
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V] : Finset Nat :=
  (allVertexPairs G).image
    (fun p =>
      match pairDistance? p with
      | some n => n
      | none => 0)

/--
A small local maximum operator on lists of natural numbers.

The empty-list convention is `0`.
-/
def natListMax : List Nat → Nat
  | [] => 0
  | n :: ns => max n (natListMax ns)

theorem le_natListMax_of_mem
  {xs : List Nat}
  {n : Nat}
  (h : n ∈ xs) :
  n ≤ natListMax xs := by
  induction xs with
  | nil =>
      cases h
  | cons head tail ih =>
      simp [List.mem_cons] at h
      cases h with
      | inl hEq =>
          rw [hEq]
          exact Nat.le_max_left head (natListMax tail)
      | inr hMem =>
          exact Nat.le_trans (ih hMem) (Nat.le_max_right head (natListMax tail))

/--
Option-valued finite graph diameter.

For finite disconnected graphs, this returns `none`.
For finite connected graphs, this returns the maximum realized pairwise
distance.
For the empty repo-native vertex-pair set, the maximum convention is `0`.
-/
noncomputable def finiteGraphDiameter?
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V] : Option Nat := by
  classical
  exact
    if allPairDistancesReachable G then
      some (natListMax (pairDistanceValues G).toList)
    else
      none

theorem connected_implies_all_pair_distances_reachable
  (G : Graph)
  [Fintype G.V]
  (hG : ConnectedGraph G) :
  allPairDistancesReachable G := by
  intro p hp
  exact hG p.1 p.2

theorem finite_connected_graph_diameter_exists
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (hG : ConnectedGraph G) :
  ∃ d : Nat, finiteGraphDiameter? G = some d := by
  classical
  refine ⟨natListMax (pairDistanceValues G).toList, ?_⟩
  simp [finiteGraphDiameter?, connected_implies_all_pair_distances_reachable G hG]


theorem finiteGraphDiameter_eq_none_of_not_allPairDistancesReachable
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (h : ¬ allPairDistancesReachable G) :
  finiteGraphDiameter? G = none := by
  classical
  simp [finiteGraphDiameter?, h]


theorem finiteGraphDiameter_exists_of_allPairDistancesReachable
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (h : allPairDistancesReachable G) :
  ∃ d : Nat, finiteGraphDiameter? G = some d := by
  classical
  refine ⟨natListMax (pairDistanceValues G).toList, ?_⟩
  simp [finiteGraphDiameter?, h]


theorem finiteGraphDiameter_eq_some_natListMax_of_allPairDistancesReachable
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (h : allPairDistancesReachable G) :
  finiteGraphDiameter? G = some (natListMax (pairDistanceValues G).toList) := by
  classical
  simp [finiteGraphDiameter?, h]

theorem finiteGraphDiameter_exists_iff_allPairDistancesReachable
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V] :
  (∃ d : Nat, finiteGraphDiameter? G = some d) ↔ allPairDistancesReachable G := by
  classical
  constructor
  · intro hsome
    by_contra hnot
    rcases hsome with ⟨d, hd⟩
    have hnone :
        finiteGraphDiameter? G = none :=
      finiteGraphDiameter_eq_none_of_not_allPairDistancesReachable G hnot
    rw [hd] at hnone
    cases hnone
  · intro h
    exact finiteGraphDiameter_exists_of_allPairDistancesReachable G h

theorem distance_mem_pairDistanceValues
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (u w : G.V)
  (n : Nat)
  (hdist : dist? u w = some n) :
  n ∈ pairDistanceValues G := by
  classical
  refine Finset.mem_image.mpr ?_
  refine ⟨(u, w), ?_, ?_⟩
  · simp [allVertexPairs]
  · simp [pairDistance?, hdist]

theorem distance_le_diameter_of_finite_connected
  (G : Graph)
  [Fintype G.V]
  [DecidableEq G.V]
  (hG : ConnectedGraph G)
  (u w : G.V)
  (n d : Nat)
  (hdist : dist? u w = some n)
  (hdiam : finiteGraphDiameter? G = some d) :
  n ≤ d := by
  classical
  have hmem : n ∈ pairDistanceValues G :=
    distance_mem_pairDistanceValues G u w n hdist

  have hlist : n ∈ (pairDistanceValues G).toList := by
    simpa using hmem

  have hreachable : allPairDistancesReachable G :=
    connected_implies_all_pair_distances_reachable G hG

  simp [finiteGraphDiameter?, hreachable] at hdiam
  subst d

  exact le_natListMax_of_mem hlist

end FMT.Graph


namespace FMT.Graph

/--
Final convenience theorem: on a reachable finite graph, the finite graph
diameter value is exactly the maximum of the finite pair-distance value list.
This is the public-facing alias of the exact theorem closed in PR #161.
-/
theorem finiteGraphDiameter_eq_exact_value_of_allPairDistancesReachable
    (G : Graph) [Fintype G.V] [DecidableEq G.V]
    (h : allPairDistancesReachable G) :
    finiteGraphDiameter? G = some (natListMax (pairDistanceValues G).toList) :=
  finiteGraphDiameter_eq_some_natListMax_of_allPairDistancesReachable G h

/--
Final existence theorem: reachability gives a concrete exact diameter witness.
-/
theorem finiteGraphDiameter_exact_value_exists_of_allPairDistancesReachable
    (G : Graph) [Fintype G.V] [DecidableEq G.V]
    (h : allPairDistancesReachable G) :
    ∃ d, finiteGraphDiameter? G = some d :=
  finiteGraphDiameter_exists_of_allPairDistancesReachable G h

/--
Final nonexistence theorem: failure of all-pairs reachability gives no diameter.
-/
theorem finiteGraphDiameter_none_of_not_allPairDistancesReachable'
    (G : Graph) [Fintype G.V] [DecidableEq G.V]
    (h : ¬ allPairDistancesReachable G) :
    finiteGraphDiameter? G = none :=
  finiteGraphDiameter_eq_none_of_not_allPairDistancesReachable G h

/--
Final iff theorem: a finite graph has a diameter value iff all pair distances are reachable.
-/
theorem finiteGraphDiameter_some_iff_allPairDistancesReachable
    (G : Graph) [Fintype G.V] [DecidableEq G.V] :
    (∃ d, finiteGraphDiameter? G = some d) ↔ allPairDistancesReachable G :=
  finiteGraphDiameter_exists_iff_allPairDistancesReachable G

/--
Final public theorem: the finite graph diameter package is closed at the
Option Nat level by none/some/exact-value cases.
-/
theorem finiteGraphDiameter_closed_option_nat_cases
    (G : Graph) [Fintype G.V] [DecidableEq G.V] :
    ((¬ allPairDistancesReachable G) → finiteGraphDiameter? G = none)
      ∧ (allPairDistancesReachable G →
          finiteGraphDiameter? G = some (natListMax (pairDistanceValues G).toList))
      ∧ ((∃ d, finiteGraphDiameter? G = some d) ↔ allPairDistancesReachable G) := by
  constructor
  · intro h
    exact finiteGraphDiameter_eq_none_of_not_allPairDistancesReachable G h
  constructor
  · intro h
    exact finiteGraphDiameter_eq_some_natListMax_of_allPairDistancesReachable G h
  · exact finiteGraphDiameter_exists_iff_allPairDistancesReachable G

end FMT.Graph
