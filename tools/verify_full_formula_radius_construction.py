#!/usr/bin/env python3
from pathlib import Path
import re

src = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean").read_text()

required = [
    "theorem unguarded_fo_top_locality_input",
    "theorem unguarded_fo_bot_locality_input",
    "noncomputable def unguarded_fo_formula_radius_construction",
    "exact existential_locality_radius_constructor M ih",
    "def full_formula_radius_construction : Type 1",
    "noncomputable def full_formula_radius_construction_closed",
    "def full_formula_radius_construction_status : Prop",
    "theorem full_formula_radius_construction_status_closed",
]

for needle in required:
    if needle not in src:
        raise SystemExit(f"MISSING_OBJECT := {needle}")

block_start = src.find("theorem unguarded_fo_top_locality_input")
if block_start == -1:
    raise SystemExit("MISSING_OBJECT := full_formula_radius_construction_block")

block = src[block_start:]
for forbidden in ["sorry", "admit"]:
    if re.search(rf"\b{forbidden}\b", block):
        raise SystemExit(f"FORBIDDEN_OBJECT := {forbidden}")

for forbidden_decl in [
    r"\baxiom\s+full_formula_radius_construction\b",
    r"\bopaque\s+full_formula_radius_construction\b",
    r"\baxiom\s+unguarded_fo_formula_radius_construction\b",
    r"\bopaque\s+unguarded_fo_formula_radius_construction\b",
]:
    if re.search(forbidden_decl, src):
        raise SystemExit("FORBIDDEN_OBJECT := opaque_or_axiom_formula_radius_construction")

print("FULL_FORMULA_RADIUS_CONSTRUCTION_OK")
