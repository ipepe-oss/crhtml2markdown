# 5. Element converter classes

Date: 2025-06-05

## Status

Accepted

## Context

As the converter starts supporting more HTML elements, placing all rendering
logic in a single method becomes hard to maintain. The project needs a
composable approach that allows adding new element handling without cluttering
the core API.

## Decision

Introduce a small hierarchy of *element converter* classes. Each converter knows
how to render a specific type of HTML node. `Crhtml2markdown.convert` traverses
the parsed document and delegates rendering of a node to the first converter
that reports it can handle the node. For now the library provides:

- `HeadingConverter` for `h1`-`h6` elements
- `TextConverter` for plain text nodes

Additional converters will be added as support grows for other elements.

## Consequences

Rendering logic is split into small classes that can be tested and extended
independently. The main module remains simple, merely orchestrating traversal
and delegation to converters.
