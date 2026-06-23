# Bounded Recursive Theorem Family Closure

STATUS := WEAKEST_ADMISSIBLE_REPLACEMENT_ONLY

INTERPRETATION := bounded_recursive_theorem_family_closure is the weakest admissible replacement for unrestricted theorem closure. It applies only to an explicitly named finite or recursively enumerated theorem family with bounded membership, bounded closure criteria, and verifier-checkable status for each member.

SCOPE := bounded recursive theorem family only

REPLACES_REJECTED_TARGET := unrestricted_theorem_closure

POSITIVE_CRITERION := a bounded recursive theorem family may be counted as closed only when the family membership rule is explicit, the bounded stopping condition is explicit, and every admitted family member has either a proof-bearing artifact, a verifier-accepted closed status, or an explicitly recorded missing object that prevents promotion beyond the bounded family.

FORBIDDEN_PROMOTION := bounded_recursive_theorem_family_closure does not imply unrestricted theorem closure.

UNRESTRICTED_THEOREM_CLOSURE_PERCENT := 0%

BOUNDARY := ¬ unrestricted_theorem_closure
