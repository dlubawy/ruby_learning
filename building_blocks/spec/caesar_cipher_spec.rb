require 'spec_helper'

describe "caesar_cipher" do
  it "shifts input by a given factor" do
    expect(caesar_cipher("caesar", 3)).to eq("fdhvdu")
  end

  it "handles shift over 26" do
    expect(caesar_cipher("caesar", 264)).to eq("geiwev")
  end

  it "handles below negative 26" do
    expect(caesar_cipher("caesar", -30)).to eq("ywaown")
  end

  it "keeps capitalized letters" do
    expect(caesar_cipher("CaESar", 3)).to eq("FdHVdu")
  end

  it "keeps punctuation" do
    expect(caesar_cipher("Hello!", 3)).to eq("Khoor!")
  end

  it "handles more than one word" do
    expect(caesar_cipher("Hello World!", 3)).to eq("Khoor Zruog!")
  end
end
