---
name: coding-conventions
description: Detect and follow a specific codebase's existing conventions (naming, formatting, file structure, error handling, import order, testing patterns, comment style) when writing or modifying code in it, instead of defaulting to generic "best practice" style. Use this whenever adding new code, new files, or new functions/classes to an existing codebase — especially when the user says "match the existing style", "follow our conventions", "do it the way we normally do it", or hasn't specified a style at all (in which case mirroring the codebase is the correct default, not inventing one). Also use when reviewing code for consistency with the rest of the project.
---

# Coding Conventions

A process for writing code that looks like it belongs in the codebase it's
being added to — instead of code that looks like generic textbook style,
or style from a different codebase/language convention entirely.

## Core principle

**Consistency with the existing codebase beats "best practice" in the
abstract**, as long as the existing convention isn't actively broken.
A codebase-wide convention that's merely a matter of taste (tabs vs.
spaces, where braces go, `snake_case` vs. `camelCase` for a given context)
should be followed even if a different choice is generally preferred
elsewhere — introducing a second style fragments the codebase and adds
friction for everyone who works in it after you.

## Workflow

### 1. Detect conventions before writing anything

Before adding new code, sample 3-5 existing files similar to what you're
about to write (same layer: e.g. other route handlers if writing a route
handler, other test files if writing tests) and note:

- **Naming**: casing conventions per identifier type (variables, functions,
  classes, constants, files, directories); prefixes/suffixes with meaning
  (`_private`, `IFoo`, `FooImpl`, `use*` hooks, `test_*` vs `*_test`)
- **File structure**: one class per file or grouped? Where do types/
  interfaces live relative to implementation? Barrel files/index re-exports
  or direct imports?
- **Import style**: ordering (stdlib/third-party/local), absolute vs.
  relative paths, named vs. default exports
- **Error handling**: exceptions vs. result/either types vs. error codes;
  where errors are caught vs. propagated; logging conventions around errors
- **Formatting**: check for a linter/formatter config file first
  (`.eslintrc`, `.prettierrc`, `pyproject.toml` / `ruff.toml`,
  `.editorconfig`, `rustfmt.toml`, etc.) — this is ground truth and
  overrides any inference from reading files, since files may predate
  the current config or not all be reformatted yet
- **Comment/doc style**: docstring format, whether comments explain *what*
  or *why*, header/license comment blocks, TODO conventions
- **Testing patterns**: test framework, file naming/location convention,
  arrange-act-assert vs. given-when-then structure, fixture/mock
  conventions, one assertion per test vs. grouped

### 2. Check for explicit project documentation

Look for `CONTRIBUTING.md`, `STYLE.md`, `AGENTS.md`, `CLAUDE.md`, or a
`docs/` style guide before inferring purely from reading code — explicit
documentation should take precedence over an inferred pattern, and may
explain *why* a convention exists (helpful for edge cases the sampled
files didn't cover).

### 3. Mirror, don't improve, unless asked

Write new code following the detected convention even where it differs
from what you'd choose by default. If you genuinely believe the existing
convention is a mistake (e.g. it's inconsistent with itself, or actively
causes bugs), say so explicitly and ask, rather than silently "fixing" the
style in new code — a mixed-convention codebase is worse than a
consistently-suboptimal one, and the person may have context you don't.

### 4. Handle inconsistency in the existing codebase

Real codebases are often inconsistent (multiple past authors, migrations
in progress, mixed old/new patterns). When you find conflicting
conventions:
1. Prefer whatever the *more recent* code does (check version control
   history/dates if unclear) — it's more likely to reflect current intent
2. Prefer whatever the linter/formatter config would enforce, if any
3. Prefer the convention used in the specific subdirectory/module you're
   editing over a different convention used elsewhere in the repo
4. If still ambiguous and it matters, ask rather than picking arbitrarily

### 5. Verify before finishing

- Run the project's linter/formatter if one is configured, rather than
  eyeballing style compliance
- Check that new file names, in particular, match the existing pattern —
  this is an easy one to get wrong since there's no line-level linting for
  file naming
- If tests exist for similar code, check that new tests follow the same
  structural pattern (not just "tests exist")

## Anti-patterns to avoid

- Applying your default style preferences to a codebase that has a
  different established convention, because the default "feels more
  correct" in isolation
- Inferring convention from a single file, which might itself be an
  outlier
- Trusting comments/docs about conventions without spot-checking against
  actual current code (docs rot faster than code)
- Treating formatting-only differences (that a formatter would
  auto-fix) as meaningful signal, when the config file is the actual
  source of truth
- Silently mixing two conventions within the same new file/module
