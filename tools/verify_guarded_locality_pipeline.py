#!/usr/bin/env python3
from pathlib import Path
import json
import re

lean = Path("lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")
if not lean.exists():
    raise SystemExit("missing lean/CSLIB/FMT/GuardedLocality/Pipeline.lean")

text = lean.read_text()

required = [
    "guarded_rank_locality",
    "restricted_guarded_translation_sound",
    "restricted_guarded_rank_locality",
    "ballIso_to_localIso",
    "localIso_to_ballIso",
    "ballIso_iff_localIso",
    "ordinary_pointed_radius_ball_bijection_to_ballIso",
    "pointed_radius_ball_equiv_iff_ballIso",
    "plain_induced_radius_ball_isomorphism_to_pointed_radius_ball_equiv",
    "plain_induced_radius_ball_isomorphism_iff_pointed_radius_ball_equiv",
    "locality_pipeline_certificate",
]

missing = [name for name in required if name not in text]
if missing:
    raise SystemExit(f"missing required declarations: {missing}")

for token in ["sorry", "admit", "axiom", "opaque"]:
    if re.search(rf"\b{token}\b", text):
        raise SystemExit(f"forbidden token found: {token}")

artifacts = sorted(Path("artifacts/fmt").glob("guarded_locality_pipeline_*.json"))
if not artifacts:
    raise SystemExit("missing guarded locality pipeline artifact")

data = json.loads(artifacts[-1].read_text())
if data.get("status") != "BOUNDED_GUARDED_LOCALITY_CLOSURE":
    raise SystemExit("bad artifact status")

print("CSLIB_FMT_GUARDED_LOCALITY_PIPELINE_OK")
