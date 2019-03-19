module Klang
  class Hangul
    INCLUDING_ALPHABETS = [
      "g", "k", "n", "d", "t",
      "r", "m", "b", "p", "s",
      "j", "c", "h", "a", "e",
      "y", "o", "w", "u", "i"
    ]

    CONSONANT = {
      0x1100 => 'g',   # ㄱ
      0x1101 => 'kk',  # ㄲ
      0x1102 => 'n',   # ㄴ
      0x1103 => 'd',   # ㄷ
      0x1104 => 'tt',  # ㄸ
      0x1105 => 'r',   # ㄹ
      0x1106 => 'm',   # ㅁ
      0x1107 => 'b',   # ㅂ
      0x1108 => 'pp',  # ㅃ
      0x1109 => 's',   # ㅅ
      0x110A => 'ss',  # ㅆ
      0x110B => '',    # ㅇ
      0x110C => 'j',   # ㅈ
      0x110D => 'jj',  # ㅉ
      0x110E => 'ch',  # ㅊ
      0x110F => 'k',   # ㅋ
      0x1110 => 't',   # ㅌ
      0x1111 => 'p',   # ㅍ
      0x1112 => 'h',   # ㅎ
    }
    VOWEL = {
      0x1161 => 'a',   # ㅏ
      0x1162 => 'ae',  # ㅐ
      0x1163 => 'ya',  # ㅑ
      0x1164 => 'yae', # ㅒ
      0x1165 => 'eo',  # ㅓ
      0x1166 => 'e',   # ㅔ
      0x1167 => 'yeo', # ㅕ
      0x1168 => 'ye',  # ㅖ
      0x1169 => 'o',   # ㅗ
      0x116A => 'wa',  # ㅘ
      0x116B => 'wae', # ㅙ
      0x116C => 'oe',  # ㅚ
      0x116D => 'yo',  # ㅛ
      0x116E => 'u',   # ㅜ
      0x116F => 'wo',  # ㅝ
      0x1170 => 'we',  # ㅞ
      0x1171 => 'wi',  # ㅟ
      0x1172 => 'yu',  # ㅠ
      0x1173 => 'eu',  # ㅡ
      0x1174 => 'ui',  # ㅢ
      0x1175 => 'i',   # ㅣ
    }
    PATCHIM = {
      0x11A8 => 'k',   # ㄱ
      0x11A9 => 'kk',  # ㄲ
      0x11AA => 'k',   # ㄳ
      0x11AB => 'n',   # ㄴ
      0x11AC => 'n',   # ㄵ
      0x11AD => 'n',   # ㄶ
      0x11AE => 't',   # ㄷ
      0x11AF => 'r',   # ㄹ
      0x11B0 => 'r',   # ㄺ
      0x11B1 => 'm',   # ㄻ
      0x11B2 => 'r',   # ㄼ
      0x11B3 => 'r',   # ㄽ
      0x11B4 => 'r',   # ㄾ
      0x11B5 => 'p',   # ㄿ
      0x11B6 => 'r',   # ㅀ
      0x11B7 => 'm',   # ㅁ
      0x11B8 => 'p',   # ㅂ
      0x11B9 => 'p',   # ㅄ
      0x11BA => 's',   # ㅅ
      0x11BB => 'ss',  # ㅆ
      0x11BC => 'ng',  # ㅇ
      0x11BD => 'j',   # ㅈ
      0x11BE => 'ch',  # ㅊ
      0x11BF => 'k',   # ㅋ
      0x11C0 => 't',   # ㅌ
      0x11C1 => 'p',   # ㅍ
      0x11C2 => 'h',   # ㅎ
    }
  
    def self.hangul?(char)
      o = char.ord
      ((o >= 0x1100 && o <= 0x11FF) ||
        (o >= 0xA960 && o <= 0xA97F) ||
        (o >= 0xD7B0 && o <= 0xD7FF) ||
        (o >= 0x3130 && o <= 0x318F) ||
        (o >= 0xAC00 && o <= 0xD7AF))
    end

    def self.consonant?(str)
      CONSONANT.value? str
    end

    def self.consonant(str)
      CONSONANT.key str
    end

    def self.vowel?(str)
      VOWEL.value? str
    end

    def self.vowel(str)
      VOWEL.key str
    end

    def self.patchim?(str)
      PATCHIM.value? str
    end

    def self.patchim(str)
      PATCHIM.key str
    end
  end
end
