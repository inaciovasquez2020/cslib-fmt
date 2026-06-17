from pathlib import Path
import re

roots = [Path("FMT"), Path("lean/CSLIB/FMT")]
missing_roots = [str(p) for p in roots if not p.exists()]
if missing_roots:
    print("MISSING_OBJECT := " + ", ".join(missing_roots))
    raise SystemExit(1)

pat = re.compile(r"^\s*(theorem|lemma|def)\s+([A-Za-z0-9_?!']+)")
exports = set()
for root in roots:
    for path in root.rglob("*.lean"):
        for line in path.read_text(errors="ignore").splitlines():
            m = pat.match(line)
            if m:
                exports.add(m.group(2))

groups = {
    "GUARDED-LOCALITY": [],
    "EF-GAMES": [],
    "FINITE-VARIABLE / WL": [],
    "GRAPH-DISTANCE": [],
    "FACTORIZATION / INVARIANTS": [],
    "FMT-CORE / SPEC SURFACES": [],
}

for name in sorted(exports):
    low = name.lower()
    if any(k in low for k in ["guard", "balliso", "localiso", "pointed_radius", "plain_induced", "gsat", "restrictedsat", "toguar"]):
        groups["GUARDED-LOCALITY"].append(name)
    elif any(k in low for k in ["ef_game", "winslocal", "indistinguishable"]):
        groups["EF-GAMES"].append(name)
    elif any(k in low for k in ["wl", "refinecolor"]):
        groups["FINITE-VARIABLE / WL"].append(name)
    elif any(k in low for k in [
        "dist", "path", "graph", "edge", "vertex", "reachable", "ball", "boundedradius",
        "connected", "diameter", "triangle", "symm", "cycle", "natlistmax", "inboundedradius"
    ]):
        groups["GRAPH-DISTANCE"].append(name)
    elif any(k in low for k in [
        "factor", "inject", "surject", "biject", "coherence", "localprojection",
        "localtoglobal", "globallift", "localcode", "eval", "slash", "uselocal"
    ]):
        groups["FACTORIZATION / INVARIANTS"].append(name)
    else:
        groups["FMT-CORE / SPEC SURFACES"].append(name)

out = []
out.append("# CSLIB-FMT Citation Dependency Map\n")
out.append("Status: exported-theorem citation audit surface.\n")
out.append("Date: 2026-06-17.\n")
out.append("Scope: `FMT/*` and `lean/CSLIB/FMT/*`.\n")
out.append("Boundary: citation support only; not a theorem-level closure claim.\n\n")
out.append("BOUNDARY := ¬ repository-level proof of Fagin theorem ∨ 0-1 Law ∨ global finite-model-theory final theorem.\n\n")

out.append("## Canonical citation families\n\n")
out.append("### FMT-CORE\n\n")
out.append("- Leonid Libkin, *Elements of Finite Model Theory*, Springer, 2004.\n")
out.append("- Heinz-Dieter Ebbinghaus and Jörg Flum, *Finite Model Theory*, Springer, 1995.\n")
out.append("- Neil Immerman, *Descriptive Complexity*, Springer, 1999.\n\n")

out.append("### LOCALITY\n\n")
out.append("- William Hanf, \"Model-theoretic methods in the study of elementary logic\", 1965.\n")
out.append("- Haim Gaifman, \"On local and non-local properties\", 1982.\n")
out.append("- Lauri Hella, Leonid Libkin, Juha Nurmonen, \"Notions of locality and their logical characterizations over finite models\", *Journal of Symbolic Logic* 64(4), 1999.\n\n")

out.append("### GUARDED-LOCALITY\n\n")
out.append("- Hajnal Andréka, Johan van Benthem, István Németi, \"Modal Languages and Bounded Fragments of Predicate Logic\", *Journal of Philosophical Logic* 27, 1998.\n")
out.append("- Erich Grädel, \"On the Restraining Power of Guards\", *Journal of Symbolic Logic* 64(4), 1999.\n")
out.append("- Erich Grädel, \"Decision Procedures for Guarded Logics\", CADE 1999.\n\n")

out.append("### EF-GAMES\n\n")
out.append("- Roland Fraïssé, \"Sur quelques classifications des systèmes de relations\", 1954.\n")
out.append("- Andrzej Ehrenfeucht, \"An application of games to the completeness problem for formalized theories\", *Fundamenta Mathematicae* 49, 1961.\n\n")

out.append("### FINITE-VARIABLE / WL\n\n")
out.append("- Jin-Yi Cai, Martin Fürer, Neil Immerman, \"An Optimal Lower Bound on the Number of Variables for Graph Identification\", *Combinatorica* 12, 1992.\n\n")

out.append("### GRAPH-DISTANCE\n\n")
out.append("- Reinhard Diestel, *Graph Theory*, Springer.\n")
out.append("- Douglas B. West, *Introduction to Graph Theory*, Prentice Hall.\n")
out.append("- Béla Bollobás, *Modern Graph Theory*, Springer.\n\n")

out.append("### FACTORIZATION / INVARIANTS\n\n")
out.append("- Leonid Libkin, *Elements of Finite Model Theory*, finite types/locality chapters.\n")
out.append("- Lauri Hella, Leonid Libkin, Juha Nurmonen, \"Notions of locality and their logical characterizations over finite models\", 1999.\n\n")

out.append("### FORMALIZATION-METHODOLOGY\n\n")
out.append("- Mario Carneiro et al., \"Lean4Lean: Mechanizing the Metatheory of Lean\", WITS 2026.\n")
out.append("- Yuanhe Zhang, Jason D. Lee, Fanghui Liu, \"AI4SLT: Empirical Processes in Lean 4 for Formal Statistical Learning Theory\", arXiv:2602.02285, ICML 2026.\n")
out.append("- Yuanhe Zhang, Jason D. Lee, Fanghui Liu, \"Statistical Learning Theory in Lean 4: Empirical Processes from Scratch\", ResearchGate preprint page.\n\n")
out.append("Boundary: these works support formalization methodology, not CSLIB-FMT mathematical theorem content.\n\n")

out.append("## Promoted proof-facing target\n\n")
out.append("- `locality_pipeline_certificate`\n\n")
out.append("Canonical family: `GUARDED-LOCALITY`.\n")
out.append("Secondary families: `LOCALITY`, `EF-GAMES`.\n\n")

out.append("## Exported-name citation map\n\n")
for group, names in groups.items():
    out.append(f"### {group}\n\n")
    out.append("Mapped names:\n\n")
    for name in names:
        out.append(f"- `{name}`\n")
    out.append("\n")

out.append("## Explicit nonclaims\n\n")
out.append("The following are intentionally out of scope for this repository-level map:\n\n")
out.append("- Fagin, \"Generalized first-order spectra and polynomial-time recognizable sets\", 1974.\n")
out.append("- Glebskii, Kogan, Liogonkii, Talanov, \"Range and degree of realizability of formulas in the restricted predicate calculus\", 1969.\n")
out.append("- Kolaitis/Vardi existential second-order and 0-1 law fragments.\n\n")
out.append("Reason:\n\n")
out.append("- These support global finite-model-theory and descriptive-complexity frontiers.\n")
out.append("- The repository boundary says no Fagin theorem, no 0-1 Law, and no global finite-model-theory final theorem is claimed.\n\n")

Path("CITATION_DEPENDENCY_MAP.md").write_text("".join(out))

doc = Path("CITATION_DEPENDENCY_MAP.md").read_text()
missing = sorted(name for name in exports if f"`{name}`" not in doc)
if missing:
    print("MISSING_OBJECT := citation map entries")
    for name in missing:
        print(name)
    raise SystemExit(1)

print("CSLIB_FMT_CITATION_DEPENDENCY_MAP_EXPORT_COVERAGE_OK")
