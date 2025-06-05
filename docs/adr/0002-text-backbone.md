# 2. Initial HTML to Markdown backbone

Date: 2025-06-05

## Status

Accepted

## Context

The project requires a starting point for converting HTML documents into Markdown. At this early stage we do not yet support individual HTML elements. We need a simple approach that allows incremental improvements while offering immediate value.

## Decision

Implement `Crhtml2markdown.convert` which takes an HTML string and returns the parsed document's textual content via `XML.parse_html(html).content`. This provides a minimal but functional conversion that strips markup and outputs plain text.

## Consequences

All HTML markup will be discarded in the first release. Future ADRs will document enhancements that map specific HTML elements to Markdown syntax.
