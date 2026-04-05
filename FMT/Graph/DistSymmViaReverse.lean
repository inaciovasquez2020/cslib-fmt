import FMT.Graph.DistanceCore
import FMT.Graph.PathLengthReverse

namespace FMT.Graph

theorem dist?_symm_via_reverse
  (G : Graph)
  (hsymm : ∀ a b : G.V, G.Adj a b → G.Adj b a)
  (u v : G.V) :
  (∃ n, dist? (G:=G) u v = some n) → (∃ n, dist? (G:=G) v u = some n) := by
  intro huv
  rcases huv with ⟨n, hn⟩
  have hp : Nonempty (PathLength G u v n) := path_of_dist?_some G hn
  rcases hp with ⟨P⟩
  rcases dist?_cases G v u with ⟨m, hm⟩ | hnone
  · exact ⟨m, hm⟩
  · exfalso
    unfold dist? at hnone
    have hrev : Nonempty (PathLength G v u n) := ⟨pathLength_reverse G hsymm P⟩
    have hex : ∃ k, Nonempty (PathLength G v u k) := ⟨n, hrev⟩
    simp [hex] at hnone

end FMT.Graph
