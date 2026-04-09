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
      index = if ordered && (start = node["start"]?)
                start.to_i? || 1
              else
                1
              end
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
      indent = "    " * (depth + 1)

      # Collect paragraphs and other block children
      paragraphs = [] of String
      buffer = IO::Memory.new
      has_sublists = false

      node.children.each do |child|
        if child.name == "ul" || child.name == "ol"
          # Flush buffer as a paragraph
          text = buffer.to_s.strip
          paragraphs << text unless text.empty?
          buffer.clear

          # Write paragraphs collected so far
          paragraphs.each_with_index do |para, i|
            if i == 0
              io << para
            else
              io << "\n\n" << indent << para
            end
          end
          paragraphs.clear

          io << "\n"
          convert_list(child, io, depth + 1)
          ends_with_sublist = true
          has_sublists = true
        elsif child.name == "p"
          # Flush any non-paragraph buffer content first
          text = buffer.to_s.strip
          paragraphs << text unless text.empty?
          buffer.clear

          # Convert paragraph content (without the trailing \n\n from ParagraphConverter)
          para_text = String.build do |inner|
            child.children.each { |c| Crhtml2markdown.convert_node(c, inner) }
          end.strip
          paragraphs << para_text unless para_text.empty?
        else
          Crhtml2markdown.convert_node(child, buffer)
          unless child.text? && child.content.strip.empty?
            ends_with_sublist = false
          end
        end
      end

      # Flush remaining buffer
      text = buffer.to_s.strip
      paragraphs << text unless text.empty?

      # Write remaining paragraphs
      unless has_sublists && paragraphs.empty?
        paragraphs.each_with_index do |para, i|
          if i == 0
            io << para
          else
            io << "\n\n" << indent << para
          end
        end
      end

      ends_with_sublist
    end
  end
end
