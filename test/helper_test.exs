defmodule Checkdigit.HelperTest do
  use ExUnit.Case

  alias Checkdigit.{Helper}

  test "is numeric" do
    assert Helper.is_numeric("111") == true
  end

  test "is not numeric 1" do
    assert Helper.is_numeric("a111") == false
  end

  test "is not numeric 2" do
    assert Helper.is_numeric("111a") == false
  end
end