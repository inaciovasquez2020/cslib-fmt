namespace FMT.Types

inductive LocalType : Type
| zero
| one
deriving DecidableEq, Repr

def evalLocal : LocalType → Nat
| .zero => 0
| .one  => 1

end FMT.Types
