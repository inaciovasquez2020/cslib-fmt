namespace FMT.Graph

structure Graph where
  V   : Type
  Adj : V → V → Prop

end FMT.Graph
