# Bridge Frontier

## Live object
`FMT/Bridge/LocalGlobal.lean` currently exposes only a placeholder theorem:
`theorem localToGlobal : True := by trivial`

## Weakest sufficient next object
Replace the placeholder with the typed factorization bridge:
- a concrete local-data type
- a concrete global-interface type
- an existence map from local data to global factorization output
- a uniqueness statement for the resulting factorization output

## Closure rule
When `localToGlobal` is no longer `True`-valued and the public factorization interface derives from it without new axioms/sorry/admit, the bridge frontier may be marked closed.
