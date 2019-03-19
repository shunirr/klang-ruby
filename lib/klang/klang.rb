require 'unicode'

module Klang
  class Klang
    def initialize(str)
      @raw = str
      @alphabet = nil
    end
  
    def to_alphabet
      parse_hangul unless @alphabet
      @alphabet
    end
  
    private
    def parse_hangul
      alpha = []
      @raw.each_char do |c|
        unless Hangul.hangul?(c)
          alpha << c
          next
        end
        consonant, vowel, patchim = Unicode::nfkd(c).chars
        alpha << Hangul::CONSONANT[consonant.ord]                               if consonant
        alpha << Hangul::VOWEL[vowel.ord]                                       if vowel
        alpha << Hangul::PATCHIM[patchim.ord] || Hangul::CONSONANT[patchim.ord] if patchim
      end
      @alphabet = alpha.join
    end
  end
end
