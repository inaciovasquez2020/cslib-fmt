import FMT.Invariants.GenuineCycleRankV2
import FMT.Invariants.CycleSpace
import FMT.Graph.Edge
import Mathlib

namespace FMT.Examples

open FMT.Graph
open FMT.Invariants

inductive Path3V
| a
| b
| c
deriving DecidableEq, Fintype

def path3Graph : Graph where
  V := Path3V
  Adj
  | .a, .b => True
  | .b, .a => True
  | .b, .c => True
  | .c, .b => True
  | _, _ => False

instance : FiniteGraph path3Graph where
  fintypeV := by
    change Fintype Path3V
    infer_instance
  decEqV := by
    change DecidableEq Path3V
    infer_instance
  decAdj := by
    intro x y
    cases x <;> cases y <;> dsimp [path3Graph] <;> infer_instance

example : vertexCount path3Graph = 3 := by
  native_decide

noncomputable example : 0 ≤ edgeCount path3Graph := by
  exact edgeCount_nonneg path3Graph

example : (cycleSpaceOfGraph path3Graph).dim = 3 := by
  native_decide

example : 0 ≤ genuineCycleRankV2 path3Graph := by
  exact genuineCycleRankV2_nonneg path3Graph

end FMT.Examples
