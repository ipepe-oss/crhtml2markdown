#!/usr/bin/env crystal

# Test for missing HTML elements and features

require "xml"
require "../src/crhtml2markdown"

test_cases = {
  "abbr"       => "<p><abbr title=\"Graphical User Interface\">GUI</abbr></p>",
  "acronym"    => "<p><acronym title=\"Application Programming Interface\">API</acronym></p>",
  "cite"       => "<p><cite>The Odyssey</cite> by Homer</p>",
  "dfn"        => "<p><dfn>HTML</dfn> is the standard...</p>",
  "kbd"        => "<p>Press <kbd>Ctrl</kbd>+<kbd>C</kbd></p>",
  "mark"       => "<p>Marked <mark>text</mark></p>",
  "s"          => "<p><s>Strikethrough</s> text</p>",
  "samp"       => "<p>The output <samp>Hello World</samp></p>",
  "small"      => "<p><small>Small text</small></p>",
  "u"          => "<p><u>Underlined</u> text</p>",
  "var"        => "<p>Use <code>var</code> for variables</p>",
  "wbr"        => "<p>Supercali<wbr>fragilistic<wbr>expialidocious</p>",
  "data"       => "<p><data value=\"123\">Product</data></p>",
  "time"       => "<p><time datetime=\"2023-01-01\">January 1st</time></p>",
  "progress"   => "<p>Progress: <progress value=\"70\" max=\"100\"></progress></p>",
  "meter"      => "<p>Meter: <meter value=\"0.7\" min=\"0\" max=\"1\">70%</meter></p>",
  "ins"        => "<p><ins>Inserted</ins> text</p>",
  "del"        => "<p><del>Deleted</del> text</p>",
  "q"          => "<p>He said <q>Hello</q></p>",
  "ruby"       => "<ruby>漢<rt>kan</rt><ruby>字<rt>ji</rt></ruby>",
  "bdi"        => "<p><bdi>עברית</bdi> text</p>",
  "bdo"        => "<p><bdo dir=\"rtl\">Right to left</bdo></p>",
  "figcaption" => "<figure><img src=\"test.jpg\" alt=\"Test\"><figcaption>Caption</figcaption></figure>",
  "address"    => "<address>123 Main St</address>",
  "output"     => "<p>Result: <output>42</output></p>",
  "template"   => "<template>Hidden content</template>",
}

puts "=" * 80
puts "TESTING FOR MISSING HTML ELEMENTS"
puts "=" * 80
puts

missing = [] of Tuple(String, String, String)
partially_supported = [] of Tuple(String, String, String)
well_supported = [] of Tuple(String, String, String)

test_cases.each do |name, html|
  begin
    result = Crhtml2markdown.convert(html)

    # Check if the result is different from just stripping HTML
    text_only = html.gsub(/<[^>]+>/, "").strip

    if result == text_only
      missing << {name, html, result}
      puts "❌ #{name.ljust(15)} - NOT SUPPORTED (output: #{result.inspect})"
    elsif result.includes?("<") && result.includes?(">")
      partially_supported << {name, html, result}
      puts "⚠️  #{name.ljust(15)} - PARTIAL (HTML passthrough: #{result.inspect})"
    else
      well_supported << {name, html, result}
      puts "✅ #{name.ljust(15)} - SUPPORTED (output: #{result.inspect})"
    end
  rescue ex : Exception
    missing << {name, html, "ERROR: #{ex.message}"}
    puts "❌ #{name.ljust(15)} - ERROR: #{ex.message}"
  end
end

puts
puts "=" * 80
puts "SUMMARY"
puts "=" * 80
puts

puts "Well supported (#{well_supported.size}):"
well_supported.each do |name, html, result|
  puts "  - #{name}"
end
puts

puts "Partially supported (#{partially_supported.size}):"
partially_supported.each do |name, html, result|
  puts "  - #{name}: #{result}"
end
puts

puts "Missing (#{missing.size}):"
missing.each do |name, html, result|
  puts "  - #{name}"
end
puts

puts "=" * 80
puts "RECOMMENDATIONS"
puts "=" * 80
puts

if missing.empty? && partially_supported.empty?
  puts "✅ All tested HTML elements are well supported!"
else
  puts "Consider adding support for:"
  missing.each do |name, html, result|
    puts "  - #{name}: #{html}"
  end
  puts
  puts "Consider improving support for:"
  partially_supported.each do |name, html, result|
    puts "  - #{name}: #{html}"
  end
end
