module OpenCC
  class Converter
    include OpenCC::Mixin

    class << self
      def with(config, &block)
        converter = new(config)
        if block.arity == 0
          converter.instance_eval(&block)
        else
          yield converter
        end
      ensure
        converter.close
      end
    end
    
    attr_reader :config

    # *<tt>:config</tt> - The config file name without .json suffix, default "s2t"
    def initialize(config = nil)
      @config = (config || OpenCC::DEFAULT_CONFIG).to_s

      if !OpenCC::CONFIGS.include?(@config)
        raise ArgumentError, "Unsupported configuration name #{@config.inspect}, expected one of #{OpenCC::CONFIGS.join(', ')}"
      end

      @mutex  = Mutex.new
      @closed = false
    end

    def convert(input)
      synchronize do
        return if closed?
        
        @__opencc__ ||= opencc_open(config_file_name)
        
        if @__opencc__.nil?
          raise RuntimeError, "OpenCC failed to load (#{config_file_name})"
        end
        
        opencc_convert(@__opencc__, input.force_encoding(Encoding::UTF_8))
      end
    end

    def close
      synchronize do
        return false if closed?
        return false if @__opencc__.nil?
        return false if !opencc_close(@__opencc__)

        @__opencc__ = nil
        @closed = true
      end
    end

    def closed?
      @closed
    end

    private
      def synchronize(&block)
        @mutex.synchronize(&block)
      end

      def config_file_name
        "#{@config}.json"
      end
  end
end
