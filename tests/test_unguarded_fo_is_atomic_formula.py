import subprocess
from pathlib import Path

def test_unguarded_fo_is_atomic_formula_accepts_only_eq_and_rel(tmp_path):
    source = Path("lean/CSLIB/FMT/UnguardedFO/SyntaxSemantics.lean").read_text()
    lean_file = tmp_path / "CheckIsAtomicFormula.lean"
    lean_file.write_text(
        source
        + """

namespace CSLIB
namespace FMT
namespace UnguardedFO

theorem is_atomic_formula_eq_true
    {σ : RelLanguage} {n : Nat} (x y : Fin n) :
    IsAtomicFormula (Formula.eq (σ := σ) x y) = True := by
  rfl

theorem is_atomic_formula_rel_true
    {σ : RelLanguage} {n : Nat}
    (R : σ.Rel) (args : Fin (σ.arity R) → Fin n) :
    IsAtomicFormula (Formula.rel (σ := σ) R args) = True := by
  rfl

theorem is_atomic_formula_neg_false
    {σ : RelLanguage} {n : Nat} (φ : Formula σ n) :
    IsAtomicFormula (Formula.neg φ) = False := by
  rfl

theorem is_atomic_formula_conj_false
    {σ : RelLanguage} {n : Nat} (φ ψ : Formula σ n) :
    IsAtomicFormula (Formula.conj φ ψ) = False := by
  rfl

theorem is_atomic_formula_disj_false
    {σ : RelLanguage} {n : Nat} (φ ψ : Formula σ n) :
    IsAtomicFormula (Formula.disj φ ψ) = False := by
  rfl

theorem is_atomic_formula_ex_false
    {σ : RelLanguage} {n : Nat} (φ : Formula σ (n + 1)) :
    IsAtomicFormula (Formula.ex φ) = False := by
  rfl

end UnguardedFO
end FMT
end CSLIB
""",
        encoding="utf-8",
    )

    result = subprocess.run(
        ["lake", "env", "lean", str(lean_file)],
        text=True,
        capture_output=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr
