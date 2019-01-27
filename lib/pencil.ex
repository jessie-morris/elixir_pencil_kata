defmodule Pencil do
    def new(durability \\ 10) do
        {:ok, pencil_actor} = Agent.start_link(fn -> %{:durability => durability} end)
        pencil_actor
    end

    def write(pencil, paper, text) do
        durability_cost = TextCost.text_cost(text) 
        Agent.update(pencil, fn state -> Map.update!(state, :durability, fn dura -> dura - durability_cost end) end) 
        paper <> text
    end
end