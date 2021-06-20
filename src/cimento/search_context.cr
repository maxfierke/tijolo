module Editor
  class SearchContext
    property highlight = false
    getter occurrences_count = 0
    getter error_message = "Not implemented"
    property regexp_enabled = false

    def initialize(_foo)
    end

    def find(text)
    end

    def find_next
    end

    def find_prev
    end

    def has_error?
      true
    end

    def on_find_finish
      yield
    end
  end
end
