# 4. Introduce ameba for linting

Date: 2025-06-05

## Status

Accepted

## Context

We want to enforce consistent code style and catch issues early using static analysis.

## Decision

Add the `ameba` linter as a development dependency in `shard.yml` and run it as part of development checks.

## Consequences

Developers can run `./bin/ameba` after installing dependencies to lint the code. The current codebase contains some TODO comments that trigger warnings which can be addressed later.
