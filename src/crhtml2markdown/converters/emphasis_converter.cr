module Crhtml2markdown
  class EmphasisConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "em" || node.name == "strong" || node.name == "b" || node.name == "i"
    end

    def convert(node : XML::Node, io : IO) : Nil
      is_bold = node.name == "strong" || node.name == "b"

      # Get the content to check for special characters
      content = String.build do |inner|
        node.children.each { |child| Crhtml2markdown.convert_node(child, inner) }
      end

      # Determine which delimiter to use based on content and context
      marker = choose_delimiter(is_bold, content, node)

      io << marker
      io << content
      io << marker
    end

    private def choose_delimiter(is_bold : Bool, content : String, node : XML::Node) : String
      default_marker = is_bold ? "**" : "*"
      alt_marker = is_bold ? "__" : "_"

      # Use alternate markers if previous sibling is also emphasis
      prev = node.previous_sibling
      if prev && !prev.text? && emphasis_element?(prev)
        return alt_marker
      end

      # Use alternate marker if content contains the default delimiter
      if is_bold
        # For bold: use __ if content contains **
        return alt_marker if content.includes?("**")
      else
        # For italic: use _ if content contains *
        return alt_marker if content.includes?("*")
      end

      default_marker
    end

    private def emphasis_element?(node : XML::Node) : Bool
      {"em", "strong", "b", "i"}.includes?(node.name)
    end
  end
end
