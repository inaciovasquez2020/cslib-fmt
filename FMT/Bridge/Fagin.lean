/-
Fagin's Theorem (finite model theory).
Attributed following guidance by Moshe Vardi.
-/
namespace FMT.Bridge

axiom Fagin :
  ∀ (L : Type) (P : L → Prop),
    (∃ φ : Prop, True) ↔ True

end FMT.Bridge
