#!/usr/bin/env python3
from pathlib import Path
import json
import re
import subprocess

SRC = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
ART = Path("artifacts/cslib_fmt/finite_boolean_disjunction_fold_access_surface_2026_06_20.json")
DOC = Path("docs/status/FINITE_BOOLEAN_DISJUNCTION_FOLD_ACCESS_SURFACE_2026_06_20.md")

def git_grep(pattern: str) -> str:
    return subprocess.check_output(
        ["git", "grep", "-n", pattern, "--", "*.lean"],
        text=True,
    )

def main() -> None:
    src = SRC.read_text()
    data = json.loads(ART.read_text())
    doc = DOC.read_text()

    assert re.search(r"\bdef\s+finite_boolean_disjunction_fold_access_surface\b", src)
    assert re.search(r"\btheorem\s+finite_boolean_disjunction_fold_access_surface_closed\b", src)
    assert "unguarded_fo_disj_same_radius_constructor" in src
    assert "unguarded_fo_disj_common_smaller_radius_constructor" in src

    fold_hits = git_grep("finite_boolean_family_fold")
    shared_hits = git_grep("finite_boolean_family_fold_shared_radius")
    assert "finite_boolean_family_fold" in fold_hits
    assert "finite_boolean_family_fold_shared_radius" in shared_hits

    assert data["artifact"] == "FINITE_BOOLEAN_DISJUNCTION_FOLD_ACCESS_SURFACE"
    assert data["status"] == "ACCESS_SURFACE_ONLY"
    assert data["boundary"] == "BOUNDARY := ¬ arbitrary_boolean_or_quantifier_recursion"

    assert "STATUS := ACCESS_SURFACE_ONLY" in doc
    assert "BOUNDARY := ¬ arbitrary_boolean_or_quantifier_recursion" in doc

    print("FINITE_BOOLEAN_DISJUNCTION_FOLD_ACCESS_SURFACE_OK")

if __name__ == "__main__":
    main()
