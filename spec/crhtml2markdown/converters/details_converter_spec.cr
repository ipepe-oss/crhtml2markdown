require "../../spec_helper"

describe Crhtml2markdown::DetailsConverter do
  it "converts details/summary to HTML passthrough" do
    html = "<details><summary>Click to expand</summary><p>Hidden content.</p></details>"
    result = Crhtml2markdown.convert(html)
    result.should contain("<details>")
    result.should contain("<summary>Click to expand</summary>")
    result.should contain("Hidden content.")
    result.should contain("</details>")
  end

  it "handles details without summary" do
    html = "<details><p>Just content.</p></details>"
    result = Crhtml2markdown.convert(html)
    result.should contain("<details>")
    result.should contain("Just content.")
    result.should contain("</details>")
  end
end
