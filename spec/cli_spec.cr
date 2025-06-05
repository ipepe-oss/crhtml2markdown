require "./spec_helper"

private def run_cli(args : Array(String), input = "")
  output = IO::Memory.new
  Process.run("#{__DIR__}/../bin/crhtml2markdown", args, input: IO::Memory.new(input), output: output)
  output.to_s
end

describe "crhtml2markdown CLI" do
  it "reads from a file" do
    dir = Dir.tempdir
    path = File.join(dir, "input.html")
    File.write(path, "<h1>Title</h1>")
    begin
      run_cli([path]).strip.should eq("# Title")
    ensure
      File.delete(path)
    end
  end

  it "reads from STDIN" do
    run_cli([] of String, "<h1>Title</h1>").strip.should eq("# Title")
  end

  it "prints help" do
    output = run_cli(["--help"])
    output.should contain("Usage: crhtml2markdown")
  end
end
