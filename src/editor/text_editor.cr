module Editor
  alias TextRange = {TextIter, TextIter}

  class TextEditor
    enum BackgroundPattern
      None
      Grid
    end

    enum WrapMode
      None
      Char
      Word
      WordChar
    end
  end

  module TextBufferListener
    abstract def text_buffer_cursor_changed
    abstract def text_buffer_text_inserted(iter : TextIter, value : String)
    abstract def text_buffer_text_deleted(start_iter : TextIter, end_iter : TextIter)
    abstract def text_buffer_modified_changed
  end

  class TextBuffer
    observable_by TextBufferListener

    def search_context : SearchContext
      @search_context ||= Editor::SearchContext.new(self)
    end
  end
end

{% if !flag?(:cimento) %}
  require "./text_editor_gsv"
{% else %}
  require "../cimento/text_editor"
{% end %}
