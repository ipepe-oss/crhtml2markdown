#!/usr/bin/env crystal

# Round-trip test: Markdown -> HTML -> Markdown
# This script tests how well the crhtml2markdown library preserves markdown features

require "xml"
require "../src/crhtml2markdown"

# Read the markdown test file
markdown_file = ARGV[0]? || File.join(__DIR__, "../examples/markdown-only/allysonsilva-full.md")
markdown_file = File.expand_path(markdown_file)
original_markdown = File.read(markdown_file)

puts "=" * 80
puts "ROUND-TRIP TEST: Markdown -> HTML -> Markdown"
puts "=" * 80
puts

# Step 1: Convert Markdown to HTML using cmark
puts "Step 1: Converting Markdown to HTML using cmark..."
html_output = IO::Memory.new
Process.run("cmark", ["--to", "html", markdown_file], output: html_output)
html_content = html_output.to_s

# Save HTML for inspection
File.write("/tmp/test_output.html", html_content)
puts "✓ HTML saved to /tmp/test_output.html"
puts "HTML length: #{html_content.size} bytes"
puts

# Step 2: Convert HTML back to Markdown using crhtml2markdown
puts "Step 2: Converting HTML back to Markdown using crhtml2markdown..."
begin
  converted_markdown = Crhtml2markdown.convert(html_content)

  # Save converted markdown
  File.write("/tmp/test_output.md", converted_markdown)
  puts "✓ Converted markdown saved to /tmp/test_output.md"
  puts "Converted markdown length: #{converted_markdown.size} bytes"
  puts

  # Step 3: Compare and analyze
  puts "=" * 80
  puts "ANALYSIS"
  puts "=" * 80
  puts

  original_lines = original_markdown.lines
  converted_lines = converted_markdown.lines

  puts "Original lines: #{original_lines.size}"
  puts "Converted lines: #{converted_lines.size}"
  puts

  # Find features that might be missing
  puts "Checking for potential issues..."
  puts

  # Check for footnotes (HTML comments or specific patterns)
  if original_markdown.includes?("[^")
    puts "⚠️  Footnotes found in original - checking if preserved..."
    if converted_markdown.includes?("[^")
      puts "  ✓ Footnotes appear to be preserved"
    else
      puts "  ✗ Footnotes NOT preserved - this is a known limitation"
    end
    puts
  end

  # Check for underline-style headers (Alt-H1, Alt-H2)
  if original_markdown.matches?(/^\w+\n=+$/)
    puts "⚠️  Underline-style headers (Setext) found in original"
    puts "  ℹ️  These will be converted to ATX style (# headers) - expected behavior"
    puts
  end

  # Check for reference-style links
  if original_markdown.matches?(/\[.*?\]:\s*http/)
    puts "⚠️  Reference-style links found in original - checking if preserved..."
    if converted_markdown.matches?(/\[.*?\]:\s*http/)
      puts "  ✓ Reference-style links appear to be preserved"
    else
      puts "  ✗ Reference-style links NOT converted back properly"
    end
    puts
  end

  # Check for auto-links
  if original_markdown.matches?(/<http[^>]+>/)
    puts "⚠️  Auto-links (<http://...>) found in original - checking if preserved..."
    if converted_markdown.matches?(/<http[^>]+>/)
      puts "  ✓ Auto-links appear to be preserved"
    else
      puts "  ✗ Auto-links NOT preserved - converted to inline links"
    end
    puts
  end

  # Check for escaped characters
  if original_markdown.includes?("\\")
    puts "⚠️  Escaped characters found in original - checking if preserved..."
    puts "  ℹ️  HTML doesn't preserve backslash escapes - this is expected"
    puts
  end

  # Check for code blocks with language spec
  if original_markdown.matches?(/```\w+/)
    puts "⚠️  Fenced code blocks with language found in original - checking if preserved..."
    if converted_markdown.matches?(/```\w+/)
      puts "  ✓ Language specification appears to be preserved"
    else
      puts "  ⚠️  Language specification might not be preserved"
    end
    puts
  end

  # Display sample comparison
  puts "=" * 80
  puts "SAMPLE COMPARISON (first 50 lines each)"
  puts "=" * 80
  puts

  puts "ORIGINAL MARKDOWN:"
  puts "-" * 40
  original_lines.first(50).each_with_index do |line, i|
    puts "#{i + 1}: #{line}"
  end

  puts
  puts "CONVERTED MARKDOWN:"
  puts "-" * 40
  converted_lines.first(50).each_with_index do |line, i|
    puts "#{i + 1}: #{line}"
  end

  puts
  puts "=" * 80
  puts "Full comparison saved to /tmp/roundtrip_comparison.txt"
  puts "=" * 80

  # Create detailed comparison file
  File.open("/tmp/roundtrip_comparison.txt", "w") do |f|
    f.puts "=" * 80
    f.puts "ROUND-TRIP COMPARISON"
    f.puts "=" * 80
    f.puts
    f.puts "ORIGINAL:"
    f.puts "-" * 40
    f.puts original_markdown
    f.puts
    f.puts "=" * 80
    f.puts "CONVERTED:"
    f.puts "-" * 40
    f.puts converted_markdown
  end
rescue ex : Exception
  puts "Error during conversion: #{ex.message}"
  puts ex.backtrace.join("\n")
  exit 1
end
