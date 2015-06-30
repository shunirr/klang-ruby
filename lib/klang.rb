require "klang/version"
require 'unicode'

module Klang
  class Klang
    CONSONANT = {
      Unicode::nfkd('ㄱ') => 'g',
      Unicode::nfkd('ㄴ') => 'n',
      Unicode::nfkd('ㄷ') => 'd',
      Unicode::nfkd('ㄹ') => 'r',
      Unicode::nfkd('ㅁ') => 'm',
      Unicode::nfkd('ㅂ') => 'b',
      Unicode::nfkd('ㅅ') => 's',
      Unicode::nfkd('ㅇ') => '',
      Unicode::nfkd('ㅈ') => 'j',
      Unicode::nfkd('ㅊ') => 'ch',
      Unicode::nfkd('ㅋ') => 'k',
      Unicode::nfkd('ㅌ') => 't',
      Unicode::nfkd('ㅍ') => 'p',
      Unicode::nfkd('ㅎ') => 'h',
      Unicode::nfkd('ㄲ') => 'kk',
      Unicode::nfkd('ㄸ') => 'tt',
      Unicode::nfkd('ㅃ') => 'pp',
      Unicode::nfkd('ㅆ') => 'ss',
      Unicode::nfkd('ㅉ') => 'jj',
      Unicode::nfkd('ㅘ') => 'wa',
      Unicode::nfkd('ㅙ') => 'wae',
      Unicode::nfkd('ㅚ') => 'oe',
      Unicode::nfkd('ㅝ') => 'wo',
      Unicode::nfkd('ㅞ') => 'we',
      Unicode::nfkd('ㅟ') => 'wi',
      Unicode::nfkd('ㅢ') => 'ui',
    }
    VOWEL = {
      Unicode::nfkd('ㅏ') => 'a',
      Unicode::nfkd('ㅑ') => 'ya',
      Unicode::nfkd('ㅓ') => 'eo',
      Unicode::nfkd('ㅕ') => 'yeo',
      Unicode::nfkd('ㅗ') => 'o',
      Unicode::nfkd('ㅛ') => 'yo',
      Unicode::nfkd('ㅜ') => 'u',
      Unicode::nfkd('ㅠ') => 'yu',
      Unicode::nfkd('ㅡ') => 'eu',
      Unicode::nfkd('ㅣ') => 'i',
      Unicode::nfkd('ㅐ') => 'ae',
      Unicode::nfkd('ㅒ') => 'yae',
      Unicode::nfkd('ㅔ') => 'e',
      Unicode::nfkd('ㅖ') => 'ye',
    }
    PATCHIM = {
      Unicode::nfkd('ㄱ') => 'k',
      Unicode::nfkd('ㄷ') => 't',
      Unicode::nfkd('ㅂ') => 'p',
      Unicode::nfkd('ㅇ') => 'ng',
    }
  
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
        unless hangul?(c)
          alpha << c
          next
        end
        consonant, vowel, patchim1, patchim2 = Unicode::nfkd(c).chars
        alpha << CONSONANT[consonant] if consonant
        alpha << VOWEL[vowel] if vowel
        alpha << PATCHIM[patchim1] || CONSONANT[patchim1] if patchim1
        alpha << PATCHIM[patchim2] || CONSONANT[patchim2] if patchim2
      end
      @alphabet = alpha.join
    end
  
    def hangul?(char)
      o = char.ord
      ((o >= 0x1100 && o <= 0x11FF) ||
        (o >= 0xA960 && o <= 0xA97F) ||
        (o >= 0xD7B0 && o <= 0xD7FF) ||
        (o >= 0x3130 && o <= 0x318F) ||
        (o >= 0xAC00 && o <= 0xD7AF))
    end
  end
end
