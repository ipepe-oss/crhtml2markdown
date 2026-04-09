require "../../spec_helper"

describe Crhtml2markdown::FigureConverter do
  it "converts figure with img and figcaption" do
    html = "<figure><img src=\"https://example.com/photo.jpg\" alt=\"A photo\"><figcaption>Figure 1: A nice photo</figcaption></figure>"
    result = Crhtml2markdown.convert(html)
    result.should contain("![A photo](https://example.com/photo.jpg)")
    result.should contain("*Figure 1: A nice photo*")
  end

  it "converts figure with only img" do
    html = "<figure><img src=\"https://example.com/photo.jpg\" alt=\"A photo\"></figure>"
    result = Crhtml2markdown.convert(html)
    result.should contain("![A photo](https://example.com/photo.jpg)")
  end

  it "converts figcaption with inline formatting" do
    html = "<figure><img src=\"img.jpg\" alt=\"test\"><figcaption><strong>Bold</strong> caption</figcaption></figure>"
    result = Crhtml2markdown.convert(html)
    result.should contain("***Bold** caption*")
  end
end
