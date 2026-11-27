import re
import sys
from pathlib import Path

audit = Path(sys.argv[1]).read_text(encoding="utf-8")
log = Path(sys.argv[2]).read_text(encoding="utf-8")
names = re.findall(r"^#print axioms (\S+)$", audit, re.MULTILINE)
required = {
    "CSLIB.FMT.UnguardedFO.cycleSimpleGraph_boundary_intertwines",
    "CSLIB.FMT.UnguardedFO.cycleGraphEntropy_transport",
    "CSLIB.FMT.UnguardedFO.logicalEntropy_witnesses",
    "CSLIB.FMT.UnguardedFO.logicalEntropy_estimator_lower_bound",
    "CSLIB.FMT.UnguardedFO.cyclePartition_radius_minimax_value",
}
if len(names) != len(set(names)) or not required <= set(names):
    raise SystemExit("Audit targets must be unique and include all integration endpoints")

allowed = {"propext", "Classical.choice", "Quot.sound"}
for name in names:
    pattern = (
        rf"^'{re.escape(name)}' "
        r"(?:does not depend on any axioms|depends on axioms:\s*\[([^\]]*)\])"
    )
    reports = re.findall(pattern, log, re.MULTILINE)
    if len(reports) != 1:
        raise SystemExit(f"Expected one axiom report for {name}")
    used = {entry.strip() for entry in reports[0].split(",") if entry.strip()}
    if not used <= allowed:
        raise SystemExit(f"Disallowed axioms for {name}: {sorted(used - allowed)}")
    print(f"{name}: {', '.join(sorted(used)) or '(none)'}")
print(f"PASS: {len(names)} declarations imported through FMT")
