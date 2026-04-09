require "../../spec_helper"

describe Crhtml2markdown::HorizontalRuleConverter do
  it "converts hr to ---" do
    html = "<p>Above</p><hr /><p>Below</p>"
    Crhtml2markdown.convert(html).should eq("Above\n\n---\n\nBelow")
  end

  it "converts self-closing hr" do
    html = "<hr/>"
    Crhtml2markdown.convert(html).should eq("---")
  end
end
