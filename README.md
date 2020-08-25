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
  ct.convert('汉字') # => '漢字'
end

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
