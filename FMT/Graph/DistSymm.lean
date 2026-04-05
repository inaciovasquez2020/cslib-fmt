import FMT.Graph.DistancePath
import FMT.Graph.PathLength
import FMT.Inputs.SLASH_Axioms

namespace FMT.Graph

theorem dist?_symm
  (G : Graph) [FMT.Inputs.SLASHAxioms G] (u v : G.V) :
  ∀ d, dist? G u v = some d → dist? G v u = some d := by
  intro d huv
  classical
  obtain ⟨p⟩ := path_of_dist?_some (G:=G) (u:=u) (v:=v) huv
  have hrev : Nonempty (PathLength G v u d) := ⟨PathLength.reverse p⟩
  obtain ⟨d', hd', hle⟩ := dist?_le_of_path (G:=G) (u:=v) (v:=u) hrev
  have : d' = d := by
    apply Nat.le_antisymm
    · exact hle
    ·
      obtain ⟨p'⟩ := path_of_dist?_some (G:=G) (u:=v) (v:=u) hd'
      have hcat : Nonempty (PathLength G u v (d' + d)) :=
        ⟨PathLength.concat p' p⟩
      obtain ⟨d'', hd'', hle''⟩ := dist?_le_of_path (G:=G) (u:=u) (v:=v) hcat
      have : d'' = 0 := by
        simpa using hd''
      exact Nat.le_of_eq (by simp [this] at hle''; exact le_of_eq (Nat.zero_add _ ▸ rfl))
  simpa [this] using hd'

end FMT.Graph
