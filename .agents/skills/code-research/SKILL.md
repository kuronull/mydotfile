---
name: code-research
description: Systematically explore and understand an unfamiliar codebase, trace how a feature or bug flows through the system, or find every place something is used, before proposing or making changes. Use this whenever the user asks "how does X work", "where is X used/defined/called", "trace this bug/request/data flow", "understand this codebase/module before I touch it", or before any non-trivial refactor, bug fix, or feature addition in code you haven't already mapped out in this session. Push toward using this even for seemingly small changes in unfamiliar code — a two-line fix in the wrong place is worse than five minutes of research.
---

# Code Research

A repeatable process for building an accurate mental model of code before
reasoning about it or changing it — instead of guessing from file names,
skimming one file, or pattern-matching to what similar code "usually" looks
like in other codebases.

## Core principle

**Ground every claim in something you actually read.** If you're about to
say "this function does X" or "this is called from Y", you should have
either read the code or explicitly flagged it as an assumption. Guessing
based on naming conventions or general experience is the single biggest
source of wrong answers in code research — file/function names lie or go
stale more often than people expect.

## Workflow

### 1. Pin down the actual question

Before searching, write down (even just mentally) what you're trying to
answer. Vague versions of the same request lead to wasted searching:

- Bad framing: "understand the auth module"
- Good framing: "what happens between a login POST request arriving and a
  session token being issued — which functions, in what order, and where
  are the trust boundaries?"

If the user's request is broad ("understand this codebase"), narrow it by
asking what they're about to do with the understanding (fix a bug, add a
feature, review for security, onboard) — that determines what actually
matters to trace.

### 2. Find entry points, don't start in the middle

Locate where the relevant behavior begins from the outside:
- HTTP routes / controllers / CLI command definitions / message queue
  consumers / cron/scheduled job definitions / event handlers
- Search for route tables, `@app.route`, `router.`, `Controller`, `handle`,
  `main()`, config files that wire things together

Starting from an entry point and reading forward is far more reliable than
starting from a function you found via grep and guessing at its callers.

### 3. Widen, then narrow

- **Widen first**: grep/glob broadly for the concept (multiple synonyms —
  "auth", "session", "token", "login" might all be relevant). Look at
  directory structure and naming conventions to find where this concern
  lives.
- **Narrow deliberately**: once you've found the 2-4 files that actually
  matter, read them in full rather than skimming fragments. Partial reads
  of the "obviously relevant" 20 lines miss the early-return three lines
  above that changes everything.

### 4. Trace the call graph in the direction that matters

- Tracing forward ("what does this do next?") — follow function calls
  downward from the entry point.
- Tracing backward ("who calls this, and with what?") — grep for the
  function/class name, check every call site, and note differences in how
  it's invoked (different args, different error handling expectations).

For anything more than 2-3 hops, keep a running note of the chain
(`fileA:funcX -> fileB:funcY -> fileC:funcZ`) so you don't lose the thread
and can cite it back to the user.

### 5. Check tests and fixtures

Tests are often the most reliable documentation of *intended* behavior,
especially for edge cases. Before concluding "this function does X",
check whether tests exist that pin down its actual contract — real
behavior sometimes diverges from what the implementation "looks like" it
does at a glance (off-by-ones, silently swallowed errors, etc.).

### 6. Check for the boring but load-bearing stuff

Things that silently change behavior and are easy to miss on a first pass:
- Middleware / decorators / interceptors wrapping the code you're reading
- Config flags and environment-based branching
- Base classes / mixins that inject behavior
- Generated code (check for `.generated.`, codegen comments, or build
  scripts before assuming hand-written logic)

### 7. Summarize with receipts

When reporting findings back:
- Cite `path/to/file.ext:line` for concrete claims, not just file names
- Distinguish clearly between "I confirmed this by reading X" and "I'm
  inferring this because Y, but haven't verified it directly"
- Surface open questions rather than papering over gaps with a plausible
  guess — a flagged unknown is more useful than false confidence
- If the codebase does something surprising or inconsistent with its own
  conventions, call that out explicitly rather than smoothing it over

## When investigating a bug specifically

Add these steps:
1. Reproduce the reported symptom's *exact* trigger conditions before
   theorizing about cause — precision here saves a lot of wrong turns.
2. Work backward from where the wrong behavior is observed (error message,
   wrong output, log line) rather than forward from where you assume the
   bug lives.
3. Check version control history / blame on the suspect region — a recent
   change is a strong prior; "this has worked for years" code is a weak
   suspect unless something around it changed.
4. Before proposing a fix, confirm you can explain *why* the current code
   produces the wrong behavior — not just that a different version of the
   code would probably work.

## Anti-patterns to avoid

- Reading a function name and describing what it "should" do instead of
  what it does
- Stopping at the first plausible-looking call site instead of checking
  all of them
- Treating comments/docstrings as ground truth without spot-checking
  against the actual code (comments rot)
- Silently expanding scope — if research reveals the user's real question
  is different from what they asked, say so rather than quietly answering
  a different question
