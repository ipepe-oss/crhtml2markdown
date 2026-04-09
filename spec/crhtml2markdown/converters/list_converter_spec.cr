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
end
