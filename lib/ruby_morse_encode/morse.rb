module RubyMorseEncode
  class Morse
    def initialize(letter)
      @letter = letter
    end

    def call
      MAPPING[@letter.upcase]
    end

    RULES = IO.read(File.expand_path('rules', __dir__)).freeze
    MAPPING = Hash[RULES.strip.lines.map {|x| x.split(' ')}].freeze
  end
end
