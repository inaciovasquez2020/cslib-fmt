from pathlib import Path

p = Path("EXNILIO/input.txt")
xs = p.read_text(encoding="utf-8").splitlines()
ys = ["  beta  ", "", "alpha", "gamma", "alpha", "   "]
p.write_text("\n".join(ys) + "\n", encoding="utf-8")
print("corrupted EXNILIO/input.txt")
