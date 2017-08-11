require "spec_helper"

RSpec.describe RubyMorseEncode do
  it "has a version number" do
    expect(RubyMorseEncode::VERSION).not_to be nil
  end

  let(:command) { RubyMorseEncode::Encoder }

  it "tokenizes input" do
    expect(command.new('I AM IN TROUBLE').()).to eql('I/A|M/I|N/T|R|O|U|B|L|E')
  end
end
