module RubyMorseEncode
  class Obfuscate
    def initialize(morse)
      @morse = morse
    end

    def call
      @morse
        .gsub(/\.+/) { |s| s.chars.count.to_s }
        .gsub(/-+/) { |s| LETTERS[s.chars.count - 1] }
    end

    RULES = IO.read(File.expand_path('rules', __dir__)).freeze
    LETTERS = RULES.strip.lines.map {|x| x.split(' ') }.map(&:first)
  end
end
