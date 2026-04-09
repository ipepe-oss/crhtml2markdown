require "../../spec_helper"

describe Crhtml2markdown::DefinitionListConverter do
  it "converts a definition list" do
    html = "<dl><dt>Term</dt><dd>Definition</dd></dl>"
    Crhtml2markdown.convert(html).should eq("Term\n: Definition")
  end

  it "converts multiple terms and definitions" do
    html = "<dl><dt>A</dt><dd>Alpha</dd><dt>B</dt><dd>Beta</dd></dl>"
    Crhtml2markdown.convert(html).should eq("A\n: Alpha\n\nB\n: Beta")
  end

  it "handles inline formatting in definitions" do
    html = "<dl><dt>Term</dt><dd>A <strong>bold</strong> definition</dd></dl>"
    Crhtml2markdown.convert(html).should eq("Term\n: A **bold** definition")
  end
end
