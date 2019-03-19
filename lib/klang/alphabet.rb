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
        if Klang::CONSONANT.value? @raw[index..index+1]
          hangul << Klang::CONSONANT.key(@raw[index..index+1])
          index += 2
        elsif Klang::CONSONANT.value? @raw[index]
          hangul << Klang::CONSONANT.key(@raw[index])
          index += 1
        else
          hangul << Klang::CONSONANT.key('')
        end

        if Klang::VOWEL.value? @raw[index..index+2]
          hangul << Klang::VOWEL.key(@raw[index..index+2])
          index += 3
        elsif Klang::VOWEL.value? @raw[index..index+1]
          hangul << Klang::VOWEL.key(@raw[index..index+1])
          index += 2
        elsif Klang::VOWEL.value? @raw[index]
          hangul << Klang::VOWEL.key(@raw[index])
          index += 1
        end

        if Klang::PATCHIM.value? @raw[index..index+1]
          hangul << Klang::PATCHIM.key(@raw[index..index+1])
          index += 2
        elsif Klang::PATCHIM.value? @raw[index]
          hangul << Klang::PATCHIM.key(@raw[index])
          index += 1
        end

        index += 1 if start_index == index
      end

      # @raw.each_char do |c|
      #   consonant, vowel, patchim = Unicode::nfkd(c).chars
      #   alpha << CONSONANT[consonant.ord]                       if consonant
      #   alpha << VOWEL[vowel.ord]                               if vowel
      #   alpha << PATCHIM[patchim.ord] || CONSONANT[patchim.ord] if patchim
      # end
      @hangul = Unicode.nfkc(hangul.map{|h| h.chr('UTF-8') }.join)
    end
  end
end
