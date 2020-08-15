module OpenCC
  class Converter
    SUPPORTED_CFGS = %w[ s2t t2s s2tw tw2s s2hk hk2s s2twp tw2sp t2tw hk2t t2hk t2jp jp2t tw2t ]
    DEFAULT_CFG = 's2t'

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
      @config = (config || DEFAULT_CFG).to_s

      if !SUPPORTED_CFGS.include?(@config)
        raise ArgumentError, "`#{@config}` config file name not supported, have to be one of #{SUPPORTED_CFGS}"
      end

      @closed = false
      @mutex  = Mutex.new
    end

    def convert(input)
      synchronize do
        return if closed?
        
        @occid ||= opencc_open(config_file_name)

        if occid
          opencc_convert(occid, input)
        end
      end
    end

    # It will raise an +RuntimeError+ exception if can not make an instance of OpenCC.
    def convert!(input)
      synchronize do
        return if closed?
        
        @occid ||= opencc_open(config_file_name)
        
        if occid.nil?
          raise RuntimeError, "Can not make an instance of OpenCC with configuration file #{config_file_name}"
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
