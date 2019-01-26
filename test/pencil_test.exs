defmodule PencilTest do
  use ExUnit.Case

  test "Pencil writes to an empty paper" do
    pencil = Pencil.new(10)
    assert Pencil.write(pencil, "hello") == "hello"
  end

  test "Pencil appends to an existing piece of paper" do
    pencil = Pencil.new(10)
    paper = "hello"
    assert Pencil.write(pencil, paper, " world") == "hello world"
  end
end
