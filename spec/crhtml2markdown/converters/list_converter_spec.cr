require "../../spec_helper"

describe Crhtml2markdown::ListConverter do
  it "converts unordered lists" do
    html = "<ul><li>One</li><li>Two</li><li>Three</li></ul>"
    Crhtml2markdown.convert(html).should eq("- One\n- Two\n- Three")
  end

  it "converts ordered lists" do
    html = "<ol><li>First</li><li>Second</li><li>Third</li></ol>"
    Crhtml2markdown.convert(html).should eq("1. First\n2. Second\n3. Third")
  end

  it "converts nested lists" do
    html = "<ol><li>Parent<ul><li>Child</li></ul></li><li>Second</li></ol>"
    Crhtml2markdown.convert(html).should eq("1. Parent\n    - Child\n2. Second")
  end

  it "converts deeply nested lists" do
    html = "<ul><li>A<ul><li>B<ul><li>C</li></ul></li></ul></li></ul>"
    Crhtml2markdown.convert(html).should eq("- A\n    - B\n        - C")
  end

  it "handles list items with inline elements" do
    html = "<ul><li>Text with <strong>bold</strong> and <code>code</code></li></ul>"
    Crhtml2markdown.convert(html).should eq("- Text with **bold** and `code`")
  end

  it "handles ordered list with start attribute" do
    html = "<ol start=\"5\"><li>Five</li><li>Six</li><li>Seven</li></ol>"
    Crhtml2markdown.convert(html).should eq("5. Five\n6. Six\n7. Seven")
  end

  it "handles multi-paragraph list items" do
    html = "<ul><li><p>First paragraph.</p><p>Second paragraph.</p></li><li><p>Another item.</p></li></ul>"
    Crhtml2markdown.convert(html).should eq("- First paragraph.\n\n    Second paragraph.\n\n- Another item.")
  end

  it "handles mixed list types (ol inside ul)" do
    html = "<ul><li>Unordered<ol><li>Ordered 1</li><li>Ordered 2</li></ol></li></ul>"
    Crhtml2markdown.convert(html).should eq("- Unordered\n    1. Ordered 1\n    2. Ordered 2")
  end

  it "indents code blocks inside list items" do
    html = "<ol><li><p>Item with code:</p><pre><code>some code\n</code></pre></li><li><p>Next item</p></li></ol>"
    result = Crhtml2markdown.convert(html)
    result.should contain("    ```")
    lines = result.split("\n")
    # All code block lines should be indented within the list
    in_code = false
    lines.each do |line|
      if line.includes?("```")
        in_code = !in_code
        line.should start_with("    ")
      elsif in_code
        line.should start_with("    ")
      end
    end
  end

  it "indents blockquotes inside list items" do
    html = "<ol><li><p>Item with quote:</p><blockquote><p>Quoted text</p></blockquote></li></ol>"
    result = Crhtml2markdown.convert(html)
    result.should contain("    > Quoted text")
  end
end
