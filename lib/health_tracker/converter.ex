defmodule HealthTracker.Converter do
  # Converts strings to floats
  def to_float(number) when is_binary(number) do
    # We now know that number is a string

    if String.contains?(number, ".") or String.contains?(number, ",") do
      String.to_float(number)
    else
      String.to_integer(number) / 1
    end
  end

  def to_float(number) when is_integer(number) or is_float(number) do
    number / 1
  end
end
