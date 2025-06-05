# 6. Command line interface

Date: 2025-06-08

## Status

Accepted

## Context

The project aims to provide both a library and a command line utility. While the
core conversion API exists, there is no executable that users can invoke from
the terminal. A small CLI wrapper is needed to parse options, read input and
print the converted Markdown.

## Decision

Implement `Crhtml2markdown::CLI` under `src/crhtml2markdown/cli.cr`.
The CLI parses `--help` and accepts an optional file argument. When a filename
is provided the HTML is read from that file; otherwise STDIN is consumed. The
result of `Crhtml2markdown.convert` is printed to STDOUT. A shell script
`bin/crhtml2markdown` runs the CLI via `crystal run`. The shard's `targets`
section is updated so the executable can be built with `shards build`.

## Consequences

Users can now run `crhtml2markdown` directly to convert HTML documents.
Future enhancements can extend the option parser without affecting the library
API.
