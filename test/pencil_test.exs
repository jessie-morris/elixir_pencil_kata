defmodule PencilTest do
  use ExUnit.Case

  test "Pencil writes to an empty paper" do
    pencil = Pencil.new(10)
    assert Pencil.write(pencil, "", "hello") == "hello"
  end

  test "Pencil appends to an existing piece of paper" do
    pencil = Pencil.new(10)
    paper = "hello"
    assert Pencil.write(pencil, paper, " world") == "hello world"
  end

  test "Pencil durability drops 1 for each lowercase character" do
    pencil = Pencil.new(10)
    Pencil.write(pencil, "", "hello")
    assert Agent.get(pencil, fn state -> state end) == %{:durability => 5}
  end

  test "Pencil durability drops 1 for each uppercase character" do
    pencil = Pencil.new(10)
    Pencil.write(pencil, "", "HELP")
    assert Agent.get(pencil, fn state -> state end) == %{:durability => 2}
  end
  test "writing spaces and newlines expends no graphite" do
    pencil = Pencil.new(10)
    Pencil.write(pencil, "", "HELP    \n")
    assert Agent.get(pencil, fn state -> state end) == %{:durability => 2}
  end
end
