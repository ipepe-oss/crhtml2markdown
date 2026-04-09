require "../../spec_helper"

describe Crhtml2markdown::InlineHtmlPassthroughConverter do
  # Note: wbr tags are now handled by WbrConverter
  # it "passes through <wbr> tags" do
  #   html = "<p>Supercali<wbr>fragilistic<wbr>expialidocious</p>"
  #   result = Crhtml2markdown.convert(html)
  #   result.should contain("<wbr>")
  # end

  # Note: rt and rp tags are handled by RubyConverter
  # it "passes through <rt> tags" do
  #   html = "<ruby>漢<rt>kan</rt></ruby>"
  #   result = Crhtml2markdown.convert(html)
  #   result.should contain("<rt>")
  # end

  # it "passes through <rp> tags" do
  #   html = "<ruby>漢<rp>(</rp><rt>kan</rt><rp>)</rp></ruby>"
  #   result = Crhtml2markdown.convert(html)
  #   result.should contain("<rp>")
  # end

  # Note: acronym tags are now handled by AcronymConverter
  # it "passes through <acronym> tags" do
  #   html = "<p><acronym title=\"Application Programming Interface\">API</acronym></p>"
  #   result = Crhtml2markdown.convert(html)
  #   result.should contain("<acronym")
  # end
end
