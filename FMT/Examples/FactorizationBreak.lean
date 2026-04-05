import FMT.Invariants.NonFactorization

namespace FMT.Examples

open FMT.Invariants
open FMT.Types

example : factorsThrough badF := by
  exact badF_factorsThrough

end FMT.Examples
