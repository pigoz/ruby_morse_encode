require "spec_helper"

RSpec.describe RubyMorseEncode do
  it "has a version number" do
    expect(RubyMorseEncode::VERSION).not_to be nil
  end

  let(:command) { RubyMorseEncode::Encoder }
  let(:hello) { 'HELLO' }
  let(:trouble) { 'I AM IN TROUBLE' }
  let(:multiline) { [hello, trouble].join("\n") }

  it "tokenizes input" do
    expect(command.new(trouble).()).to eql('I/A|M/I|N/T|R|O|U|B|L|E')
  end

  it 'converts to morse' do
    subject = command.new(trouble, processor: :morse)
    expect(subject.()).to eql('../.-|--/..|-./-|.-.|---|..-|-...|.-..|.')
  end

  it 'converts to morse when using .' do
    subject = command.new('I.', processor: :morse)
    expect(subject.()).to eql('..|.-.-.-')
  end

  it 'converts multiline input to morse' do
    subject = command.new(multiline, processor: :morse)
    expect(subject.()).to eql("....|.|.-..|.-..|---\n../.-|--/..|-./-|.-.|---|..-|-...|.-..|.")
  end

  it 'converts to obfuscated morse' do
    subject = command.new(trouble, processor: :obfuscate)
    expect(subject.()).to eql('2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1')
  end

  it 'converts to obfuscated morse when using .' do
    subject = command.new('I.', processor: :obfuscate)
    expect(subject.()).to eql('2|1A1A1A')
  end

  it 'converts multiline input to obfuscated morse' do
    subject = command.new(multiline, processor: :obfuscate)
    expect(subject.()).to eql("4|1|1A2|1A2|C\n2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1")
  end
end
