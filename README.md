# OpenCC [![Build Status](https://travis-ci.org/songjiz/opencc-rb.svg?branch=master)](https://travis-ci.org/songjiz/opencc-rb)

## Description

This gem is for conversions between Traditional Chinese, Simplified Chinese and Japanese Kanji (Shinjitai). It's builded on [OpenCC](https://github.com/BYVoid/OpenCC).

## Installation

You have to install OpenCC firstly.

MacOS:

```shell
brew install opencc
```

Debian/Ubuntu:

```shell
sudo apt install libopencc-dev
```
Archlinux:

```shell
sudo pacman -Sy opencc
```

Fedora:

```shell
sudo yum install opencc-devel
```

Or install from source code:

```shell
cd /usr/src
git clone https://github.com/BYVoid/OpenCC
cd OpenCC
git checkout ver.1.1.1
make PREFIX=/usr/local
sudo make install
```

Then add this line to your application's Gemfile:

```ruby
gem 'opencc-rb', git: 'https://github.com/songjiz/opencc-rb'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install opencc-rb
```

## Usage

```ruby
require 'opencc'

# Recommended.
# The converter will automatically be closed when the block terminates.
OpenCC.with(:s2t) do |ct|
  ct.convert("汉字") # => "漢字"
  ct.convert("曾经有一份真诚的爱情放在我面前，我没有珍惜，等我失去的时候我才后悔莫及。人事间最痛苦的事莫过于此。如果上天能够给我一个再来一次得机会，我会对那个女孩子说三个字，我爱你。如果非要在这份爱上加个期限，我希望是，一万年。") # => "曾經有一份真誠的愛情放在我面前，我沒有珍惜，等我失去的時候我才後悔莫及。人事間最痛苦的事莫過於此。如果上天能夠給我一個再來一次得機會，我會對那個女孩子說三個字，我愛你。如果非要在這份愛上加個期限，我希望是，一萬年。"
end

# Or
OpenCC.s2t("汉字") # => "漢字"
OpenCC.t2s("漢字") # => "汉字"
OpenCC.s2tw('着装污染虚伪发泄棱柱群众里面') # => "著裝汙染虛偽發洩稜柱群眾裡面"
OpenCC.tw2s("著裝汙染虛偽發洩稜柱群眾裡面") # => "着装污染虚伪发泄棱柱群众里面"
OpenCC.s2hk("虚伪叹息") # => "虛偽嘆息"
OpenCC.hk2s("虛偽嘆息") # => "虚伪叹息"
OpenCC.s2twp("海内存知己") # => "海內存知己"
OpenCC.tw2sp("海內存知己") # => "海内存知己"
OpenCC.hk2t("想到自己一緊張就口吃，我就沒胃口吃飯") # => "想到自己一緊張就口吃，我就沒胃口喫飯"
OpenCC.t2hk("想到自己一緊張就口吃，我就沒胃口喫飯") # => "想到自己一緊張就口吃，我就沒胃口吃飯"
OpenCC.t2jp("藝術 缺航 飲料罐") # => "芸術 欠航 飲料缶"
OpenCC.jp2t("芸術 欠航 飲料缶") # => "藝術 缺航 飲料罐"
OpenCC.tw2t("想到自己一緊張就口吃，我就沒胃口吃飯") # => "想到自己一緊張就口吃，我就沒胃口喫飯"

# Or
converter = OpenCC[:s2t]
converter.convert('汉字') # => '漢字'
converter.close # => true
converter.closed? # => true
converter.close # => false
converter.convert('汉字') # => nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/songjiz/opencc-rb.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
