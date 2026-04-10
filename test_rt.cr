#!/usr/bin/env crystal

require "./src/crhtml2markdown"

html = %(<ruby>Base<rt title='Has "quotes"'>ruby text</rt></ruby>)
puts "Input HTML: #{html}"
puts "Output markdown:"
puts Crhtml2markdown.convert(html)
