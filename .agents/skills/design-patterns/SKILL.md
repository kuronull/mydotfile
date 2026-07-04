---
name: design-patterns
description: Decide whether a classic design pattern (creational, structural, behavioral, concurrency, or architectural) genuinely fits a problem, pick the right one, and implement it idiomatically for the target language — while actively guarding against over-engineering. Use whenever the user asks "what pattern fits X", "how should I structure/refactor this class hierarchy", "is there a pattern for Y", mentions a pattern by name (Factory, Observer, Strategy, Decorator, Singleton, etc.) and wants it applied or reviewed, or is designing an abstraction layer and the shape of the problem suggests a known pattern would help. See references/catalog.md for the full pattern catalog with intent, structure, and idiomatic-language notes.
---

# Design Patterns

A decision process for applying design patterns where they earn their
complexity — instead of either avoiding structure that would genuinely
help, or reaching for named patterns as ceremony where a plain function
would do.

## Core principle

**A pattern is justified by the problem's actual variability, not by
familiarity or resume value.** Every pattern trades simplicity now for
flexibility along some specific axis of future change. If that axis of
change isn't real (or not likely enough to matter), the pattern is net
negative — more indirection, more files, more cognitive load, for
flexibility nobody needs.

## Workflow

### 1. Name the actual force at play

Before reaching for a pattern, identify what's actually varying or likely
to vary:
- Which concrete type/algorithm is used at runtime? → creational or
  strategy-family pattern
- How objects are composed/extended without modifying them? → structural
  pattern
- How objects communicate or how a sequence of steps is organized? →
  behavioral pattern
- Multiple things need to happen in response to one event, decoupled? →
  observer/pub-sub
- How concurrent access to shared state is coordinated? → concurrency
  pattern

If you can't name a concrete axis of variation, that's a signal that a
plain, direct implementation is probably correct and no pattern is needed
yet — patterns solve variability you actually have, not variability you
might have.

### 2. Check whether the variability is real yet

A common failure mode is applying a flexible pattern for a single current
case "in case we need another one later." Prefer:
- Write the direct/concrete version first when there's currently exactly
  one implementation
- Introduce the pattern when a second concrete variant actually shows up,
  refactoring toward the pattern at that point (this is usually cheap if
  the code was reasonably well-factored to begin with)
- Exception: when the second case is *known* to be coming imminently and
  concretely (not hypothetically), it's reasonable to design for it now

### 3. Pick the specific pattern

See `references/catalog.md` for the full catalog. Quick disambiguation for
commonly-confused pairs:

- **Strategy vs. Template Method**: Strategy swaps a whole algorithm via
  composition (has-a); Template Method fixes the skeleton and lets
  subclasses override specific steps (is-a). Prefer Strategy in languages
  where composition is idiomatic (most modern code); Template Method fits
  when the steps genuinely share a lot of structure worth inheriting.
- **Factory Method vs. Abstract Factory**: Factory Method creates one
  product; Abstract Factory creates a *family* of related products that
  need to be used together consistently.
- **Decorator vs. Proxy**: Decorator adds behavior/responsibilities;
  Proxy controls access to the underlying object (lazy loading, access
  control, remote calls) while preserving its interface exactly.
- **Observer vs. Mediator**: Observer is one-to-many notification with no
  coordination logic; Mediator centralizes coordination logic between
  many objects that would otherwise reference each other directly.
- **Adapter vs. Facade**: Adapter makes one incompatible interface match
  another; Facade simplifies access to a complex subsystem behind a
  simpler unified interface, without necessarily changing any interface.

### 4. Implement idiomatically for the language

Classic GoF pattern descriptions assume class-based OOP with limited
language features (this was Java/C++ in the 1990s). Many patterns
simplify or disappear entirely in languages with first-class functions,
modules, or other modern features:
- Strategy/Command often reduce to passing a function/closure directly —
  no need for a single-method interface class if the language has
  first-class functions
- Singleton is often better served by a module-level instance (in
  languages with real modules) than a class with a static accessor and
  guarded instantiation
- Visitor is far less necessary in languages with pattern matching /
  sum types — a match expression often replaces the double-dispatch
  machinery entirely
- Iterator is usually built into the language already — implement the
  language's native iteration protocol rather than a custom `hasNext`/
  `next` interface

Check `references/catalog.md` for language-specific notes on which
patterns are natively subsumed by common language features.

### 5. Sanity-check the result

Before finalizing, verify:
- Does this actually reduce the change-cost for the variability identified
  in step 1? (If adding a new case still requires touching multiple
  existing files, the pattern isn't doing its job.)
- Could a reviewer unfamiliar with this specific code understand the
  pattern's intent from the naming and structure alone, or does it require
  tribal knowledge to see why the indirection exists?
- Is there now a class/file whose only job is to satisfy the pattern's
  shape, with no other reason to exist? That's a smell worth reconsidering.

## Anti-patterns to avoid

- Applying a pattern because it was recently learned/read about, not
  because the problem calls for it ("pattern of the week" over-engineering)
- Naming a class `XFactory` or `XStrategy` without an actual second
  implementation ever existing — speculative generality
- Using inheritance-heavy classic-GoF patterns in languages where
  composition or functions would be more idiomatic and less ceremonious
- Treating "uses design patterns" as a proxy for code quality — plain,
  direct code with no patterns is often the *correct* answer for problems
  without real variability
- Forcing a problem into the closest-named pattern instead of the pattern
  that actually fits its structure
