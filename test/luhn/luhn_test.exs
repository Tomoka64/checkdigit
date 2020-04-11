defmodule Checkdigit.LuhnTest do
  use ExUnit.Case

  alias Checkdigit.{Luhn}

  test "Luhn: regular 1" do
    assert Luhn.verify("4242424242424242") == true
  end

  test "Luhn: regular 2" do
    assert Luhn.verify("5105105105105100") == true
  end

  test "Luhn: regular 3" do
    assert Luhn.verify("34") == true
  end

  test "Luhn: irregular 1" do
    assert Luhn.verify("510510510510511") == false
  end

  test "Luhn: irregular 2" do
    assert Luhn.verify("") == false
  end

  test "Luhn: irregular 3" do
    assert Luhn.verify("111a") == false
  end
end