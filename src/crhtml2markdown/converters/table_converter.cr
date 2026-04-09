module Crhtml2markdown
  class TableConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "table"
    end

    def convert(node : XML::Node, io : IO) : Nil
      rows = collect_rows(node)
      return if rows.empty?

      alignments = collect_alignments(node)
      widths = column_widths(rows)

      rows.each_with_index do |row, idx|
        io << "| "
        row.each_with_index do |cell, col|
          io << cell.ljust(widths[col]) << " | "
        end
        io << "\n"

        if idx == 0
          io << "| "
          widths.each_with_index do |w, col|
            align = alignments[col]? || "left"
            case align
            when "center"
              io << ":" << "-" * (w - 2) << ":" << " | "
            when "right"
              io << "-" * (w - 1) << ":" << " | "
            else
              io << "-" * w << " | "
            end
          end
          io << "\n"
        end
      end
      io << "\n"
    end

    private def collect_rows(table : XML::Node) : Array(Array(String))
      rows = [] of Array(String)
      table.children.each do |child|
        case child.name
        when "thead", "tbody", "tfoot"
          child.children.each do |tr|
            rows << collect_cells(tr) if tr.name == "tr"
          end
        when "tr"
          rows << collect_cells(child)
        end
      end
      rows
    end

    private def collect_cells(tr : XML::Node) : Array(String)
      cells = [] of String
      tr.children.each do |td|
        next unless td.name == "td" || td.name == "th"
        text = String.build do |inner|
          td.children.each { |child| Crhtml2markdown.convert_node(child, inner) }
        end.strip
        cells << text
      end
      cells
    end

    private def collect_alignments(table : XML::Node) : Array(String)
      alignments = [] of String
      # Look for alignment in the first row (thead > tr > th/td)
      table.children.each do |child|
        row = nil
        case child.name
        when "thead"
          child.children.each do |tr|
            if tr.name == "tr"
              row = tr
              break
            end
          end
        when "tr"
          row = child
        end
        if row
          row.children.each do |cell|
            next unless cell.name == "th" || cell.name == "td"
            alignments << (cell["align"]? || "left")
          end
          break
        end
      end
      alignments
    end

    private def column_widths(rows : Array(Array(String))) : Array(Int32)
      max_cols = rows.max_of(&.size)
      widths = Array.new(max_cols, 3) # minimum width of 3 for "---"
      rows.each do |row|
        row.each_with_index do |cell, col|
          widths[col] = {widths[col], cell.size}.max
        end
      end
      widths
    end
  end
end
