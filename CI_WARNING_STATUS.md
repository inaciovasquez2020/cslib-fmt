# CI warning status

- main commit: 999813c
- workflow file: .github/workflows/lean.yml
- repo-local fix applied: actions/checkout@v5 + FORCE_JAVASCRIPT_ACTIONS_TO_NODE24=true
- remaining warning source: leanprover/lean-action@v1 transitively invokes actions/cache/restore@v4 and actions/cache/save@v4
- status: build succeeds; warning is upstream/transitive, not from current repo-local checkout step
