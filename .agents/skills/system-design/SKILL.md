---
name: system-design
description: Design the architecture for a new system, service, or significant feature — including requirements gathering, scale estimation, API/data model design, component breakdown, and identifying bottlenecks and failure modes. Use whenever the user asks to "design a system for X", "how should I architect Y", wants help with a system design interview question, is planning a new service or major feature and needs the high-level shape before writing code, or asks about scaling/reliability trade-offs for an existing design. Push toward this whenever architecture-level decisions are being made, not just when the word "design" appears explicitly.
---

# System Design

A structured approach to going from a rough idea to a defensible
architecture, in the right order — instead of jumping straight to a tech
stack or a diagram before the actual requirements and constraints are
pinned down.

## Core principle

**Requirements and scale determine architecture, not the other way
around.** The same feature can have wildly different correct designs
depending on read/write ratios, consistency requirements, and scale — get
these established before proposing components.

## Workflow

### 1. Clarify requirements

**Functional**: What must the system actually do? List the core
operations/user stories concretely (e.g. "user posts a message", "message
is delivered to followers within N seconds"). Explicitly note what's
*out of scope* — scope creep during design is as costly as under-scoping.

**Non-functional**, and don't skip these even if the user didn't mention
them — ask or state reasonable assumptions explicitly:
- Scale: users, requests/sec, data volume, growth rate
- Latency: what needs to be fast, and how fast
- Consistency vs. availability requirements (does this need strict
  consistency, or is eventual consistency acceptable — and where?)
- Durability requirements (can data ever be lost? how much?)
- Read/write ratio — this alone often determines the whole caching and
  storage strategy

If this is a take-home/interview-style prompt, spend real time here before
moving on — under-specified requirements are the most common way these
go wrong, on both sides.

### 2. Back-of-envelope estimation

Rough numbers, not false precision — but do the arithmetic, don't skip it:
- Requests per second (average and peak)
- Storage volume (per record size × count × retention, growth over time)
- Bandwidth (payload size × request rate)

These numbers should directly inform decisions later (e.g. "at this
write volume, a single relational primary is/isn't going to be the
bottleneck").

### 3. Define the interface before the internals

Sketch the API (or equivalent contract) first: endpoints/RPCs, request and
response shapes, key error cases. This forces clarity on what the system
actually promises to callers before deciding how it delivers on that
promise internally.

Then sketch the core data model: main entities, their relationships, and
which fields are actually queried-by vs. just stored — access patterns
should drive schema and index/storage-engine choice, not the reverse.

### 4. High-level architecture

Break the system into components and show how data flows between them.
For each major component, be explicit about:
- Its single responsibility
- What it talks to, synchronously vs. asynchronously
- What state it owns, if any

Prefer starting simple (even "one service + one database") and layering
in complexity (caches, queues, read replicas, sharding) as a response to a
specific bottleneck identified in step 2 or 5 — not by default. A design
that's more complex than the stated scale requires is a real design flaw,
not a safe choice.

### 5. Identify bottlenecks and failure modes

For the design as sketched, work through:
- What's the first thing to fall over as load increases, and why?
- Single points of failure — where, and what's the mitigation (redundancy,
  failover, degraded-mode behavior)?
- What happens to in-flight requests/data during a partial failure
  (a downstream service is down, a network partition happens)?
- Hot spots (a single popular key, a single heavy tenant) and how the
  design handles them

### 6. Discuss trade-offs explicitly

Real system design has no single correct answer — surface the trade-offs
made rather than presenting the design as the only reasonable choice:
- Consistency vs. availability choices and where they were made
- Cost vs. latency vs. complexity trade-offs
- What was deliberately deferred as a "solve it when it's actually a
  problem" rather than solved upfront, and why that's a reasonable bet

### 7. Iterate against new constraints

If new requirements or scale numbers come in (common in interviews and in
real design reviews), revisit steps 2-6 rather than patching the diagram —
a 10x scale change often changes the right answer, not just the numbers.

## Anti-patterns to avoid

- Naming specific technologies (a particular queue/database/cache product)
  before establishing the requirements those technologies would need to
  satisfy — the requirement should select the tool, not the reverse
- Defaulting to a maximally distributed/scalable design regardless of the
  actual scale requirements ("resume-driven design")
- Treating consistency, availability, and partition tolerance trade-offs
  as an afterthought rather than a first-class design decision
- Skipping failure-mode analysis because the happy path works
- Presenting the design as finished without noting what would need to
  change at 10x or 100x the estimated scale
