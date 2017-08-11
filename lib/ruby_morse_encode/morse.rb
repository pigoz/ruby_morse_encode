module RubyMorseEncode
  class Morse
    def initialize(letter)
      @letter = letter
    end

    def call
      MAPPING.fetch(@letter.upcase) do
        raise ArgumentError, "invalid input '#{@letter}'"
      end
    end

    RULES = IO.read(File.expand_path('rules', __dir__)).freeze
    MAPPING = Hash[RULES.strip.lines.map {|x| x.split(' ')}].freeze
  end
end
