require "option_parser"
require "../crhtml2markdown"

module Crhtml2markdown
  module CLI
    def self.run(args = ARGV)
      show_help = false

      parser = OptionParser.parse(args) do |p|
        p.banner = "Usage: crhtml2markdown [options] [file]"
        p.on("-h", "--help", "Show this help") { show_help = true }
      end

      if show_help
        puts parser
        return
      end

      filename = args.shift?
      html = if filename
               File.read(filename)
             else
               STDIN.gets_to_end
             end

      puts Crhtml2markdown.convert(html)
    end
  end
end

Crhtml2markdown::CLI.run
