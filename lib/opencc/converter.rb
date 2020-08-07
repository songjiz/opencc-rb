module OpenCC
  class Converter
    include OpenCC

    class << self
      def with(cfg)
        converter = new(cfg)
        yield converter
      ensure
        converter.close
      end
    end
    
    # *<tt>:cfg</tt> - The config file name without .json suffix, default "s2t"
    #   [s2t|t2s|s2tw|tw2s|s2hk|hk2s|s2twp|tw2sp|t2tw|hk2t|t2hk|t2jp|jp2t|tw2t]
    def initialize(cfg = :s2t)
      @cfg    = cfg
      @closed = false
      @mutex  = Mutex.new
    end

    def convert(input)
      synchronize do
        return if closed?

        opencc_convert(opencc, input).force_encoding(Encoding::UTF_8.to_s)
      end
    end

    def close
      synchronize do
        return false if closed?

        if opencc_close(opencc)
          @opencc = nil
          @closed = true
        end
      end
    end

    def closed?
      @closed
    end

    private

    def synchronize(&block)
      @mutex.synchronize &block
    end

    def opencc
      @opencc ||= opencc_open(cfg_file_name)
    end

    def cfg_file_name
      @cfg && "#{@cfg}.json"
    end
  end
end
