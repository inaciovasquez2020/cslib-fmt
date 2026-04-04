Theorem Status
Legend:
Closed: theorem-level proof present in repository.
Conditional: result depends on an explicitly named assumption/lemma.
Open: result not yet proved in repository.
Core graph layer
Item	Status	File	Note
PathLength basic structure	Closed	FMT/Graph/PathLength.lean	core path object
Path reversal	Closed	FMT/Graph/PathLengthReverse.lean	reversal infrastructure
Path concatenation	Closed	FMT/Graph/PathLengthConcat.lean	concatenation infrastructure
Distance existence baseline	Closed	FMT/Graph/Distance.lean	existence-level distance
Distance symmetry	Open	FMT/Graph/DistSymm.lean	theorem-level closure target
Distance triangle inequality	Open	FMT/Graph/DistTriangle.lean	theorem-level closure target
dist upper bound from path	Open	FMT/Graph/DistancePath.lean	constructive replacement target
Logic/game layer
Item	Status	File	Note
FO^k syntax scaffold	Conditional	FMT/Logic/FOkSyntax.lean	dependent on current syntax coverage
Locality radius interface	Conditional	FMT/Logic/LocalityRadius.lean	review pending
EF scaffold	Conditional	FMT/Game/EF.lean	public baseline pending hardening
Type/factorization layer
Item	Status	File	Note
Local type representation	Conditional	FMT/Types/LocalType.lean	interface hardening pending
FactorsThrough interface	Conditional	FMT/Types/Factorization.lean	semantic strengthening pending
WL-facing layer	Conditional	FMT/Types/WL.lean	review pending
Global invariant layer
Item	Status	File	Note
Cycle-space interface	Conditional	FMT/Invariants/CycleSpace.lean	reusable API extraction pending
Non-factorization/separation interface	Open	FMT/Invariants/NonFactorization.lean	research-facing frontier
Release rule
A release is maturity-valid only if every exported item is labeled Closed, Conditional, or Open.
