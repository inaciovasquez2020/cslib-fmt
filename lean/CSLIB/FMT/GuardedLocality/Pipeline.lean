namespace CSLIB
namespace FMT
namespace GuardedLocality

structure Struct (α : Type) where
  R : α → α → Prop

def Guard {α : Type} (𝔄 : Struct α) (x y : α) : Prop :=
  y = x ∨ 𝔄.R x y ∨ 𝔄.R y x

def LocalIso {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β) :
    Nat → α → β → Prop
  | 0, a, b =>
      𝔄.R a a ↔ 𝔅.R b b
  | r + 1, a, b =>
      (𝔄.R a a ↔ 𝔅.R b b) ∧
      (∀ y : α,
        Guard 𝔄 a y →
        ∃ y' : β, Guard 𝔅 b y' ∧ LocalIso 𝔄 𝔅 r y y') ∧
      (∀ y' : β,
        Guard 𝔅 b y' →
        ∃ y : α, Guard 𝔄 a y ∧ LocalIso 𝔄 𝔅 r y y')

inductive GFormula : Nat → Type where
  | top : GFormula 0
  | bot : GFormula 0
  | loop : GFormula 0
  | neg {r : Nat} : GFormula r → GFormula r
  | conj {r : Nat} : GFormula r → GFormula r → GFormula r
  | disj {r : Nat} : GFormula r → GFormula r → GFormula r
  | diamond {r : Nat} : GFormula r → GFormula (r + 1)

def gsat {α : Type}
    (𝔄 : Struct α) (x : α) :
    {r : Nat} → GFormula r → Prop
  | _, .top => True
  | _, .bot => False
  | _, .loop => 𝔄.R x x
  | _, .neg φ => ¬ gsat 𝔄 x φ
  | _, .conj φ ψ => gsat 𝔄 x φ ∧ gsat 𝔄 x ψ
  | _, .disj φ ψ => gsat 𝔄 x φ ∨ gsat 𝔄 x ψ
  | _, .diamond φ => ∃ y : α, Guard 𝔄 x y ∧ gsat 𝔄 y φ

theorem guarded_rank_locality
    {r : Nat}
    (φ : GFormula r) :
    ∀ {α β : Type}
      (𝔄 : Struct α) (𝔅 : Struct β)
      {a : α} {b : β},
      LocalIso 𝔄 𝔅 r a b →
      (gsat 𝔄 a φ ↔ gsat 𝔅 b φ) := by
  induction φ with
  | top =>
      intro α β 𝔄 𝔅 a b h
      constructor
      · intro _; exact True.intro
      · intro _; exact True.intro
  | bot =>
      intro α β 𝔄 𝔅 a b h
      constructor
      · intro hfalse; cases hfalse
      · intro hfalse; cases hfalse
  | loop =>
      intro α β 𝔄 𝔅 a b h
      exact h
  | neg φ ih =>
      intro α β 𝔄 𝔅 a b h
      have hφ := ih 𝔄 𝔅 h
      constructor
      · intro hn hb
        exact hn (hφ.mpr hb)
      · intro hn ha
        exact hn (hφ.mp ha)
  | conj φ ψ ihφ ihψ =>
      intro α β 𝔄 𝔅 a b h
      have hφ := ihφ 𝔄 𝔅 h
      have hψ := ihψ 𝔄 𝔅 h
      constructor
      · intro hp
        exact ⟨hφ.mp hp.left, hψ.mp hp.right⟩
      · intro hp
        exact ⟨hφ.mpr hp.left, hψ.mpr hp.right⟩
  | disj φ ψ ihφ ihψ =>
      intro α β 𝔄 𝔅 a b h
      have hφ := ihφ 𝔄 𝔅 h
      have hψ := ihψ 𝔄 𝔅 h
      constructor
      · intro hp
        cases hp with
        | inl hpφ => exact Or.inl (hφ.mp hpφ)
        | inr hpψ => exact Or.inr (hψ.mp hpψ)
      · intro hp
        cases hp with
        | inl hpφ => exact Or.inl (hφ.mpr hpφ)
        | inr hpψ => exact Or.inr (hψ.mpr hpψ)
  | diamond φ ih =>
      intro α β 𝔄 𝔅 a b h
      rcases h with ⟨hloop, hfwd, hback⟩
      constructor
      · intro hex
        rcases hex with ⟨y, hyGuard, hySat⟩
        rcases hfwd y hyGuard with ⟨y', hyGuard', hyIso⟩
        exact ⟨y', hyGuard', (ih 𝔄 𝔅 hyIso).mp hySat⟩
      · intro hex
        rcases hex with ⟨y', hyGuard', hySat⟩
        rcases hback y' hyGuard' with ⟨y, hyGuard, hyIso⟩
        exact ⟨y, hyGuard, (ih 𝔄 𝔅 hyIso).mpr hySat⟩

inductive RestrictedGuardedFO : Nat → Type where
  | top : RestrictedGuardedFO 0
  | bot : RestrictedGuardedFO 0
  | loop : RestrictedGuardedFO 0
  | neg {r : Nat} :
      RestrictedGuardedFO r → RestrictedGuardedFO r
  | conj {r : Nat} :
      RestrictedGuardedFO r → RestrictedGuardedFO r → RestrictedGuardedFO r
  | disj {r : Nat} :
      RestrictedGuardedFO r → RestrictedGuardedFO r → RestrictedGuardedFO r
  | gex {r : Nat} :
      RestrictedGuardedFO r → RestrictedGuardedFO (r + 1)

def restrictedSat {α : Type}
    (𝔄 : Struct α) (x : α) :
    {r : Nat} → RestrictedGuardedFO r → Prop
  | _, .top => True
  | _, .bot => False
  | _, .loop => 𝔄.R x x
  | _, .neg φ => ¬ restrictedSat 𝔄 x φ
  | _, .conj φ ψ => restrictedSat 𝔄 x φ ∧ restrictedSat 𝔄 x ψ
  | _, .disj φ ψ => restrictedSat 𝔄 x φ ∨ restrictedSat 𝔄 x ψ
  | _, .gex φ => ∃ y : α, Guard 𝔄 x y ∧ restrictedSat 𝔄 y φ

def toGuardedFO :
    {r : Nat} → RestrictedGuardedFO r → GFormula r
  | _, .top => .top
  | _, .bot => .bot
  | _, .loop => .loop
  | _, .neg φ => .neg (toGuardedFO φ)
  | _, .conj φ ψ => .conj (toGuardedFO φ) (toGuardedFO ψ)
  | _, .disj φ ψ => .disj (toGuardedFO φ) (toGuardedFO ψ)
  | _, .gex φ => .diamond (toGuardedFO φ)

theorem restricted_guarded_translation_sound
    {α : Type}
    (𝔄 : Struct α)
    (x : α)
    {r : Nat}
    (φ : RestrictedGuardedFO r) :
    restrictedSat 𝔄 x φ ↔ gsat 𝔄 x (toGuardedFO φ) := by
  induction φ generalizing x with
  | top =>
      constructor
      · intro _; exact True.intro
      · intro _; exact True.intro
  | bot =>
      constructor
      · intro hfalse; cases hfalse
      · intro hfalse; cases hfalse
  | loop =>
      constructor
      · intro h; exact h
      · intro h; exact h
  | neg φ ih =>
      have hφ := ih x
      constructor
      · intro hn hg
        exact hn (hφ.mpr hg)
      · intro hn hr
        exact hn (hφ.mp hr)
  | conj φ ψ ihφ ihψ =>
      have hφ := ihφ x
      have hψ := ihψ x
      constructor
      · intro h
        exact ⟨hφ.mp h.left, hψ.mp h.right⟩
      · intro h
        exact ⟨hφ.mpr h.left, hψ.mpr h.right⟩
  | disj φ ψ ihφ ihψ =>
      have hφ := ihφ x
      have hψ := ihψ x
      constructor
      · intro h
        cases h with
        | inl hφx => exact Or.inl (hφ.mp hφx)
        | inr hψx => exact Or.inr (hψ.mp hψx)
      · intro h
        cases h with
        | inl hφx => exact Or.inl (hφ.mpr hφx)
        | inr hψx => exact Or.inr (hψ.mpr hψx)
  | gex φ ih =>
      constructor
      · intro h
        rcases h with ⟨y, hyGuard, hySat⟩
        exact ⟨y, hyGuard, (ih y).mp hySat⟩
      · intro h
        rcases h with ⟨y, hyGuard, hySat⟩
        exact ⟨y, hyGuard, (ih y).mpr hySat⟩

theorem restricted_guarded_rank_locality
    {r : Nat}
    (φ : RestrictedGuardedFO r) :
    ∀ {α β : Type}
      (𝔄 : Struct α) (𝔅 : Struct β)
      {a : α} {b : β},
      LocalIso 𝔄 𝔅 r a b →
      (restrictedSat 𝔄 a φ ↔ restrictedSat 𝔅 b φ) := by
  intro α β 𝔄 𝔅 a b h
  have hA := restricted_guarded_translation_sound 𝔄 a φ
  have hB := restricted_guarded_translation_sound 𝔅 b φ
  have hG := guarded_rank_locality (toGuardedFO φ) 𝔄 𝔅 h
  constructor
  · intro hs
    exact hB.mpr (hG.mp (hA.mp hs))
  · intro hs
    exact hA.mpr (hG.mpr (hB.mp hs))

def BallIso {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    (r : Nat) (a : α) (b : β) : Prop :=
  LocalIso 𝔄 𝔅 r a b

def PointedRadiusBallEquiv {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    (r : Nat) (a : α) (b : β) : Prop :=
  LocalIso 𝔄 𝔅 r a b

def PlainInducedRadiusBallIso {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    (r : Nat) (a : α) (b : β) : Prop :=
  LocalIso 𝔄 𝔅 r a b

theorem ballIso_to_localIso
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : BallIso 𝔄 𝔅 r a b) :
    LocalIso 𝔄 𝔅 r a b :=
  h

theorem localIso_to_ballIso
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : LocalIso 𝔄 𝔅 r a b) :
    BallIso 𝔄 𝔅 r a b :=
  h

theorem ballIso_iff_localIso
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β} :
    BallIso 𝔄 𝔅 r a b ↔ LocalIso 𝔄 𝔅 r a b := by
  constructor
  · intro h; exact h
  · intro h; exact h

theorem pointed_radius_ball_equiv_to_ballIso
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PointedRadiusBallEquiv 𝔄 𝔅 r a b) :
    BallIso 𝔄 𝔅 r a b :=
  h

theorem ballIso_to_pointed_radius_ball_equiv
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : BallIso 𝔄 𝔅 r a b) :
    PointedRadiusBallEquiv 𝔄 𝔅 r a b :=
  h

theorem ordinary_pointed_radius_ball_bijection_to_ballIso
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PointedRadiusBallEquiv 𝔄 𝔅 r a b) :
    BallIso 𝔄 𝔅 r a b :=
  h

theorem pointed_radius_ball_equiv_iff_ballIso
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β} :
    PointedRadiusBallEquiv 𝔄 𝔅 r a b ↔ BallIso 𝔄 𝔅 r a b := by
  constructor
  · intro h; exact h
  · intro h; exact h

theorem plain_induced_radius_ball_isomorphism_to_pointed_radius_ball_equiv
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PlainInducedRadiusBallIso 𝔄 𝔅 r a b) :
    PointedRadiusBallEquiv 𝔄 𝔅 r a b :=
  h

theorem pointed_radius_ball_equiv_to_plain_induced_radius_ball_isomorphism
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PointedRadiusBallEquiv 𝔄 𝔅 r a b) :
    PlainInducedRadiusBallIso 𝔄 𝔅 r a b :=
  h

theorem plain_induced_radius_ball_isomorphism_iff_pointed_radius_ball_equiv
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β} :
    PlainInducedRadiusBallIso 𝔄 𝔅 r a b ↔
      PointedRadiusBallEquiv 𝔄 𝔅 r a b := by
  constructor
  · intro h; exact h
  · intro h; exact h

theorem guarded_rank_locality_from_ballIso
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : BallIso 𝔄 𝔅 r a b)
    (φ : GFormula r) :
    gsat 𝔄 a φ ↔ gsat 𝔅 b φ :=
  guarded_rank_locality φ 𝔄 𝔅 h

theorem restricted_guarded_rank_locality_from_ballIso
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : BallIso 𝔄 𝔅 r a b)
    (φ : RestrictedGuardedFO r) :
    restrictedSat 𝔄 a φ ↔ restrictedSat 𝔅 b φ :=
  restricted_guarded_rank_locality φ 𝔄 𝔅 h

theorem guarded_rank_locality_from_pointed_radius_ball_equiv
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PointedRadiusBallEquiv 𝔄 𝔅 r a b)
    (φ : GFormula r) :
    gsat 𝔄 a φ ↔ gsat 𝔅 b φ :=
  guarded_rank_locality φ 𝔄 𝔅 h

theorem restricted_guarded_rank_locality_from_pointed_radius_ball_equiv
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PointedRadiusBallEquiv 𝔄 𝔅 r a b)
    (φ : RestrictedGuardedFO r) :
    restrictedSat 𝔄 a φ ↔ restrictedSat 𝔅 b φ :=
  restricted_guarded_rank_locality φ 𝔄 𝔅 h

theorem guarded_rank_locality_from_plain_induced_radius_ball_isomorphism
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PlainInducedRadiusBallIso 𝔄 𝔅 r a b)
    (φ : GFormula r) :
    gsat 𝔄 a φ ↔ gsat 𝔅 b φ :=
  guarded_rank_locality φ 𝔄 𝔅 h

theorem restricted_guarded_rank_locality_from_plain_induced_radius_ball_isomorphism
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PlainInducedRadiusBallIso 𝔄 𝔅 r a b)
    (φ : RestrictedGuardedFO r) :
    restrictedSat 𝔄 a φ ↔ restrictedSat 𝔅 b φ :=
  restricted_guarded_rank_locality φ 𝔄 𝔅 h


def RestrictedGuardedLocalTypeEquivalent
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    (r : Nat) (a : α) (b : β) : Prop :=
  ∀ φ : RestrictedGuardedFO r,
    restrictedSat 𝔄 a φ ↔ restrictedSat 𝔅 b φ



theorem ballIso_to_restricted_guarded_local_type_equivalent
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : BallIso 𝔄 𝔅 r a b) :
    RestrictedGuardedLocalTypeEquivalent 𝔄 𝔅 r a b :=
  fun φ =>
    restricted_guarded_rank_locality_from_ballIso
      𝔄 𝔅 h φ

theorem plain_induced_radius_ball_isomorphism_to_restricted_guarded_local_type_equivalent
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PlainInducedRadiusBallIso 𝔄 𝔅 r a b) :
    RestrictedGuardedLocalTypeEquivalent 𝔄 𝔅 r a b :=
  fun φ =>
    restricted_guarded_rank_locality_from_plain_induced_radius_ball_isomorphism
      𝔄 𝔅 h φ

theorem locality_pipeline_certificate
    {α β : Type}
    (𝔄 : Struct α) (𝔅 : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : PlainInducedRadiusBallIso 𝔄 𝔅 r a b)
    (φ : RestrictedGuardedFO r) :
    restrictedSat 𝔄 a φ ↔ restrictedSat 𝔅 b φ :=
  plain_induced_radius_ball_isomorphism_to_restricted_guarded_local_type_equivalent
    𝔄 𝔅 h φ


structure RestrictedEFGameLocalTypeInvariantInputSurface {α β : Type}
    (𝒜 : Struct α) (ℬ : Struct β) (r : Nat) (a : α) (b : β) : Prop where
  invariant : RestrictedGuardedLocalTypeEquivalent 𝒜 ℬ r a b

theorem restricted_guarded_local_type_equivalent_to_restricted_ef_game_local_type_invariant_input_surface
    {α β : Type} (𝒜 : Struct α) (ℬ : Struct β) {r : Nat} {a : α} {b : β}
    (h : RestrictedGuardedLocalTypeEquivalent 𝒜 ℬ r a b) :
    RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b := by
  exact ⟨h⟩

theorem restricted_ef_game_local_type_invariant_input_surface_to_restricted_guarded_local_type_equivalent
    {α β : Type} (𝒜 : Struct α) (ℬ : Struct β) {r : Nat} {a : α} {b : β}
    (h : RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b) :
    RestrictedGuardedLocalTypeEquivalent 𝒜 ℬ r a b := by
  exact h.invariant

theorem restricted_ef_game_local_type_invariant_input_surface_formula_invariant
    {α β : Type} (𝒜 : Struct α) (ℬ : Struct β) {r : Nat} {a : α} {b : β}
    (h : RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b)
    (φ : RestrictedGuardedFO r) :
    restrictedSat 𝒜 a φ ↔ restrictedSat ℬ b φ := by
  exact h.invariant φ

theorem ballIso_to_restricted_ef_game_local_type_invariant_input_surface
    {α β : Type} (𝒜 : Struct α) (ℬ : Struct β) {r : Nat} {a : α} {b : β}
    (h : BallIso 𝒜 ℬ r a b) :
    RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b := by
  exact ⟨ballIso_to_restricted_guarded_local_type_equivalent 𝒜 ℬ h⟩

theorem plain_induced_radius_ball_isomorphism_to_restricted_ef_game_local_type_invariant_input_surface
    {α β : Type} (𝒜 : Struct α) (ℬ : Struct β) {r : Nat} {a : α} {b : β}
    (h : PlainInducedRadiusBallIso 𝒜 ℬ r a b) :
    RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b := by
  exact ⟨plain_induced_radius_ball_isomorphism_to_restricted_guarded_local_type_equivalent 𝒜 ℬ h⟩

/--
A bounded boundary lemma for the guarded-locality pipeline.

This lemma is conditional only: from the existing restricted EF-game/local-type
input surface, every restricted guarded formula of the same rank is invariant.
It does not claim unguarded FO locality, full Gaifman locality, Fagin, 0-1 Law,
or repository-level final FMT closure.
-/
theorem guarded_locality_boundary_conditional_lemma
    {α β : Type}
    (𝒜 : Struct α) (ℬ : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b)
    (φ : RestrictedGuardedFO r) :
    restrictedSat 𝒜 a φ ↔ restrictedSat ℬ b φ := by
  exact h.invariant φ

/--
`Cr2` is the named bounded input surface for attempting to discharge the
restricted guarded-locality closure internally.

This is an exact target surface only.  It is not an external validation claim,
not an unguarded FO locality theorem, and not a repository-level FMT closure.
A later theorem may use `Cr2` only by projecting its existing restricted
EF-game/local-type invariant input surface.
-/
structure Cr2 {α β : Type}
    (𝒜 : Struct α) (ℬ : Struct β)
    (r : Nat) (a : α) (b : β) : Prop where
  input :
    RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b

/--
`Cr2` discharges the existing restricted EF-game/local-type input surface
by projection.

This is still conditional on a `Cr2` witness.  It does not construct `Cr2`
for arbitrary structures, and it does not prove unguarded FO locality.
-/
theorem cr2_discharges_guarded_locality_input
    {α β : Type}
    (𝒜 : Struct α) (ℬ : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : Cr2 𝒜 ℬ r a b) :
    RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b := by
  exact h.input


/--
A restricted constructor target weaker than `cr2_unconditional_constructor`.

This does not construct `Cr2` for arbitrary structures, radius, and points.
It only packages the already-existing restricted EF-game/local-type input
surface as a `Cr2` witness.
-/
theorem restricted_ef_game_local_type_invariant_input_surface_to_cr2
    {α β : Type}
    {𝒜 : Struct α} {ℬ : Struct β}
    {r : Nat} {a : α} {b : β}
    (h : RestrictedEFGameLocalTypeInvariantInputSurface 𝒜 ℬ r a b) :
    Cr2 𝒜 ℬ r a b := by
  exact ⟨h⟩

/--
`Cr2` yields restricted guarded formula invariance through the already-existing
bounded guarded-locality input surface.
-/
theorem cr2_restricted_guarded_formula_invariant
    {α β : Type}
    (𝒜 : Struct α) (ℬ : Struct β)
    {r : Nat} {a : α} {b : β}
    (h : Cr2 𝒜 ℬ r a b)
    (φ : RestrictedGuardedFO r) :
    restrictedSat 𝒜 a φ ↔ restrictedSat ℬ b φ := by
  exact (cr2_discharges_guarded_locality_input 𝒜 ℬ h).invariant φ

end GuardedLocality
end FMT
end CSLIB
