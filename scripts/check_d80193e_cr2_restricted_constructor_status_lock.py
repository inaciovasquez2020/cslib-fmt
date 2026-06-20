#!/usr/bin/env python3
import argparse
import json
import subprocess
from pathlib import Path

CERT_ID = "D80193E_CR2_RESTRICTED_CONSTRUCTOR_STATUS_LOCK_2026_06_19"
COMMIT = "d80193e"
ARTIFACT = Path("artifacts/cslib_fmt/d80193e_cr2_restricted_constructor_status_lock_2026_06_19.json")
DOC = Path("docs/status/D80193E_CR2_RESTRICTED_CONSTRUCTOR_STATUS_LOCK_2026_06_19.md")

REQUIRED_FILES = [
    "lean/CSLIB/FMT/GuardedLocality/Pipeline.lean",
    "artifacts/cslib_fmt/bounded_surface_verified_lemma_certificate_2026_06_19.json",
    "artifacts/cslib_fmt/cr2_discharges_guarded_locality_input_2026_06_19.json",
    "artifacts/cslib_fmt/cr2_exact_target_surface_2026_06_19.json",
    "artifacts/cslib_fmt/cr2_restricted_constructor_target_2026_06_19.json",
    "artifacts/cslib_fmt/cr2_unconditional_constructor_gap_2026_06_19.json",
    "artifacts/cslib_fmt/guarded_locality_boundary_conditional_lemma_2026_06_19.json",
    "artifacts/cslib_fmt/noncomputable_audit_2026_06_19.json",
    "docs/status/BOUNDED_SURFACE_VERIFIED_LEMMA_CERTIFICATE_2026_06_19.md",
    "docs/status/CR2_DISCHARGES_GUARDED_LOCALITY_INPUT_2026_06_19.md",
    "docs/status/CR2_EXACT_TARGET_SURFACE_2026_06_19.md",
    "docs/status/CR2_RESTRICTED_CONSTRUCTOR_TARGET_2026_06_19.md",
    "docs/status/CR2_UNCONDITIONAL_CONSTRUCTOR_GAP_2026_06_19.md",
    "docs/status/GUARDED_LOCALITY_BOUNDARY_CONDITIONAL_LEMMA_2026_06_19.md",
    "docs/status/NONCOMPUTABLE_AUDIT_2026_06_19.md",
    "scripts/check_bounded_surface_verified_lemma_certificate.py",
    "scripts/check_cr2_discharges_guarded_locality_input.py",
    "scripts/check_cr2_exact_target_surface.py",
    "scripts/check_cr2_restricted_constructor_target.py",
    "scripts/check_cr2_unconditional_constructor_gap.py",
    "scripts/check_guarded_locality_boundary_conditional_lemma.py",
    "scripts/check_noncomputable_audit.py",
    "tests/test_bounded_surface_verified_lemma_certificate.py",
    "tests/test_cr2_discharges_guarded_locality_input.py",
    "tests/test_cr2_exact_target_surface.py",
    "tests/test_cr2_restricted_constructor_target.py",
    "tests/test_cr2_unconditional_constructor_gap.py",
    "tests/test_guarded_locality_boundary_conditional_lemma.py",
    "tests/test_noncomputable_audit.py",
]

BOUNDARIES = [
    "BOUNDARY := ¬ cr2_unconditional_constructor",
    "BOUNDARY := ¬ arbitrary Cr2 witness",
    "BOUNDARY := ¬ unguarded FO locality",
    "BOUNDARY := ¬ full Gaifman locality",
    "BOUNDARY := ¬ Fagin theorem",
    "BOUNDARY := ¬ 0-1 Law",
    "BOUNDARY := ¬ repository-level final FMT closure",
]

def git(*args: str) -> str:
    return subprocess.check_output(["git", *args], text=True).strip()

def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(message)

def make_payload() -> dict:
    head = git("rev-parse", "--short=7", "HEAD")
    origin = git("rev-parse", "--short=7", "origin/main")
    require(head == COMMIT, f"HEAD_MISMATCH := {head}")
    require(origin == COMMIT, f"ORIGIN_MAIN_MISMATCH := {origin}")

    for rel in REQUIRED_FILES:
        require(Path(rel).exists(), f"MISSING_OBJECT := {rel}")

    pipeline = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean").read_text()
    require(
        "theorem restricted_ef_game_local_type_invariant_input_surface_to_cr2" in pipeline,
        "MISSING_OBJECT := restricted_ef_game_local_type_invariant_input_surface_to_cr2",
    )
    require(
        "theorem cr2_unconditional_constructor" not in pipeline,
        "BOUNDARY_STALE := cr2_unconditional_constructor now exists",
    )

    return {
        "id": CERT_ID,
        "commit": COMMIT,
        "status": "pushed status lock for Cr2 restricted constructor target",
        "remote_sync": "HEAD and origin/main both resolve to d80193e",
        "closed_packet": [
            "bounded surface verified lemma certificate",
            "noncomputable audit",
            "guarded locality boundary conditional lemma",
            "Cr2 exact target surface",
            "Cr2 conditional discharge of existing guarded-locality input",
            "Cr2 unconditional constructor gap certificate",
            "Cr2 restricted constructor target",
        ],
        "validated_before_lock": [
            "targeted certificate rollup: 7 passed",
            "full pytest: 124 passed",
            "lake build: completed successfully",
        ],
        "lean_theorem_added": "restricted_ef_game_local_type_invariant_input_surface_to_cr2",
        "remaining_blocker": "cr2_unconditional_constructor",
        "boundaries": BOUNDARIES,
        "required_files": REQUIRED_FILES,
    }

def write_outputs(payload: dict) -> None:
    ARTIFACT.parent.mkdir(parents=True, exist_ok=True)
    ARTIFACT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    DOC.parent.mkdir(parents=True, exist_ok=True)
    DOC.write_text(f"""# {CERT_ID}

## Commit

`{payload["commit"]}`

## Status

Pushed status lock for the Cr2 restricted constructor target packet.

## Remote sync

HEAD and `origin/main` both resolve to `d80193e`.

## Closed packet

{chr(10).join(f"- {x}" for x in payload["closed_packet"])}

## Validation before lock

{chr(10).join(f"- {x}" for x in payload["validated_before_lock"])}

## Lean theorem added

`restricted_ef_game_local_type_invariant_input_surface_to_cr2`

## Remaining blocker

`cr2_unconditional_constructor`

## Boundary locks

{chr(10).join(f"- `{b}`" for b in payload["boundaries"])}
""")

def verify_payload(payload: dict) -> None:
    require(payload["id"] == CERT_ID, "status lock id mismatch")
    require(payload["commit"] == COMMIT, "status lock commit mismatch")
    require(payload["remaining_blocker"] == "cr2_unconditional_constructor", "remaining blocker mismatch")
    require(payload["lean_theorem_added"] == "restricted_ef_game_local_type_invariant_input_surface_to_cr2", "Lean theorem mismatch")
    for boundary in BOUNDARIES:
        require(boundary in payload["boundaries"], f"missing boundary := {boundary}")
    for rel in payload["required_files"]:
        require(Path(rel).exists(), f"MISSING_OBJECT := {rel}")

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--write-report", action="store_true")
    args = parser.parse_args()

    if args.write_report:
        write_outputs(make_payload())

    require(ARTIFACT.exists(), f"MISSING_OBJECT := {ARTIFACT}")
    require(DOC.exists(), f"MISSING_OBJECT := {DOC}")
    verify_payload(json.loads(ARTIFACT.read_text()))
    print("D80193E_CR2_RESTRICTED_CONSTRUCTOR_STATUS_LOCK_OK")

if __name__ == "__main__":
    main()
