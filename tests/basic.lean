import FMT.API
import FMT.Invariants.CycleSpace
import FMT.Types.LocalType

open FMT

def t1 := extractType ⟨3⟩ 5
def t2 := invariantDim 4 6 1

#eval t1.code
#eval t2.dim
