# Pattern Catalog

Organized by category. For each: intent, when it fits, and notes on modern/
idiomatic implementation. This is reference material — read the relevant
section, not the whole file, once SKILL.md has narrowed down the category.

## Creational

Concerned with *how objects get created*, decoupling client code from
concrete classes being instantiated.

- **Factory Method** — Defer instantiation of a single product to a
  subclass/overridable method. Fits when a class can't anticipate which
  concrete type it needs until runtime. Often just a function returning
  different concrete instances based on input in languages without
  mandatory classes.
- **Abstract Factory** — Create families of related objects that must be
  used together (e.g. a UI toolkit's Button/Checkbox/Menu all matching one
  theme). Only worth it when "family consistency" is a real constraint —
  otherwise it's Factory Method with extra ceremony.
- **Builder** — Construct a complex object step-by-step, separating
  construction from representation. Fits objects with many optional
  parameters/configuration steps or that must be validated incrementally.
  In languages with named/keyword arguments or optional-field structs,
  this is frequently unnecessary — check that first.
- **Singleton** — Ensure exactly one instance, globally accessible.
  Genuinely useful for things that must be process-global by nature
  (a single connection pool, a single hardware resource handle) — but
  widely overused as a workaround for not passing dependencies explicitly.
  Prefer dependency injection or a module-level instance over a
  class-based Singleton in most modern code; the classic
  double-checked-locking Singleton is largely a historical artifact of
  languages without simpler module systems.
- **Prototype** — Create new objects by cloning an existing instance
  rather than instantiating from a class. Fits when construction is
  expensive relative to copying, or when the set of "types" is really
  a set of configured instances rather than classes.

## Structural

Concerned with how objects/classes are *composed* into larger structures.

- **Adapter** — Convert one interface into another interface a client
  expects, without changing either side's behavior. Fits at integration
  boundaries (wrapping a third-party library or legacy interface to match
  an internal one).
- **Decorator** — Attach additional responsibilities to an object
  dynamically, as an alternative to subclassing for every combination of
  behaviors. Fits when behaviors need to compose (e.g. stacking
  logging + caching + retry around a base operation).
- **Facade** — Provide a simplified, unified interface to a complex
  subsystem. Fits when client code shouldn't need to know a subsystem's
  internal structure. Doesn't hide capability, just simplifies the common
  path.
- **Composite** — Treat individual objects and compositions of objects
  uniformly through a shared interface (classic case: filesystem
  files/directories, UI widget trees). Fits genuinely recursive/tree-shaped
  domains.
- **Proxy** — Provide a stand-in that controls access to another object:
  lazy initialization, access control, caching, or remote-call marshaling,
  while preserving the original's interface exactly. Distinct from
  Decorator in intent (access control vs. behavior addition), even though
  the structure looks similar.
- **Bridge** — Decouple an abstraction from its implementation so both can
  vary independently (e.g. shape hierarchy × rendering-API hierarchy,
  instead of a cross-product of subclasses). Fits when you'd otherwise get
  a combinatorial explosion of subclasses across two independent
  dimensions of variation.
- **Flyweight** — Share common state across many fine-grained objects to
  reduce memory footprint (e.g. character glyphs in a text editor, tile
  types in a game map). Fits large numbers of objects with substantial
  shared, immutable state. Rarely relevant outside performance-sensitive
  or very-large-scale-object scenarios.

## Behavioral

Concerned with how objects *communicate* and how responsibility is
distributed among them.

- **Strategy** — Encapsulate interchangeable algorithms behind a common
  interface, selected/injected at runtime. In languages with first-class
  functions, this is often just "pass a function" rather than a full
  interface + concrete classes.
- **Template Method** — Define an algorithm's skeleton in a base
  class/function, deferring specific steps to subclasses/callbacks. Fits
  when steps genuinely share structure worth factoring into a shared
  parent, not just superficially similar signatures.
- **Observer** — One-to-many dependency: when one object's state changes,
  dependents are notified automatically. Fits event systems, reactive UI,
  pub-sub within a process. At larger scale (cross-process), this becomes
  a message queue / event bus architectural choice rather than an in-code
  pattern.
- **Command** — Encapsulate a request (and its parameters) as an object,
  enabling queuing, undo/redo, logging of operations. Fits when operations
  themselves need to be treated as data (undo stacks, task queues,
  macro recording). Often reducible to a closure + a list, unless
  undo/serialization is actually needed.
- **Mediator** — Centralize communication logic between a set of objects
  that would otherwise reference each other directly (avoiding an N×N mesh
  of dependencies). Fits complex UI component coordination, chat-room-like
  interaction hubs.
- **Chain of Responsibility** — Pass a request along a chain of handlers
  until one handles it. Fits middleware pipelines, event bubbling,
  validation pipelines where handlers should be addable/removable/
  reorderable independently.
- **State** — Let an object alter its behavior when its internal state
  changes, by delegating to state-specific objects rather than branching
  on a state field everywhere. Fits state machines with real behavioral
  differences per state (not just a status label). In languages with
  algebraic/sum types, a match/switch on a sum type is often clearer than
  the classic State-object-hierarchy version.
- **Visitor** — Add new operations to a class hierarchy without modifying
  the classes, via double dispatch. Fits when operations change more
  often than the type hierarchy itself. Largely superseded by pattern
  matching over sum/union types in languages that support it.
- **Iterator** — Provide sequential access to elements of a collection
  without exposing its internal representation. Use the language's native
  iteration protocol (generators, `Iterable`, `IntoIterator`, etc.) instead
  of hand-rolling one, unless the language has no such native facility.
- **Memento** — Capture and externalize an object's internal state so it
  can be restored later, without violating encapsulation. Fits undo
  systems and checkpointing where a plain serialized snapshot won't do
  because internal state shouldn't be exposed to the caller holding it.

## Concurrency

- **Producer-Consumer** — Decouple work generation from work processing
  via a shared queue, allowing independent scaling of each side and
  smoothing bursty load.
- **Read-Write Lock** — Allow concurrent reads but exclusive writes, when
  reads vastly outnumber writes and read-read contention would otherwise
  be needlessly serialized.
- **Future/Promise** — Represent the eventual result of an asynchronous
  operation as a first-class value that can be composed, awaited, or
  chained. Native in most modern languages/runtimes — rarely worth
  hand-rolling.
- **Actor Model** — Encapsulate state and behavior in isolated actors that
  communicate only via asynchronous messages, avoiding shared-mutable-state
  concurrency bugs entirely. Fits systems with lots of independent stateful
  entities (game entities, per-connection session state, simulation
  agents).

## Architectural (larger-scale)

- **Repository** — Abstract persistence behind a collection-like interface,
  decoupling business logic from the specific storage mechanism. Fits when
  storage needs to be swappable or mockable for tests; overkill for a
  small app directly bound to one database it'll never change.
- **Dependency Injection** — Supply a component's dependencies from
  outside rather than having it construct them internally, for
  testability and configurability. This is close to a default-good-practice
  rather than a situational pattern — the main judgment call is whether to
  use a DI framework/container or plain constructor/parameter injection
  (prefer the latter unless the object graph is genuinely large and
  container-managed lifecycle actually helps).
- **CQRS (Command Query Responsibility Segregation)** — Separate the
  read model from the write model when their scaling/consistency/shape
  requirements diverge significantly. Meaningful complexity cost — only
  justified when read and write patterns have genuinely diverged, not by
  default for typical CRUD.
- **Event Sourcing** — Persist state as a sequence of events rather than
  current state, deriving current state by replay. Fits domains needing a
  full audit trail or where "how did we get here" matters as much as
  "where are we now." Significant complexity cost; don't reach for this
  without a concrete need for the history itself.
- **Hexagonal / Ports and Adapters** — Isolate core domain logic behind
  interfaces ("ports"), with infrastructure concerns (DB, HTTP, queues)
  implemented as swappable "adapters" on the outside. Fits when the domain
  logic needs to be testable/portable independent of infrastructure
  choices, and infrastructure is expected to change or vary by
  environment.
