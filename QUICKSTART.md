# CSLIB FMT Quickstart

This is the shortest path from clone to a first successful local verification pass.

## Requirements

- `git`
- `bash`
- `python3`
- Lean 4 with `lake`

## 1. Clone

```bash
git clone https://github.com/inaciovasquez2020/cslib-fmt.git
cd cslib-fmt
```

## 2. Check tools

```bash
python3 --version
git --version
lake --version
lean --version
```

## 3. Build

```bash
lake build
```

## 4. Run tests

```bash
python3 -m pytest -q
```

## 5. Start here

- `docs/onboarding/START_HERE.md`
- `docs/SETUP_GUIDE.md`
- `README.md`
- `STATUS.md`

## 6. Public API entrypoints

- `FMT.Graph`
- `FMT.Logic`
- `FMT.Game`
- `FMT.Types`
- `FMT.Invariants`
