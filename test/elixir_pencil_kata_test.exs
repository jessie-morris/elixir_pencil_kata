defmodule ElixirPencilKataTest do
  use ExUnit.Case
  doctest ElixirPencilKata

  test "Pencil writes to an empty paper" do
    assert ElixirPencilKata.write("hello") == "hello"
  end

  test "Pencil appends to an existing piece of paper" do
    paper = "hello"
    assert ElixirPencilKata.write(paper, " world") == "hello world"
  end
end
