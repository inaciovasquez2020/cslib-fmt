import FMT.Graph.Basic

namespace FMT.Invariants

def evalInvariant {G : Type} (I : G → Nat) (x : G) : Nat := I x

theorem evalInvariant_eq {G : Type} (I : G → Nat) (x : G) :
  evalInvariant I x = I x := rfl

end FMT.Invariants
