module Crhtml2markdown
  class SelectConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "select"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert select dropdown to a simple list representation
      # Since markdown doesn't have form elements, we show options as a list
      options = [] of String
      node.children.each do |child|
        if child.name == "option"
          option_text = String.build do |opt|
            child.children.each { |c| Crhtml2markdown.convert_node(c, opt) }
          end.strip
          # Indicate selected option
          if child["selected"]?
            options << "[#{option_text}]"
          else
            options << option_text
          end
        end
      end

      if options.size == 1
        io << options.first
      elsif options.size > 1
        io << options.join(" | ")
      end
    end
  end
end
