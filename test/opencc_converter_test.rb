require "test_helper"

class OpenCC::ConverterTest < Minitest::Test
  def get_input(cfg)
    File.read(File.join(__dir__, 'data', "#{cfg}.in" )).force_encoding("UTF-8").strip
  end

  def get_answer(cfg)
    File.read(File.join(__dir__, 'data', "#{cfg}.ans" )).force_encoding("UTF-8").strip
  end

  def test_that_it_respond_to_config
    converter = OpenCC::Converter[:s2t]
    assert_respond_to converter, :config
    assert_equal converter.config, 's2t'
  end

  def test_that_it_respond_to_convert
    converter = OpenCC::Converter[:s2t]
    assert_respond_to converter, :convert
  end

  def test_that_it_respond_to_close
    converter = OpenCC::Converter[:s2t]
    assert_respond_to converter, :close
  end

  def test_that_it_respond_to_occid
    converter = OpenCC::Converter[:s2t]
    assert_respond_to converter, :occid
    assert_nil converter.occid
    converter.convert('繁体')
    refute_nil converter.occid
    assert_kind_of Integer, converter.occid
    converter.close
    assert_nil converter.occid
  ensure
    converter&.close
  end

  def test_hk2s
    cfg    = :hk2s
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.hk2s(input), answer
  end

  def test_hk2t
    cfg    = :hk2t
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.hk2t(input), answer
  end

  def test_jp2t
    cfg    = :jp2t
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.jp2t(input), answer
  end

  def test_s2hk
    cfg    = :s2hk
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.s2hk(input), answer
  end

  def test_s2t
    cfg    = :s2t
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.s2t(input), answer
  end

  def test_s2tw
    cfg    = :s2tw
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.s2tw(input), answer
  end

  def test_s2twp
    cfg    = :s2twp
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.s2twp(input), answer
  end

  def test_t2hk
    cfg    = :t2hk
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.t2hk(input), answer
  end

  def test_t2jp
    cfg    = :t2jp
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.t2jp(input), answer
  end

  def test_t2s
    cfg    = :t2s
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.t2s(input), answer
  end

  def test_tw2s
    cfg    = :tw2s
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.tw2s(input), answer
  end

  def test_tw2sp
    cfg    = :tw2sp
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.tw2sp(input), answer
  end

  def test_tw2t
    cfg    = :tw2t
    input  = get_input(cfg)
    answer = get_answer(cfg)
    assert_equal OpenCC.tw2t(input), answer
  end
end
