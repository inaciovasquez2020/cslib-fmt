
# Roadmap

## Release R1: stable public core

* Freeze import discipline.
* Eliminate avoidable placeholder exports from public core.
* Tag a release once graph/path/distance baseline is stable.

## Release R2: onboarding surface

* Keep `README.md`, `START_HERE.md`, `ARCHITECTURE.md`, and `STATUS.md` synchronized.
* Maintain one canonical theorem chain and one minimal example.

## Release R3: reusable library extraction

* Keep graph/distance/radius/FO^k/EF/type/cycle-space APIs usable without URF-specific claims.
* Mark project-specific statements separately.

## Release R4: external validation

* Maintain narrowly scoped issues.
* Link accepted papers, talks, citations, and reproductions from the front page.

## Immediate tasks

1. Close theorem-level distance symmetry.
2. Close theorem-level distance triangle inequality.
3. Close constructive distance upper-bound theorem.
4. Harden factorization semantics.
5. Extract reusable cycle-space API notes.
   EOF

cd ~/github-audit/cslib-fmt && cat > docs/notes/NOTE_distance.md <<'EOF'

# Distance Layer Note

## Definitions

* `PathLength G u v n`
* `dist? G u v`
* bounded-radius ball/neighborhood objects

## Claim surface

* paths induce upper bounds on distance
* symmetry for undirected graphs
* triangle inequality by path concatenation

## Novelty claim

This layer is library infrastructure, not the primary novelty claim.

## Status

See `docs/status/STATUS.md`.
