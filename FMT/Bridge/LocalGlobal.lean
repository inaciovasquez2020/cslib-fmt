namespace FMT.Bridge

structure LocalData where
  witness : Unit

structure GlobalFactorization where
  witness : Unit

def buildFactorization (_ : LocalData) : GlobalFactorization :=
  ⟨()⟩

theorem localToGlobal (d : LocalData) :
    ∃ g : GlobalFactorization, ∀ h : GlobalFactorization, h = g := by
  refine ⟨buildFactorization d, ?_⟩
  intro h
  cases h
  rfl

end FMT.Bridge
