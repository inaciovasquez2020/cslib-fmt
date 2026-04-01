import FMT.Graph.Basic

namespace FMT.Examples

open FMT.Graph

def trivialGraph : Graph :=
{ V := Unit,
  Adj := fun _ _ => False }

end FMT.Examples
