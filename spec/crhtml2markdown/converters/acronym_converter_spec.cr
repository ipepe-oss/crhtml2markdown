require "spec"
require "../../../src/crhtml2markdown"

describe Crhtml2markdown::AcronymConverter do
  it "converts acronym with title to markdown format" do
    html = "<p><acronym title=\"Application Programming Interface\">API</acronym></p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("API (Application Programming Interface)")
  end

  it "handles acronym without title" do
    html = "<p><acronym>API</acronym></p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("API")
  end

  it "handles acronym with empty title" do
    html = "<p><acronym title=\"\">API</acronym></p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("API")
  end

  it "handles acronym within other content" do
    html = "<p>Use the <acronym title=\"Graphical User Interface\">GUI</acronym> to interact.</p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("Use the GUI (Graphical User Interface) to interact.")
  end

  it "handles multiple acronyms in one paragraph" do
    html = "<p><acronym title=\"Application Programming Interface\">API</acronym> and <acronym title=\"Graphical User Interface\">GUI</acronym></p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("API (Application Programming Interface) and GUI (Graphical User Interface)")
  end
end
