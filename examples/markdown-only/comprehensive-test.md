# Comprehensive Markdown Test Document

## Text Formatting

This is **bold text** and this is *italic text*. This is ***bold and italic*** together.

Here is ~~strikethrough text~~ for deleted content.

## Headings

### H3 Heading

#### H4 Heading

##### H5 Heading

###### H6 Heading

## Links and Images

Here is an [inline link](https://example.com) and another [link with title](https://example.com "Example Site").

![Alt text for image](https://example.com/image.png)

![Image with title](https://example.com/photo.jpg "Photo title")

## Lists

### Unordered List

- Item one
- Item two
- Item three
  - Nested item A
  - Nested item B
    - Deep nested item
- Item four

### Ordered List

1. First item
2. Second item
3. Third item
   1. Nested ordered A
   2. Nested ordered B
4. Fourth item

### Mixed List

1. Ordered item one
   - Unordered nested
   - Another unordered
2. Ordered item two

## Blockquotes

> This is a blockquote.
> It spans multiple lines.
>
> > Nested blockquote here.
> > Another line.

## Code

Inline `code` in a paragraph.

```
Fenced code block without language
multiple lines
of code here
```

```crystal
# Code with language specification
def hello(name : String) : String
  "Hello, #{name}!"
end

puts hello("World")
```

    Indented code block
    with four spaces
    multiple lines

## Tables

| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Cell 4   | Cell 5   | Cell 6   |

| Left Align | Center Align | Right Align |
|:-----------|:------------:|------------:|
| Left       | Center       | Right       |
| More left  | More center  | More right  |

## Horizontal Rules

---

***

___

## Paragraphs and Line Breaks

First paragraph with some text.

Second paragraph after blank line.

Line one with two spaces at end.
Line two after line break.

## Task Lists

- [x] Completed task
- [ ] Incomplete task
- [x] Another completed task
- [ ] Another incomplete task

## Nested Structures

### Blockquote with Lists

> - Quoted list item 1
> - Quoted list item 2
> - Quoted list item 3

### List with Code

1. First item with `inline code`
2. Second item with code block:

   ```
   code in a list
   ```

3. Third item continues

### List with Blockquote

- List item one
- List item two

  > A blockquote inside a list
  > Multiple lines

- List item three

## Mixed Inline Formatting

This paragraph has **bold**, *italic*, `code`, ~~strikethrough~~, and a [link](https://example.com).

You can also combine ***bold italic*** and `**code with asterisks**`.

## Definition Lists (HTML)

<dl>
  <dt>Term 1</dt>
  <dd>Definition 1</dd>
  <dt>Term 2</dt>
  <dd>Definition 2</dd>
</dl>

## HTML Elements

<div>This is a div element</div>

<span>This is a span element</span>

<strong>Strong via HTML tag</strong>

<em>Emphasis via HTML tag</em>

## Special Characters

AT&T has an ampersand &amp; angle brackets &lt; &gt;

## Links with Complex Content

[**Bold link text**](https://example.com)

[*Italic link text*](https://example.com)

[`Code link text`](https://example.com)

## Empty and Edge Cases

### Empty Table Rows

| A | B |
|---|---|
|   |   |
| 1 | 2 |

### Multiple Blank Lines



Between these paragraphs are multiple blank lines.



## Footnotes (GFM Extension)

Here is a footnote reference[^1] and another[^2].

[^1]: This is the first footnote.
[^2]: This is the second footnote with **bold text**.

## Emphasis Edge Cases

*Single asterisks with "quoted" text*

_Underscores with "quoted" text_

**Double asterisks with multiple words inside**

## Escaping Special Characters

\*Not italic\*

\**Not bold\**

\# Not a heading

\[Not a link\](not-a-url)

## Complex Nested Markdown

> **Note:** This blockquote contains *italic*, `code`, and a [link](https://example.com).
>
> It also has:
> - A list item
> - Another item with **bold**
>
> And even a code block:
>
> ```javascript
> console.log("hello");
> ```

---

1. **First**: A description with `code` and a [link](https://example.com)
2. *Second*: Another description with ~~strikethrough~~
3. `Third`: Yet another with **nested bold** and *nested italic*
