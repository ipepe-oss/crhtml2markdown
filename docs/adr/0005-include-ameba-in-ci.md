# 5. Include ameba in CI pipeline

Date: 2025-06-05

## Status

Accepted

## Context

After introducing the `ameba` linter for development, we want the same checks run automatically in continuous integration to prevent style issues from entering the codebase.

## Decision

Extend the GitHub Actions workflow to execute `./bin/ameba` after installing dependencies.

## Consequences

Pull requests will fail if linting errors are detected, encouraging contributors to fix issues locally before submitting changes.
