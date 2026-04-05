namespace FMT.Types

structure FactorsThrough {A B C : Type} (f : A → C) (g : A → B) :=
(h : ∃ h' : B → C, ∀ x, f x = h' (g x))

theorem factorsThrough_of_eq
  {A B C : Type} {f : A → C} {g : A → B}
  (h : ∃ h' : B → C, ∀ x, f x = h' (g x)) :
  FactorsThrough f g := ⟨h⟩

end FMT.Types
