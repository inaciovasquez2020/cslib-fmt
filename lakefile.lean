import Lake
open Lake DSL

package «FMT» where

require urf_core from git
  "https://github.com/inaciovasquez2020/urf-core.git" @
  "422294157daa95a8e7d95a0ce79caf5492821a9c"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @
  "0c154d67103f74be3a0f2c509f72ccbf5be9f2a7"

@[default_target]
lean_lib FMT
lean_lib CslibFmt where

lean_lib CSLIB where
  srcDir := "lean"
