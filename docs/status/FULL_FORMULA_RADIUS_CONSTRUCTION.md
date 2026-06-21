# Full formula-radius construction

Status: `FULL_FORMULA_RADIUS_CONSTRUCTION_CLOSED`

The repository-internal `full_formula_radius_construction` object is closed in
`lean/CSLIB/FMT/UnguardedFO/LocalityInputSurface.lean` by structural recursion
over `Formula`.

The Boolean conjunction and disjunction cases use the already available
common-smaller-radius constructors. The existential case uses the already closed
`existential_locality_radius_constructor`.

Boundary: this closes only the repository-internal formula-radius construction
object. It does not prove Fagin's theorem, the 0-1 Law, or any external
finite-model-theory closure theorem.
