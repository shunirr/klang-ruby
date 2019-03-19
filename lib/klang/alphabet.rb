require 'unicode'

module Klang
  class Alphabet
    def initialize(str)
      @raw = str
      @hangul = nil
    end

    def to_hangul
      convert_hangul unless @hangul
      @hangul
    end

    private
    def convert_hangul
      hangul = []

      index = 0
      while index < @raw.length do
        start_index = index
        if Hangul.consonant? @raw[index..index+1]
          hangul << Hangul.consonant(@raw[index..index+1])
          index += 2
        elsif Hangul.consonant? @raw[index]
          hangul << Hangul.consonant(@raw[index])
          index += 1
        else
          hangul << Hangul.consonant('')
        end

        if Hangul.vowel? @raw[index..index+2]
          hangul << Hangul.vowel(@raw[index..index+2])
          index += 3 elsif Hangul.vowel? @raw[index..index+1]
          hangul << Hangul.vowel(@raw[index..index+1])
          index += 2
        elsif Hangul.vowel? @raw[index]
          hangul << Hangul.vowel(@raw[index])
          index += 1
        end

        if Hangul.patchim? @raw[index..index+1]
          unless next_vowel?(index+2)
            hangul << Hangul.patchim(@raw[index..index+1])
            index += 2
          end
        elsif Hangul.patchim? @raw[index]
          unless next_vowel?(index+1)
            hangul << Hangul.patchim(@raw[index])
            index += 1
          end
        end

        index += 1 if start_index == index
      end

      @hangul = Unicode.nfkc(hangul.map{|h| h.chr('UTF-8') }.join)
    end

    def next_vowel?(index)
      Hangul.vowel?(@raw[index]) && Hangul.vowel?(@raw[index..index+1])
    end
  end
end
