defmodule Converter do
  # Converts strings to floats
  def string_to_float(number) when is_binary(number) do
    # We now know that number is a string

    if String.contains?(number, ".") or String.contains?(number, ",") do
      String.to_float(number)
    else
      String.to_integer(number)
    end
  end

  def string_to_float(number) when is_integer(number) or is_float(number) do
    number
  end
end
