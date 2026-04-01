import FMT.Graph.Basic

namespace FMT.Types

structure RootedBall (G : Type) where
  center : G
  radius : Nat

structure LocalType where
  code : Nat

def encode {G : Type} (b : RootedBall G) : LocalType :=
  ⟨b.radius⟩

end FMT.Types
