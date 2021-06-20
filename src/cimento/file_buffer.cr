require "./char_reader"

module Cimento
  class Buffer
    @data : Bytes
    property line_starts : Array(Int32)

    def initialize(@data)
      @line_starts = Array.new(1, 0)

      reader = CharReader.new(@data)
      reader.each_with_index do |char, i|
        @line_starts << i if char == '\n'
      end
    end

    private def byte_at(i)
      @data.to_unsafe[i].to_u32
    end
  end

  # This class may be used in the future to load large files in chunks
  # to speed up load of really large files, for  now it's just a thin wrapper
  # that does nothing
  class FileBuffer < Buffer
    def initialize(path : Path)
      fp = File.open(path, "rb")
      data = Bytes.new(fp.size)
      fp.read(data)
      fp.close
      super(data)
    end
  end
end
