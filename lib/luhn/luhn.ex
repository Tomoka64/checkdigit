defmodule Checkdigit.Luhn do
  import Checkdigit.Helper

  @spec verify(String.t()) :: boolean
  def verify(code) when code == "", do: false

  def verify(code) do
    if String.length(code) < 2 or !is_numeric(code) do
      false
    else
      check_digit = String.at(code, String.length(code)-1) |> String.to_integer
      generated = String.slice(code, 0..-2) |> generate
      generated == check_digit
    end
  end

  def generate(seed) when seed == "", do: 0

  def generate(seed) do
    parity = rem(String.length(seed) + 1, 2)
    len = String.length(seed)
    result = generate_helper(0, seed, parity, len) * 9 |> rem(10)
    result
  end

  defp generate_helper(index, _, _, len) when index == len, do: 0

  defp generate_helper(index, seed, parity, len) do
    curr = String.at(seed, index) |> String.to_integer
    modified =
      if rem(index, 2) == parity do
        ret =
          case curr * 2 do
            x when x > 9 -> x - 9
            x -> x
          end
        ret
      else
        curr
      end
    next = modified + generate_helper(index+1, seed, parity, len)
    next
  end
end

