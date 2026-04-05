import FMT.Invariants.FactorsThrough

namespace FMT.Invariants

inductive LocalType where
  | zero

axiom badF_factorsThrough
  {A B C : Type _} (f : A → B) (g : B → C) (h : A → C) :
  factorsThrough f g h

axiom nonFactorization_placeholder : True

end FMT.Invariants
