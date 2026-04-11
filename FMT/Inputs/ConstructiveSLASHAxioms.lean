import FMT.Inputs.SLASH_Axioms

namespace FMT.Inputs

abbrev ConstructiveSLASHAxioms (G : Graph.Graph) : Prop := SLASHAxioms G

theorem constructiveSLASHAxioms_iff (G : Graph.Graph) :
    ConstructiveSLASHAxioms G ↔ SLASHAxioms G := Iff.rfl

end FMT.Inputs
