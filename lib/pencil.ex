defmodule Pencil do
    def new(durability \\ 10) do
        {:ok, pencil_actor} = Agent.start_link(fn -> %{:durability => durability} end)
        pencil_actor
    end

    def write(pencil, text) do
        text_size = String.length(text) 
        Agent.update(pencil, fn state -> Map.update!(state, :durability, fn dura -> dura - text_size end) end)
        text
    end
    def write(pencil, paper, text) do
        text_size = String.length(text) 
        Agent.update(pencil, fn state -> Map.update!(state, :durability, fn dura -> dura - text_size end) end) 
        paper <> text
    end
end