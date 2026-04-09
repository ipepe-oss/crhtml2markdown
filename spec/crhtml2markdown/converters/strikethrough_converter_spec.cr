require "../../spec_helper"

describe Crhtml2markdown::StrikethroughConverter do
  it "converts del to double tildes" do
    html = "<p><del>deleted</del></p>"
    Crhtml2markdown.convert(html).should eq("~~deleted~~")
  end

  it "converts s to double tildes" do
    html = "<p><s>strikethrough</s></p>"
    Crhtml2markdown.convert(html).should eq("~~strikethrough~~")
  end

  it "handles inline content inside del" do
    html = "<p><del><strong>bold deleted</strong></del></p>"
    Crhtml2markdown.convert(html).should eq("~~**bold deleted**~~")
  end

  it "handles strikethrough mixed with other text" do
    html = "<p>before <del>middle</del> after</p>"
    Crhtml2markdown.convert(html).should eq("before ~~middle~~ after")
  end
end
