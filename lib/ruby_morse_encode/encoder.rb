module RubyMorseEncode
  class Encoder
    def initialize(input, encoders: [])
      @input = input
      @encoders = encoders
    end

    def call
      ast = tokenize(@input)
      result = @encoders.reduce(ast) do |prev_ast, encoder|
        klass = get_encoder_klass(encoder)
        prev_ast.visit { |letter| klass.new(letter).() }
      end
      result.to_s
    end

    private

    def get_encoder_klass(name)
      { morse: Morse }.fetch(name)
    end

    class Ast < Struct.new(:words)
      def visit(&block)
        self.class.new(words.map { |w| w.visit(&block) })
      end

      def to_s
        words.map(&:to_s).join('/')
      end
    end

    class Word < Struct.new(:letters)
      def visit(&block)
        self.class.new(letters.map { |l| l.visit(&block) })
      end

      def to_s
        letters.map(&:to_s).join('|')
      end
    end

    class Letter < Struct.new(:letter)
      def visit(&block)
        self.class.new(yield(letter))
      end

      def to_s
        letter.to_s
      end
    end

    def tokenize(input)
      Ast.new(input.split(' ').map do |word| 
        letters = word.split('')
        tokenized_letters = letters.map { |letter| Letter.new(letter) }
        Word.new(tokenized_letters)
      end)
    end
  end
end
