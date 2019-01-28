defmodule Pencil do
    def new(durability \\ 10) do
        {:ok, pencil_actor} = Agent.start_link(fn -> %{:durability => durability} end)
        pencil_actor
    end

    def write(pencil, paper, text) do
        durability_cost = TextCost.text_cost(text)
        pencil_durability = Agent.get(pencil, fn state -> Map.get(state, :durability) end) 
        new_durability = max(0, pencil_durability - durability_cost) 

        output_text = 
            String.graphemes(text)
            |> Enum.reduce(paper, fn char, acc -> write_char(char, pencil, acc) end)
        
        #Agent.update(pencil, fn state -> Map.update!(state, :durability, fn dura -> new_durability end) end) 
        output_text

    end
    def write_char(char, pencil, paper) do
        durability = Agent.get(pencil, fn state -> Map.get(state, :durability) end)
        char_cost = TextCost.text_cost(char)
        is_writeable = durability > char_cost
        Agent.update(pencil, fn state -> Map.update!(state, :durability, fn dura -> max(0, durability - char_cost) end) end) 
        cond do
            durability >= char_cost -> paper <> char
            durability < char_cost -> paper <> " "
        end
    end
end