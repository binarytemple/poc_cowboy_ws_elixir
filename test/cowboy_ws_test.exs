defmodule CowboyWsTest do
  use ExUnit.Case
  doctest CowboyWs

  test "greets the world" do
    assert CowboyWs.hello() == :world
  end
end
