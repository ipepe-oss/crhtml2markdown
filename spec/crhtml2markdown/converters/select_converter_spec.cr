require "../../spec_helper"

describe Crhtml2markdown::SelectConverter do
  it "converts select with single option" do
    html = "<select><option>Only option</option></select>"
    Crhtml2markdown.convert(html).should eq("Only option")
  end

  it "converts select with multiple options" do
    html = "<select><option>Option 1</option><option>Option 2</option></select>"
    result = Crhtml2markdown.convert(html)
    result.should eq("Option 1 | Option 2")
  end

  it "indicates selected option with brackets" do
    html = "<select><option>Option 1</option><option selected>Option 2</option></select>"
    result = Crhtml2markdown.convert(html)
    result.should eq("Option 1 | [Option 2]")
  end

  it "handles select with multiple options and one selected" do
    html = "<select><option>Apple</option><option selected>Banana</option><option>Cherry</option></select>"
    result = Crhtml2markdown.convert(html)
    result.should eq("Apple | [Banana] | Cherry")
  end

  it "handles select with no selected option" do
    html = "<select><option>First</option><option>Second</option><option>Third</option></select>"
    result = Crhtml2markdown.convert(html)
    result.should eq("First | Second | Third")
  end
end
