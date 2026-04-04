from pathlib import Path

p = Path("EXNILIO/input.txt")
xs = p.read_text(encoding="utf-8").splitlines()
ys = sorted(set(x.strip() for x in xs if x.strip() != ""))
p.write_text("\n".join(ys) + "\n", encoding="utf-8")
print("corrected EXNILIO/input.txt")
