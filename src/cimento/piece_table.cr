require "./file_buffer"

module Cimento
  private class Node
    property buffer : Int32
    property start : Int32
    property length : Int32
    @buffer_line_starts : Int32

    def initialize(@buffer)
      @buffer_line_starts = 0
    end

    property line_starts
      @buffer.line_starts(@buffer_line_starts)
    end
  end

  class PieceTable
    @buffers : Array(Buffer)
    @root_node : Node?

    def initialize(path : Path)
      @buffers = [FileBuffer.new(path)] of Buffer
    end

    def insert(pos : Int32, text : Bytes)
      buffer = Buffer.new(text)
      @buffers << buffer
      root_node = @root_node

      if root_node.nil?
        @root_node = Node.new(buffers)
        return
      end
    ensure
    end

    def delete(pos, length)
    end

    def char(pos)
    end

    def line(n : Int32)
    end

    def line_count : Int32
      0
    end
  end
end

puts Cimento::PieceTable.new(Path.new(__FILE__))