defmodule Pencil do
    def new(durability \\ 10) do
        {:ok, pencil_actor} = Agent.start_link(fn -> %{:durability => durability} end)
        pencil_actor
    end

    def write(pencil, paper, text) do
        output_text = 
            String.graphemes(text)
            |> Enum.reduce(paper, fn char, acc -> write_char(char, pencil, acc) end)
    end

    defp write_char(char, pencil, paper) do
        durability = durability(pencil) 
        char_cost = TextCost.text_cost(char)
        is_writeable = durability >= char_cost
        Agent.update(pencil, fn state -> Map.update!(state, :durability, fn dura -> max(0, durability - char_cost) end) end) 
        cond do
            is_writeable -> paper <> char
            true -> paper <> " "
        end
    end

    def erase(paper, word) do
        word_list = split_by_word(paper, word)
        {_ ,last_occur} = 
           word_list
           |> get_last_occurence(word)

        replace_last_occur(word_list, last_occur)
    end

    def replace_last_occur(list, index) do
       replacement_string_length = String.length(Enum.at(list, index))
       IO.puts(replacement_string_length)
       replacement_string = Enum.reduce(0..replacement_string_length - 1, "", fn x, acc -> acc <> " " end)
       Enum.join(List.replace_at(list, index, replacement_string))
    end

    def split_by_word(paper, word) do
        IO.inspect(paper)
        match = Regex.compile!(word)
        String.split(paper, match, [include_captures: true])
    end

    def get_last_occurence(list, item) do
        {_, last_index} = Enum.zip(list, 0..Kernel.length(list)) |> Enum.filter(fn({str, index}) -> str == item end) |> List.last
    end
    
    def durability(pencil) do
        Agent.get(pencil, fn state -> Map.get(state, :durability) end) 
    end
end