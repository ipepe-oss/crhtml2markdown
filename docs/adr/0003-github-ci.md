# 3. GitHub Actions for Crystal

Date: 2025-06-06

## Status

Accepted

## Context

The project currently requires developers to run `crystal tool format` and `crystal spec` manually before submitting changes. Automating these checks ensures consistent formatting and passing tests for every contribution.

## Decision

Set up a GitHub Actions workflow that installs Crystal, runs the formatter in check mode, and executes the specs on each push and pull request.

## Consequences

Formatting and spec failures will cause the workflow to fail, preventing unformatted or broken code from being merged. Contributors will get immediate feedback via CI.
