require "./search_context_gsv"

module Editor
class TextBuffer
  @buffer : GtkSource::Buffer

  def initialize(@buffer : GtkSource::Buffer)
    @buffer.style_scheme = GtkSource::StyleSchemeManager.default.scheme("monokai")

    @buffer.connect("notify::cursor-position") { notify_text_buffer_cursor_changed }
    @buffer.after_insert_text(&->text_inserted(Gtk::TextBuffer, Gtk::TextIter, String, Int32))
    @buffer.after_delete_range(&->text_deleted(Gtk::TextBuffer, Gtk::TextIter, Gtk::TextIter))
    @buffer.on_modified_changed { notify_text_buffer_modified_changed }
  end

  private def text_inserted(_buffer, iter, text, _text_size)
    notify_text_buffer_text_inserted(iter, text)
  end

  private def text_deleted(_buffer, start_iter, end_iter)
    notify_text_buffer_text_deleted(start_iter, end_iter)
  end

  def gobject
    @buffer
  end

  delegate iter_at_line, to: @buffer
  delegate iter_at_offset, to: @buffer

  def iter_at(line : Int32, col : Int32) : TextIter
    @buffer.iter_at_line_offset(line, col)
  end

  def iter_at_cursor : TextIter
    @buffer.iter_at_offset(@buffer.cursor_position)
  end

  delegate place_cursor, to: @buffer
  delegate select_range, to: @buffer
  delegate select_lines, to: @buffer
  delegate delete, to: @buffer
  delegate lines, to: @buffer

  delegate create_mark, to: @buffer
  delegate mark, to: @buffer
  delegate move_mark, to: @buffer
  delegate iter_at_mark, to: @buffer

  def move_mark(name : String, iter)
    @buffer.move_mark_by_name(name, iter)
  end

  delegate :text=, to: @buffer
  delegate :modified=, to: @buffer

  def text : String
    @buffer.text(@buffer.start_iter, @buffer.end_iter, false)
  end

  def save(file_path : Path, remove_trailing_spaces : Bool)
    remove_all_trailing_spaces! if remove_trailing_spaces
    File.write(file_path, text)
    @buffer.modified = false
  end

  def remove_all_trailing_spaces!
    original_text = self.text
    start_iter = Gtk::TextIter.new
    end_iter = Gtk::TextIter.new

    user_action do
      original_text.split("\n").each_with_index do |line, line_index|
        next if line.empty? || !line[-1].whitespace?

        match = line.match(/([ \t]+)\r?\z/)
        next if match.nil?

        @buffer.iter_at_line_offset(start_iter, line_index, match.begin(1).not_nil!)
        @buffer.iter_at_line_offset(end_iter, line_index, match.end(1).not_nil!)
        @buffer.delete(start_iter, end_iter)
      end
    end
  end

  delegate selection_bounds, to: @buffer
  delegate insert, to: @buffer

  def selected_text : String
    return "" unless has_selection?

    start_iter, end_iter = @buffer.selection_bounds
    @buffer.text(start_iter, end_iter, false)
  end

  def replace(range : TextRange, replacement : String)
    @buffer.begin_user_action
    @buffer.delete_interactive(*range, true)
    @buffer.insert_interactive(range[0], replacement, replacement.bytesize, true)
    @buffer.end_user_action
  end

  def sort_lines(start_iter, end_iter)
    @buffer.sort_lines(start_iter, end_iter, :case_sensitive, 0)
  end

  def language=(language : Language)
    @buffer.language = language.gtk_language
  end

  def modified? : Bool
    @buffer.modified
  end

  def user_action
    @buffer.begin_user_action
    yield
  ensure
    @buffer.end_user_action
  end

  def not_undoable_action
    @buffer.begin_not_undoable_action
    yield
  ensure
    @buffer.end_not_undoable_action
  end

  def has_selection? : Bool
    @buffer.has_selection
  end
end
end