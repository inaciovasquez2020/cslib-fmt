# Distance layer release freeze

Status: RELEASE FREEZE.

## Certified object

The cslib-fmt graph distance layer is frozen after theorem-level closure.

## Evidence

Merged closure chain:

- PR #130: constructive `dist?_le_of_path`
- PR #131: theorem-level `dist?_symm`
- PR #132: theorem-level `dist?_triangle`
- PR #134: theorem-level `distLE_triangle`
- PR #135: grep-clean stale frontier removal

Release tag:

```text
cslib-fmt-distance-layer-closed-grep-clean-2026-04-23
Local verification surface
Required local checks:
PYTHONDONTWRITEBYTECODE=1 python3 -m pytest -q
lake build
Known passing surface:
27 passed
Build completed successfully
Boundary
This freeze certifies only the cslib-fmt graph distance layer.
No claim is made about unrelated graph modules, external repositories, or future theorem layers.
Conclusion
The graph distance layer is theorem-level closed and release-frozen.
