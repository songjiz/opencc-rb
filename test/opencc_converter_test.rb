require "test_helper"

class OpenCC::ConverterTest < Minitest::Test
  def get_input(cfg)
    File.read(File.join(__dir__, 'data', "#{cfg}.in" )).force_encoding("UTF-8").strip
  end

  def get_answer(cfg)
    File.read(File.join(__dir__, 'data', "#{cfg}.ans" )).force_encoding("UTF-8").strip
  end

  def test_hk2s
    OpenCC::Converter.with(:hk2s) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_jp2t
    OpenCC::Converter.with(:jp2t) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_s2hk
    OpenCC::Converter.with(:s2hk) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_s2t
    OpenCC::Converter.with(:s2t) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_s2tw
    OpenCC::Converter.with(:s2tw) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_s2twp
    OpenCC::Converter.with(:s2twp) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_t2hk
    OpenCC::Converter.with(:t2hk) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_t2jp
    OpenCC::Converter.with(:t2jp) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_t2s
    OpenCC::Converter.with(:t2s) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_tw2s
    OpenCC::Converter.with(:tw2s) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_tw2sp
    OpenCC::Converter.with(:tw2sp) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end

  def test_tw2t
    OpenCC::Converter.with(:tw2t) do |ct|
      input  = get_input(ct.cfg)
      answer = get_answer(ct.cfg)
      assert_equal ct.convert(input), answer
    end
  end
end
