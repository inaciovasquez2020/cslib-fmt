import FMT.Graph.PathLength
import FMT.Graph.DistancePath

namespace FMT.Examples

open FMT.Graph

/-
This file is reserved for demonstrating that any legacy fallback distance
that returns a finite value on disconnected vertices cannot satisfy
the path-based `dist?` semantics.  The semantic regression target is:
`dist? = none` on disconnected pairs.
-/

end FMT.Examples
