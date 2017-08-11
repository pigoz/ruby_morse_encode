module RubyMorseEncode
  class Encoder
    def initialize(input)
      @input = input
    end

    def call
      tokenize(@input).to_s
    end

    private

    class Ast < Struct.new(:words)
      def to_s
        words.map(&:to_s).join('/')
      end
    end

    class Word < Struct.new(:letters)
      def to_s
        letters.map(&:to_s).join('|')
      end
    end

    class Letter < Struct.new(:letter)
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
