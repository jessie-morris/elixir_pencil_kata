defmodule PencilTest do
  use ExUnit.Case

  test "Pencil writes to an empty paper" do
    assert Pencil.write("hello") == "hello"
  end

  test "Pencil appends to an existing piece of paper" do
    paper = "hello"
    assert Pencil.write(paper, " world") == "hello world"
  end
end
