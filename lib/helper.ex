defmodule Checkdigit.Helper do
  def is_numeric(str) do
    case :re.run(str, "^[0-9]*$") do
      {:match, _} -> true
      _ -> false
    end
  end
end