import FMT.Invariants.CycleSpace
import Mathlib

namespace FMT.Examples

open FMT.Graph
open FMT.Invariants

inductive TwoV
| a
| b
deriving DecidableEq, Fintype

def testGraph : Graph where
  V := TwoV
  Adj
  | .a, .b => True
  | .b, .a => True
  | _, _ => False

instance : FiniteGraph testGraph where
  fintypeV := by
    change Fintype TwoV
    infer_instance
  decEqV := by
    change DecidableEq TwoV
    infer_instance
  decAdj := by
    intro x y
    cases x <;> cases y <;> dsimp [testGraph] <;> infer_instance

example : Fintype.card TwoV = 2 := by
  native_decide

example : vertexCount testGraph = 2 := by
  simp [vertexCount, testGraph]
  native_decide

example : (cycleSpaceOfGraph testGraph).dim = 2 := by
  simp [cycleSpaceOfGraph, vertexCount, testGraph]
  native_decide

end FMT.Examples
