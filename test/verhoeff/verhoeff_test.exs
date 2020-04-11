defmodule Checkdigit.VerhoeffTest do
  use ExUnit.Case

  alias Checkdigit.{Verhoeff}

  test "Verhoeff: regular 1" do
    assert Verhoeff.verify("938472210036") == true
  end

  test "Verhoeff: regular 2" do
    assert Verhoeff.verify("0973652") == true
  end

  test "Verhoeff: regular 3" do
    assert Verhoeff.verify("27") == true
  end

  test "Verhoeff: irregular 1" do
    assert Verhoeff.verify("2361") == false
  end

  test "Verhoeff: irregular 2" do
    assert Verhoeff.verify("") == false
  end

  test "Verhoeff: irregular 3" do
    assert Verhoeff.verify("1") == false
  end

  test "Verhoeff: irregular 4" do
    assert Verhoeff.verify("1aa") == false
  end
end