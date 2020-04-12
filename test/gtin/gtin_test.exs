defmodule Checkdigit.GtinTest do
  use ExUnit.Case

  alias Checkdigit.{Gtin}

  test "EAN8: verify regular" do
    assert Gtin.verify_EAN8("96385074") == true
  end

  test "JAN8: verify regular" do
    assert Gtin.verify_JAN8("49968712") == true
  end

  test "EAN13: verify regular" do
    assert Gtin.verify_EAN13("5901234123457") == true
  end

  test "JAN13: verify regular" do
    assert Gtin.verify_JAN13("4569951116179") == true
  end

  test "IEF: verify regular" do
    assert Gtin.verify_IEF("14569951116176") == true
  end

  test "UPC: verify regular" do
    assert Gtin.verify_UPC("012345678905") == true
  end

  test "SSCC: verify regular" do
    assert Gtin.verify_SSCC("045699511100000016") == true
  end

  test "EAN8: generate regular" do
    assert Gtin.generate_EAN8("9638507") == 4
  end

  test "JAN8: generate regular" do
    assert Gtin.generate_JAN8("4996871") == 2
  end

  test "EAN13: generate regular" do
    assert Gtin.generate_EAN13("590123412345") == 7
  end

  test "JAN13: generate regular" do
    assert Gtin.generate_JAN13("456995111617") == 9
  end

  test "IEF: generate regular" do
    assert Gtin.generate_IEF("1456995111617") == 6
  end

  test "UPC: generate regular" do
    assert Gtin.generate_UPC("01234567890") == 5
  end

  test "SSCC: generate regular" do
    assert Gtin.generate_SSCC("04569951110000001") == 6
  end

  test "Gtin: irregular 2" do
    assert Gtin.verify_EAN8("") == false
  end

  test "Gtin: irregular 3" do
    assert Gtin.verify_EAN8("1") == false
  end

  test "Gtin: irregular 4" do
    assert Gtin.verify_EAN8("1aa") == false
  end
end