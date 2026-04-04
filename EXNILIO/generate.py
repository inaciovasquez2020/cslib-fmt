from pathlib import Path

seed = sorted([
    "gamma",
    "alpha",
    "beta",
])

Path("EXNILIO/input.txt").write_text("\n".join(seed) + "\n", encoding="utf-8")
print("generated EXNILIO/input.txt")
