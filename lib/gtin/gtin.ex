defmodule Checkdigit.Gtin do
  import Checkdigit.Helper

  defstruct [digit: 0, pos_corr: false]

  def new(attributes \\ []), do: __struct__(attributes)

  def verify_EAN8(code) do
    gtin = new([digit: 8, pos_corr: true])
    verify(code, gtin)
  end

  def verify_JAN8(code) do
    gtin = new([digit: 8, pos_corr: true])
    verify(code, gtin)
  end

  def verify_EAN13(code) do
    gtin = new([digit: 13, pos_corr: true])
    verify(code, gtin)
  end

  def verify_JAN13(code) do
    gtin = new([digit: 13, pos_corr: true])
    verify(code, gtin)
  end

  def verify_IEF(code) do
    gtin = new([digit: 14, pos_corr: false])
    verify(code, gtin)
  end

  def verify_UPC(code) do
    gtin = new([digit: 12, pos_corr: true])
    verify(code, gtin)
  end

  def verify_SSCC(code) do
    gtin = new([digit: 18, pos_corr: false])
    verify(code, gtin)
  end

  def verify(code, gtin) do
    if String.length(code) != gtin.digit or !is_numeric(code) do
      false
    else
      check_digit = String.at(code, String.length(code)-1) |> String.to_integer
      generated = String.slice(code, 0..-2) |> generate(gtin)
      generated == check_digit
    end
  end

  def generate_EAN8(code) do
    gtin = new([digit: 8, pos_corr: true])
    generate(code, gtin)
  end

  def generate_JAN8(code) do
    gtin = new([digit: 8, pos_corr: true])
    generate(code, gtin)
  end

  def generate_EAN13(code) do
    gtin = new([digit: 13, pos_corr: true])
    generate(code, gtin)
  end

  def generate_JAN13(code) do
    gtin = new([digit: 13, pos_corr: true])
    generate(code, gtin)
  end

  def generate_IEF(code) do
    gtin = new([digit: 14, pos_corr: false])
    generate(code, gtin)
  end

  def generate_UPC(code) do
    gtin = new([digit: 12, pos_corr: true])
    generate(code, gtin)
  end

  def generate_SSCC(code) do
    gtin = new([digit: 18, pos_corr: false])
    generate(code, gtin)
  end

  def generate(seed) when seed == "", do: 0

  def generate(seed, gtin) do
    len = String.length(seed)
    if len != gtin.digit - 1 do
      false
    else
      result = generate_helper(0, seed, 0, 0, gtin, len)
      result
    end
  end

  defp generate_helper(index, _, odd_sum, even_sum, _, len) when index == len do
    result = 10 - rem((even_sum*3+odd_sum), 10)
    if result == 10 do
      0
    else
      result
    end
  end

  defp generate_helper(index, seed, odd_sum, even_sum, gtin, len) do
    curr = String.at(seed, index) |> String.to_integer
    check_index = if gtin.pos_corr do
      index + 1
    else
      index
    end
    if rem(check_index, 2) == 0 do
      generate_helper(index+1, seed, odd_sum, even_sum+curr, gtin, len)
    else
      generate_helper(index+1, seed, odd_sum+curr, even_sum, gtin, len)
    end
  end
end