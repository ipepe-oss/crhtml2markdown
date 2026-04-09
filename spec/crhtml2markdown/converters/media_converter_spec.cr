require "../../spec_helper"

describe Crhtml2markdown::MediaConverter do
  it "passes through video elements as HTML" do
    html = "<video src=\"https://example.com/video.mp4\" controls>Fallback</video>"
    result = Crhtml2markdown.convert(html)
    result.should contain("<video")
    result.should contain("src=\"https://example.com/video.mp4\"")
    result.should contain("</video>")
  end

  it "passes through audio elements as HTML" do
    html = "<audio src=\"https://example.com/audio.mp3\" controls>Fallback</audio>"
    result = Crhtml2markdown.convert(html)
    result.should contain("<audio")
    result.should contain("src=\"https://example.com/audio.mp3\"")
    result.should contain("</audio>")
  end

  it "preserves video attributes" do
    html = "<video src=\"v.mp4\" controls autoplay>text</video>"
    result = Crhtml2markdown.convert(html)
    result.should contain("controls")
    result.should contain("src=\"v.mp4\"")
  end
end
