import FMT.Graph.PathLength

namespace FMT.Graph

theorem PathLength.first_eq
    {G : Graph} {u v : G.V} {n : Nat}
    (P : PathLength G u v n) :
    P.verts ⟨0, Nat.succ_pos _⟩ = u :=
  P.start

theorem PathLength.last_eq
    {G : Graph} {u v : G.V} {n : Nat}
    (P : PathLength G u v n) :
    P.verts ⟨n, Nat.lt_succ_self n⟩ = v :=
  P.finish

theorem PathLength.start_adj
    {G : Graph} {u v : G.V} {n : Nat}
    (P : PathLength G u v (n + 1)) :
    G.Adj (P.verts ⟨0, Nat.succ_pos _⟩) (P.verts ⟨1, Nat.succ_lt_succ (Nat.succ_pos _)⟩) :=
  P.step ⟨0, Nat.succ_pos _⟩

end FMT.Graph
