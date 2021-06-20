require "../language"

# Dummy class while syntax highlight library doesn't get ready.
class LanguageManager
  def find(id : String) : Language
    Language::NONE
  end

  def guess_language(file : Path) : Language
    Language::NONE
  end

  def start_languages_for(files : Enumerable(Path)) : Nil
  end

  def shutdown
  end
end
