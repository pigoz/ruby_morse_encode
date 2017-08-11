require "spec_helper"

RSpec.describe "bin/encode" do
  # not portable, hopefully no one uses windows

  it 'is wired correctly to argv[0]' do
    expect(`bin/encode hello`.chomp).to eql('4|1|1A2|1A2|C')
  end

  it 'is wired correctly to stdin' do
    expect(`echo 'hello' | bin/encode --stdin`.chomp).to eql('4|1|1A2|1A2|C')
  end
end

