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
        String.graphemes(text)
        |> Enum.reduce(0, fn char, acc -> acc + char_cost(char) end )
    end

    def char_cost(char) do
        cost = 1
        if(String.upcase(char) == char) do
            cost = 2
        end
        cost
    end
end