require "../../spec_helper"

describe Crhtml2markdown::HeadingConverter do
  it "converts all heading levels" do
    (1..6).each do |level|
      html = "<h#{level}>Heading #{level}</h#{level}>"
      expected = "#{"#" * level} Heading #{level}"
      Crhtml2markdown.convert(html).should eq(expected)
    end
  end

  it "strips whitespace from heading content" do
    html = "<h1>  Spaced  </h1>"
    Crhtml2markdown.convert(html).should eq("# Spaced")
  end
end
