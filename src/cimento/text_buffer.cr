module Editor
  class TextBuffer
    property? modified = false
    property text = ""

    def iter_at(line : Int32, col : Int32) : TextIter
      TextIter.new
    end

    def iter_at_offset(offset : Int32) : TextIter
      TextIter.new
    end

    def iter_at_cursor(n = 0)
      TextIter.new
    end

    def place_cursor(iter : TextIter)
    end

    def save(file_path : Path, remove_trailing_spaces : Bool)
    end

    def user_action
      yield
    end

    def not_undoable_action
      yield
    end

    def has_selection?
      false
    end

    def selection_bounds : {TextIter,TextIter}
     {TextIter.new, TextIter.new}
    end

    def selected_text : String
      ""
    end

    def select_range(start_iter : TextIter, end_iter : TextIter)
    end

    def sort_lines(start_iter : TextIter, end_iter : TextIter)
    end

    def mark(name : String)
    end

    def create_mark(name, iter, _left_gravity)
    end

    def insert(iter : TextIter, value)
    end

    def language=(value)
    end
  end
end