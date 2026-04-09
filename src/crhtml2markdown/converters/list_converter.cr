module Crhtml2markdown
  class ListConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "ul" || node.name == "ol"
    end

    def convert(node : XML::Node, io : IO) : Nil
      convert_list(node, io, 0)
      # Add trailing newline only for top-level lists
      unless node.parent.try(&.name) == "li"
        io << "\n"
      end
    end

    private def convert_list(node : XML::Node, io : IO, depth : Int32)
      ordered = node.name == "ol"
      index = 1
      node.children.each do |child|
        next unless child.name == "li"
        indent = "    " * depth
        marker = ordered ? "#{index}." : "-"
        io << indent << marker << " "
        ends_with_sublist = convert_li_content(child, io, depth)
        io << "\n" unless ends_with_sublist
        index += 1
      end
    end

    private def convert_li_content(node : XML::Node, io : IO, depth : Int32) : Bool
      ends_with_sublist = false
      buffer = IO::Memory.new
      node.children.each do |child|
        if child.name == "ul" || child.name == "ol"
          io << buffer.to_s.rstrip
          buffer.clear
          io << "\n"
          convert_list(child, io, depth + 1)
          ends_with_sublist = true
        else
          Crhtml2markdown.convert_node(child, buffer)
          # Only reset ends_with_sublist if we got real content (not just whitespace)
          unless child.text? && child.content.strip.empty?
            ends_with_sublist = false
          end
        end
      end
      remaining = buffer.to_s
      io << remaining unless remaining.strip.empty?
      ends_with_sublist
    end
  end
end
