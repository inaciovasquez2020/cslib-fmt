# UNGUARDED_FO_SYNTAX_SEMANTICS_2026_06_20

## Status

The first general-FMT frontier layer is present: unguarded FO syntax and semantics.

## Source file

`lean/CSLIB/FMT/UnguardedFO/SyntaxSemantics.lean`

## Classification stratum

definition layer with basic verified simp lemmas

## Definitions

- `RelLanguage`
- `RelStructure`
- `Formula`
- `Sentence`
- `extendAssignment`
- `emptyAssignment`
- `Holds`
- `Satisfies`

## Verified lemmas

- `holds_top`
- `holds_bot`
- `holds_eq`
- `holds_conj`
- `holds_disj`
- `holds_ex`

## Next target

`Gaifman graph and distance for arbitrary finite structures`

## Nonclaims

- Does not claim general FMT closure.
- Does not claim Fagin theorem.
- Does not claim 0-1 Law.
- Does not claim full Gaifman locality.
- Does not claim unguarded FO locality.
- Does not claim external validation.

## Boundary locks

- `BOUNDARY := ¬ Fagin theorem`
- `BOUNDARY := ¬ 0-1 Law`
- `BOUNDARY := ¬ full Gaifman locality`
- `BOUNDARY := ¬ unguarded FO locality`
- `BOUNDARY := ¬ global finite-model-theory final theorem`
- `BOUNDARY := ¬ external validation claim`
