defmodule Checkdigit.Verhoeff do
  import Checkdigit.Helper

  @multiplication %{
    0 => %{0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9},
    1 => %{0 => 1, 1 => 2, 2 => 3, 3 => 4, 4 => 0, 5 => 6, 6 => 7, 7 => 8, 8 => 9, 9 => 5},
    2 => %{0 => 2, 1 => 3, 2 => 4, 3 => 0, 4 => 1, 5 => 7, 6 => 8, 7 => 9, 8 => 5, 9 => 6},
    3 => %{0 => 3, 1 => 4, 2 => 0, 3 => 1, 4 => 2, 5 => 8, 6 => 9, 7 => 5, 8 => 6, 9 => 7},
    4 => %{0 => 4, 1 => 0, 2 => 1, 3 => 2, 4 => 3, 5 => 9, 6 => 5, 7 => 6, 8 => 7, 9 => 8},
    5 => %{0 => 5, 1 => 9, 2 => 8, 3 => 7, 4 => 6, 5 => 0, 6 => 4, 7 => 3, 8 => 2, 9 => 1},
    6 => %{0 => 6, 1 => 5, 2 => 9, 3 => 8, 4 => 7, 5 => 1, 6 => 0, 7 => 4, 8 => 3, 9 => 2},
    7 => %{0 => 7, 1 => 6, 2 => 5, 3 => 9, 4 => 8, 5 => 2, 6 => 1, 7 => 0, 8 => 4, 9 => 3},
    8 => %{0 => 8, 1 => 7, 2 => 6, 3 => 5, 4 => 9, 5 => 3, 6 => 2, 7 => 1, 8 => 0, 9 => 4},
    9 => %{0 => 9, 1 => 8, 2 => 7, 3 => 6, 4 => 5, 5 => 4, 6 => 3, 7 => 2, 8 => 1, 9 => 0},
  }

  @permutation %{
    0 => %{0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9},
    1 => %{0 => 1, 1 => 5, 2 => 7, 3 => 6, 4 => 2, 5 => 8, 6 => 3, 7 => 0, 8 => 9, 9 => 4},
    2 => %{0 => 5, 1 => 8, 2 => 0, 3 => 3, 4 => 7, 5 => 9, 6 => 6, 7 => 1, 8 => 4, 9 => 2},
    3 => %{0 => 8, 1 => 9, 2 => 1, 3 => 6, 4 => 0, 5 => 4, 6 => 3, 7 => 5, 8 => 2, 9 => 7},
    4 => %{0 => 9, 1 => 4, 2 => 5, 3 => 3, 4 => 1, 5 => 2, 6 => 6, 7 => 8, 8 => 7, 9 => 0},
    5 => %{0 => 4, 1 => 2, 2 => 8, 3 => 6, 4 => 5, 5 => 7, 6 => 3, 7 => 9, 8 => 0, 9 => 1},
    6 => %{0 => 2, 1 => 7, 2 => 9, 3 => 3, 4 => 8, 5 => 0, 6 => 6, 7 => 4, 8 => 1, 9 => 5},
    7 => %{0 => 7, 1 => 0, 2 => 4, 3 => 6, 4 => 9, 5 => 1, 6 => 3, 7 => 2, 8 => 5, 9 => 8},
  }

  @inverse %{0 => 0, 1 => 4, 2 => 3, 3 => 2, 4 => 1, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9}


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

  def generate(seed) do
    len = String.length(seed)
    result = generate_helper(0, seed, 0, len)
    result
  end

  defp generate_helper(index, _, interim, len) when index == len, do: @inverse[interim]

  defp generate_helper(index, seed, interim, len) do
    curr = String.at(seed, len-index-1) |> String.to_integer
    next = @multiplication[interim][@permutation[rem((index+1), 8)][curr]]
    generate_helper(index+1, seed, next, len)
  end
end