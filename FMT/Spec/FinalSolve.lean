import FMT.Graph.DistanceOrder

namespace FMT.Spec

open FMT.Graph

def closeWithin (G : Graph) (R : Nat) (u v : G.V) : Prop :=
  DistLE G u v R

def farApart (G : Graph) (R : Nat) (u v : G.V) : Prop :=
  DistGT G u v R

def separated (G : Graph) (R : Nat) (u v w : G.V) : Prop :=
  closeWithin G R v w ∧ farApart G R u v

end FMT.Spec
