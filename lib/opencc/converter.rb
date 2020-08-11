module OpenCC
  class Converter
    SUPPORTED_CFGS = %w[ s2t t2s s2tw tw2s s2hk hk2s s2twp tw2sp t2tw hk2t t2hk t2jp jp2t tw2t ]
    DEFAULT_CFG = 's2t'

    include OpenCC::Context

    class << self
      def with(cfg = nil)
        converter = new(cfg)
        yield converter
      ensure
        converter.close
      end

      alias :[] :new
    end
    
    attr_reader :cfg, :ocid

    # *<tt>:cfg</tt> - The config file name without .json suffix, default "s2t"
    def initialize(cfg = nil)
      @cfg = (cfg || DEFAULT_CFG).to_s

      if !SUPPORTED_CFGS.include?(@cfg)
        raise ArgumentError, "`#{@cfg}` config file name not supported, have to be one of #{SUPPORTED_CFGS}"
      end

      @closed = false
      @mutex  = Mutex.new
    end

    def convert(input)
      synchronize do
        return if closed?
        
        @ocid ||= opencc_open(cfg_file_name)

        if ocid
          opencc_convert(ocid, input)
        end
      end
    end

    # It will raise an +RuntimeError+ exception if can not make an instance of OpenCC.
    def convert!(input, encoding = nil)
      synchronize do
        return if closed?
        
        @ocid ||= opencc_open(cfg_file_name)
        
        if ocid.nil?
          raise RuntimeError, "Can not make an instance of OpenCC with configuration file #{cfg_file_name}"
        end

        opencc_convert(ocid, input)
      end
    end

    def close
      synchronize do
        return false if closed?
        return false if ocid.nil?
        
        if opencc_close(ocid)
          @ocid = nil
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

    def cfg_file_name
      "#{@cfg}.json"
    end
  end
end
