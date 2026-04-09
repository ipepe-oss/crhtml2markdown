module Crhtml2markdown
  class InlineHtmlPassthroughConverter < ElementConverter
    PASSTHROUGH_TAGS = Set{
      "mark",     # Highlighted text
      "kbd",      # Keyboard input
      "ins",      # Inserted text
      "u",        # Underlined text
      "small",    # Small text
      "abbr",     # Abbreviation
      "cite",     # Citation
      "dfn",      # Definition term
      "bdo",      # Bi-directional override
      "bdi",      # Bi-directional isolation
      "wbr",      # Word break opportunity
      "ruby",     # Ruby annotation
      "rt",       # Ruby text
      "rp",       # Ruby parenthesis
      "data",     # Machine-readable data
      "time",     # Date/time
      "output",   # Output element
      "progress", # Progress bar
      "meter",    # Meter/gauge
      "acronym",  # Acronym (deprecated but still used)
    }

    def handles?(node : XML::Node) : Bool
      PASSTHROUGH_TAGS.includes?(node.name)
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << "<" << node.name
      node.attributes.each do |attr|
        io << " " << attr.name << "=\"" << attr.content << "\""
      end
      io << ">"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "</" << node.name << ">"
    end
  end
end
