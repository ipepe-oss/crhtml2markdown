# 4. HTML Element Support Plan

Date: 2025-06-07

## Status

Accepted

## Context

The initial conversion only extracts text from HTML. To produce proper Markdown,
we need to map individual HTML elements to their Markdown equivalents. This plan
lays out which elements will be supported in upcoming iterations.

## Decision

We will incrementally implement conversion for the following elements:

- `h1` to `h6` for headings
- `p` for paragraphs
- `strong` and `em` for emphasis
- `a` for hyperlinks
- `img` for images (using the `alt` text and `src` URL)
- `code` for inline code spans
- `pre` for fenced code blocks
- `blockquote` for block quotes
- `ul` and `ol` with nested `li` for lists
- `hr` for horizontal rules
- `br` for line breaks
- `table`, `thead`, `tbody`, `tfoot`, `tr`, `th`, and `td` for tables

Additional elements may be added as needed. Elements such as `div` or `span`
without semantic meaning will generally be ignored unless required for layout.

## Consequences

Implementation will proceed element by element. Each addition will include
tests verifying the correct Markdown output. Future ADRs may extend or adjust
the list as real‑world usage reveals further requirements.
