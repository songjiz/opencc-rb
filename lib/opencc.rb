require "opencc/version"
require "opencc/opencc"
require "opencc/converter"

module OpenCC
  class << self
    def with(config = nil, &block)
      Converter.with(config, &block)
    end

    def [](config)
      Converter[config]
    end
  end
end
