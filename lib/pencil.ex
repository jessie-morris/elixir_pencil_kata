defmodule Pencil do
    def new(durability) do
        {:ok, pencil_actor} = Agent.start_link(fn -> %{:durability => durability} end)
        pencil_actor
    end

    def write(text) do
        text
    end
    def write(paper, text) do
        paper <> text
    end
end