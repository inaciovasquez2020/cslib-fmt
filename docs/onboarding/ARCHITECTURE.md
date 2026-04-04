Architecture
Layer A: Core graph infrastructure
Purpose: paths, path length, existence, concatenation, reversal, distance.
Primary modules:
FMT.Graph.Basic
FMT.Graph.PathLength
FMT.Graph.Distance
FMT.Graph.BoundedRadius
Invariant:
graph/path/distance layer is reusable independently of URF-specific claims.
Layer B: Logic infrastructure
Purpose: FO^k syntax and locality-facing definitions.
Primary modules:
FMT.Logic.FOkSyntax
FMT.Logic.LocalityRadius
Invariant:
syntax/locality layer depends only on stable graph/radius interfaces.
Layer C: Game infrastructure
Purpose: EF/k-pebble style interfaces over bounded-radius structures.
Primary modules:
FMT.Game.EF
FMT.Game.BoundedRadiusEF
Invariant:
game layer is separable from any specific obstruction theorem.
Layer D: Type/factorization layer
Purpose: local types, factorization interfaces, definable compression boundaries.
Primary modules:
FMT.Types.LocalType
FMT.Types.Factorization
FMT.Types.WL
Invariant:
local descriptions remain modular and reusable.
Layer E: Global invariant layer
Purpose: cycle-space, quotient/global obstruction interfaces.
Primary modules:
FMT.Invariants.CycleSpace
FMT.Invariants.NonFactorization
Invariant:
global obstructions are stated independently from library-core utility theorems.
Layer F: Examples
Purpose: explicit instances, high-girth/lift-style templates, separation witnesses.
Primary modules:
FMT.Examples.*
Invariant:
examples test interfaces without contaminating reusable core APIs.
Public maturity rules
Stable imports from lower to higher layers only.
Closed / Conditional / Open status recorded explicitly.
Reusable modules documented independently of project-specific interpretation.
