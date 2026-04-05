import FMT.Invariants.CycleSpace
import Mathlib

namespace FMT.Examples

open FMT.Graph
open FMT.Invariants

inductive ThreeV
| a
| b
| c
deriving DecidableEq, Fintype

def triangleGraph : Graph where
  V := ThreeV
  Adj
  | .a, .b => True
  | .b, .a => True
  | .b, .c => True
  | .c, .b => True
  | .a, .c => True
  | .c, .a => True
  | _, _ => False

instance : FiniteGraph triangleGraph where
  fintypeV := by
    change Fintype ThreeV
    infer_instance
  decEqV := by
    change DecidableEq ThreeV
    infer_instance
  decAdj := by
    intro x y
    cases x <;> cases y <;> dsimp [triangleGraph] <;> infer_instance

example : Fintype.card ThreeV = 3 := by
  native_decide

example : vertexCount triangleGraph = 3 := by
  simp [vertexCount, triangleGraph]
  native_decide

example : (cycleSpaceOfGraph triangleGraph).dim = 3 := by
  simp [cycleSpaceOfGraph, vertexCount, triangleGraph]
  native_decide

end FMT.Examples
