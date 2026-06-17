# CSLIB-FMT Citation Dependency Map
Status: exported-theorem citation audit surface.
Date: 2026-06-17.
Scope: `FMT/*` and `lean/CSLIB/FMT/*`.
Boundary: citation support only; not a theorem-level closure claim.

BOUNDARY := ¬ repository-level proof of Fagin theorem ∨ 0-1 Law ∨ global finite-model-theory final theorem.

## Canonical citation families

### FMT-CORE

- Leonid Libkin, *Elements of Finite Model Theory*, Springer, 2004.
- Heinz-Dieter Ebbinghaus and Jörg Flum, *Finite Model Theory*, Springer, 1995.
- Neil Immerman, *Descriptive Complexity*, Springer, 1999.

### LOCALITY

- William Hanf, "Model-theoretic methods in the study of elementary logic", 1965.
- Haim Gaifman, "On local and non-local properties", 1982.
- Lauri Hella, Leonid Libkin, Juha Nurmonen, "Notions of locality and their logical characterizations over finite models", *Journal of Symbolic Logic* 64(4), 1999.

### GUARDED-LOCALITY

- Hajnal Andréka, Johan van Benthem, István Németi, "Modal Languages and Bounded Fragments of Predicate Logic", *Journal of Philosophical Logic* 27, 1998.
- Erich Grädel, "On the Restraining Power of Guards", *Journal of Symbolic Logic* 64(4), 1999.
- Erich Grädel, "Decision Procedures for Guarded Logics", CADE 1999.

### EF-GAMES

- Roland Fraïssé, "Sur quelques classifications des systèmes de relations", 1954.
- Andrzej Ehrenfeucht, "An application of games to the completeness problem for formalized theories", *Fundamenta Mathematicae* 49, 1961.

### FINITE-VARIABLE / WL

- Jin-Yi Cai, Martin Fürer, Neil Immerman, "An Optimal Lower Bound on the Number of Variables for Graph Identification", *Combinatorica* 12, 1992.

### GRAPH-DISTANCE

- Reinhard Diestel, *Graph Theory*, Springer.
- Douglas B. West, *Introduction to Graph Theory*, Prentice Hall.
- Béla Bollobás, *Modern Graph Theory*, Springer.

### FACTORIZATION / INVARIANTS

- Leonid Libkin, *Elements of Finite Model Theory*, finite types/locality chapters.
- Lauri Hella, Leonid Libkin, Juha Nurmonen, "Notions of locality and their logical characterizations over finite models", 1999.

### FORMALIZATION-METHODOLOGY

- Mario Carneiro et al., "Lean4Lean: Mechanizing the Metatheory of Lean", WITS 2026.
- Yuanhe Zhang, Jason D. Lee, Fanghui Liu, "AI4SLT: Empirical Processes in Lean 4 for Formal Statistical Learning Theory", arXiv:2602.02285, ICML 2026.
- Yuanhe Zhang, Jason D. Lee, Fanghui Liu, "Statistical Learning Theory in Lean 4: Empirical Processes from Scratch", ResearchGate preprint page.

Boundary: these works support formalization methodology, not CSLIB-FMT mathematical theorem content.

## Promoted proof-facing target

- `locality_pipeline_certificate`

Canonical family: `GUARDED-LOCALITY`.
Secondary families: `LOCALITY`, `EF-GAMES`.

## Exported-name citation map

### GUARDED-LOCALITY

Mapped names:

- `BallIso`
- `Guard`
- `LocalIso`
- `PlainInducedRadiusBallIso`
- `RestrictedGuardedLocalTypeEquivalent`
- `ballIso_iff_localIso`
- `ballIso_to_localIso`
- `ballIso_to_pointed_radius_ball_equiv`
- `ballIso_to_restricted_ef_game_local_type_invariant_input_surface`
- `ballIso_to_restricted_guarded_local_type_equivalent`
- `gsat`
- `guarded_rank_locality`
- `guarded_rank_locality_from_ballIso`
- `guarded_rank_locality_from_plain_induced_radius_ball_isomorphism`
- `guarded_rank_locality_from_pointed_radius_ball_equiv`
- `localIso_to_ballIso`
- `ordinary_pointed_radius_ball_bijection_to_ballIso`
- `plain_induced_radius_ball_isomorphism_iff_pointed_radius_ball_equiv`
- `plain_induced_radius_ball_isomorphism_to_pointed_radius_ball_equiv`
- `plain_induced_radius_ball_isomorphism_to_restricted_ef_game_local_type_invariant_input_surface`
- `plain_induced_radius_ball_isomorphism_to_restricted_guarded_local_type_equivalent`
- `pointed_radius_ball_equiv_iff_ballIso`
- `pointed_radius_ball_equiv_to_ballIso`
- `pointed_radius_ball_equiv_to_plain_induced_radius_ball_isomorphism`
- `restrictedSat`
- `restricted_ef_game_local_type_invariant_input_surface_to_restricted_guarded_local_type_equivalent`
- `restricted_guarded_local_type_equivalent_to_restricted_ef_game_local_type_invariant_input_surface`
- `restricted_guarded_rank_locality`
- `restricted_guarded_rank_locality_from_ballIso`
- `restricted_guarded_rank_locality_from_plain_induced_radius_ball_isomorphism`
- `restricted_guarded_rank_locality_from_pointed_radius_ball_equiv`
- `restricted_guarded_translation_sound`
- `toGuardedFO`

### EF-GAMES

Mapped names:

- `indistinguishable`
- `restricted_ef_game_local_type_invariant_input_surface_formula_invariant`
- `winsLocal`

### FINITE-VARIABLE / WL

Mapped names:

- `WL_stabilizes`
- `WLstep`
- `refineColor`

### GRAPH-DISTANCE

Mapped names:

- `Ball`
- `BoundedRadius`
- `ConnectedGraph`
- `DistGT`
- `DistLE`
- `Edge`
- `InBoundedRadius`
- `PathLength`
- `PointedRadiusBallEquiv`
- `Reachable`
- `SymmAdj`
- `UndirectedEdge`
- `allPairDistancesReachable`
- `allVertexPairs`
- `ball_mono`
- `center_mem_ball`
- `connected_implies_all_pair_distances_reachable`
- `cycleDim_nonneg`
- `cycleQuotientProjection_ker`
- `cycleSpaceOfGraph`
- `dist?_exists_of_path`
- `dist?_le_of_path`
- `dist?_le_of_path_from_shortest_axioms`
- `dist?_le_of_path_via_exists`
- `dist?_refl`
- `dist?_some_iff_shortest`
- `dist?_some_of_shortest_path`
- `dist?_symm`
- `dist?_symm_via_reverse`
- `dist?_triangle`
- `distGT_of_none`
- `distLE_of_eq`
- `distLE_triangle`
- `dist_eq_of_no_shorter_path`
- `dist_exists`
- `dist_is_shortest`
- `dist_le_of_inBoundedRadius`
- `dist_triangle_nat`
- `distancePathBound_exists_only_baseline`
- `distanceSymmetry_exists_only_baseline`
- `distance_le_diameter_of_finite_connected`
- `distance_mem_pairDistanceValues`
- `edgeCount_nonneg`
- `existsMinPath`
- `exists_min_pathLength`
- `exists_min_pathLength_of_reachable`
- `exists_path_or_none`
- `exists_shortest_path_length`
- `finiteGraphDiameter_closed_option_nat_cases`
- `finiteGraphDiameter_eq_exact_value_of_allPairDistancesReachable`
- `finiteGraphDiameter_eq_none_of_not_allPairDistancesReachable`
- `finiteGraphDiameter_eq_some_natListMax_of_allPairDistancesReachable`
- `finiteGraphDiameter_exact_value_exists_of_allPairDistancesReachable`
- `finiteGraphDiameter_exists_iff_allPairDistancesReachable`
- `finiteGraphDiameter_exists_of_allPairDistancesReachable`
- `finiteGraphDiameter_none_of_not_allPairDistancesReachable'`
- `finiteGraphDiameter_some_iff_allPairDistancesReachable`
- `finite_connected_graph_diameter_exists`
- `genuineCycleRankV2_nonneg`
- `globalLift`
- `global_dist?_symmetry`
- `global_dist?_symmetry_from_SymmAdj`
- `global_dist?_symmetry_from_UndirectedGraph`
- `global_dist?_triangle`
- `global_dist?_triangle_unconditional`
- `inBoundedRadius_of_distLE`
- `le_natListMax_of_mem`
- `lineGraph`
- `lineGraph_direct_path_ac_le_two`
- `lineGraph_direct_path_symmetry_ab_ba`
- `lineGraph_dist_ab_ba_symmetry`
- `lineGraph_dist_ab_le_one`
- `lineGraph_dist_ac_le_two`
- `lineGraph_dist_ba_le_one`
- `lineGraph_path_aa_zero`
- `lineGraph_path_ab`
- `lineGraph_path_ac_two`
- `lineGraph_path_ba`
- `lineGraph_path_bb_zero`
- `lineGraph_path_bc`
- `lineGraph_path_ca_two`
- `lineGraph_path_cb`
- `lineGraph_path_cc_zero`
- `lineGraph_symm`
- `memBall_iff`
- `natListMax`
- `nilPath`
- `not_distGT_of_distLE`
- `not_distLE_of_none`
- `path3Graph`
- `pathLength_concat`
- `pathLength_one_of_adj`
- `pathLength_reverse`
- `pathLength_zero_iff`
- `path_concat`
- `path_of_dist?_some`
- `path_reverse`
- `reachable_of_adj`
- `reachable_refl`
- `shortest_path_selector_complete_of_reachable`
- `splitGraph`
- `symmAdj_of_undirectedGraph`
- `testGraph`
- `triangleGraph`
- `trivialGraph`
- `undirectedEdgeCount_nonneg`
- `vertexCount`

### FACTORIZATION / INVARIANTS

Mapped names:

- `EvalStub`
- `SLASH`
- `badF_factorsThrough`
- `constructiveSLASHAxioms_iff`
- `evalLocal`
- `eval_bijective`
- `eval_coherence`
- `eval_injective`
- `eval_surjective01`
- `factorsThrough`
- `factorsThrough_comp`
- `factorsThrough_id`
- `localCode`
- `localCode_one`
- `localCode_separates`
- `localCode_zero`
- `localProjection`
- `localToGlobal`
- `nonFactorization_placeholder`
- `useLocalFactorization`
- `useLocalType`

### FMT-CORE / SPEC SURFACES

Mapped names:

- `G`
- `closeWithin`
- `concatVerts`
- `f`
- `farApart`
- `final_solve_spec`
- `locality_pipeline_certificate`
- `revFin`
- `revFin_involutive_val`
- `revFin_last`
- `revFin_zero`
- `separated`
- `shortest_length_spec`

## Explicit nonclaims

The following are intentionally out of scope for this repository-level map:

- Fagin, "Generalized first-order spectra and polynomial-time recognizable sets", 1974.
- Glebskii, Kogan, Liogonkii, Talanov, "Range and degree of realizability of formulas in the restricted predicate calculus", 1969.
- Kolaitis/Vardi existential second-order and 0-1 law fragments.

Reason:

- These support global finite-model-theory and descriptive-complexity frontiers.
- The repository boundary says no Fagin theorem, no 0-1 Law, and no global finite-model-theory final theorem is claimed.

