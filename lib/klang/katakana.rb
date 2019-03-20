require 'unicode'
require 'romaji'

module Klang
  class Katakana
    def initialize(str)
      @raw = str
    end

    def to_hangul
      to_alphabet.map {|a| Alphabet.new(a).to_hangul }
    end

    def to_alphabet
      convert_romaji @raw
    end

    private
    def self.useful_romaji(romaji_list)
      romaji_list.select do |romaji|
        useful = true
        romaji.each_char do |c|
          unless Hangul::INCLUDING_ALPHABETS.include? c
            useful = false
            break
          end
        end
        useful
      end
    end

    def convert_romaji(text)
      text = Romaji.hira2kata(Romaji.normalize(text))
      convert_n(text).flatten.map do |t|
        Katakana.kana2romaji t
      end
    end

    def convert_n(text)
      unless text.include? 'ン'
        return text
      end
      return [convert_n(text.sub(/ン/, 'n')), convert_n(text.sub(/ン/, 'ng'))]
    end

    # From https://github.com/makimoto/romaji/blob/master/lib/romaji.rb
    def self.kana2romaji(text)
      pos = 0
      k = nil
      romaji = ''
      chars = text.split(//u)
      while true
        # ッ
        if chars[pos] == 'ッ'
          next_char_romaji = useful_romaji(Romaji::KANA2ROMAJI[chars[pos + 1]])
          romaji += (next_char_romaji[0].slice(0, 1))
          pos += 1
          next
        end

        Romaji::ROMAJI_MAX_LENGTH.downto(1) do |t|
          substr = chars.slice(pos, t).join
          k = Romaji::KANA2ROMAJI[substr]
          if k
            romaji += useful_romaji(k)[0]
            pos += t
            break
          end
        end
        unless k
          romaji += chars.slice(pos, 1).join
          pos += 1
        end
        break if pos >= chars.size
      end
      romaji
    end
  end
end
