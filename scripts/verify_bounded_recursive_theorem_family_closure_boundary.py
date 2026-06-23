from pathlib import Path

DOC = Path("docs/status/BOUNDED_RECURSIVE_THEOREM_FAMILY_CLOSURE.md")

required = [
    "STATUS := WEAKEST_ADMISSIBLE_REPLACEMENT_ONLY",
    "SCOPE := bounded recursive theorem family only",
    "REPLACES_REJECTED_TARGET := unrestricted_theorem_closure",
    "POSITIVE_CRITERION :=",
    "FORBIDDEN_PROMOTION := bounded_recursive_theorem_family_closure does not imply unrestricted theorem closure.",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 0%",
    "BOUNDARY := ¬ unrestricted_theorem_closure",
]

forbidden = [
    "STATUS := unrestricted theorem closure",
    "CLAIM_NOW_SAFE := unrestricted theorem closure",
    "bounded_recursive_theorem_family_closure implies unrestricted theorem closure",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 1%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 10%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 20%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 50%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 88%",
    "UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 100%",
    "BOUNDARY := unrestricted_theorem_closure",
]

text = DOC.read_text(encoding="utf-8")

for item in required:
    if item not in text:
        raise SystemExit(f"MISSING_OBJECT := {item}")

for item in forbidden:
    if item in text:
        raise SystemExit(f"FORBIDDEN_PROMOTION := {item}")

print("BOUNDED_RECURSIVE_THEOREM_FAMILY_CLOSURE_BOUNDARY_OK")
