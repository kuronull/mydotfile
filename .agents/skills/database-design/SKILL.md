---
name: database-design
description: Design a database schema — table/collection structure, relationships, normalization level, indexing strategy, and migration approach. Use whenever the user is designing a new schema, adding tables/columns/collections to an existing database, asks about normalization, indexing, or query performance related to schema design, or is planning a schema migration.
---

# Database Design

A process for schemas that match actual access patterns and hold up under
real data volume and concurrency — instead of schemas designed purely
from the entity list without considering how they'll be queried.

## Core principle

**Access patterns should drive schema design as much as the entities
themselves.** Two schemas can model the same entities correctly while
having wildly different performance characteristics depending on what
gets queried together, how often, and at what volume — decide this before
finalizing structure, not after performance problems show up.

## Workflow

### 1. Identify entities and relationships

Standard first pass: list the core entities, their attributes, and the
relationships between them (one-to-many, many-to-many, optional vs.
required). This is necessary but not sufficient — don't stop here.

### 2. Identify actual access patterns before finalizing structure

For each entity, note:
- What's queried together frequently (this affects whether to
  denormalize, embed, or keep separate with a join)
- Read/write ratio and expected volume (affects normalization trade-offs
  and indexing aggressiveness — heavy-write tables want fewer, more
  targeted indexes since each index adds write cost)
- What needs to be queried by (this determines which fields need
  indexes) versus what's only ever fetched by primary key alongside
  something else

### 3. Choose a normalization level deliberately

- Normalize (separate tables, avoid duplication) by default for data
  that's updated independently and where duplication would create
  update-anomaly risk (the same fact stored in multiple places getting
  out of sync)
- Denormalize deliberately, not by accident, when: a specific
  read-heavy access pattern is dominant and a join would be a genuine
  bottleneck at the expected scale, or when historical accuracy is
  needed (e.g. storing the price *at time of purchase* on an order line,
  not just a reference to the current product price)
- Document *why* wherever you denormalize — this is the detail future
  maintainers most need and most often lack, since a denormalized field
  reads as "just a copy" without context

### 4. Design keys and relationships explicitly

- Primary keys: prefer a surrogate key (auto-increment/UUID) unless a
  natural key is truly stable and unique long-term — natural keys have a
  habit of turning out to be neither
- Foreign keys with proper constraints where the database supports them
  — catches data integrity bugs at write time rather than silently
  producing orphaned/inconsistent data discovered much later
- For many-to-many relationships, a join table — and consider whether
  the relationship itself has attributes (e.g. "joined_at" on a
  user-to-group membership) that belong on the join table rather than
  either side

### 5. Index for the actual query patterns

- Index columns that appear in WHERE clauses, JOIN conditions, and ORDER
  BY clauses for frequent queries — not speculatively on every column
- Composite indexes should match the actual query's column order and
  usage (leftmost-prefix rule for most B-tree index implementations) —
  an index on `(a, b)` doesn't necessarily help a query filtering only
  on `b`
- Every index has a write-cost — don't add one without a query that
  actually benefits, and periodically check for unused indexes on
  existing schemas
- Use `EXPLAIN`/query plan tooling to verify an index is actually being
  used as expected, rather than assuming from the schema alone

### 6. Plan migrations as a first-class concern, not an afterthought

- For any schema change on a live system, plan the transition: can the
  old and new schema coexist during a rollout (additive change,
  backward-compatible), or does it require a multi-step migration
  (add new column → backfill → switch reads → remove old column)?
- Large table migrations (adding a NOT NULL column, changing a column
  type, adding an index) can lock or degrade a live table depending on
  the database engine — check whether the specific operation is
  online/non-blocking for the database in use, and plan around it if not
- Always have a rollback plan for a migration, not just a forward plan

### 7. Consider consistency and concurrency explicitly

- Decide what needs transactional guarantees (multiple writes that must
  succeed or fail together) and wrap them in an actual transaction rather
  than relying on sequential application-level calls
- For counters/aggregates updated by concurrent writers, consider
  atomic increment operations or optimistic concurrency control rather
  than read-modify-write from application code, which races under
  concurrent access

## Anti-patterns to avoid

- Designing schema purely from the entity-relationship diagram without
  considering query patterns, then discovering performance problems only
  under real load
- Adding indexes speculatively on every column "just in case," which
  slows every write without a corresponding read benefit
- Denormalizing without documenting why, leaving future readers unsure
  whether a duplicated field is intentional or a bug
- Schema migrations on live tables without checking whether the specific
  operation locks the table for the database engine in use
- Relying on application-level sequential read-then-write for values that
  need atomic update under concurrency
