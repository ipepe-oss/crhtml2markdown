module Crhtml2markdown
  INLINE_ELEMENTS = Set{"p", "a", "em", "strong", "code", "span", "td", "th", "h1", "h2", "h3", "h4", "h5", "h6"}

  class TextConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.text?
    end

    def convert(node : XML::Node, io : IO) : Nil
      text = node.content
      return if text.strip.empty? && !inline_context?(node)
      if text.strip.empty? && text.includes?("\n")
        # In inline context, preserve a single space between siblings
        io << " " if inline_context?(node) && has_adjacent_siblings?(node)
      else
        io << text
      end
    end

    private def has_adjacent_siblings?(node : XML::Node) : Bool
      !!(node.previous_sibling && node.next_sibling)
    end

    private def inline_context?(node : XML::Node) : Bool
      parent = node.parent
      return false unless parent
      INLINE_ELEMENTS.includes?(parent.name)
    end
  end
end
