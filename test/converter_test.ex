defmodule ConverterTest do
  use ExUnit.Case
  doctest Converter

  test "converts '1.2' to 1.2" do
    assert Converter.string_to_float("1.2") == 1.2
  end

  test "converts '1' to 1.0" do
    assert Converter.string_to_float("1") == 1.0
  end

  test "leaves float unchanged" do
    assert Converter.string_to_float(1.1) == 1.1
  end

  test "converts integers to floats" do
    assert Converter.string_to_float(1) == 1.0
  end
end
