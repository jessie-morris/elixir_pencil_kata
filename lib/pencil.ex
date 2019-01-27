defmodule Pencil do
    def new(durability \\ 10) do
        {:ok, pencil_actor} = Agent.start_link(fn -> %{:durability => durability} end)
        pencil_actor
    end

    def write(pencil, paper, text) do
        durability_cost = text_cost(text) 
        Agent.update(pencil, fn state -> Map.update!(state, :durability, fn dura -> dura - durability_cost end) end) 
        paper <> text
    end
    def text_cost(text) do
        String.to_charlist(text)
        |> Enum.reduce(0, fn char, acc -> acc + char_cost(char) end )
    end

    def char_cost(char) when char in ?a..?z do
        1
    end
    def char_cost(char) when char in ?A..?Z do
        2
    end
    def char_cost(char) do
        0
    end
end