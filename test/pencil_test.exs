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
    assert Pencil.durability(pencil) == 5
  end

  test "Pencil durability drops 1 for each uppercase character" do
    pencil = Pencil.new(10)
    Pencil.write(pencil, "", "HELP")
    assert Pencil.durability(pencil) == 2
  end

  test "writing spaces and newlines expends no graphite" do
    pencil = Pencil.new(10)
    Pencil.write(pencil, "", "HELP    \n")
    assert Pencil.durability(pencil) == 2
  end

  test "pencil stops writing characters when durability hits 0" do
    pencil = Pencil.new(4)
    assert Pencil.write(pencil, "", "Text") == "Tex "
  end

  test "pencil erases a word from the text" do
    assert Pencil.erase("hey girl", "hey") == "    girl"
  end

  test "pencil erases the last occurance of a word from the text" do
    assert Pencil.erase("hey girl hey", "hey") == "hey girl    "
  end

  test "pencil gets sharpened and returned to initial durability when length > 0" do
    pencil = Pencil.new(10, 10)
    Pencil.write(pencil, "", "hello")
    Pencil.sharpen(pencil)
    assert Pencil.pencil_length(pencil) == 9
    assert Pencil.durability(pencil) == 10
  end

  test "pencil doesnt get free durability if length == 0" do
    pencil = Pencil.new(5, 0)
    Pencil.write(pencil, "", "hello")
    Pencil.sharpen(pencil)
    assert Pencil.pencil_length(pencil) == 0
    assert Pencil.durability(pencil) == 0
  end
end
