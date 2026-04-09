require "spec"
require "../../../src/crhtml2markdown"

describe Crhtml2markdown::WbrConverter do
  it "removes wbr elements from output" do
    html = "<p>Supercali<wbr>fragilistic<wbr>expialidocious</p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("Supercalifragilisticexpialidocious")
  end

  it "handles multiple wbr elements in a row" do
    html = "<p>word<wbr><wbr><wbr>break</p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("wordbreak")
  end

  it "handles wbr at the start of text" do
    html = "<p><wbr>word</p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("word")
  end

  it "handles wbr at the end of text" do
    html = "<p>word<wbr></p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("word")
  end

  it "handles wbr with other inline elements" do
    html = "<p><strong>Supercali<wbr>fragilistic</strong></p>"
    result = Crhtml2markdown.convert(html)
    result.should eq("**Supercalifragilistic**")
  end
end
