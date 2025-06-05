# 6. Run Ameba in CI

Date: 2025-06-09

## Status

Accepted

## Context

Ameba was added as a development dependency to help enforce Crystal best
practices. While developers can run `./bin/ameba` locally, linting should also
occur automatically in the continuous integration pipeline.

## Decision

Update the GitHub Actions workflow to execute `./bin/ameba` after installing
dependencies. The workflow already checks formatting and runs the specs, so
adding Ameba ensures lint violations also fail the build.

## Consequences

Pull requests will now be blocked if Ameba reports any issues. This keeps the
codebase consistent and encourages contributors to fix lint warnings before
merging.
