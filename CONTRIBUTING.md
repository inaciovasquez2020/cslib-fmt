
# Contributing

## Build

```zsh
lake build
```

## Contribution rules

1. One structural change per patch.
2. Rebuild immediately after each change.
3. Do not stack unrelated fixes.
4. Preserve Closed / Conditional / Open labeling.
5. New public exports require a note in `docs/status/STATUS.md`.

## Good first tasks

* documentation synchronization
* example hardening
* import cleanup
* theorem dependency cleanup
* issue reproduction minimization

## Pull request checklist

* [ ] `lake build` passes
* [ ] public status labels updated
* [ ] new exported names documented
* [ ] no unnecessary placeholder introduced
* [ ] one-sentence mathematical summary added in changed file header if needed
  EOF

## cd ~/github-audit/cslib-fmt && cat > .github/ISSUE_TEMPLATE/bug_report.md <<'EOF'

name: Bug report
about: Report a build, import, theorem, or documentation defect
title: "[BUG] "
labels: bug
assignees: ''
-------------

## Component

* Graph
* Logic
* Game
* Types
* Invariants
* Docs
* CI

## Expected behavior

## Actual behavior

## Reproduction

## Proposed micro-fix

