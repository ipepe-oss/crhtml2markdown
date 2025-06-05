# 5. Adopt Ameba Linter

Date: 2025-06-08

## Status

Accepted

## Context

To maintain code quality, we want an automated linter that enforces Crystal best practices. The Ameba shard provides static code analysis for Crystal projects and integrates easily via shards.

## Decision

Add Ameba as a development dependency in `shard.yml`. Developers can run `bin/ameba` locally and the CI pipeline may be extended later to include this linter.

## Consequences

The repository now includes the Ameba shard in `shard.lock`. Contributors should run `bin/ameba` before committing to catch common issues.
