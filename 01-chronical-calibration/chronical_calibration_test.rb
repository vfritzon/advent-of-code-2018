require 'minitest/autorun'
require_relative 'chronical_calibration'

class ChronicalCalibrationTest < Minitest::Test
  def test_only_positive
    assert_equal 3, ChronicalCalibration.compute_file("test-inputs/positive")
  end

  def test_only_negative
    assert_equal -6, ChronicalCalibration.compute_file("test-inputs/negative")
  end

  def test_mixed
    assert_equal 0, ChronicalCalibration.compute_file("test-inputs/mixed")
  end

  def test_repeated_zero
    assert_equal 0, ChronicalCalibration.get_first_repeat_from_file("test-inputs/repeated-zero")
  end

  def test_repeated_ten
    assert_equal 10, ChronicalCalibration.get_first_repeat_from_file("test-inputs/repeated-ten")
  end
end

