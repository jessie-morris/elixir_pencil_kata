defmodule TextCost do
  def text_cost(text) do
    String.to_charlist(text)
    |> Enum.reduce(0, fn char, acc -> acc + char_cost(char) end)
  end

  defp char_cost(char) when char in ?a..?z do
    1
  end

  defp char_cost(char) when char in ?A..?Z do
    2
  end

  defp char_cost(char) do
    0
  end
end
