require "opencc/version"
require "opencc/opencc"
require "opencc/converter"

module OpenCC
  SUPPORTED_CFGS = %w[ s2t t2s s2tw tw2s s2hk hk2s s2twp tw2sp hk2t t2hk t2jp jp2t tw2t ]
  DEFAULT_CFG    = 's2t'

  class << self
    def with(config = nil, &block)
      Converter.with(config, &block)
    end

    def [](config)
      Converter[config]
    end

    SUPPORTED_CFGS.each do |config|
      define_method :"#{config}" do |input|
        with(config) do |converter|
          converter.convert(input)
        end
      end
    end
  end
end
