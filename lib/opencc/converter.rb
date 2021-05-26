module OpenCC
  class Converter
    include OpenCC::Context

    class << self
      # The converter will automatically be closed when the block terminates.
      def with(config = nil)
        converter = new(config)
        yield converter
      ensure
        converter.close
      end

      alias :[] :new
    end
    
    attr_reader :config, :occid

    # *<tt>:config</tt> - The config file name without .json suffix, default "s2t"
    def initialize(config = nil)
      @config = (config || OpenCC::DEFAULT_CFG).to_s

      if !SUPPORTED_CFGS.include?(@config)
        raise ArgumentError, "Unsupported configuration name #{@config.inspect}, expected one of #{OpenCC::SUPPORTED_CFGS.join(', ')}"
      end

      @closed = false
      @mutex  = Mutex.new
    end

    def convert(input)
      synchronize do
        return if closed?
        
        @occid ||= opencc_open(config_file_name)
        
        if occid.nil?
          raise RuntimeError, "OpenCC open failed with #{config_file_name}"
        end
        
        opencc_convert(occid, input)
      end
    end

    # Destroys the instance of opencc.
    def close
      synchronize do
        return false if closed?
        return false if occid.nil?
        
        if opencc_close(occid)
          @occid = nil
          @closed = true
        end
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
