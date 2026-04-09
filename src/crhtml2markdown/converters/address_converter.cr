module Crhtml2markdown
  class AddressConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "address"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Convert address to a code block or preformatted text
      # to preserve the formatting
      content = String.build do |content_io|
        node.children.each { |child| Crhtml2markdown.convert_node(child, content_io) }
      end

      # Use a simple code block format
      io << "```\n" << content.strip << "\n```"
    end
  end
end
