require "../../spec_helper"

describe Crhtml2markdown::TableConverter do
  it "converts a simple table" do
    html = "<table><thead><tr><th>A</th><th>B</th></tr></thead><tbody><tr><td>1</td><td>2</td></tr></tbody></table>"
    expected = "| A   | B   | \n| --- | --- | \n| 1   | 2   |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "pads columns to equal width" do
    html = "<table><thead><tr><th>Name</th><th>X</th></tr></thead><tbody><tr><td>A</td><td>Long value</td></tr></tbody></table>"
    expected = "| Name | X          | \n| ---- | ---------- | \n| A    | Long value |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "handles inline formatting in cells" do
    html = "<table><thead><tr><th>Col</th></tr></thead><tbody><tr><td><strong>bold</strong></td></tr></tbody></table>"
    expected = "| Col      | \n| -------- | \n| **bold** |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "handles table without thead" do
    html = "<table><tr><td>A</td><td>B</td></tr><tr><td>1</td><td>2</td></tr></table>"
    expected = "| A   | B   | \n| --- | --- | \n| 1   | 2   |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "preserves center alignment" do
    html = "<table><thead><tr><th>Left</th><th align=\"center\">Center</th></tr></thead><tbody><tr><td>a</td><td align=\"center\">b</td></tr></tbody></table>"
    expected = "| Left | Center | \n| ---- | :----: | \n| a    | b      |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "preserves right alignment" do
    html = "<table><thead><tr><th>Name</th><th align=\"right\">Price</th></tr></thead><tbody><tr><td>Item</td><td align=\"right\">$10</td></tr></tbody></table>"
    expected = "| Name | Price | \n| ---- | ----: | \n| Item | $10   |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "preserves mixed alignments" do
    html = "<table><thead><tr><th align=\"left\">Left</th><th align=\"center\">Center</th><th align=\"right\">Right</th></tr></thead><tbody><tr><td>a</td><td>b</td><td>c</td></tr></tbody></table>"
    expected = "| Left | Center | Right | \n| ---- | :----: | ----: | \n| a    | b      | c     |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "escapes pipe characters in cell content" do
    html = "<table><thead><tr><th>Name</th><th>Char</th></tr></thead><tbody><tr><td>Pipe</td><td>|</td></tr></tbody></table>"
    result = Crhtml2markdown.convert(html)
    result.should contain("\\|")
  end

  it "flattens code blocks in cells to inline code" do
    html = "<table><tr><th>Code</th><th>Output</th></tr><tr><td><pre><code>hello world</code></pre></td><td>text</td></tr></table>"
    result = Crhtml2markdown.convert(html)
    result.should contain("`hello world`")
    result.should_not contain("```")
  end

  it "flattens multi-line content in cells to single line" do
    html = "<table><tr><th>Col</th></tr><tr><td><h2>Title</h2><p>Text</p></td></tr></table>"
    result = Crhtml2markdown.convert(html)
    # Each row should be a single line (no newlines within cell content)
    result.split("\n").each do |line|
      next if line.strip.empty?
      line.count("|").should be >= 2 # valid table row
    end
  end

  it "preserves center alignment from style attribute" do
    html = "<table><thead><tr><th>Left</th><th style=\"text-align: center\">Center</th></tr></thead><tbody><tr><td>a</td><td>b</td></tr></tbody></table>"
    expected = "| Left | Center | \n| ---- | :----: | \n| a    | b      |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "preserves right alignment from style attribute" do
    html = "<table><thead><tr><th style=\"text-align: right\">Price</th></tr></thead><tbody><tr><td style=\"text-align: right\">$10</td></tr></tbody></table>"
    expected = "| Price | \n| ----: | \n| $10   |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "preserves mixed alignments from style and align attributes" do
    html = "<table><thead><tr><th align=\"left\">A</th><th style=\"text-align:center\">B</th><th style=\"text-align: right\">C</th></tr></thead><tbody><tr><td>1</td><td>2</td><td>3</td></tr></tbody></table>"
    expected = "| A   | B   | C   | \n| --- | :-: | --: | \n| 1   | 2   | 3   |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "treats justify alignment as left" do
    html = "<table><thead><tr><th style=\"text-align: justify\">Col</th></tr></thead><tbody><tr><td>a</td></tr></tbody></table>"
    expected = "| Col | \n| --- | \n| a   |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "pads rows with fewer cells than header" do
    html = "<table><thead><tr><th>A</th><th>B</th><th>C</th></tr></thead><tbody><tr><td>1</td></tr></tbody></table>"
    expected = "| A   | B   | C   | \n| --- | --- | --- | \n| 1   |     |     |"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "handles colspan by inserting empty cells" do
    html = "<table><thead><tr><th>A</th><th>B</th><th>C</th></tr></thead><tbody><tr><td colspan=\"2\">Merged</td><td>D</td></tr></tbody></table>"
    result = Crhtml2markdown.convert(html)
    result.should contain("| Merged |     | D   |")
    # Should have 3 columns in all rows
    result.split("\n").each do |line|
      next if line.strip.empty?
      line.count("|").should eq(4) # 3 cells = 4 pipes
    end
  end
end
