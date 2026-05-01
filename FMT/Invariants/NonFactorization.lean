namespace FMT.Invariants

/-- Status object: the non-factorization invariant has not yet been given a theorem-level witness here. -/
inductive NonFactorizationFrontierStatus where
  | frontier : NonFactorizationFrontierStatus

def badF_factorsThrough : NonFactorizationFrontierStatus :=
  NonFactorizationFrontierStatus.frontier

def nonFactorization_placeholder : NonFactorizationFrontierStatus :=
  badF_factorsThrough

end FMT.Invariants
