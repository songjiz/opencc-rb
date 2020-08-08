require "opencc/version"
require "opencc/opencc"
require "opencc/converter"

module OpenCC
  class << self
    def with(cfg = nil, &block)
      Converter.with cfg, &block
    end
  end
end
