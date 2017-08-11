require "spec_helper"

RSpec.describe RubyMorseEncode do
  it "has a version number" do
    expect(RubyMorseEncode::VERSION).not_to be nil
  end

  let(:command) { RubyMorseEncode::Encoder }

  it "tokenizes input" do
    expect(command.new('I AM IN TROUBLE').()).to eql('I/A|M/I|N/T|R|O|U|B|L|E')
  end

  it 'converts to morse' do
    subject = command.new('I AM IN TROUBLE', processor: :morse)
    expect(subject.()).to eql('../.-|--/..|-./-|.-.|---|..-|-...|.-..|.')
  end

  it 'convers to morse when using .' do
    subject = command.new('I.', processor: :morse)
    expect(subject.()).to eql('..|.-.-.-')
  end

  it 'convers to obfuscated morse' do
    subject = command.new('I AM IN TROUBLE', processor: :obfuscate)
    expect(subject.()).to eql('2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1')
  end

  it 'convers to obfuscated morse when using .' do
    subject = command.new('I.', processor: :obfuscate)
    expect(subject.()).to eql('2|1A1A1A')
  end

end
