1. Keep feat/cslib-fmt build-green at every commit.
2. Isolate scaffold, specification, and semantic-realization work into separate branches.
3. Never push a branch after a failed lake build.
4. Add downstream repair commits before opening the PR that changes an upstream definition.
5. Quote every shell PR body containing backticks or :=.
6. Replace True-stubs only when the corresponding tests are already prepared.
7. Add one counterexample test immediately after each de-trivialization step.
8. Prefer minimal existential witnesses before introducing semantic axioms.
9. Tag only green checkpoints.
10. Switch repositories before searching for foreign namespaces.
