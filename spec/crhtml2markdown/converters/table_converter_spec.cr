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
end
