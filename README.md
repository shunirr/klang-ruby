# Klang

Parse korean hangul language.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'klang'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install klang

## Usage

```ruby
word = '아'
Klang::Klang.new(word).to_alphabet # => a
```

```ruby
Klang::Klang.hangul? '아' # => true
Klang::Klang.hangul? 'あ' # => false
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/klang/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
