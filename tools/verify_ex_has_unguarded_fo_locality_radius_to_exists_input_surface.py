from pathlib import Path
import re

LEAN = Path("lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")
if not LEAN.exists():
    raise SystemExit("MISSING_OBJECT := lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean")

src = LEAN.read_text()

theorem_name = "ex_has_unguarded_fo_locality_radius_to_exists_input_surface"
pos = src.find("theorem " + theorem_name)
if pos < 0:
    raise SystemExit(f"MISSING_OBJECT := theorem {theorem_name}")

end = src.find("\nend UnguardedFO", pos)
if end < 0:
    raise SystemExit("MISSING_OBJECT := theorem namespace closing anchor")

block = src[pos:end]

required = [
    "∃ r : Nat, UnguardedFOLocalityInputSurface M (Formula.ex φ) r",
    "HasUnguardedFOLocalityRadius M φ",
    "existential_locality_radius_constructor M hφ",
    "exact ⟨hEx.radius, hEx.input⟩",
]
for needle in required:
    if needle not in block:
        raise SystemExit(f"MISSING_OBJECT := {needle}")

for forbidden in ["sorry", "admit", "axiom", "opaque"]:
    if re.search(rf"\b{forbidden}\b", block):
        raise SystemExit(f"FORBIDDEN_TOKEN := {forbidden}")

print("EX_HAS_UNGUARDED_FO_LOCALITY_RADIUS_TO_EXISTS_INPUT_SURFACE_OK")
