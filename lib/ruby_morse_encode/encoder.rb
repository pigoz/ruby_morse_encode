module RubyMorseEncode
  class Encoder
    def initialize(input, processor: :none)
      @input = input
      @processor = processor
    end

    def call
      ast = Tokenizer.new(@input).()
      encoders = get_encoders(@processor)
      result = encoders.reduce(ast) do |prev_ast, encoder_klass|
        prev_ast.visit { |letter| encoder_klass.new(letter).() }
      end
      result.to_s
    end

    private

    def get_encoders(name)
      {
        none: [],
        morse: [Morse],
        obfuscate: [Morse, Obfuscate],
      }.fetch(name)
    end
  end
end
