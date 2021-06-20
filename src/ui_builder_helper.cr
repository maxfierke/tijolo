module UiBuilderHelper
  macro builder_for(file)
    {% if flag?(:release) %}
    Gtk::Builder.new_from_string({{ read_file("#{__DIR__}/ui/" + file + ".glade") }}, -1)
    {% else %}
    dir = {{ __DIR__ }}
    Gtk::Builder.new_from_file("#{dir}/ui/" + {{ file }} + ".glade")
    {% end %}
  end

  protected def apply_css
    display = Gdk::Display.default
    css_provider = Gtk::CssProvider.new
    css_provider.load_from_data(application_css)
    Gtk::StyleContext.add_provider_for_display(display, css_provider, Gtk::STYLE_PROVIDER_PRIORITY_APPLICATION.to_u32)
  end

  private def application_css
    {% if flag?(:release) %}
      {{ read_file("#{__DIR__}/ui/application.css") }}.to_slice
    {% else %}
      File.read("#{__DIR__}/ui/application.css").to_slice
    {% end %}
  end
end
