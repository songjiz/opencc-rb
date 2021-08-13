require "opencc/version"
require "opencc/opencc"

module OpenCC
  CONFIGS = %w[ s2t t2s s2tw tw2s s2hk hk2s s2twp tw2sp hk2t t2hk t2jp jp2t tw2t ]

  class << self
    def with(config, &block)
      converter = Converter.new(config)
      
      begin
        if block.arity == 0
          converter.instance_eval(&block)
        else
          yield converter
        end
      ensure
        converter && converter.close
      end
    end

    CONFIGS.each do |config|
      define_method :"#{config}" do |input|
        begin
          converter = Converter.new(config)
          converter.convert(input)
        ensure
          converter && converter.close
        end
      end
    end
  end
end
