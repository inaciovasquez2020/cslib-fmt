namespace FMT.Types

open Classical

structure FactorsThrough {A B C : Type} (f : A → C) (g : A → B) where
  lift : B → C
  comm : ∀ x, f x = lift (g x)

noncomputable def factorsThrough_of_eq
  {A B C : Type} {f : A → C} {g : A → B}
  (h : ∃ h' : B → C, ∀ x, f x = h' (g x)) :
  FactorsThrough f g :=
  ⟨Classical.choose h, Classical.choose_spec h⟩

def factorsThrough_id
  {A B : Type} (g : A → B) :
  FactorsThrough g g :=
  ⟨id, by intro x; rfl⟩

def factorsThrough_comp
  {A B C D : Type}
  {f : A → D} {g : A → C} {h : A → B}
  (hf : FactorsThrough f g)
  (hg : FactorsThrough g h) :
  FactorsThrough f h :=
  ⟨fun b => hf.lift (hg.lift b), by
    intro x
    rw [hf.comm x, hg.comm x]⟩

end FMT.Types
