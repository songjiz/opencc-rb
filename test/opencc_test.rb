require "test_helper"

class OpenCCTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::OpenCC::VERSION
  end
end
