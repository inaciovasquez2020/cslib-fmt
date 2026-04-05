namespace FMT.Invariants

def factorsThrough {A B C : Type _} (f : A → B) (g : B → C) (h : A → C) : Prop :=
  ∀ a, h a = g (f a)

end FMT.Invariants
