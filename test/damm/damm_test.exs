defmodule Checkdigit.DammTest do
    use ExUnit.Case

    alias Checkdigit.{Damm}

    test "Damm: regular 1" do
      assert Damm.verify("224564332323") == true
    end

    test "Damm: regular 2" do
      assert Damm.verify("543525432346") == true
    end

    test "Damm: regular 3" do
      assert Damm.verify("37") == true
    end

    test "Damm: irregular 1" do
      assert Damm.verify("835323233227") == false
    end

    test "Damm: irregular 2" do
      assert Damm.verify("") == false
    end

    test "Damm: irregular 3" do
      assert Damm.verify("1") == false
    end

    test "Damm: irregular 4" do
      assert Damm.verify("1aa") == false
    end
end