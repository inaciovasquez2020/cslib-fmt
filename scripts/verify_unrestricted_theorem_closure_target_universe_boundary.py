from pathlib import Path

DOC = Path("docs/status/UNRESTRICTED_THEOREM_CLOSURE_TARGET_UNIVERSE.md")

required = [
    "STATUS := TARGET_UNIVERSE_MISSING",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 0%",
    "WEAKEST_ADMISSIBLE_REPLACEMENT := bounded_recursive_theorem_family_closure",
    "POSITIVE_FINITE_FAMILY_CRITERION :=",
    "REJECTED_PROMOTION := bounded theorem-closure audit examples do not imply unrestricted theorem closure.",
    "BOUNDARY := ¬ unrestricted_theorem_closure",
]

forbidden = [
    "CLAIM_NOW_SAFE := unrestricted theorem closure",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 1%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 10%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 20%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 50%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 88%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 100%",
    "bounded theorem-closure audit examples imply unrestricted theorem closure",
    "BOUNDARY := unrestricted_theorem_closure",
]

text = DOC.read_text(encoding="utf-8")

for item in required:
    if item not in text:
        raise SystemExit(f"MISSING_OBJECT := {item}")

for item in forbidden:
    if item in text:
        raise SystemExit(f"FORBIDDEN_PROMOTION := {item}")

print("UNRESTRICTED_THEOREM_CLOSURE_TARGET_UNIVERSE_BOUNDARY_OK")
