module RubyMorseEncode
  class Tokenizer
    def initialize(input)
      @input = input
    end

    def call
      Ast.new(@input.lines.map do |line|
        Line.new(line.split(' ').map do |word|
          letters = word.split('')
          tokenized_letters = letters.map { |letter| Letter.new(letter) }
          Word.new(tokenized_letters)
        end)
      end)
    end

    class Ast < Struct.new(:lines)
      def visit(&block)
        self.class.new(lines.map { |w| w.visit(&block) })
      end

      def to_s
        lines.map(&:to_s).join("\n")
      end
    end

    class Line < Struct.new(:words)
      def visit(&block)
        self.class.new(words.map { |l| l.visit(&block) })
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
  end
end
