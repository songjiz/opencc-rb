require "test_helper"

class OpenCC::ConverterTest < Minitest::Test
  def test_t2s
    OpenCC::Converter.with(:t2s) do |ct|
      assert_equal ct.convert('漢字'), '汉字'
    end
  end

  def test_s2t
    OpenCC::Converter.with(:s2t) do |ct|
      assert_equal ct.convert('汉字'), '漢字'
    end
  end

  def test_t2hk
    OpenCC::Converter.with(:t2hk) do |ct|
      assert_equal ct.convert('關於OpenCC'), '關於OpenCC'
    end
  end

  def test_hk2s
    OpenCC::Converter.with(:hk2s) do |ct|
      assert_equal ct.convert('關於OpenCC'), '关于OpenCC'
    end
  end
end
