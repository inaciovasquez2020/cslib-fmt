# TIFF Law (Total Imbalance Failure Formula)

## Definition
For a system S with demand D(t) and capacity C(S,t):

E_t = max(0, D(t) - C(S,t))

TIFF(S) = sum_t E_t

## Core Law
Failure(S) > 0  ⇔  ∃ t : D(t) > C(S,t)

Failure(S) = 0  ⇔  ∀ t : D(t) ≤ C(S,t)

TIFF(S) = 0     ⇔  Failure(S) = 0

TIFF(S) > 0     ⇔  Failure(S) > 0

## Bounds
max_t (D(t)-C(S,t))_+ ≤ TIFF(S) ≤ sum_t D(t)

## Interpretation
Total failure equals total unmet demand.

## Condition
Valid for systems with no hidden/global capacity channels.
