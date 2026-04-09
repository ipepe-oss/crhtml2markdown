module Crhtml2markdown
  class EmphasisConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "em" || node.name == "strong" || node.name == "b" || node.name == "i"
    end

    def convert(node : XML::Node, io : IO) : Nil
      is_bold = node.name == "strong" || node.name == "b"
      marker = is_bold ? "**" : "*"

      # Use alternate markers (_ or __) if previous sibling is also emphasis
      # to avoid ambiguous output like *one**two*
      prev = node.previous_sibling
      if prev && !prev.text? && emphasis_element?(prev)
        marker = is_bold ? "__" : "_"
      end

      io << marker
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << marker
    end

    private def emphasis_element?(node : XML::Node) : Bool
      {"em", "strong", "b", "i"}.includes?(node.name)
    end
  end
end
