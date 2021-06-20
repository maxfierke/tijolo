require "./text_buffer"
require "./search_context"


# We need to keep this on Editor module while GtkSourceView still supported.
module Editor
  struct TextIter
    getter line = 0
    getter col = 0
    getter offset = 0

    def backward_char
    end
  end

  class TextEditor
    getter buffer : TextBuffer
    getter widget : Gtk::Widget

    property? readonly = true
    getter? focus = false

    property wrap_mode = WrapMode::None
    property show_line_numbers = false
    property tab_width = 2
    property insert_spaces_instead_of_tabs = false
    property show_right_margin = false
    property right_margin_position = 125
    property highlight_current_line = false
    property background_pattern = BackgroundPattern::None
    property font_size = 14


    def initialize
      @buffer = TextBuffer.new
      @widget = Gtk::DrawingArea.new
      @font_desc = Pango.font_description_from_string("JetBrainsMono Nerd Font")

      # @widget.on_draw(&->render(Gtk::Widget, Cairo::Context))
    end

    def finalize
      LibC.printf("destroying editor")
    end

    def scroll_to(iter : TextIter) : Nil
    end

    private def render(_widget, cr)
      rgba = Gdk::RGBA.new(0.3, 0.6, 0.7, 1.0)

      Gdk.cairo_set_source_rgba(cr, rgba)
      layout = PangoCairo.create_layout(cr)
      layout.set_text(@buffer.text, @buffer.text.bytesize)
      layout.font_description = @font_desc

      PangoCairo.update_layout(cr, layout)
      PangoCairo.show_layout(cr, layout)

      true
    end
  end
end
