module RubyMorseEncode
  class Encoder
    def initialize(input, pipeline: :empty)
      @input = input
      @pipeline = pipeline
    end

    PIPELINES = {
      empty: [],
      morse: [Morse],
      obfuscate: [Morse, Obfuscate],
    }.freeze

    def call
      ast = Tokenizer.new(@input).()
      transformers = fetch_transformers(@pipeline)
      result = transformers.reduce(ast) do |prev_ast, transformer_klass|
        prev_ast.visit { |letter| transformer_klass.new(letter).() }
      end
      result.to_s
    end

    private

    def fetch_transformers(pipeline)
      PIPELINES.fetch(pipeline)
    end
  end
end
