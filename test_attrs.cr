#!/usr/bin/env crystal

require "./src/crhtml2markdown"

html = %(<p><acronym title='Has "quotes"'>ABC</acronym></p>)
puts "Input HTML: #{html}"
puts "Output markdown: #{Crhtml2markdown.convert(html).inspect}"
